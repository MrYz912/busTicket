import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    ticketData: {},
  },
  getters: {
    getTicketData: state => state.ticketData,
  },
  mutations: {
    setTicketData(state, item) {
      state.ticketData = item;
    },
  },
  actions: {
    queryTicketData({ commit }, item) {
      commit('setTicketData', item);
    },
  },
});
