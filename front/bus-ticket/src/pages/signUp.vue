<template>
  <div class="signUp" style="background: #fff; height:100vh;">
    <van-nav-bar left-text="返回" right-text="登录" left-arrow class="signUp-nav-header"
      @click-left="onClickLeft" @click-right="onClickRight"
    />
    <section>
      <h2 class="signUp-title">用户注册</h2>
      <van-form @submit="onSignUp" style="margin-top: 8vh; padding: 2vh">
        <van-field v-model="user_fromData.username" name="用户名" label="用户名" placeholder="用户名"
          :rules="[{ required: true, message: '请填写用户名' }]" class="signUp-formItem"
        />
        <van-field v-model="user_fromData.password1" type="password" name="密码" label="密码"
          :rules="[{ required: true, message: '请填写密码' }]" class="signUp-formItem" placeholder="密码"
        />
        <van-field v-model="user_fromData.password2" type="password" name="再次输入密码" label="密码"
            placeholder="请再次输入密码" class="signUp-formItem"
            :rules="[{ required: true, message: '请再次输入密码' }]"
        />
        <div style="margin-top: 4vh;">
          <van-button block type="info" native-type="submit"
            style="border-radius: 5px;" color="#1872fc"
          >
            注册
          </van-button>
        </div>
      </van-form>
    </section>
  </div>
</template>

<script>
import axios from 'axios';
import root from '../store/root';

export default {
  name: 'SignUp',
  data() {
    return {
      user_fromData: {
        username: '',
        password1: '',
        password2: '',
      },
    };
  },
  methods: {
    onSignUp() {
      axios.post(`${root.baseUrl}/user/register`, {
        nickname: this.user_fromData.username,
        password1: this.user_fromData.password1,
        password2: this.user_fromData.password2,
      }).then(() => {
        this.$notify({ type: 'success', message: '注册成功' });
        this.$router.push('/signIn');
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
      });
    },
    onClickLeft() {
      this.$router.push('/');
    },
    onClickRight() {
      this.$router.push('/signIn');
    },
  },
};
</script>

<style scoped>
.signUp-title {
  margin-top: 10vh;
  text-align: center;
  font-size: 25px;
  color: #333;
  line-height: 25px;
  font-weight: 400;
}
.signUp-nav-header::after {
  border-bottom-width: 0;
}
.signUp-formItem::after {
  border-bottom: 1px solid #cecece;
}
</style>
