import { defineConfig, ConfigEnv } from 'vite';
import vue from '@vitejs/plugin-vue';
import { resolve } from 'path';
import vueJsx from '@vitejs/plugin-vue-jsx';
import { AntDesignVueResolver } from 'unplugin-vue-components/resolvers';
import Components from 'unplugin-vue-components/vite';
import { nodeResolve } from '@rollup/plugin-node-resolve';

export default defineConfig(async ({ command, mode }: ConfigEnv) => {
  const prod: boolean = command === 'build' && mode === 'production';
  let fileName = prod ? 'kernel' : 'index';
  console.log(prod, fileName, 'prod, fileName');
  return {
    base: '/',
    plugins: [
      vue(),
      vueJsx(),
      nodeResolve(),
      Components({
        resolvers: [AntDesignVueResolver({ importStyle: false })],
        directoryAsNamespace: true,
        dts: './temp/auto-components.d.ts',
      }),
    ],
    resolve: {
      alias: {
        '@store': resolve('src/store'),
        '@global': resolve('global'),
      },
    },
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: '@import "src/style/_variable.scss";',
        },
      },
    },
    clearScreen: false,
    server: {
      port: 1423,
      strictPort: true,
      watch: {
        ignored: ['**/src-tauri/**', '/Users/mekings/.palm/plugins'],
      },
    },
    build: {
      outDir: '../../dist',
      rollupOptions: {
        input: {
          [fileName]: resolve(__dirname, `./${fileName}.html`),
        },
        output: {
          // chunkFileNames: 'js/[name]-[hash:8].js',
          // entryFileNames: 'js/[name]-[hash:8].js',
          // assetFileNames: '[ext]/[name]-[hash:8].[ext]',
          // manualChunks: {
          //   codemirror: ['codemirror', '@codemirror/autocomplete', '@codemirror/commands', '@codemirror/language', '@codemirror/lint', '@codemirror/search', '@codemirror/state', '@codemirror/view'],
          //   'codemirror-lang': ['@codemirror/lang-html', '@codemirror/lang-javascript', '@codemirror/lang-markdown'],
          // },
        },
      },
    },
  };
});
