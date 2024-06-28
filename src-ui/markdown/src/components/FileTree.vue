<template>
  <FileTree />
</template>
<script setup lang="tsx">
import { h, onMounted } from 'vue';
import { FolderOutlined, FileOutlined, DownOutlined, RightOutlined } from '@ant-design/icons-vue';
import { open } from '@tauri-apps/api/dialog';
import { BaseDirectory, readDir, readTextFile } from '@tauri-apps/api/fs';
import { MenuProps } from 'ant-design-vue';
const props = defineProps({
  data: {
    type: Array,
    required: true,
  },
});
const emits = defineEmits(['openFile']);

const FileTree = () => {
  // console.log(props.data, 'datadatadatadata');
  return render(props.data);
};

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
    openFile(item);
  }
}

async function openFile(item: any) {
  const contents = await readTextFile(item.path);
  item.fileContent = contents;
  console.log(contents, 'contents');
  emits('openFile', item);
}

// 二进制转字符串
function Uint8ArrayToString(fileData) {
  var dataString = '';
  for (var i = 0; i < fileData.length; i++) {
    dataString += String.fromCharCode(fileData[i]);
  }
  return dataString;
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
                class={`tree-node ${item.expand ? 'switcher_open' : 'switcher_close'}`}>
                {item.expand ? <DownOutlined /> : <RightOutlined />}
                <span class="tree-title">{item.name}</span>
              </dt>
              <dd>{render(item.children, index)}</dd>
            </>
          );
        } else {
          return (
            <>
              {index > 1 ? (
                <dt
                  onClick={(e) => selected(item, e)}
                  class="tree-node">
                  <FileOutlined />
                  <span class="tree-title">{item.name}</span>
                </dt>
              ) : (
                <dt
                  onClick={(e) => selected(item, e)}
                  class="tree-node">
                  <FileOutlined />
                  <span class="tree-title">{item.name}</span>
                </dt>
              )}
            </>
          );
        }
      })}
    </dl>
  );
};

onMounted(async () => {});

const handleClick: MenuProps['onClick'] = (e) => {
  console.log('click', e);
};

const openDir = async () => {
  // Open a selection dialog for directories
  const selected = await open({
    directory: true,
    multiple: true,
    defaultPath: BaseDirectory.Home.toString(),
  });
  if (Array.isArray(selected)) {
    const entries = await readDir('test', { dir: BaseDirectory.Home, recursive: true });
    processEntries(entries);
    console.log('用户选择了多个目录', selected);
  } else if (selected === null) {
    console.log('用户取消了选择', selected);
  } else {
    console.log('用户选择了一个目录', selected);
  }
};

function recursion(dataArr) {
  const _this = this;
  const arr = [] as any;
  if (dataArr && Array.isArray(dataArr)) {
    dataArr.forEach((item: any, index: number) => {
      if (item.children && item.children.length > 0) {
        const children = recursion(item.children);
        item.children = children;
        item.title = item.name;
        item.key = item.path;
        item.label = item.name;
        item.icon = () => h(FolderOutlined);
        arr.push(item);
      } else {
        item.title = item.name;
        item.key = item.path;
        item.label = item.name;
        item.icon = () => h(FileOutlined);
        arr.push(item);
      }
    });
  }
  return arr;
}

function processEntries(entries) {
  let fileList: Array<string> = new Array();
  for (const entry of entries) {
    console.log(`Entry: ${entry.path}`);
    fileList.push(entry.path);
    if (entry.children) {
      fileList.concat(processEntries(entry.children));
    }
  }
  return fileList;
}
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
    overflow: hidden;
  }

  dt,
  dd {
    cursor: pointer;
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
