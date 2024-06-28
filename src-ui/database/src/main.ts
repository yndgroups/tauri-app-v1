import { createApp } from 'vue';
import './bridge';
import { setupStore } from './store/index';
import App from './App.vue';
import './assets/css/style.scss';
const app = createApp(App);
setupStore(app);
app.mount('#app');
