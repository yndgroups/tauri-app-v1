import { createApp } from 'vue';
import './bridge';
import App from './App.vue';
import './style/styles.scss';
import { setupStore } from './store/index';
const app = createApp(App);
setupStore(app);
app.mount('#app');
