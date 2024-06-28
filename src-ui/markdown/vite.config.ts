import { defineConfig, ConfigEnv } from 'vite';
import vue from '@vitejs/plugin-vue';
import { resolve } from 'path';
import vueJsx from '@vitejs/plugin-vue-jsx';
import { AntDesignVueResolver } from 'unplugin-vue-components/resolvers';
import Components from 'unplugin-vue-components/vite';
import { nodeResolve } from '@rollup/plugin-node-resolve';

// https://vitejs.dev/config/
export default defineConfig(async ({ command, mode }: ConfigEnv) => {
  const prod: boolean = command === 'build' && mode === 'production';
  let fileName = prod ? 'markdown' : 'index';
  console.log(prod, fileName, 'prod, fileName');
  return {
    // root: `./src/markdown/`,
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
          additionalData: '@import "src/assets/css/_variable.scss";',
        },
      },
    },
    clearScreen: false,
    server: {
      port: 1422,
      strictPort: true,
      watch: {
        ignored: ['**/src-tauri/**'],
      },
    },
    build: {
      outDir: '../../dist',
      rollupOptions: {
        input: {
          [fileName]: resolve(__dirname, `./${fileName}.html`),
        },
      },
    },
  };
});
