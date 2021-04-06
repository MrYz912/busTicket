<template>
  <div class="busPay">
    <van-nav-bar class="header" title="订单填写" left-text="返回" left-arrow
      @click-left="onClickLeft"
    />
    <div class="content-info">
      <div class="content-info-all content-info-header">
        {{ticketDetail.day}} {{ticketDetail.time}} 发车
      </div>
      <div class="content-info-all content-info-content">
        {{ticketDetail.startStation}} -> {{ticketDetail.endStation}}
      </div>
      <div class="content-info-all content-info-bottom">
        {{ticketDetail.duration}}
      </div>
    </div>
    <div class="content-passenger">
      <div v-for="(item, index) in passengerList" :key="item.id" class="content-passenger-header">
        <van-icon v-if="isChange" name="close" style="flex: 1; margin-left: 1vh;"
          color="#ff0000" size="25" @click="spliceIndex(index)"/>
        <van-icon v-else name="user-o" style="flex: 1; margin-left: 1vh;" color="#1872fc"/>
        <div style="flex: 10; font-size: 14px;">
          <div>姓名：{{item.name}}</div>
          <div style="padding-top: 1vh">身份证：{{item.creditId}}</div>
        </div>
      </div>
      <van-button v-if="isChange" icon="plus" style="width: 100%" @click="toSelectPassenger">
        添加乘车人
      </van-button>
    </div>
    <van-submit-bar
      :price="price" decimal-length="1"
      :disabled="!passengerList.length" button-text="去支付" button-type="info"
      button-color="#1872fc" @submit="onSubmit"
    />
    <van-dialog v-model="showDialog" message="确认支付吗" show-cancel-button @confirm="surePay" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex';
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';

export default {
  name: 'BusPay',
  mounted() {
    this.init();
  },
  computed: {
    price() {
      return this.isChange ? this.ticketDetail.money * 100 * this.passengerList.length : 0;
    },
  },
  data() {
    return {
      ticketDetail: {},
      passengerList: [],
      showDialog: false,
      isChange: true,
    };
  },
  methods: {
    ...mapGetters(['getTicketData']),
    init() {
      this.ticketDetail = this.getTicketData();
      const plist = this.$route.query.data;
      if (plist) {
        this.passengerList = JSON.parse(plist);
      }
      if (this.$route.query.changeTicket == 1) {
        this.isChange = false;
        this.searchRider();
      }
    },
    // 提交订单
    surePay() {
      const token = localStorage.getItem('token');
      if (this.isChange) {
        const obj = {};
        const arr = [];
        obj.ticketId = this.ticketDetail.id;
        for (let i = 0; i < this.passengerList.length; i += 1) {
          arr.push(this.passengerList[i].riderId);
        }
        obj.passengerId = arr;

        axios.post(`${root.baseUrl}/pay`, obj, {
          headers: {
            Authorization: `Basic ${Base64.encode(token)}`,
          },
        }).then(() => {
          this.$router.push('/ticketWallet');
        }).catch((error) => {
          const { errorCode, msg } = error.response.data;
          this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
        });
      } else {
        const obj = this.$route.query;
        delete obj.changeTicket;

        axios.post(`${root.baseUrl}/ticket/change`, obj, {
          headers: {
            Authorization: `Basic ${Base64.encode(token)}`,
          },
        }).then(() => {
          this.$router.push('/ticketWallet');
        }).catch((error) => {
          const { errorCode, msg } = error.response.data;
          this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
        });
      }
    },
    // 改签时查改签乘客
    searchRider() {
      const ticketId = this.$route.query.ticketId;
      const token = localStorage.getItem('token');
      axios.get(`${root.baseUrl}/ticket/rider`, {
        params: {
          ticketId,
        },
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
      }).then((res) => {
        this.passengerList.push(res.data.riderInfo);
      })
        .catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
      });
    },
    spliceIndex(index) {
      this.passengerList.splice(index, 1);
    },
    onClickLeft() {
      let obj = {};
      if (this.$route.query.changeTicket == 1) {
        obj = this.$route.query;
      }
      this.$router.push({
        path: '/busList',
        query: obj,
      });
    },
    onSubmit() {
      this.showDialog = true;
    },
    toSelectPassenger() {
      this.$router.push('/selectPassenger');
    },
  },
};
</script>

<style scoped>
.header {
  /* position: fixed !important; */
  top: 0;
  z-index: 999;
  width: 100%;
}
.content-info {
  display: flex;
  flex-flow: column;
  align-items: center;
  background-color: #fff;
  height: 17vh;
  /* margin-top: 46px; */
}
.content-info-all {
  margin: 1vh 0;
}
.content-info-header {
  padding-top: 1vh;
}
.content-info-content {
  font-size: 20px;
}
.content-passenger {
  margin-top: 1vh;
}
.content-passenger-header {
  display: flex;
  align-items: center;
  background-color: #fff;
  margin: 1vh 0;
  padding: 1vh 0;
}
</style>
