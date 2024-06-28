/// <reference types="vite/client" />
export interface AnyObject {
  [k: string]: any;
}

export interface Response {
  code: number;
  msg: string;
  data: AnyObject;
}

export enum DbType {
  dm = 'dm',
  kingbase = 'dmkingbase',
  mysql = 'mysql',
  mariadb = 'mariadb',
  oracle = 'oracle',
  redis = 'redis',
  sqlite = 'sqlite',
  sqlserver = 'sqlserver',
  mongodb = 'mongodb',
  postgresql = 'postgresql',
}

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

interface Bridge {
  invoke: (evt: string, params: AnyObject) => Promise<Response>;
  delete: (evt: string, id: string | number, tableName: string) => Promise<Response>;
}

declare global {
  interface Window {
    Bridge: Bridge;
  }
}

export {};
