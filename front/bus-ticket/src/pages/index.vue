<template>
  <div class="index">
    <img alt="" src="https://dimg04.c-ctrip.com/images/zg0o1f000001g208lD72B.jpg"
      style="width: 100%; height: 204.7px"/>
    <van-cell-group class="search-cell">
      <van-cell title="起点站" :value="startStation" icon="logistics" is-link
        @click="toStationSelect(0)"
      />
      <van-cell title="终点站" :value="endStation" icon="location-o" is-link
        @click="toStationSelect(1)"
      />
      <van-cell title="出发日期" :value="date" icon="calendar-o" is-link @click="showCalendar = true"/>
      <van-button type="primary" class="search-button" color="#1872fc" :disabled="!canSearch"
        @click="toBusList">
        查询
      </van-button>
    </van-cell-group>
    <van-tabbar v-model="active">
      <van-tabbar-item icon="home-o">首页</van-tabbar-item>
      <van-tabbar-item to="/ticketWallet" icon="paid">车票夹</van-tabbar-item>
      <van-tabbar-item to="/mine" icon="friends-o">我的</van-tabbar-item>
    </van-tabbar>
    <van-calendar color="#1872fc" v-model="showCalendar" :max-date="maxDate" @confirm="onConfirm" />
  </div>
</template>

<script>
export default {
  name: 'Index',
  mounted() {
    this.startStation = sessionStorage.getItem('startStation');
    this.endStation = sessionStorage.getItem('endStation');
    this.date = sessionStorage.getItem('date');
  },
  computed: {
    canSearch() {
      return this.startStation && this.endStation && this.date;
    },
  },
  data() {
    return {
      startStation: '',
      endStation: '',
      date: '',
      maxDate: new Date(new Date().setMonth(new Date().getMonth() + 1)),
      showCalendar: false,
      active: 0,
    };
  },
  methods: {
    formatDate(date) {
      return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
    },
    onConfirm(date) {
      this.showCalendar = false;
      this.date = this.formatDate(date);
      sessionStorage.setItem('date', this.date);
    },
    toBusList() {
      this.$router.push('/buslist');
    },
    toStationSelect(index) {
      let isStart = '0';
      if (index === 1) isStart = '1';
      this.$router.push({
        path: '/stationSelect',
        query: {
          isStart,
        },
      });
    },
  },
};
</script>

<style scoped>
.search-cell {
  width: 95vw;
  margin: -30px auto 0;
  padding: 5px 0 15px;
}
.search-button {
  width: 90vw;
  left: 50%;
  margin-left: -45vw;
  border-radius: 5px;
  font-size: 16px;
}

.index .van-cell {
  color: #969799;
}
.index .van-cell ::before {
  color: #323233;
}

.index .van-cell__value{
  color: #323233;
  font-size: 16px;
  font-weight: 500;
}
</style>
