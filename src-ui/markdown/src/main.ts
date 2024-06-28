import { createApp } from 'vue';
import './style/styles.scss';
import 'vditor/src/assets/less/index.less';
import App from './App.vue';
import { setupStore } from './store/index';
const app = createApp(App);
setupStore(app);
app.mount('#app');
