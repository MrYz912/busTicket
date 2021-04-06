<template>
  <div class="stationSelect">
    <van-nav-bar
      title="选择车站"
      left-text="返回"
      left-arrow
      @click-left="onClickLeft"
    />
    <van-tree-select :items="items" :active-id.sync="activeId"
      :main-active-index.sync="activeIndex" height="94vh"
      @click-nav="clickNav" @click-item="cilckItem"
    />
  </div>
</template>

<script>
import axios from 'axios';
import root from '../store/root';

export default {
  name: 'StationSelect',
  mounted() {
    this.init();
  },
  data() {
    return {
      items: [],
      activeId: 1,
      activeIndex: 0,
    };
  },
  methods: {
    init() {
      axios.get(`${root.baseUrl}/cityStation/city`)
        .then((res) => {
          this.items = res.data.city;
          this.searchStation(1);
        }).catch((error) => {
          const { errorCode, msg } = error.response.data;
          this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
        });
    },
    cilckItem(data) {
      if (this.$route.query.isStart === '0') {
        sessionStorage.setItem('startStation', data.text);
      } else if (this.$route.query.isStart === '1') {
        sessionStorage.setItem('endStation', data.text);
      }
      this.$router.push('/');
    },
    clickNav(data) {
      this.searchStation(data + 1);
    },
    searchStation(id) {
      axios.get(`${root.baseUrl}/cityStation/station?id=${id}`)
        .then((res) => {
          // 对象和数字更新后通知页面
          this.$set(this.items[id - 1], 'children', res.data.station);
        }).catch((error) => {
          const { errorCode, msg } = error.response.data;
          this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
        });
    },
    onClickLeft() {
      this.$router.push('/');
    },
  },
};
</script>

<style scoped>
.stationSelect .van-tree-select__item--active {
  color: #1872fc;
}
.stationSelect .van-sidebar-item--select::before {
  background-color: #1872fc;
}
</style>
