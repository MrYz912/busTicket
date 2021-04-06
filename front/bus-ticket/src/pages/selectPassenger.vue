<template>
  <div class="selectPassenger">
    <van-nav-bar class="header"
      title="选择乘车人" left-text="返回" left-arrow
      @click-left="onClickLeft"
    />
    <div class="content">
      <van-checkbox-group v-model="result" @change="select">
        <van-cell-group>
          <van-cell v-for="(item, index) in list" :key="item.riderId" clickable
            @click="toggle(index)">
            <template #title>
              <div>姓名：{{item.name}}</div>
              <div style="padding-top: 1vh">身份证：{{item.creditId}}</div>
            </template>
            <template #right-icon>
              <van-checkbox :name="item" ref="checkboxes" />
            </template>
          </van-cell>
        </van-cell-group>
      </van-checkbox-group>
      <van-button icon="plus" class="content-bottom" @click="toAddPassenger">新增乘车人</van-button>
    </div>
    <van-button class="bottom" color="#1872fc" @click="back">确定</van-button>
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';

export default {
  name: 'SelectPassenger',
  mounted() {
    this.init();
  },
  data() {
    return {
      result: [],
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
    toggle(index) {
      this.$refs.checkboxes[index].toggle();
    },
    select(name) {
      this.result = name;
    },
    onClickLeft() {
      this.$router.push('/busPay');
    },
    toAddPassenger() {
      this.$router.push({
        path: '/addPassenger',
        query: {
          isNew: 1,
        },
      });
    },
    back() {
      this.$router.push({
        path: '/busPay',
        query: {
          data: JSON.stringify(this.result),
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
.content-bottom {
  margin-top: 1vh;
  width: 100%;
}
.bottom {
  position: fixed !important;
  bottom: 0;
  z-index: 888;
  width: 100%;
}
</style>
