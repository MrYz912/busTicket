<template>
  <div class="ticketWallet">
    <van-nav-bar title="车票夹"/>
    <ticket-detail-card v-if="!showEmpty" :showChange="true"
      :ticketList="ticketList"></ticket-detail-card>
    <van-empty v-else description="暂时没有车票" />
    <van-tabbar v-model="active">
      <van-tabbar-item to="/" icon="home-o">首页</van-tabbar-item>
      <van-tabbar-item icon="paid">车票夹</van-tabbar-item>
      <van-tabbar-item to="/mine" icon="friends-o">我的</van-tabbar-item>
    </van-tabbar>
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';
import TicketDetailCard from '../components/ticketDetailCard';

export default {
  name: 'TicketWallet',
  mounted() {
    this.init();
  },
  data() {
    return {
      active: 1,
      ticketList: [],
      showEmpty: true,
    };
  },
  methods: {
    init() {
      const token = localStorage.getItem('token');
      if (!token) {
        this.$router.push('signIn');
      } else {
        axios.get(`${root.baseUrl}/ticket/notUse`, {
          headers: {
            Authorization: `Basic ${Base64.encode(token)}`,
          },
        }).then((res) => {
          const list = res.data.notUseTicket;
          if (list.length !== 0) {
            this.showEmpty = false;
            for (let i = 0; i < list.length; i += 1) {
              const temp1 = list[i].duration.split(':');
              const temp2 = list[i].time.split(':');
              list[i].duration = '约' + temp1[0].replace(/\b(0+)/gi, '') + '时' + temp1[1].replace(/\b(0+)/gi, '') + '分';
              list[i].time = temp2[0] + ':' + temp2[1];
            }
            this.ticketList = list;
          } else {
            this.ticketList = [];
            this.showEmpty = true;
          }
        }).catch((error) => {
          this.tableList = [];
          this.showEmpty = true;
          const { errorCode, msg } = error.response.data;
          this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
        });
      }
    },
  },
  components: {
    TicketDetailCard,
  },
};
</script>

<style scoped>

</style>
