<template>
  <div class="page-welcome">
    <div v-if="state.welcomeText">{{ state.welcomeText }}</div>
  </div>
</template>

<script setup lang="ts">
import { nextTick, reactive } from 'vue';
import { invoke } from '@tauri-apps/api/tauri';
import { getName } from '@tauri-apps/api/app';
const state = reactive({
  welcomeText: '',
});
defineOptions({
  name: 'Welcome',
});
nextTick(async () => {
  // 调用原生函数
  const appName = await getName();
  const res = await invoke('welcome', { appName: appName });
  state.welcomeText = res as string;
  console.info(res);
});
</script>
