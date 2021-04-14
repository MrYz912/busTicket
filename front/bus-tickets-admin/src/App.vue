<template>
  <div id="app">
    <router-view v-if="this.$route.path === '/'" @changeName="changeName"></router-view>
    <a-layout v-else id="components-layout-demo-top-side-2" style="min-height: 100vh">
      <a-layout-header class="header">
        <a-dropdown placement="bottomCenter" style="float: right">
          <a class="ant-dropdown-link" @click="e => e.preventDefault()">
            {{name}} <a-icon type="down" />
          </a>
          <a-menu slot="overlay">
            <a-menu-item @click="openModal">
              注册管理员
            </a-menu-item>
            <a-menu-item @click="exit">
              退出登录
            </a-menu-item>
          </a-menu>
        </a-dropdown>
      </a-layout-header>
      <a-layout>
        <a-layout-sider width="150" style="background: #fff">
          <a-menu
            mode="inline"
            :default-selected-keys="['1']"
            :default-open-keys="['sub1']"
            :style="{ height: '100%', borderRight: 0 }"
          >
            <a-sub-menu key="sub1">
              <span slot="title">数据库表管理</span>
              <a-menu-item key="1">
                车次表
                <a href="/#/ticketTable"></a>
              </a-menu-item>
              <a-menu-item key="2">
                建议表
                <a href="/#/advice"></a>
              </a-menu-item>
            </a-sub-menu>
          </a-menu>
        </a-layout-sider>
        <a-layout style="padding: 0 12px">
          <a-layout-content
            :style="{ background: '#fff', padding: '24px', margin: 0, minHeight: '280px' }"
          >
            <router-view></router-view>
            <a-modal v-model="showModal" title="注册管理员" @ok="register" ok-text="确定" cancel-text="取消">
                <a-form-model :model="formInline" :label-col="{span: 6}" :wrapper-col="{span: 12}">
                <a-form-model-item label="账户">
                  <a-input v-model="formInline.nickname" allowClear placeholder="请输入账户"></a-input>
                </a-form-model-item>
                <a-form-model-item label="密码">
                  <a-input-password v-model="formInline.password1" allowClear placeholder="请输入密码"></a-input-password>
                </a-form-model-item>
                <a-form-model-item label="密码">
                  <a-input-password v-model="formInline.password2" allowClear placeholder="请再次输入密码"></a-input-password>
                </a-form-model-item>
              </a-form-model>
            </a-modal>
          </a-layout-content>
        </a-layout>
      </a-layout>
    </a-layout>
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from './router/root';

export default {
  name: 'App',
  mounted() {
    this.name = sessionStorage.getItem('name');
  },
  data() {
    return {
      formInline: {},
      name: '',
      showModal: false,
    };
  },
  methods: {
    openModal() {
      this.showModal = true;
    },
    register() {
      const token = sessionStorage.getItem('token')
      axios.post(`${root.baseUrl}/admin/register`, this.formInline, {
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
      }).then(() => {
        this.$message.success('新增成功');
        this.showModal = false;
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    exit() {
      sessionStorage.removeItem('token');
      sessionStorage.removeItem('name');
      this.$router.push('/');
    },
    changeName() {
      this.name = sessionStorage.getItem('name');
    },
  },
}
</script>

<style>
#components-layout-demo-top-side-2 .logo {
  width: 120px;
  height: 31px;
  background: rgba(255, 255, 255, 0.2);
  margin: 16px 28px 16px 0;
  float: left;
}
</style>
