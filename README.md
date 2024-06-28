# Tauri + Vue 3 + TypeScript

This template should help get you started developing with Vue 3 and TypeScript in Vite. The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.

## Recommended IDE Setup

- [VS Code](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) + [Tauri](https://marketplace.visualstudio.com/items?itemName=tauri-apps.tauri-vscode) + [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)

## Type Support For `.vue` Imports in TS

Since TypeScript cannot handle type information for `.vue` imports, they are shimmed to be a generic Vue component type by default. In most cases this is fine if you don't really care about component prop types outside of templates. However, if you wish to get actual prop types in `.vue` imports (for example to get props validation when using manual `h(...)` calls), you can enable Volar's Take Over mode by following these steps:

1. Run `Extensions: Show Built-in Extensions` from VS Code's command palette, look for `TypeScript and JavaScript Language Features`, then right click and select `Disable (Workspace)`. By default, Take Over mode will enable itself if the default TypeScript extension is disabled.
2. Reload the VS Code window by running `Developer: Reload Window` from the command palette.

You can learn more about Take Over mode [here](https://github.com/johnsoncodehk/volar/discussions/471).

> "no such command: tauri" when following Getting Started cargo guide
> cargo install tauri-cli

## 平台分割符号

```
// std::path::MAIN_SEPARATOR // 平台特定的分隔符
// 1.68 开始 还有std::path::MAIN_SEPARATOR_STR
```

## 命令行配置

```
let theme: ITheme = {
  foreground: '#00ff40',
  cyan: '#2aa198',
  magenta: '#dd3682',
  green: '#859900',
  brightGreen: '#586e75',
  background: '#042028',
  brightRed: '#cb4b16',
  red: '#dc322f',
  yellow: '#b58900',
  brightYellow: '#657b83',
  brightMagenta: '#6c71c4',
  white: '#eee8d5',
  brightWhite: '#fdf6e3',
  brightBlue: '#839496',
  blue: '#268bd2',
  black: '#002b36',
  brightBlack: '#073642',
  // text(bold)=839496
};
```

### 沙盒测试

```
 window.sex = '男';
let proxy1 = new ProxySandbox('music');
let proxy2 = new ProxySandbox('git');
((window) => {
  proxy1.active();
  console.log('修改前proxy1的sex', window.sex);
  window.sex = '女';
  console.log('修改后proxy1的sex', window.sex);
})(proxy1.proxy);
console.log('外部window.sex=>1', window.sex);

((window) => {
  proxy2.active();
  console.log('修改前proxy2的sex', window.sex);
  window.sex = '111';
  console.log('修改后proxy2的sex', window.sex);
})(proxy2.proxy);
console.log('外部window.sex=>2', window.sex);
```
