<template>
  <ConfigProvider :locale="state.locale">
    <MainLayout />
  </ConfigProvider>
</template>
<script lang="ts" setup>
import zhCN from 'ant-design-vue/es/locale/zh_CN';
import dayjs from 'dayjs';
import 'dayjs/locale/zh-cn';
import { ConfigProvider } from 'ant-design-vue';
import MainLayout from './components/MainLayout.vue';
import { reactive } from 'vue';
import { Theme, ThemeModeEnum } from './utils/theme';
import { listen } from '@tauri-apps/api/event';
dayjs.locale('zh-cn');
const state = reactive({ locale: zhCN });
const theme = new Theme(ThemeModeEnum.dark);
const changeTheme = (mode: ThemeModeEnum) => {
  theme.themeChange(mode);
};
// 监听布局改变
listen('changeTheme', (event) => {
  console.log('参数');
  console.log(event);
  changeTheme('light' as any);
});

// oncontextmenu事件禁用右键菜单；
// document.oncontextmenu = function () {
//   console.log('右键已经禁用');
//   return false;
// };

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
