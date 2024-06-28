<template>
  <a-layout class="layout-main">
    <a-layout-sider
      v-model:collapsed="collapsed"
      :trigger="null"
      theme="light"
      width="300"
      class="layout-sider"
      collapsible>
      <div class="logo" />
      <FileTree
        :data="fileList"
        @openFile="openFile" />
    </a-layout-sider>
    <a-layout>
      <a-layout-header style="background: #fff; padding: 0">
        <FileTabs>
          <template #action>
            <menu-unfold-outlined
              v-if="collapsed"
              class="trigger"
              @click="() => (collapsed = !collapsed)" />
            <menu-fold-outlined
              v-else
              class="trigger"
              @click="() => (collapsed = !collapsed)" />
          </template>
        </FileTabs>
      </a-layout-header>
      <a-layout-content :style="{ background: '#fff', minHeight: '280px' }">
        <Editor />
      </a-layout-content>
    </a-layout>
  </a-layout>
</template>
<script lang="ts" setup>
import { onMounted, ref } from 'vue';
import { MenuUnfoldOutlined, MenuFoldOutlined } from '@ant-design/icons-vue';
import FileTree from './FileTree.vue';
import FileTabs from './FileTabs.vue';
import Editor from './Editor.vue';
import { BaseDirectory, readDir, writeTextFile } from '@tauri-apps/api/fs';
import { useFileStoreWithOut } from '../store/file';
import keyboard from '../utils/keyboard';
const store = useFileStoreWithOut();
const collapsed = ref<boolean>(false);
const fileList = ref<any>([]);

// 读取文件列表
async function getFileList() {
  const entries = await readDir('test', { dir: BaseDirectory.Home, recursive: true });
  fileList.value = entries as any;
}

// 打开文件
async function openFile(fileInfo: any) {
  store.setFileList({
    key: fileInfo.path,
    name: fileInfo.name,
    path: fileInfo.path,
    editStatus: false,
    fileContent: fileInfo.fileContent,
  });
}

onMounted(() => {
  let kbd = keyboard();
  console.log(kbd, 'kbdkbdkbd');
  kbd.key(
    '⌘+x,ctrl+x,⌘+c,ctrl+c,⌘+s,ctrl+s',
    async (event, handler) => {
      console.log(store.file);
      let fileContent = store.file.fileContent || '';
      let filePath = store.file.path || '';
      console.log(event, handler.shortcut, handler.scope, 'keyboard >>>>>>>');
      switch (true) {
        case handler.shortcut == '⌘+s' || handler.shortcut == 'ctrl+s':
          await writeTextFile(filePath, fileContent);
          store.file.editStatus = false;
          break;
      }
      return false;
    },
    undefined,
  );
  getFileList();
});
</script>

<style lang="scss" scoped>
.layout-main {
  min-height: 100vh;
  min-width: 100vw;
  overflow: hidden;
}
:deep(.ant-layout-header) {
  padding: 0;
  margin: 0;
}
:deep(.ant-layout-content) {
  padding: 0;
  margin: 0;
}
.files-nav {
  display: flex;
  align-items: center;
  overflow: hidden;
}

.layout-sider {
  height: 100vh;
  overflow: hidden auto;
}
</style>
