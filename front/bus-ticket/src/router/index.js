import Vue from 'vue';
import Router from 'vue-router';
import Index from '@/pages/index';
import BusList from '@/pages/busList';
import StationSelect from '@/pages/stationSelect';
import TicketWallet from '@/pages/ticketWallet';
import Mine from '@/pages/mine';
import SignIn from '@/pages/signIn';
import SignUp from '@/pages/signUp';
import MyPassenger from '@/pages/myPassenger';
import AddPassenger from '@/pages/addPassenger';
import BusPay from '@/pages/busPay';
import SelectPassenger from '@/pages/selectPassenger';
import AllOrder from '@/pages/allOrder';
import Feedback from '@/pages/feedback';

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Index',
      component: Index,
    },
    {
      path: '/busList',
      name: 'BusList',
      component: BusList,
    },
    {
      path: '/stationSelect',
      name: 'StationSelect',
      component: StationSelect,
    },
    {
      path: '/ticketWallet',
      name: 'TicketWallet',
      component: TicketWallet,
    },
    {
      path: '/mine',
      name: 'Mine',
      component: Mine,
    },
    {
      path: '/signIn',
      name: 'SignIn',
      component: SignIn,
    },
    {
      path: '/signUp',
      name: 'SignUp',
      component: SignUp,
    },
    {
      path: '/myPassenger',
      name: 'MyPassenger',
      component: MyPassenger,
    },
    {
      path: '/addPassenger',
      name: 'AddPassenger',
      component: AddPassenger,
    },
    {
      path: '/busPay',
      name: 'BusPay',
      component: BusPay,
    },
    {
      path: '/selectPassenger',
      name: 'SelectPassenger',
      component: SelectPassenger,
    },
    {
      path: '/allOrder',
      name: 'AllOrder',
      component: AllOrder,
    },
    {
      path: '/feedback',
      name: 'Feedback',
      component: Feedback,
    },
  ],
});
