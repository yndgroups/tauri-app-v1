import {
  AnyObject,
  Response,
  TauriApp,
  TauriCli,
  TauriClipboard,
  TauriDialog,
  TauriEvent,
  TauriFs,
  TauriGlobalShortcut,
  TauriHttp,
  TauriNotification,
  TauriOs,
  TauriPath,
  TauriProcess,
  TauriShell,
  TauriUpdate,
  TauriWindow,
} from '../../types';
import { invoke } from '@tauri-apps/api/tauri';
import { app, cli, clipboard, dialog, event, fs, globalShortcut, http, notification, path, process, shell, updater, window as win, os, tauri } from '@tauri-apps/api';

window.Bridge = {
  invoke: async (handler: string, params: AnyObject): Promise<Response> => {
    console.log('invoke =>', handler, params);
    const resut: Response = await invoke(handler, params);
    console.log(`'invoke => code:'${resut.code}, msg: ${resut.msg}, data:`, resut.data);
    return resut;
  },
  delete: async (handler: string, id: string | number, tableName: string) => {
    const resut: Response = await invoke(handler, { id: id, tableName: tableName });
    console.log(`'invoke => code:'${resut.code}, msg: ${resut.msg}, data:`, resut.data);
    return resut;
  },
  app: app as TauriApp,
  cli: cli as TauriCli,
  clipboard: clipboard as TauriClipboard,
  dialog: dialog as TauriDialog,
  event: event as TauriEvent,
  fs: fs as TauriFs,
  globalShortcut: globalShortcut as TauriGlobalShortcut,
  http: http as TauriHttp,
  notification: notification as TauriNotification,
  path: path as TauriPath,
  process: process as TauriProcess,
  shell: shell as TauriShell,
  updater: updater as TauriUpdate,
  window: win as TauriWindow,
  os: os as TauriOs,
  tauri: tauri,
};

// 全局编辑器实例
// window.Palm = {
//   setApp() {},
// };
