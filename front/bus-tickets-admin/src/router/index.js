import Vue from 'vue'
import Router from "vue-router";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Login',
      component: () => import('@/pages/login'),
    },
    {
      path: '/ticketTable',
      name: 'TicketTable',
      component: () => import('@/pages/ticketTable'),
    },
    {
      path: '/advice',
      name: 'Advice',
      component: () => import('@/pages/advice'),
    },
  ],
});