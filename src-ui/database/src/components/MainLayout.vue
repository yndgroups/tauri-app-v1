<template>
  <div class="palm-db-main">
    <div class="editor-work">
      <!-- 连接区 -->
      <div
        v-if="state.showLeft"
        ref="dragLeftParent"
        class="editor-links"
        @contextmenu.stop.prevent="navRightClick">
        <div class="search-box">
          <div class="input">
            <a-input-search placeholder="请输入关键词" />
          </div>
          <div
            class="create-database"
            @click="toolChange({ id: 1 })">
            <PalmSvg
              :name="'createDatabase'"
              :width="26"
              :color="'#666'"></PalmSvg>
          </div>
        </div>
        <div class="tree-link">
          <MenuTree
            :data="store.linkList"
            @openLink="openLink"
            @deleteLinkHandle="deleteLinkHandle" />
        </div>
        <div
          ref="dragLeft"
          class="drag-line"
          @mousedown="leftMousedown($event)"></div>
      </div>
      <!-- 操作区 -->
      <div
        class="editor-operation"
        @contextmenu="rightClick">
        <component
          :is="layouts[state.layoutsName]"
          :data="state.checkedItem"></component>
      </div>
    </div>
    <div class="editor-views">
      <div
        class="left icon"
        @click="state.showLeft = !state.showLeft"></div>
      <div
        class="right icon"
        @click="state.showRight = !state.showRight"></div>
    </div>

    <!-- 添加连接 -->
    <CreateLink
      v-if="state.visible"
      :visible="state.visible"
      @closeModal="state.visible = false"
      @refresh="refresh" />

    <a-modal
      v-model:open="state.open"
      title="删除提示"
      @ok="deleteLinkHandle">
      <p class="del-notice">您确定要删除吗？</p>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import { reactive, ref, onMounted, watch } from 'vue';
import PalmSvg from './PalmSvg.vue';
import welcome from './PalmWelcome.vue';
import PalmIcon from './PalmIcon.vue';
import { message } from 'ant-design-vue';
import { listen } from '@tauri-apps/api/event';
import CreateLink from './CreateLink.vue';
import DbLayout from './Layout.vue';
import MenuTree from './MenuTree.vue';
import { Response } from '../../env';
import { useLinkStore } from '../store/links';

const store = useLinkStore();
console.log(store, 'store-------');

function navRightClick() {
  console.log('链接区域右击事件');
  return false;
}

function rightClick() {
  console.log('内容区域右击事件');
}

// import { useLayoutStore } from "../store/modules/layout";
// const mainStore = useLayoutStore();
const dragLeft = ref<HTMLElement>();
const dragLeftParent = ref<HTMLElement>();
// const dragRight = ref<HTMLElement>();
// const dragRightParent = ref<HTMLElement>();
const layouts: any = {
  dbLayout: DbLayout,
  welcome: welcome,
};

// 数据初始化
const state = reactive({
  layoutsName: 'dbLayout',
  showLeft: true,
  showRight: true,
  visible: false,
  open: false,
  actions: [
    { name: '连接', icon: 'createLink', id: 1, width: 20, color: '#F00' },
    { name: '新建查询', icon: 'createQuery', id: 2, width: 20, color: '#F00' },
    { name: '表', icon: 'table', id: 2, width: 20, color: '#F00' },
    { name: '视图', icon: 'views', id: 3, width: 20, color: '#F00' },
    { name: '函数', icon: 'fn', id: 4, width: 20, color: '#F00' },
    { name: '事件', icon: 'event', id: 5, width: 20, color: '#F00' },
    { name: '用户', icon: 'user', id: 6, width: 20, color: '#F00' },
    { name: '查询', icon: 'tableQuery', id: 7, width: 20, color: '#F00' },
    { name: '报表', icon: 'report', id: 8, width: 20, color: '#F00' },
    { name: '备份', icon: 'bak', id: 9, width: 20, height: 10, color: '#F00' },
    { name: '自动运行', icon: 'autoRun', id: 10, width: 20, color: '#F00' },
    { name: '模型', icon: 'model', id: 11, width: 20, color: 'blue' },
  ],
  lX: 0,
  rX: 0,
  treeData: new Array<any>() as any,
  checkedItem: {},
  expandedKeys: [] as any,
  delId: '', // 要删除的id信息
});

onMounted(async () => {
  getLinks();
});

/*刷新菜单数据*/
const refresh = () => {
  getLinks();
};

// 删除连接
const deleteLinkHandle = async (delId: string) => {
  let { code, msg }: Response = await window.Bridge.invoke('plugin:sqlite|delete', {
    id: `${delId}`,
    tbMark: 1,
  });
  if (code === 1) {
    refresh();
    state.open = false;
    message.success(msg);
  } else {
    message.error(msg);
  }
};

/*获取连接*/
const getLinks = async () => {
  let { code, data }: Response = await window.Bridge.invoke('plugin:sqlite|get_links', {
    params: {},
    operationType: 1,
  });
  if (code === 1) {
    if (data && typeof data === 'object') {
      let list = data || [];
      if (Array.isArray(list)) {
        list = list.map((item: any, index: number) => {
          item.key = `${item.host}_${item.id}_${index}`;
          item.title = item.link_name;
          item.children = [];
          item.itemType = 'link';
          return item;
        }) as any;
        store.linkList = list as any;
      }
    }
  } else {
    message.error('暂无数据');
  }
};

// 监听布局改变
listen('changeWindowLayout', (event) => {
  console.log('参数');
  console.log(event);
  state.showLeft = !state.showLeft;
});

// 工具栏切换
const toolChange = (o: any) => {
  switch (o.id) {
    case 1:
      if (!state.visible) {
        state.visible = true;
      }
      break;
  }
  console.log(o, '工具栏切换');
};

// 左边拖动
const leftMousedown = (event: any) => {
  let dragWidth = 0;
  let dragContainerWidth = 0;
  if (dragLeft.value && dragLeftParent.value) {
    state.lX = event.clientX - dragLeft.value.offsetLeft;
    dragWidth = dragLeft.value.offsetWidth;
    dragContainerWidth = dragLeftParent.value.offsetWidth + 100;
  }
  document.onmousemove = (el) => {
    let moveX = el.clientX - state.lX;
    if (moveX <= 0) {
      moveX = 0;
    }

    if (moveX >= dragContainerWidth - dragWidth) {
      moveX = dragContainerWidth - dragWidth;
    }
    if (moveX > 150 && moveX < 350) {
      if (dragLeftParent.value) {
        dragLeftParent.value.style.width = `${moveX}px`;
      }
    }
  };

  document.onmouseup = () => {
    document.onmousemove = null;
  };
};

// 菜单栏
const onContextMenuClick = async (treeKey: string, menuKey: number, id: number) => {
  console.log(`treeKey: ${treeKey}, menuKey: ${menuKey}, id = ${id}`);
  switch (menuKey) {
    case 1:
      state.open = true;
      state.delId = `${id}`;
      break;
  }
};

// 监听
watch(state.expandedKeys, () => {
  console.log('expandedKeys', state.expandedKeys);
});

// 选择数据库
async function executeSql(uniqure: String) {
  let { code }: Response = await window.Bridge.invoke('plugin:mysql|execute_sql', {
    sql: `use ${uniqure}`,
  });
  if (code !== 1) {
    message.error('数据库选取失败');
  }
}

function openLink(item: any) {
  state.checkedItem = item;
  state.layoutsName = 'dbLayout';
  switch (item.itemType) {
    case 'link':
      getDbLinksTree(item);
      break;
    case 'database':
      executeSql(item.linkName);
      console.log(item, '选择数据库');
      break;
  }
}

// 获取树
const getDbLinksTree = async (item: any) => {
  // 连接接口
  let { code, msg }: Response = await window.Bridge.invoke('plugin:mysql|link_db', {
    params: {
      host: item.host,
      user: item.user,
      password: item.password,
      dbType: 'mysql',
      port: item.port,
      linkName: item.linkName,
      title: '',
    },
  });
  if (code === 1) {
    let { code, data, msg }: Response = await window.Bridge.invoke('plugin:mysql|query_schema', {
      params: {
        linkName: item.linkName,
        dbType: item.dbType,
      },
    });
    if (code === 1) {
      if (Array.isArray(data) && data.length) {
        if (state.expandedKeys.indexOf(item.key) === -1) {
          state.expandedKeys.push(item.key);
        }
        let list = data.map((dbName: any, index: number) => {
          let id: string = `chidren_db_${index}`;
          if (state.expandedKeys.indexOf(id) === -1) {
            state.expandedKeys.push(id);
          }
          return {
            linkName: dbName,
            key: id,
            dbType: 'database',
            itemType: 'database',
            expand: true,
            id: id,
          };
        });
        if (store.linkList && store.linkList.length) {
          store.linkList = store.linkList.map((o: any) => {
            if (item.itemType === 'link' && item.id === o.id) {
              item.expand = true;
              o.children = list;
            }
            return o;
          });
        }
        if (item) {
          item.children = list;
        }
      }
    } else {
      message.error(msg || '查询失败');
    }
  } else {
    message.error(msg || '操作失败');
  }
};
</script>
<style lang="scss" scoped>
.palm-db-main {
  min-height: 100vh;
  min-width: 100vw;
  overflow: hidden;
  .editor-work {
    height: calc(100vh - 30px);
    background-color: val(--color-bg-container);
    display: flex;

    .editor-links {
      width: 350px;
      background-color: val(--color-bg-container);
      position: relative;
      margin-right: 4px;
      box-sizing: border-box;
      overflow: hidden;

      .search-box {
        display: flex;
        justify-content: space-between;
        padding-top: 10px;
        padding-left: 10px;

        .input {
          flex: 1;
        }
        .create-database {
          margin-left: 10px;
        }
      }

      .tree-link {
        padding: 10px;
        overflow-x: hidden;
        overflow-y: auto;
        box-sizing: border-box;
        height: calc(100vh - 80px);
      }

      .drag-line {
        position: absolute;
        width: 4px;
        height: 100%;
        background: var(--color-border);
        z-index: 9;
        right: 0px;
        top: 0;
        cursor: col-resize;
      }
    }

    .editor-operation {
      flex: 1;
    }
  }

  .editor-views {
    height: 30px;
    background-color: var(--color-border);
    display: flex;
    justify-content: right;
    align-items: center;
    padding-right: 20px;

    .icon {
      border: 1px solid var(--color-border);
      width: 18px;
      height: 20px;
      margin-right: 5px;
      display: flex;
      align-items: center;
      cursor: pointer;

      &.left::after,
      &.right::after {
        content: '';
        width: 6px;
        height: 15px;
        background-color: var(--color-border);
      }

      &.left {
        box-sizing: border-box;
        padding-left: 2px;
        justify-content: left;
      }
      &.right {
        box-sizing: border-box;
        padding-right: 2px;
        justify-content: right;
      }
    }
  }
}
.del-notice {
  color: var(--warning);
}
</style>
