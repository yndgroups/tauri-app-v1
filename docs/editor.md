```
<template>
  <div ref="parent"></div>
</template>
<script setup lang="ts">
import { markdown } from '@codemirror/lang-markdown';
import { EditorState } from '@codemirror/state';
import { EditorView, ViewUpdate, lineNumbers } from '@codemirror/view';
import { oneDark } from '@codemirror/theme-one-dark';
import { syntaxHighlighting, defaultHighlightStyle } from '@codemirror/language';
import { unified, Transformer } from 'unified';
import remarkParse from 'remark-parse';
import remarkRehype from 'remark-rehype';
import rehypeStringify from 'rehype-stringify';
import remarkMath from 'remark-math';
import rehypeKatex from 'rehype-katex';
import rehypeDocument from 'rehype-document';
import rehypeHighlight from 'rehype-highlight';
import remarkGfm from 'remark-gfm';
import { highlightOptions } from './highlight';
import './App.css';
import { BasicStyleWrap, CodeStyleWrap, MathStyleWrap } from './basic';
import SyncScroll from './sync';
import throttle from 'lodash.throttle';
import { watch, onMounted, ref, watchEffect } from 'vue';

interface ASTtreeType {
  type: string;
  position: any;
  children: Array<Record<string, unknown>>;
}

// ref回调动态更新
/* function useClientRect<T>(init: T): [T, (node: T) => void, Dispatch<SetStateAction<T>>] {
  const [rect, setRect] = useState<T>(init);
  const ref = useCallback((node: T) => {
    if (node !== null) {
      setRect(node);
    }
  }, []);
  return [rect, ref, setRect];
} */

// function useClientRect(init: any) {
//   const useTm = ref<any>(init);
//   const refs = useCallback((node: any) => {
//     if (node !== null) {
//       useTm.value = node;
//     }
//   }, []);
//   return [useTm, refs, useTm.value];
// }

const parent = ref();
const docContent = ref();
const showContent = ref();
const instance = ref<any>({
  current: {},
});
const editorView = ref();
const AstNode = ref();
const rectScrollRef = ref();
const contentRef = ref();
const rectContentRef = ref();

watch([() => rectScrollRef.value, () => rectContentRef.value, () => editorView.value], () => {
  instance.value.current = new SyncScroll(editorView.value, { scrollRef: rectScrollRef.value, contentRef: rectContentRef.value });
});

watch([() => rectScrollRef.value, () => rectContentRef.value, () => editorView.value], () => {
  instance.value.current = new SyncScroll(editorView.value, { scrollRef: rectScrollRef.value, contentRef: rectContentRef.value });
});

// *********************
// Editor
// *********************
const scrollPlugin = () => {
  return EditorView.domEventHandlers({
    scroll() {
      instance.value.current.syncPreview(AstNode.value.current);
    },
    mouseenter() {
      instance.value.current.currentScrollArea = 'editor';
    },
  });
};

watchEffect(() => {
  let view = new EditorView({
    state: EditorState.create({
      doc: docContent.value,
      extensions: [
        lineNumbers({}),
        EditorView.lineWrapping,
        syntaxHighlighting(defaultHighlightStyle, {
          fallback: true,
        }),
        markdown({ addKeymap: false }),
        oneDark,
        EditorView.updateListener.of((view: ViewUpdate) => {
          if (view.docChanged) {
            const doc = view.state.doc;
            const value = doc.toString();
            showContent.value = value;
          }
        }),
        // scrollPlugin(),
      ],
    }),
    parent: parent.value,
  });
  editorView.value = view;
});

watch([() => docContent.value, () => editorView.value], (nv: any) => {
  const currentValue = docContent.value ? editorView.value.state.doc.toString() : '';
  if (docContent.value && docContent.value !== currentValue) {
    editorView.value.dispatch({
      changes: { from: 0, to: currentValue.length, insert: nv[0] || '' },
    });
  }
});

// *********************
// MarkDown
// *********************

watch(
  () => docContent.value,
  () => {
    const timer = setTimeout(() => {
      mdToHTML();
    }, 100);
    return () => clearTimeout(timer);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  },
);

const mdToHTML = () => {
  unified()
    .use(remarkParse)
    .use(remarkMath)
    .use(remarkGfm)
    .use(remarkRehype)
    .use(rehypeHighlight, highlightOptions)
    .use(customPlugin) //  Our plug-in is remarkRehype After the plug-in, use
    .use(rehypeKatex)
    .use(rehypeDocument)
    .use(rehypeStringify)
    .process(docContent) //  docContent为编辑器文本
    .then(
      (file: any) => {
        showContent.value = String(file);
      },
      (error: any) => {
        console.error('markdown语法解析失败,失败原因:', error);
      },
    );
};

const customPlugin = (): void | Transformer<ASTtreeType> => (tree: ASTtreeType) => {
  const astNodes = tree.children || [];
  const filterAstNodes = astNodes.filter((child: any) => child.type === 'element') || [];
  AstNode.value.current = filterAstNodes;
};

// 设置滚动标识
// @ts-ignore
const setScrollArea = () => {
  instance.value.current.currentScrollArea = 'preview';
};

// 滚动事件派发同步
// @ts-ignore
const onPreviewScroll = throttle(() => {
  instance.value.current.syncEditorScroll(AstNode.value.current);
}, 100);
</script>
```

import { onMounted, onUnmounted, computed, defineComponent, nextTick, ref, shallowRef, watch, type ComputedRef, type PropType, type Ref, type ShallowRef, type WritableComputedRef } from 'vue';
import { basicSetup, minimalSetup } from 'codemirror';
import { EditorView, keymap, placeholder, type ViewUpdate } from '@codemirror/view';
import { Compartment, EditorSelection, EditorState, StateEffect, type Transaction, type Extension, type SelectionRange, type StateField, type Text } from '@codemirror/state';
import { diagnosticCount as linterDagnosticCount, forceLinting, linter, lintGutter, type Diagnostic, type LintSource } from '@codemirror/lint';
import { indentWithTab } from '@codemirror/commands';
import type { LanguageSupport } from '@codemirror/language';
import type { StyleSpec } from 'style-mod';
export default defineComponent({
name: 'codemirror',
model: {
prop: 'modelValue',
event: 'update:modelValue',
},
props: {
// 值传递
// 默认为空字符串
modelValue: {
type: String as PropType<string | Text>,
default: '',
},
// 编辑器语言的模式
// [string | object]
mode: {
type: String || Object,
},
// 编辑器的缩进单位
// 默认4个空格
indentUnit: {
type: Number,
default: 4,
},
// 是否使用mode提供的上下文的缩进
// 默认true
smartIndent: {
type: Boolean,
default: true,
},
// 编辑器主题 - [string]
theme: {
type: Object as PropType<Record<string, StyleSpec>>,
default: () => {},
},
// 默认主题是否开启
// 默认不开启
dark: {
type: Boolean,
default: false,
},
// 基础设置
basic: {
type: Boolean,
default: false,
},
//
minimal: {
type: Boolean,
default: false,
},
// 默认输入提示 - [String as PropType<string | HTMLElement>]
placeholder: {
type: String as PropType<string | HTMLElement>,
default: undefined,
},
// 是否换行 - [boolean]
// 默认false
lineWrapping: {
type: Boolean,
default: false,
},
// 编辑器左侧是否显示行号 - [boolean]
// 默认显示
lineNumbers: {
type: Boolean,
default: true,
},
// tab设置
// 默认false
tab: {
type: Boolean,
default: false,
},
// 允许多项选择
allowMultipleSelections: {
type: Boolean,
default: false,
},
// tab字符的大小
// 默认为null不设置，如果传入4相当于4个空格的宽度
tabSize: {
type: Number,
default: null,
},
// 缩进的时候，是否把前面的N\*tab大小的空间转化为N个tab字符，
// 默认为false
indentWithTabs: {
type: Boolean,
default: false,
},
// 语言模式提供缩进的前提下，当输入的会引起缩进变化的时候，是否重新调整当前行的缩进
// 默认为true
electricChars: {
type: Boolean,
default: false,
},
// 行分隔符 换行分隔符 - [string | null]
lineSeparator: {
type: String,
default: null,
},
// 编辑器是否只读 - [boolean | string]
// 默认false
// nocursor 只读，不显示光标，不可获取焦点
readonly: {
type: Boolean,
default: false,
},
// 是否禁用
disabled: {
type: Boolean,
default: false,
},
// 扩展
extensions: {
type: Array as PropType<Extension[]>,
default: () => {
return [];
},
},
// 短语提示
phrases: {
type: Object as PropType<Record<string, string>>,
default: () => null,
},
// 语言
lang: {
type: Object as PropType<LanguageSupport>,
default: () => null,
},
// lint
linter: {
type: Function as PropType<LintSource>,
default: null,
},
// lint 配置
linterConfig: {
type: Object,
default: () => {
return {};
},
},
// 强制lint
forceLinting: {
type: Boolean,
default: false,
},
// 管道
gutter: {
type: Boolean,
defalt: false,
},
// 管道设置
gutterConfig: {
type: Object,
default: () => undefined,
},
// 配置使用的键映射，默认为codemirror.js中定义的唯一的一个键映射-default - [string]
keyMap: {
type: String,
default: '',
},
// 给编辑器绑定keyMap中定义的额外的键，为null或者有效的键值对{key: value} - [object]
extraKeys: {
type: String,
default: '',
},
// 允许您配置鼠标选择和拖动的行为
configureMouse: {},
// gutters
// fixedGutter
// scrollbarStyle 滚动条样式 - [string]
// inputStyle 处理输入和焦点的方式 - [string]
// screenReaderLabel
// showCursorWhenSelecting 选择内容的时候是否显示光标 - [boolean]
// lineWiseCopyCut 当没有选择内容时，进行复制或剪切操作，是否复制或剪切当前光标所在的整行内容 - [boolean] -> true - 默认，复制或剪切整行. 注意此时会带上换行符

    // pasteLinesPerSelection
    // selectionsMayTouch

    // undoDepth 编辑器存储的最大撤销级别数, 这包括选择更改事件。默认为200。 - [integer
    // 输入、删除、选择更改操作多次之后，会把这些操作记录在history中，可以来进行撤销操
    // 而存储的最大次数就是该选项来设定的

    // historyEventDelay
    // 输入或删除的时候，停顿一定时间后，会被认定为下一次操作。默认1250 - [integer]
    // 如果输入间隔超过 historyEventDelay 后，则被认为是两次输入。单位毫秒

    // tabindex
    // 要分配给编辑器的标签索引 - [integer]

    // autofocus
    // 初始化的时候是否自动获取焦点 - [boolean]

    // hrases

    // dragDrop
    // 是否启动拖拽，默认启用true - [boolean]

    // dragDrop: true-默认

    // allowDropFileTypes
    // 允许可以向编辑器拖入的文件MIME类型 - [array<string>]

    // cursorBlinkRate
    // 光标闪烁的半周期时长-毫秒，默认为530ms - [number]
    // > 0时，光标闪烁一周时间为该时间的两倍
    // = 0时，光标停止闪烁
    // < 0时，光标不显示

    // cursorScrollMargin
    // 在可滚动的文档中，当接近可见视图的顶部或底部时，始终保持在光标上方和下方的额外空间大小。默认值为0。 - [number]

    // cursorHeight
    // 光标的高度，默认为1-代码一行的高度 - [number]
    // 根据需要可调整，如果设置0.5，则高度为代码行高的0.5倍
    // 光标默认显示从当前行顶部开始显示

    // singleCursorHeightPerLine
    // true-将保持整个行(或换行部分)的光标高度不变。false-游标的高度基于相邻引用字符的高度。 - [boolean]

    // resetSelectionOnContextMenu
    // 控制当在当前选择的外部单击打开上下文菜单时，是否将光标移动到单击的点。默认值为true。 - [boolean]

    // workTime
    // 高亮伪线程的工作时间，单位ms - [number]

    // workDelay
    // 高亮伪线程的间歇时间，单位ms - [number]

    // pollInterval
    // 指示CodeMirror应该以多快的速度轮询其输入文本区域的更改(当聚焦时)。大多数输入都是由事件捕获的，但是有些东西，比如某些浏览器上的IME输入，并没有生成允许codemmirror正确检测它的事件。因此，它来检测。默认值为100ms - [number]

    // flattenSpans
    // 默认情况下，如果相邻的标记具有相同的类，CodeMirror将把它们组合成单个span。这将生成更简单的DOM树，从而性能更好。对于某些类型的样式(如圆角)，这将改变文档的外观。您可以将此选项设置为false以禁用此行为。 - [boolean]

    // addModeClass
    // 当启用=true(默认关闭=false)时，一个额外的CSS类将被添加到每个令牌，表明产生它的(内部)模式，前缀为“cm-m-”。例如，来自XML模式的令牌将获得cm-m-xml类。 - [boolean]

    // maxHighlightLength
    // 单行高亮显示的内容长度，默认为10000 - [number]

    // 超过部分按照纯文本显示
    // Infinity - 无限制，等于关闭了该设置

    // viewportMargin
    // 指定当前滚动到视图中的文档部分的上方和下方呈现的行数。默认为10 - [integer]
    // 有点类似于虚拟滚动显示
    // Infinity - 无限制，始终显示全部内容，但是数据量大的时候会造成页面卡顿

    // spellcheck
    // 指定是否对输入启用拼写检查。 - [boolean]

    // autocorrect
    // 指定是否对输入启用自动更正。 - [boolean]

    // autocapitalize
    // 指定是否对输入启用自动大小写。 - [boolean]

},
emits: {
'update:modelValue': (\_value: string | Text) => true,
update: (\_value: ViewUpdate) => true,
ready: (\_value: { view: EditorView; state: EditorState; container: HTMLElement }) => true,
focus: (\_value: boolean) => true,
blur: (\_value: boolean) => true,
change: (\_value: EditorState) => true,
destroy: () => true,
},
setup(props, context) {
const codemirror: Ref<HTMLElement | undefined> = ref() as any;
const doc: Ref<string | Text> = ref(props.modelValue);
const view: ShallowRef<EditorView> = shallowRef(new EditorView());
const focus: WritableComputedRef<boolean> = computed({
get: () => view.value.hasFocus,
set: (f) => {
if (f) {
view.value.focus();
}
},
});
const selection: WritableComputedRef<EditorSelection> = computed({
get: () => view.value.state.selection,
set: (selection) => view.value.dispatch({ selection: selection }),
});
const cursor: WritableComputedRef<number> = computed({
get: () => view.value.state.selection.main.head,
set: (anchor) => view.value.dispatch({ selection: { anchor: anchor } }),
});
const json: WritableComputedRef<Record<string, StateField<any>>> = computed({
get: () => view.value.state.toJSON(),
set: (json) => view.value.setState(EditorState.fromJSON(json)),
});
const length: Ref<number> = ref(0);
const diagnosticCount: Ref<number> = ref(0);
const extensions: ComputedRef<Extension[]> = computed(() => {
const language = new Compartment();
const tabSize = new Compartment();
return [
props.basic ? basicSetup : undefined,
props.minimal && !props.basic ? minimalSetup : undefined,
EditorView.updateListener.of((update: ViewUpdate): void => {
context.emit('focus', view.value.hasFocus);
length.value = view.value.state.doc.length;
if (update.changes.empty || !update.docChanged) {
return;
}
if (props.linter) {
if (props.forceLinting) {
forceLinting(view.value);
}
diagnosticCount.value = (props.linter(view.value) as readonly Diagnostic[]).length;
}
context.emit('update', update);
}),
EditorView.theme(props.theme, { dark: props.dark }),
props.lineWrapping ? EditorView.lineWrapping : undefined,
props.tab ? keymap.of([indentWithTab]) : undefined,
EditorState.allowMultipleSelections.of(props.allowMultipleSelections),
props.tabSize ? tabSize.of(EditorState.tabSize.of(props.tabSize)) : undefined,
props.phrases ? EditorState.phrases.of(props.phrases) : undefined,
EditorState.readOnly.of(props.readonly),
EditorView.editable.of(!props.disabled),
props.lineSeparator ? EditorState.lineSeparator.of(props.lineSeparator) : undefined,
props.lang ? language.of(props.lang) : undefined,
props.linter ? linter(props.linter, props.linterConfig) : undefined,
// @ts-ignore
props.linter && props.gutter ? lintGutter(props.gutterConfig) : undefined,
props.placeholder ? placeholder(props.placeholder) : undefined,
...props.extensions,
].filter((extension): extension is Extension => !!extension);
});
watch(
extensions,
(exts) => {
view.value?.dispatch({
effects: StateEffect.reconfigure.of(exts),
});
},
{ immediate: true },
);
// 监听v-model传入的值
watch(
() => props.modelValue,
async (value) => {
if (view.value.composing || view.value.state.doc.toJSON().join(props.lineSeparator ?? '\n') === value) {
return;
}
view.value.dispatch({
changes: { from: 0, to: view.value.state.doc.length, insert: value },
selection: view.value.state.selection,
scrollIntoView: true,
});
},
{ immediate: true },
);
// dom挂载完成
onMounted(async () => {
let value: string | Text = doc.value;
if (!codemirror.value) {
return;
}
if (codemirror.value.childNodes[0]) {
if (doc.value !== '') {
console.warn('[PalmCodeMirror] 标记包含覆盖v-model');
}
value = (codemirror.value.childNodes[0] as HTMLElement).innerText.trim();
}
// 开始创建编辑器
if (typeof view.value !== 'undefined') {
view.value?.destroy();
}
view.value = new EditorView({
parent: codemirror.value,
state: EditorState.create({ doc: value, extensions: extensions.value }),
dispatch: (tr: Transaction) => {
view.value.update([tr]);
if (tr.changes.empty || !tr.docChanged) {
return;
}
context.emit('update:modelValue', (tr.state.doc as any).toString());
context.emit('change', tr.state);
},
});
await nextTick();
context.emit('ready', {
view: view.value,
state: view.value.state,
container: codemirror.value,
});
});
// 界面离开销毁编辑器
onUnmounted(() => {
view.value.destroy();
context.emit('destroy');
});

    const lint = (): void => {
      if (!props.linter || !view.value) {
        return;
      }
      if (props.forceLinting) {
        forceLinting(view.value);
      }
      diagnosticCount.value = linterDagnosticCount(view.value.state);
    };

    const forceReconfigure = (): void => {
      view.value?.dispatch({
        effects: StateEffect.reconfigure.of([]),
      });
      view.value?.dispatch({
        effects: StateEffect.appendConfig.of(extensions.value),
      });
    };
    // 获取编辑器的值
    const getRange = (from?: number, to?: number): string | undefined => view.value.state.sliceDoc(from, to);
    // 获取行
    const getLine = (number: number): string => view.value.state.doc.line(number + 1).text;
    // 获取代码行数
    const lineCount = (): number => view.value.state.doc.lines;
    // 获取光标位置
    const getCursor = (): number => view.value.state.selection.main.head;
    // 选中数量
    const listSelections = (): readonly SelectionRange[] => {
      let val;
      return (val = view.value.state.selection.ranges) !== null && val !== undefined ? val : [];
    };
    // 获取选中的数据
    const getSelection = (): string => {
      let val;
      return (val = view.value.state.sliceDoc(view.value.state.selection.main.from, view.value.state.selection.main.to)) !== null && val !== undefined ? val : '';
    };
    // 获取选中的数据 数组
    const getSelections = (): string[] => {
      const s = view.value.state;
      if (!s) {
        return [];
      }
      return s.selection.ranges.map((r: { from: number; to: number }) => s.sliceDoc(r.from, r.to));
    };
    // 检测是否有选中
    const checkSelected = (): boolean => view.value.state.selection.ranges.some((r: { empty: boolean }) => !r.empty);
    const replaceRange = (replacement: string | Text, from: number, to: number): void =>
      view.value.dispatch({
        changes: { from, to, insert: replacement },
      });
    // 替换选中
    const replaceSelection = (replacement: string | Text): void => view.value.dispatch(view.value.state.replaceSelection(replacement));
    // 设置光标位置
    const setCursor = (position: number): void => view.value.dispatch({ selection: { anchor: position } });
    // 设置选中
    const setSelection = (anchor: number, head?: number): void => view.value.dispatch({ selection: { anchor, head } });
    // 设置选中
    const setSelections = (ranges: readonly SelectionRange[], primary?: number): void =>
      view.value.dispatch({
        selection: EditorSelection.create(ranges, primary),
      });
    // 继承选择
    const extendSelectionsBy = (f: any): void =>
      view.value.dispatch({
        selection: EditorSelection.create(selection.value.ranges.map((r: SelectionRange) => r.extend(f(r)))),
      });

    const getViews = () => {
      return view.value;
    };

    const exposed = {
      blur,
      getViews,
      codemirror,
      view,
      cursor,
      selection,
      focus,
      length,
      json,
      diagnosticCount,
      dom: view.value.contentDOM,
      lint,
      forceReconfigure,
      getRange,
      getLine,
      lineCount,
      getCursor,
      listSelections,
      getSelection,
      getSelections,
      checkSelected,
      replaceRange,
      replaceSelection,
      setCursor,
      setSelection,
      setSelections,
      extendSelectionsBy,
    };
    context.expose(exposed);
    return exposed;

},
render() {
const blur = () => {
console.log('blur失去焦点');
};
return (

<div
        ref="codemirror"
        onBlur={blur}></div>
);
},
});
