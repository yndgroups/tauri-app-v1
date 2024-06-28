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
    <div class="app-core">插件扩展</div>
  </div>
</template>
<script setup lang="ts">
import FileTree from '../components/FileTree.vue';
import { useAppStroe, useFileStore } from '../store';
// import { onMounted } from 'vue';

const fileStore = useFileStore();
const appSore = useAppStroe();

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
