<template>
  <div class="login">
    <div style="width:429px">
      <h1 style="text-align: center; color:#ecebeb; margin-bottom: 5vh;">管理员登录</h1>
      <a-form-model>
        <a-form-model-item>
          <a-input v-model="formInline.user" placeholder="用户名" size="large">
            <a-icon slot="prefix" type="user" style="color:rgba(0,0,0,.25)" />
          </a-input>
        </a-form-model-item>
        <a-form-model-item>
          <a-input-password v-model="formInline.password" placeholder="密码" size="large">
            <a-icon slot="prefix" type="lock" style="color:rgba(0,0,0,.25)" />
          </a-input-password>
        </a-form-model-item>
        <a-form-model-item>
          <a-button
            type="primary" style="width:429px" size="large" @click="login"
            :disabled="formInline.user === '' || formInline.password === ''"
          >
            登录
          </a-button>
        </a-form-model-item>
      </a-form-model>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import root from '../router/root';

export default {
  name: 'Login',
  data() {
    return {
      formInline: {
        user: '',
        password: '',
      },
    };
  },
  methods: {
    login() {
      axios.post(`${root.baseUrl}/token`, {
        account: this.formInline.user,
        secret: this.formInline.password,
        root: 1,
      }).then((res) => {
        const { status, data } = res;
        if (status === 200) {
          sessionStorage.setItem('token', data.token + ':');
          sessionStorage.setItem('name', data.name);
          this.$router.push('/ticketTable');
        }
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
  },
  beforeDestroy() {
    this.$emit('changeName');
  }
}
</script>

<style scoped>
.login {
  display: flex;
  height: 100vh;
  background-color: #283342;
  justify-content: center;
  align-items: center;
}
</style>
