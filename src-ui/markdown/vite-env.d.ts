/// <reference types="vite/client" />

declare module '@ant-design/icons-vue';
declare module 'dayjs';
declare module 'lodash-es';
declare module 'codemirror-editor-vue3';
declare module '@codemirror/lang-markdown';
declare module '@codemirror/state';
declare module '@codemirror/view';
declare module 'codemirror';
declare module '@highlightjs/vue-plugin';
declare module '@ant-design/icons-vue';
declare module 'dayjs';
declare module 'lodash-es';
declare module 'vue-demi';
declare module 'unified';
declare module 'remark-parse';
declare module 'remark-rehype';
declare module 'rehype-stringify';
declare module 'remark-math';
declare module 'rehype-katex';
declare module 'rehype-document';
declare module 'rehype-highlight';
declare module 'remark-gfm';

export interface Bridge {
  invoke: Promise;
}

declare global {
  interface Window {
    Bridge: Bridge;
  }
}

declare module '*.vue' {
  import type { DefineComponent } from 'vue';
  const component: DefineComponent<{}, {}, any>;
  export default component;
}
