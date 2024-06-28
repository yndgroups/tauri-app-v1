/// <reference types="vite/client" />

import { Bridge, Palm, PalmEditor } from './types';

declare module '@highlightjs/vue-plugin';
declare module '@ant-design/icons-vue';
declare module 'dayjs';
declare module 'lodash-es';
declare module 'codemirror-editor-vue3';
declare module 'vue-codemirror6';
declare module '@codemirror/lang-markdown';
declare module '@codemirror/state';
declare module '@codemirror/view';
declare module 'vue-demi';
declare module 'codemirror';
declare module 'unified';
declare module 'remark-parse';
declare module 'remark-rehype';
declare module 'rehype-stringify';
declare module 'remark-math';
declare module 'rehype-katex';
declare module 'rehype-document';
declare module 'rehype-highlight';
declare module 'remark-gfm';
declare module 'palm-editor/dist';
declare module 'lodash';

declare global {
  interface Window {
    Bridge: Bridge;
    Palm: PalmEditor;
    __zone_symbol__setTimeout: any;
  }
}

export {};
