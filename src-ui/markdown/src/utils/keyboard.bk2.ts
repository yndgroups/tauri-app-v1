function code(mapData, x) {
  return mapData[x] || x.toUpperCase().charCodeAt(0);
}

function index(array, item) {
  if (Array.isArray(array)) {
    let i = array.length;
    while (i--) if (array[i] === item) return i;
  }
  return -1;
}

// for comparing mods before unassignment
function compareArray(a1, a2) {
  if (a1.length != a2.length) return false;
  for (var i = 0; i < a1.length; i++) {
    if (a1[i] !== a2[i]) return false;
  }
  return true;
}

// 分配和取消分配的抽象密钥逻辑
function getKeys(key) {
  var keys;
  key = key.replace(/\s/g, '');
  keys = key.split(',');
  if (keys[keys.length - 1] == '') {
    keys[keys.length - 2] += ',';
  }
  return keys;
}

// 用于分配和取消分配的抽象mods逻辑
function getMods(key, modifiers) {
  var mods = key.slice(0, key.length - 1);
  for (var mi = 0; mi < mods.length; mi++) mods[mi] = modifiers[mods[mi]];
  return mods;
}

interface Kbd {
  register: Function;
  setScope: Function;
  getScope: Function;
  deleteScope: Function;
  filter: Function;
  isPressed: Function;
  getPressedKeyCodes: Function;
  noConflict: Function;
  unbindKey: Function;
}

class Keyboard implements Kbd {
  handlers: any;
  mods: any;
  scope: string;
  modifiers: any;
  maps: any;
  downKeys: any;
  modifierMap: any;
  previousKey: any;

  constructor() {
    this.handlers = {};
    this.mods = { 16: false, 18: false, 17: false, 91: false };
    this.scope = 'all';
    // modifier keys
    this.modifiers = {
      '⇧': 16,
      shift: 16,
      '⌥': 18,
      alt: 18,
      option: 18,
      '⌃': 17,
      ctrl: 17,
      control: 17,
      '⌘': 91,
      command: 91,
    };
    this.maps = {
      backspace: 8,
      tab: 9,
      clear: 12,
      enter: 13,
      return: 13,
      esc: 27,
      escape: 27,
      space: 32,
      left: 37,
      up: 38,
      right: 39,
      down: 40,
      del: 46,
      delete: 46,
      home: 36,
      end: 35,
      pageup: 33,
      pagedown: 34,
      ',': 188,
      '.': 190,
      '/': 191,
      '`': 192,
      '-': 189,
      '=': 187,
      ';': 186,
      "'": 222,
      '[': 219,
      ']': 221,
      '\\': 220,
    };
    // special keys
    this.downKeys = [];
    for (let k = 1; k < 20; k++) this.maps['f' + k] = 111 + k;
    this.modifierMap = {
      16: 'shiftKey',
      18: 'altKey',
      17: 'ctrlKey',
      91: 'metaKey',
    };
    for (let k in this.modifiers) this.register[k] = false;
    this.previousKey = this.register;
    //在文档上全局设置处理程序
    this.addEvent(document, 'keydown', (event) => {
      this.dispatch(event);
    });
    //将作用域传递给回调以确保其在执行时保持不变
    this.addEvent(document, 'keyup', this.clearModifier);

    // 每当窗口（重新）聚焦时，将修饰符重置为false
    this.addEvent(window, 'focus', this.resetmodifiers);
  }

  unbindKey(key, scope) {
    let multipleKeys,
      keys,
      mods = [],
      i,
      j,
      obj;

    multipleKeys = getKeys(key);

    for (j = 0; j < multipleKeys.length; j++) {
      keys = multipleKeys[j].split('+');

      if (keys.length > 1) {
        mods = getMods(keys, this.modifiers);
      }

      key = keys[keys.length - 1];
      key = code(key, this.mods);

      if (scope === undefined) {
        scope = this.getScope();
      }
      if (!this.handlers[key]) {
        return;
      }
      for (i = 0; i < this.handlers[key].length; i++) {
        obj = this.handlers[key][i];
        //只有在正确的作用域和mods匹配时才清除处理程序
        if (obj.scope === scope && compareArray(obj.mods, mods)) {
          this.handlers[key][i] = {};
        }
      }
    }
  }

  resetmodifiers() {
    for (let k in this.mods) this.mods[k] = false;
    for (let k in this.modifiers) this.register[k] = false;
  }

  clearModifier(event) {
    var key = event.keyCode;
    let i = index(this.downKeys, key);
    // remove key from downKeys
    if (i >= 0) {
      this.downKeys.splice(i, 1);
    }

    if (key == 93 || key == 224) {
      key = 91;
    }
    console.log(this.mods, 'this.modsthis.modsthis.mods');
    if (this.mods) {
      if (key in this.mods) {
        this.mods[key] = false;
        for (let k in this.modifiers) {
          if (this.modifiers[k] == key) {
            this.register[k] = false;
          }
        }
      }
    }
  }

  register(key: any, scope: any, method: any = undefined) {
    var keys, mods;
    keys = getKeys(key);
    if (method === undefined) {
      method = scope;
      scope = 'all';
    }
    for (var i = 0; i < keys.length; i++) {
      mods = [];
      key = keys[i].split('+');
      if (key.length > 1) {
        mods = getMods(key, this.modifiers);
        key = [key[key.length - 1]];
      }
      key = key[0];
      key = code(this.maps, key);
      if (!(key in this.handlers)) {
        this.handlers[key] = [];
      }
      this.handlers[key].push({ shortcut: keys[i], scope: scope, method: method, key: keys[i], mods: mods });
    }
  }

  // 设置
  setScope(scope) {
    this.scope = scope || 'all';
  }

  getScope() {
    return this.scope || 'all';
  }

  // delete all handlers for a given scope
  deleteScope(scope) {
    let key, handlers, i;
    for (key in this.handlers) {
      handlers = this.handlers[key];
      for (i = 0; i < handlers.length; ) {
        if (handlers[i].scope === scope) handlers.splice(i, 1);
        else i++;
      }
    }
  }

  filter(event) {
    var tagName = (event.target || event.srcElement).tagName;
    // ignore keypressed in any elements that support keyboard data input
    return !(tagName == 'INPUT' || tagName == 'SELECT' || tagName == 'TEXTAREA');
  }

  isPressed(keyCode) {
    if (typeof keyCode == 'string') {
      keyCode = code(keyCode, this.maps);
    }
    return index(this.downKeys, keyCode) != -1;
  }

  getPressedKeyCodes() {
    return this.downKeys.slice(0);
  }

  noConflict() {
    return this.previousKey;
  }

  addEvent(object, event, method) {
    if (object.addEventListener) object.addEventListener(event, method, false);
    else if (object.attachEvent)
      object.attachEvent('on' + event, function () {
        method(window.event);
      });
  }

  //处理keydown事件
  dispatch(event) {
    let handler, modifiersMatch, scope;
    let key = event.keyCode;

    if (index(this.downKeys, key) == -1) {
      this.downKeys.push(key);
    }

    //如果是修改器关键帧，请设置关键帧<modifierkeyname>属性为true并返回
    if (key == 93 || key == 224) key = 91; //webkit上的右命令，Gecko上的命令
    if (key in this.mods) {
      this.mods[key] = true;
      //此闭包内部的“assignKey”导出到window.key
      for (let k in this.modifiers) {
        if (this.modifiers[k] == key) {
          this.register[k] = true;
        }
      }
      return;
    }

    this.updateModifierKey(event);

    //看看我们是否需要忽略按键（filter（）可以被覆盖）
    //默认情况下，如果选择、文本区域或输入集中，则忽略按键
    //if（！this.register.filter.call（this，event））返回；
    //如果未找到潜在匹配的快捷方式，则中止
    if (!(key in this.handlers)) return;

    scope = this.getScope();

    //对于每个潜在的快捷方式
    for (let i = 0; i < this.handlers[key].length; i++) {
      handler = this.handlers[key][i];

      //看看它是否在当前范围内
      if (handler.scope == scope || handler.scope == 'all') {
        //检查修饰符是否匹配（如果有的话）
        modifiersMatch = handler.mods.length > 0;
        for (let k in this.mods) {
          if ((!this.mods[k] && index(handler.mods, +k) > -1) || (this.mods[k] && index(handler.mods, +k) == -1)) {
            modifiersMatch = false;
          }
        }
        //必要时调用处理程序并停止事件
        if ((handler.mods.length == 0 && !this.mods[16] && !this.mods[18] && !this.mods[17] && !this.mods[91]) || modifiersMatch) {
          if (handler.method(event, handler) === false) {
            if (event.preventDefault) event.preventDefault();
            else event.returnValue = false;
            if (event.stopPropagation) event.stopPropagation();
            if (event.cancelBubble) event.cancelBubble = true;
          }
        }
      }
    }
  }

  updateModifierKey(event) {
    for (let k in this.mods) this.mods[k] = event[this.modifierMap[k]];
  }
}

export default Keyboard;
