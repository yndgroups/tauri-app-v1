<template>
  <div
    ref="xterm"
    @mouseleave.prevent.stop="onMouseout"
    id="xterm"></div>
</template>

<script setup lang="ts">
import { reactive, onMounted, ref } from 'vue';
import { ITheme, Terminal } from 'xterm';
import { FitAddon } from 'xterm-addon-fit';
import 'xterm/css/xterm.css';
import 'xterm/lib/xterm.js';
// import { invoke } from '@tauri-apps/api/tauri';
import { Command } from '@tauri-apps/api/shell';
import { platform } from '@tauri-apps/api/os';
const xterm = ref();
const state = reactive({
  term: {} as Terminal,
  curentLine: '',
});

/* let str = `cat,chattr,chgrp,chmod,chown,cksum,cmp,diff,diffstat,file,find,git,gitview,indent,cut,ln,less,locate,lsattr,mattrib,mc,mdel,mdir,mktemp,more,mmove,mread,mren,mtools,mtoolstest,mv,od,paste,patch,rcp,rm,slocate,split,tee,tmpwatch,touch,umask,which,cp,whereis,mcopy,mshowfat,rhmask,scp,awk,read,updatedb`;
let cmd = str.split(',').map((item) => {
  return { name: item, cmd: item, args: true };
});
console.log(JSON.stringify(cmd), 'cmdcmd'); */
let theme: ITheme = {
  foreground: '#00ff40',
  cyan: '#2aa198',
  magenta: '#dd3682',
  green: '#859900',
  brightGreen: '#586e75',
  background: '#1e1e1e',
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

onMounted(() => {
  state.term = new Terminal({
    // 渲染类型
    // rendererType: 'canvas',
    //   是否禁用输入
    disableStdin: false,
    cursorStyle: 'underline',
    //   启用时光标将设置为下一行的开头
    convertEol: true,
    // 终端中的回滚量
    scrollback: 10,
    fontSize: 14,
    rows: 10,
    // 光标闪烁
    cursorBlink: true,
    theme: theme,
    /* theme: {
      //   字体
      foreground: '#ffffff',
      background: '#042028',
      // 光标
      cursor: 'help',
    }, */
  });
  // 进行适应容器元素大小
  let fitAddon = new FitAddon();
  state.term.loadAddon(fitAddon);
  fitAddon.fit();
  //   创建实例
  state.term.open(xterm.value);
  // 进行适应容器元素大小
  state.term.loadAddon(fitAddon);
  fitAddon.fit();
  // state.term.focus();

  // 数据写入
  state.term.onData((key) => {
    // 粘贴的情况
    if (key.length > 1) state.term.write(key);
  });

  state.term.onKey(async (input) => {
    console.log(input, 'inputinputinputinput');
    const code = input.domEvent.code;
    if (code == '127' || code === 'Backspace') {
      //Backspace
      state.term.write('\b \b');
      let len = state.curentLine.length;
      if (len > 0) {
        state.curentLine = state.curentLine.substring(0, len - 1);
      }
      return;
      // state.term.write('\x1b[D');
    }
    if (input.key != '\r') {
      state.term.write(input.key);
      state.curentLine += input.key;
    } else {
      if (state.curentLine === 'clear') {
        state.term.clear();
        state.term.write('\n$:');
        return;
      }
      console.log(state.curentLine, '[onKey] => state.curentLine');
      if (state.curentLine.indexOf(' ') != -1) {
        console.log('带参数命令 >>>>> ');
        let arr = state.curentLine.split(' ') as string[];
        let mainCmd = arr.shift() as string;
        if (mainCmd === 'npm') {
          const platformName = await platform();
          mainCmd = /^win/i.test(platformName) ? 'npm.cmd' : 'npm';
        }
        if (mainCmd === 'cd') {
          console.log('cd -------------');
          return;
        }
        console.info(mainCmd, arr, 'cmd命令');
        const output = await new Command(mainCmd, arr).execute();
        console.log(output, 'outputoutputoutputoutput');
        state.term.write('\n$:' + output.stdout);
        state.term.focus();
      } else {
        try {
          console.info('不带参数命令 >>>>> ');
          const output = await new Command(state.curentLine).execute();
          console.log(output, 'outputoutputoutputoutput');
          state.term.write('\n$:' + output.stdout);
          state.term.focus();
        } catch (e) {
          state.term.write('\n$:' + e);
          // console.log(e, 'xxxxxx');
        }
      }
      state.term.write('\n$:');
      state.curentLine = '';
    }
  });
});

const onMouseout = () => {
  console.log('鼠标离开命令行区域');
  state.term.blur();
};
</script>

<style lang="scss" scoped>
#xterm {
  height: calc($cmd-interactive-height - 60px);
  width: 100%;
  box-sizing: border-box;
}
</style>
