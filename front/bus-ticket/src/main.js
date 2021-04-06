import Vue from 'vue';
import Vant from 'vant';
import 'vant/lib/index.css';
import App from './App';
import router from './router';
import localStore from '../src/store/index';


Vue.use(Vant);
Vue.config.productionTip = false;
// Vue.prototype.$http = http;
Vue.prototype.$message = Vant.Notify;
// Vue.prototype.$EventBus = new Vue();

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store: localStore,
  components: { App },
  template: '<App/>',
});
