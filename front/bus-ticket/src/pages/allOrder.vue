<template>
  <div class="allOrder">
    <van-nav-bar class="header"
      title="全部订单" left-text="返回" left-arrow
      @click-left="onClickLeft"
    />
    <ticket-detail-card v-if="!showEmpty" :ticketList="ticketList"></ticket-detail-card>
    <van-empty v-else description="暂时没有车票" />
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';
import TicketDetailCard from '../components/ticketDetailCard';

export default {
  name: 'AllOrder',
  mounted() {
    this.init();
  },
  data() {
    return {
      ticketList: [1, 2],
      showEmpty: true,
    };
  },
  methods: {
    init() {
      const token = localStorage.getItem('token');
      if (!token) {
        this.$router.push('signIn');
      } else {
        axios.get(`${root.baseUrl}/ticket/allTicket`, {
          headers: {
            Authorization: `Basic ${Base64.encode(token)}`,
          },
        }).then((res) => {
          const list = res.data.allTicket;
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
    onClickLeft() {
      this.$router.push('/mine');
    },
  },
  components: {
    TicketDetailCard,
  },
};
</script>

<style scope>

</style>
