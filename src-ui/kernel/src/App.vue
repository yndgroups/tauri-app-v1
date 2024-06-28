<template>
  <a-config-provider :locale="locale">
    <MainLayout />
  </a-config-provider>
</template>
<script setup lang="ts">
import { ref } from 'vue';
import zhCN from 'ant-design-vue/es/locale/zh_CN';
import dayjs from 'dayjs';
import 'dayjs/locale/zh-cn';
import MainLayout from './layouts/MicroView.vue';

dayjs.locale('zh-cn');
let locale = ref({
  locale: zhCN,
}) as any;

// oncontextmenu事件禁用右键菜单；
document.oncontextmenu = function () {
  console.log('右键已经禁用');
  // return false;
};

// onselectstart事件禁用网页上选取的内容；
document.onselectstart = function () {
  console.log('事件禁用网页上选取的内容');
  return false;
};

// oncopy事件禁用复制；
document.oncopy = function () {
  return false;
};

// 禁用鼠标事件
document.onmousedown = function (e) {
  if (e.which == 2) {
    // 鼠标滚轮的按下，滚动不触发
    return false;
  }
  if (e.which == 3) {
    // 鼠标右键
    return false;
  }
};
</script>
<style lang="scss" scoped>
i {
  display: flex;
  justify-content: center;
  align-items: center;
}
.codding-layout {
  background: $mainColor;
  min-height: 100vh;
  height: 100vh;
  min-height: 768px;
  min-width: 1366px;
  color: #fff;
  overflow: hidden;

  .top-bar {
    width: 100%;
    height: 41px;
    background-color: $thirdColor;
    border-bottom: 1px solid $deep;
    position: relative;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 24px;
  }

  .divider {
    width: 4px;
    background-color: $secondColor;

    &:hover {
      background-color: $gary;
      cursor: w-resize;
    }
  }

  .workspace {
    display: flex;
    height: calc(100vh - 41px);
  }

  .actions {
    width: 50px;
    height: 100%;
    background-color: $thirdColor;
    border-right: 1px solid $deep;
    overflow-y: overlay;
    text-align: center;

    ul li {
      padding: 10px 0;
      cursor: pointer;

      &:hover {
        background-color: $deep;
      }
    }
  }
  .file-tree {
    width: 250px;
    height: 100%;
    background-color: $deep;
    overflow-y: overlay;
  }

  .main {
    background-color: $mainColor;
    flex: 1;
  }

  .editor-area {
    height: calc(100vh - 361px);
    width: 100%;
    background-color: $thirdColor;
    border-bottom: 1px solid $deep;
    overflow-y: hidden;
  }
}
</style>
