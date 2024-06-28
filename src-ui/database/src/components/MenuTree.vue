<template>
  <FileTree />
</template>
<script setup lang="tsx">
import { reactive } from 'vue';
import { CaretDownOutlined, CaretRightOutlined } from '@ant-design/icons-vue';
import { confirm } from '@tauri-apps/api/dialog';
import PalmIcon from './PalmIcon.vue';
const props = defineProps({
  data: {
    type: Array,
    required: true,
  },
});
const emits = defineEmits(['openLink', 'deleteLinkHandle']);
const state = reactive({
  x: 0,
  y: 0,
  currentItem: {} as any,
});

const FileTree = () => {
  // console.log(props.data, 'datadatadatadata');
  return render(props.data);
};

// 选中
function selected(item: any, el: any) {
  console.log(item, 'itemitem');
  el.stopPropagation();
  if (item.children && item.children.length) {
    if (item.expand === undefined) {
      item.expand = true;
    } else {
      item.expand = !item.expand;
    }
  } else {
    openLink(item);
  }
}

// 打开链接
async function openLink(item: any) {
  emits('openLink', item);
}

function contextmenu(item: any, evt: any) {
  // console.log('右击菜单', item, evt);
  state.x = evt.clientX;
  state.y = evt.clientY;
  item.showContextmenu = true;
  state.currentItem = item;
  // evt.stopPropagation(); // 阻止冒泡会出现菜单
  return false;
}

function onMouseout(item: any, evt: any) {
  console.log('右击菜单');
  evt.stopPropagation();
  // item.showContextmenu = false;
}

// 草错类型枚举
enum OperationType {
  createTable = 'createTable',
  createDataBase = 'createDataBase',
  createQuery = 'createQuery',
  edit = 'edit',
  delete = 'delete',
}

document.onclick = () => {
  state.currentItem.showContextmenu = false;
};

async function navClick(item: any, type: string, e: any) {
  state.currentItem = item;
  e.stopPropagation();
  item.showContextmenu = false;
  switch (true) {
    case OperationType.createDataBase == type:
      // 创建数据库
      break;
    case OperationType.createTable == type:
      // 创建表
      break;
    case OperationType.createQuery == type:
      // 创建查询
      break;
    case OperationType.edit == type:
      // 编辑
      break;
    case OperationType.delete == type:
      // 编辑
      const res = await confirm('文件还未保存，确定删除吗?', {
        title: '关闭提示',
        type: 'warning',
        okLabel: '确定',
        cancelLabel: '取消',
      });
      if (res) {
        emits('deleteLinkHandle', item.id);
        // store.removeFileList(index);
      }
      break;
  }
  return false;
}

function createRightMenu(item: any) {
  console.log(item, 'createRightMenu');
  return (
    <ul
      class="menu-tree-nav"
      style={`left: ${state.x}px;top: ${state.y}px`}>
      {item.itemType === 'link' ? (
        <>
          <li onClick={(e) => navClick(item, OperationType.createDataBase, e)}>打开链接</li>
          <li onClick={(e) => navClick(item, OperationType.createDataBase, e)}>编辑链接</li>
          <li onClick={(e) => navClick(item, OperationType.createDataBase, e)}>新建链接</li>
          <li onClick={(e) => navClick(item, OperationType.createDataBase, e)}>新建数据库</li>
          <li onClick={(e) => navClick(item, OperationType.createDataBase, e)}>复制链接</li>
          <li onClick={(e) => navClick(item, OperationType.delete, e)}>删除连接</li>
        </>
      ) : item.itemType === 'database' ? (
        <>
          <li onClick={(e) => navClick(item, OperationType.createTable, e)}>打开数据库</li>
          <li onClick={(e) => navClick(item, OperationType.createTable, e)}>编辑数据库</li>
          <li onClick={(e) => navClick(item, OperationType.createDataBase, e)}>新建数据库</li>
          <li onClick={(e) => navClick(item, OperationType.delete, e)}>删除数据库</li>
          <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>新建查询</li>
          <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>转储sql文件</li>
          <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>运行sql文件</li>
          <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>刷新</li>
        </>
      ) : (
        <>
          <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>新建查询</li>
        </>
      )}
      <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>管理组</li>
      <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>颜色</li>
      <li onClick={(e) => navClick(item, OperationType.createQuery, e)}>刷新</li>
    </ul>
  );
}

// 渲染jsx模版
const render = (data: any, index: number = 0) => {
  // console.log(data, 'data');
  index += 1;
  return (
    <dl
      class="file-tree"
      style={'--pw:' + index * 15 + 'px'}>
      {data.map((item: any) => {
        if (item.children && item.children.length > 0) {
          return (
            <>
              <dt
                onClick={(e) => selected(item, e)}
                onContextmenu={contextmenu.bind(this, item)}
                onMouseout={(e) => onMouseout(item, e)}
                class={`tree-node ${item.expand ? 'switcher_open' : 'switcher_close'}`}>
                {item.expand ? <CaretDownOutlined /> : <CaretRightOutlined />}
                <PalmIcon
                  color="#666"
                  width={14}
                  height={14}
                  name={item.dbType}
                />
                <span class="tree-title">{item.linkName}</span>
                {item.showContextmenu ? createRightMenu(item) : ''}
              </dt>
              <dd>{render(item.children, index)}</dd>
            </>
          );
        } else {
          return (
            <dt
              onClick={(e) => selected(item, e)}
              class="tree-node"
              onContextmenu={contextmenu.bind(this, item)}
              onMouseout={(e) => onMouseout(item, e)}>
              <PalmIcon
                color="#666"
                width={14}
                height={14}
                name={item.dbType}
              />
              <span class="tree-title">{item.linkName}</span>
              {item.showContextmenu ? createRightMenu(item) : ''}
            </dt>
          );
        }
      })}
    </dl>
  );
};
</script>

<style lang="scss">
.file-tree {
  dl,
  dt,
  dd {
    padding: 0;
    margin: 0;
    white-space: nowrap;
    text-overflow: ellipsis;
  }

  dt,
  dd {
    cursor: pointer;
  }

  dt {
    position: relative;
    .menu-tree-nav {
      position: fixed;
      z-index: 99;
      color: #333;
      background-color: #fff;
      padding: 5px 10px;
      box-shadow: 1px 1px 3px #e4e4e4;
      border-radius: 4px;
      border: 1px solid #f1f1f1;
      li {
        border-bottom: 1px solid #ededed;
        list-style: none;
        padding: 2px 20px;

        &:last-child {
          border-bottom: none;
        }
      }
    }
  }

  .tree-title {
    padding-left: 5px;
  }
}
.tree-node {
  margin-left: var(--pw);
  cursor: pointer;
  height: 30px;
  line-height: 30px;

  &:hover {
    background-color: #f7f7f7;
  }

  &::before {
    content: '';
    display: inline-block;
    width: var(--pw);
  }
}
.switcher_open + dd {
  display: block;
}
.switcher_close + dd {
  display: none;
}
</style>
