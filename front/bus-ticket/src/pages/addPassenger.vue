<template>
  <div class="addPassenger">
    <van-nav-bar class="header" :title="pageTitle" left-text="返回" left-arrow
      @click-left="onClickLeft"
    />
    <div class="editor-content">
      <van-form style="margin-top: 46px; padding: 2vh">
        <van-field v-model="fromData.name" name="姓名" label="姓名" placeholder="姓名"
          :rules="[{ required: true, message: '请填写姓名' }]" class="signIn-formItem"
        />
        <van-field v-model="fromData.creditId" name="身份证" label="身份证" placeholder="身份证"
          :rules="[{ required: true, message: '请填写身份证' }]" class="signIn-formItem"
        />
        <div style="margin-top: 4vh;">
          <van-button block type="info" native-type="submit" color="#1872fc"
            style="border-radius: 5px;" @click="savePassenger"
          >
            保存
          </van-button>
          <van-button v-if="isNew == 0" block type="danger" native-type="submit"
            style="border-radius: 5px; margin-top: 2vh;" @click="deletePassenger"
          >
            删除
          </van-button>
        </div>
      </van-form>
    </div>
    <van-dialog v-model="showDialog" message="确认删除吗" show-cancel-button @confirm="sureDelete" />
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../store/root';

export default {
  name: 'AddPassenger',
  mounted() {
    if (this.$route.query.isNew == 0) {
      this.pageTitle = '编辑乘车人';
      this.isNew = 0;
      this.fromData = JSON.parse(this.$route.query.item);
    }
  },
  data() {
    return {
      fromData: {
        riderId: 0,
        name: '',
        creditId: '',
      },
      isNew: 1,
      pageTitle: '新增乘车人',
      showDialog: false,
    };
  },
  methods: {
    // 新增或编辑
    savePassenger() {
      if (this.$route.query.isNew == 1) {
        if (!this.name) {
          this.$notify({ type: 'danger', message: '请填写姓名' });
        } else if (!this.creditId) {
          this.$notify({ type: 'danger', message: '请填写身份证号' });
        } else {
          const token = localStorage.getItem('token');
          const obj = {
            name: this.name,
            creditId: this.creditId,
          };
          axios.post(`${root.baseUrl}/passenger/create`, obj, {
            headers: {
              Authorization: `Basic ${Base64.encode(token)}`,
            },
          }).then(() => {
            this.$router.go(-1);
          }).catch((error) => {
            const { errorCode, msg } = error.response.data;
            this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
          });
        }
      } else if (this.$route.query.isNew == 0) {
        const token = localStorage.getItem('token');
        const obj = {
          id: this.fromData.riderId,
          name: this.fromData.name,
          creditId: this.fromData.creditId,
        };
        axios.post(`${root.baseUrl}/passenger/edit`, obj, {
          headers: {
            Authorization: `Basic ${Base64.encode(token)}`,
          },
        }).then(() => {
          this.$router.push('/myPassenger');
        }).catch((error) => {
          const { errorCode, msg } = error.response.data;
          this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
        });
      }
    },
    deletePassenger() {
      this.showDialog = true;
    },
    // 删除
    sureDelete() {
      const token = localStorage.getItem('token');
      axios.delete(`${root.baseUrl}/passenger/delete`, {
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
        data: {
          id: this.fromData.riderId,
        },
      }).then(() => {
        this.$notify({ type: 'success', message: '删除成功' });
        this.$router.push('/myPassenger');
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
      });
    },
    onClickLeft() {
      this.$router.go(-1);
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
</style>
