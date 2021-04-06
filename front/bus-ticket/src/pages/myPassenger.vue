<template>
  <div class="myPassenger">
    <van-nav-bar class="header"
      title="我的乘车人" left-text="返回" left-arrow
      @click-left="onClickLeft"
    />
    <div class="content">
      <div v-for="item in list" :key="item.id" class="passenger-content" @click="onEdit(item)">
        <van-icon name="user-o" style="flex: 1; margin-left: 1vh;" color="#1872fc"/>
        <div style="flex: 10; font-size: 14px;">
          <div>姓名：{{item.name}}</div>
          <div style="padding-top: 1vh">身份证：{{item.creditId}}</div>
        </div>
        <van-icon name="arrow" style="flex: 1;"/>
      </div>
    </div>
    <van-button icon="plus" class="bottom" @click="toAddPassenger">新增乘车人</van-button>
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';

export default {
  name: 'MyPassenger',
  mounted() {
    this.init();
  },
  data() {
    return {
      list: [],
    };
  },
  methods: {
    init() {
      const token = localStorage.getItem('token');
      if (!token) {
        this.$router.push('/signIn');
      } else {
        axios.get(`${root.baseUrl}/passenger/list`, {
          headers: {
            Authorization: `Basic ${Base64.encode(token)}`,
          },
        }).then((res) => {
          this.list = res.data.list;
        });
      }
    },
    onClickLeft() {
      this.$router.push('/mine');
    },
    onEdit(item) {
      this.$router.push({
        path: '/addPassenger',
        query: {
          isNew: 0,
          item: JSON.stringify(item),
        },
      });
    },
    toAddPassenger() {
      this.$router.push({
        path: '/addPassenger',
        query: {
          isNew: 1,
        },
      });
    },
  },
};
</script>

<style scoped>
.header {
  position: fixed !important;
  top: 0;
  z-index: 999;
  width: 100%;
}
.content {
  margin-top: 46px;
}
.passenger-content {
  display: flex;
  align-items: center;
  background-color: #fff;
  margin: 1vh 0;
  padding: 1vh 0;
}
.bottom {
  position: fixed !important;
  bottom: 0;
  z-index: 888;
  width: 100%;
}
</style>
