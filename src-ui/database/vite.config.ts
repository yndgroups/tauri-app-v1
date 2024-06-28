import { defineConfig, ConfigEnv } from 'vite';
import vue from '@vitejs/plugin-vue';
import { resolve } from 'path';
import vueJsx from '@vitejs/plugin-vue-jsx';
import { AntDesignVueResolver } from 'unplugin-vue-components/resolvers';
import Components from 'unplugin-vue-components/vite';
import { nodeResolve } from '@rollup/plugin-node-resolve';

export default defineConfig(async ({ command, mode }: ConfigEnv) => {
  const prod: boolean = command === 'build' && mode === 'production';
  let fileName = prod ? 'database' : 'index';
  console.log(prod, fileName, 'prod, fileName');
  return {
    // root: `./src/database/`,
    base: '/',
    plugins: [
      vue(),
      vueJsx(),
      nodeResolve(),
      Components({
        resolvers: [AntDesignVueResolver({ importStyle: false })],
        directoryAsNamespace: true,
        dts: '../../auto-components/database-components.d.ts',
      }),
    ],
    resolve: {
      alias: {
        '@store': resolve('src/store'),
        '@globalComponents': resolve('src/global/components'),
        '@localComponents': resolve('src/database/components'),
        '@globalUtils': resolve('src/global/utils'),
        '@global': resolve('global'),
        '@globalPlugins': resolve('src/global/plugins'),
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
      port: 1420,
      strictPort: true,
      watch: {
        ignored: ['./src/**'],
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
