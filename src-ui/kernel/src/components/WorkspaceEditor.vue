<template>
  <div class="app-workspace">
    <!-- 菜单 -->
    <div class="app-file-tree">
      <template v-if="appSore.appList[appSore.appActiveIndex] && appSore.appList[appSore.appActiveIndex].fileList && appSore.appList[appSore.appActiveIndex].fileList?.length">
        <FileTree
          :data="appSore.appList[appSore.appActiveIndex].fileList"
          @openFile="openFile" />
      </template>
    </div>
    <div class="divider"></div>
    <!-- 编辑区域 -->
    <div class="app-core">
      <CodeEditor />
    </div>
  </div>
</template>
<script setup lang="ts">
import FileTree from '../components/FileTree.vue';
import { useAppStroe, useFileStore } from '../store';
import { open } from '@tauri-apps/api/dialog';
import keyboard from '../utils/keyboard';
import { BaseDirectory, readDir, writeTextFile } from '@tauri-apps/api/fs';
import { onMounted } from 'vue';
// import { App } from '../../types';

const fileStore = useFileStore();
const appSore = useAppStroe();

onMounted(() => {
  registerKeyboard();
});
// 打开进行文件夹选择
// @ts-ignore
async function choose() {
  const selectedPath = await open({
    directory: true,
    multiple: true,
    defaultPath: BaseDirectory.Home.toString(),
  });
  if (Array.isArray(selectedPath)) {
    console.log('用户选择了多个目录', selectedPath);
    let path = selectedPath[0];
    const entries = await readDir(path, { dir: BaseDirectory.Home, recursive: true });
    // fileList.value = entries as any;
    // fileStore.openPath = path;
    if (entries && entries.length) {
      let pathName = path;
      let pathArr = path.split('/');
      if (pathArr.length) {
        pathName = pathArr[pathArr.length - 1];
      }
      let fileList = [
        {
          path: path,
          children: entries,
          key: path,
          name: pathName,
          expand: true,
        },
      ] as any;
      appSore.appList[appSore.appActiveIndex].fileList = fileList;

      appSore.openPath = path;
    }
  } else if (selectedPath === null) {
    console.log('用户取消了选择', selectedPath);
  } else {
    console.log('用户选择了一个目录', selectedPath);
    fileStore.openPath = selectedPath;
    const entries = await readDir(selectedPath, { dir: BaseDirectory.Home, recursive: true });
    // fileList.value = entries as any;
    appSore.openPath = selectedPath;
    if (entries && entries.length) {
      let pathName = selectedPath;
      let pathArr = selectedPath.split('/');
      if (pathArr.length) {
        pathName = pathArr[pathArr.length - 1];
      }
      let fileList = [
        {
          path: selectedPath,
          children: entries,
          key: selectedPath,
          name: pathName,
          expand: true,
        },
      ] as any;
      appSore.appList[appSore.appActiveIndex].fileList = fileList;
    }
  }
}

// 打开文件
async function openFile(fileInfo: any) {
  fileStore.setFileList({
    key: fileInfo.path,
    name: fileInfo.name,
    path: fileInfo.path,
    editStatus: true,
    fileContent: fileInfo.fileContent,
  });
}

// 主持快捷键
// @ts-ignore
function registerKeyboard() {
  let kbd = keyboard();
  console.log(kbd, 'kbdkbdkbd');
  kbd.key(
    '⌘+x,ctrl+x,⌘+c,ctrl+c,⌘+s,ctrl+s,⌘+o,ctrl+o',
    async (event: any, handler: any) => {
      console.log(fileStore.file);
      let fileContent = fileStore.file.fileContent || '';
      let filePath = fileStore.file.path || '';
      console.log(event, handler.shortcut, handler.scope, 'keyboard >>>>>>>');
      switch (true) {
        // 保存文件
        case handler.shortcut == '⌘+s' || handler.shortcut == 'ctrl+s':
          await writeTextFile(filePath, fileContent);
          fileStore.file.editStatus = false;
          break;
        case handler.shortcut == '⌘+o' || handler.shortcut == 'ctrl+o':
          console.log('打开文件');
          choose();
          break;
      }
      return false;
    },
    undefined,
  );
}
</script>
<style lang="scss" scoped>
.app-layout {
  background: $mainColor;
  min-height: 100vh;
  height: 100vh;
  min-height: 768px;
  min-width: 1366px;
  color: #fff;
  overflow: hidden;

  .app-workspace {
    display: flex;
    height: calc(100vh - $top-bar-height);
    overflow: hidden;
    box-sizing: border-box;
  }

  .app-actions {
    width: $actions-width;
    height: calc(100vh - $top-bar-height);
    background-color: $thirdColor;
    border-right: 1px solid $deep;
    overflow-y: overlay;
    text-align: center;
    box-sizing: border-box;

    ul li {
      padding: 10px 0;
      cursor: pointer;
      font-size: $app-size;
      .item {
        display: block;
        width: 100%;
        height: 100%;
      }

      &:hover {
        background-color: $deep;
      }

      &.active {
        background-color: $deep;
      }
    }
  }
  .app-file-tree {
    width: $file-tree-width;
    height: calc(100vh - $top-bar-height);
    background-color: $deep;
    overflow-y: overlay;
    box-sizing: border-box;
    overflow-x: hidden;
  }

  .app-core {
    background-color: $mainColor;
    width: calc(100vw - $actions-width - $file-tree-width);
    box-sizing: border-box;
  }
}
</style>
