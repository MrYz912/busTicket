<template>
  <div class="feedback">
    <van-nav-bar title="意见反馈" left-text="返回" left-arrow
      @click-left="onClickLeft"
    />
    <van-form @submit="onSubmit">
      <van-field v-model="fromData.message" rows="2" left-icon="comment-o" autosize
        label="留言" type="textarea" maxlength="50" placeholder="您有什么对我们说"
        show-word-limit
      />
      <van-field v-model="fromData.location" label="上下车点" left-icon="location-o"
        placeholder="例如：'xx站'-'xx站'"
      />
      <van-field v-model="fromData.time" label="发车时间" left-icon="todo-list-o"
        placeholder="请选择出发时间" @click="show"
      />
      <van-field v-model="fromData.phone" type="tel" label="手机号" left-icon="service-o"
        placeholder="请输入您的手机号"/>
      <div style="margin: 16px;">
        <van-button round block type="info" native-type="submit">提交</van-button>
      </div>
    </van-form>
    <van-popup v-model="showPopup" round position="bottom" :style="{ height: '40%' }">
      <van-datetime-picker v-model="currentDate" type="datetime" title="选择最近一次乘车时间"
        :min-date="minDate" :max-date="maxDate" @confirm="confirmTime" @cancel="cancel"
      />
    </van-popup>
  </div>
</template>

<script>
import moment from 'moment';
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';

export default {
  name: 'Feedback',
  data() {
    return {
      fromData: {
        message: '',
        location: '',
        time: '',
        phone: '',
      },
      showPopup: false,
      currentDate: new Date(),
      minDate: new Date(2020, 0, 1),
      maxDate: new Date(),
    };
  },
  methods: {
    onClickLeft() {
      this.$router.push('/mine');
    },
    show() {
      this.showPopup = true;
    },
    cancel() {
      this.showPopup = false;
    },
    confirmTime() {
      this.fromData.time = moment(this.currentDate).format('YYYY-MM-DD HH:mm:ss');
      this.showPopup = false;
    },
    onSubmit() {
      const { message, location, time, phone } = this.fromData;
      const token = localStorage.getItem('token');
      axios.post(`${root.baseUrl}/advice`, {
        message,
        location,
        time,
        phone,
        userName: localStorage.getItem('name'),
      }, {
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
      }).then(() => {
        this.$router.push('/mine');
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
      });
    },
  },
};
</script>

<style scoped>

</style>
