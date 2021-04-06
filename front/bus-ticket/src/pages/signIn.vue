<template>
  <div class="signIn" style="background: #fff; height:100vh;">
    <van-nav-bar left-text="返回" right-text="注册" left-arrow class="signIn-nav-header"
      @click-left="onClickLeft" @click-right="onClickRight"
    />
    <section>
      <h2 class="signIn-title">账号登录</h2>
      <van-form @submit="onSignIn" style="margin-top: 8vh; padding: 2vh">
        <van-field v-model="user_fromData.username" name="用户名" label="用户名" placeholder="用户名"
          :rules="[{ required: true, message: '请填写用户名' }]" class="signIn-formItem"
        />
        <van-field v-model="user_fromData.password" type="password" name="密码" label="密码"
        placeholder="密码" :rules="[{ required: true, message: '请填写密码' }]" class="signIn-formItem"
        />
        <div style="margin-top: 4vh;">
          <van-button block type="info" native-type="submit"
            style="border-radius: 5px;" color="#1872fc"
          >
            登录
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
  name: 'SignIn',
  data() {
    return {
      user_fromData: {
        username: '',
        password: '',
      },
    };
  },
  methods: {
    onSignIn() {
      axios.post(`${root.baseUrl}/token`, {
        account: this.user_fromData.username,
        secret: this.user_fromData.password,
        root: '0',
      }).then((res) => {
        const { status, data } = res;
        if (status === 200) {
          localStorage.setItem('token', data.token + ':');
          localStorage.setItem('name', data.name);
          this.$router.go(-1);
        }
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
      });
    },
    onClickLeft() {
      this.$router.push('/');
    },
    onClickRight() {
      this.$router.push('/signUp');
    },
  },
};
</script>

<style scoped>
.signIn-title {
  margin-top: 10vh;
  text-align: center;
  font-size: 25px;
  color: #333;
  line-height: 25px;
  font-weight: 400;
}
.signIn-nav-header::after {
  border-bottom-width: 0;
}
.signIn-formItem::after {
  border-bottom: 1px solid #cecece;
}
</style>
