<template>
  <div class="ticketDetailCard">
    <div class="ticket-card" v-for="item of ticketList" :key="item.id">
      <div class="station-price">
        <p class="station-price-station">{{item.startStation}} -> {{item.endStation}}</p>
        <div class="bus-info-r">
          <div class="price">
            <small>￥</small>
            <span>{{item.money}}</span>
          </div>
        </div>
      </div>
      <p class="date">{{item.day}} {{item.time}}</p>
      <p class="date">{{item.duration}}</p>
      <div class="id-information">
        <div class="id-information-name">
          <p class="id-name">姓名：{{item.riderName}}</p>
          <p class="id-name">身份证：{{item.riderCreditId}}</p>
        </div>
        <div v-if="showChange" class="id-information-button">
          <van-button class="id-button-l" size="small" @click="changeTicket(item)">改签</van-button>
          <van-button class="id-button-r" size="small" @click="showDeleteDialog">退票</van-button>
          <van-dialog v-model="showDialog" title="确认退票吗" message="退票要收取20%手续费"
            show-cancel-button @confirm="sureDelete(item)" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';

export default {
  name: 'TicketDetailCard',
  props: {
    showChange: false,
    ticketList: {
      type: Array,
    },
  },
  data() {
    return {
      showDialog: false,
    };
  },
  methods: {
    changeTicket(data) {
      this.$router.push({
        path: '/busList',
        query: {
          changeTicket: 1,
          ticketId: data.id,
          tableId: data.tableId,
        },
      });
    },
    showDeleteDialog() {
      this.showDialog = true;
    },
    sureDelete(data) {
      const token = localStorage.getItem('token');
      axios.delete(`${root.baseUrl}/ticket/delete`, {
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
        data: {
          tableId: data.tableId,
          ticketId: data.id,
        },
      }).then(() => {
        window.location.reload();
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
      });
    },
  },
};
</script>

<style scoped>
.ticket-card {
  /* height: 20vh; */
  background-color: #fff;
  padding: 2vh 3vw;
  margin: 3vh 3vw 0;
  border-radius: 10px;
  box-shadow: 0 2px 8px 1px rgb(0 0 0 / 6%);
}
.station-price {
  display: flex;
  align-items: center;

}
.station-icon {
  margin-right: 2vw;
}
.station-price-station {
  margin: 0;
  margin-left: 2vw;
  flex: 1;
  font-size: 18px;
}
.bus-info-r {
  text-align: right;
  font-size: 18px;
  font-weight: 500;
}
.price {
  color: #f70;
}
.date {
  margin: 0;
  margin-left: 2vw;
  margin-top: 1vh;
  color: #666;
}
.id-information{
  background-color: rgba(230, 230, 230, 0.4);
  margin-top: 2vh;
  border-radius: 10px;
  padding: 1vh 2vw;
}
.id-information-name {
  margin-top: 1vh;
}
.id-name {
  margin: 0;
}
.id-information-button {
  display: flex;
  align-content: flex-end;
  margin-top: 2vh;
}
.id-button-l {
  margin-right: 2vw;
}
</style>
