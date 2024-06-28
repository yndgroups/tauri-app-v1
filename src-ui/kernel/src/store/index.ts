import type { App } from 'vue';
import { createPinia } from 'pinia';
import appStore from './app';
import fileStore from './file';
import userStore from './user';

const store = createPinia();

export { store };

export function setupStore(app: App<Element>) {
  app.use(store);
}

// 初始化appStore
export function useAppStroe() {
  return appStore(store);
}

// 初始化fileStore
export function useFileStore() {
  return fileStore(store);
}

// 初始化userSore
export function useUserStore() {
  return userStore(store);
}
