<template>
  <div
    class="app-layout"
    v-if="finished">
    <div class="app-top-bar">
      <div>Palm</div>
      <div>
        <SettingOutlined />
      </div>
    </div>
    <div class="app-workspace">
      <!-- 应用列表 -->
      <div class="app-actions">
        <ul v-if="appSore.appList && appSore.appList.length">
          <li
            v-for="(app, index) in appSore.getApp"
            :class="{ active: appSore.appActiveIndex === index }"
            :key="app.uniqueKey">
            <a-tooltip
              placement="right"
              :title="app.name"
              :color="app.color"
              @click.prevent="appClickHandle(index, app.uniqueKey)">
              <div class="item">
                <component :is="icons[app.icon]" />
              </div>
            </a-tooltip>
          </li>
        </ul>
      </div>
      <!-- 核心区域 -->
      <div class="app-workspace-editor">
        <WorkspaceEditor v-if="appUniqueKey === '1'" />
        <Extend v-else-if="appUniqueKey === '2'" />
        <div
          id="expansion-bridge"
          ref="expansionBridge"
          v-else></div>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { AppstoreAddOutlined, MediumOutlined, SettingOutlined, FileAddOutlined, BranchesOutlined, CodeSandboxOutlined, FileMarkdownOutlined } from '@ant-design/icons-vue';
import { useAppStroe } from '../store';
import { AnyObject } from '../../types';
import Palm from '../core/palm';
import { nextTick } from 'vue';
const expansionBridge = ref<HTMLElement>();
const showEditor = ref(false);
const icons = {
  CodeSandboxOutlined: CodeSandboxOutlined,
  FileAddOutlined: FileAddOutlined,
  BranchesOutlined: BranchesOutlined,
  FileMarkdownOutlined: FileMarkdownOutlined,
  MediumOutlined: MediumOutlined,
  AppstoreAddOutlined: AppstoreAddOutlined,
} as AnyObject;
const appSore = useAppStroe();
const finished = ref(false);
const appUniqueKey = ref<string>('1');
// 初始化应用界面
onMounted(async () => {
  let palm = new Palm('palm', 'v0.0.1');
  finished.value = true;
  if (appSore.app && appSore.app.uniqueKey != undefined && appSore.app.uniqueKey !== '1') {
    showEditor.value = false;
    await palm.loadPlugins();
    palm.registerPlugins();
    nextTick(async () => {
      palm.initApp(appSore.app);
    });
  } else {
    await palm.loadPlugins();
    palm.registerPlugins();
    showEditor.value = true;
  }
  window.Palm = palm;
});

// 应用事件
function appClickHandle(index: number, uniqueKey: string) {
  try {
    // 卸载
    if (uniqueKey !== appSore.app.uniqueKey) {
      appUniqueKey.value = uniqueKey;
      window.Palm.unmount();
      if (uniqueKey !== '1') {
        showEditor.value = false;
        nextTick(() => {
          let app = appSore.microApps.get(uniqueKey);
          window.Palm.initApp(app);
        });
      } else {
        showEditor.value = true;
      }
      appSore.setActiveIndex(index);
    }
  } catch (error) {
    console.error(error);
  }
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

  // 头部导航
  .app-top-bar {
    width: 100%;
    height: $top-bar-height;
    background-color: $thirdColor;
    position: relative;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 24px;
    box-sizing: border-box;
  }

  // 分割线拖动
  .divider {
    width: 4px;
    background-color: $secondColor;

    &:hover {
      background-color: $gary;
      cursor: w-resize;
    }
  }

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

  .app-workspace-editor {
    background-color: $mainColor;
    width: calc(100vw - $actions-width);
    box-sizing: border-box;
  }
}
</style>
