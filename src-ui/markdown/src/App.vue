<template>
  <div>
    <ConfigProvider :locale="state.locale">
      <MainLayout />
    </ConfigProvider>
  </div>
</template>
<script lang="ts" setup>
import zhCN from 'ant-design-vue/es/locale/zh_CN';
import dayjs from 'dayjs';
import 'dayjs/locale/zh-cn';
import { ConfigProvider } from 'ant-design-vue';
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
</script>
