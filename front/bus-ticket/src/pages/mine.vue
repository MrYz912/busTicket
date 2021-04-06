<template>
  <div class="mine">
    <van-nav-bar title="个人中心" />
    <div class="user-card" @click="toSignIn">
      <span>{{name}}</span>
    </div>
    <div class="mine-content">
      <div class="mine-content-header">
        <div style="margin-right: 15vw" @click="toTicketWallet">
          <van-button class="header-button">
            <van-icon name="logistics" color="#00de69" size="40" />
            <div>未出行</div>
          </van-button>
        </div>
        <div style="margin-left:15vw" @click="toAllOrder">
          <van-button class="header-button">
            <van-icon name="balance-list-o" color="#00a4ff" size="40" />
            <div>全部订单</div>
          </van-button>
        </div>
      </div>
      <van-cell-group class="search-cell">
        <!-- <van-cell title="我的发票" icon="coupon-o" is-link/> -->
        <van-cell title="我的乘车人" icon="friends-o" is-link @click="toMyPassenger"/>
        <van-cell title="意见反馈" icon="comment-o" is-link @click="toFeedback"/>
      </van-cell-group>
    </div>
    <van-tabbar v-model="active">
      <van-tabbar-item to="/" icon="home-o">首页</van-tabbar-item>
      <van-tabbar-item to="/ticketWallet" icon="paid">车票夹</van-tabbar-item>
      <van-tabbar-item icon="friends-o">我的</van-tabbar-item>
    </van-tabbar>
  </div>
</template>

<script>
export default {
  name: 'Mine',
  mounted() {
    this.init();
  },
  data() {
    return {
      active: 2,
      name: '',
    };
  },
  methods: {
    init() {
      const token = localStorage.getItem('token');
      if (!token) {
        this.toSignIn();
      }
      this.name = localStorage.getItem('name');
    },
    toMyPassenger() {
      this.$router.push('/myPassenger');
    },
    toTicketWallet() {
      this.$router.push('/ticketWallet');
    },
    toAllOrder() {
      this.$router.push('/allOrder');
    },
    toFeedback() {
      this.$router.push('/feedback');
    },
    toSignIn() {
      this.$router.push('/signIn');
    },
  },
};
</script>

<style scoped>
.mine-content-header {
  display: flex;
  justify-content: center;
  background: #fff;
  margin-bottom: 10px;
}
.header-button {
  height: 100%;
  border: none;
  padding: 10px 0;
}
.user-card {
  display: flex;
  height: 15vh;
  font-size: 25px;
  font-weight: 500;
  justify-content: center;
  align-items: center;
}
</style>
