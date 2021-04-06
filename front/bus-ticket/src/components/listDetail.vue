<template>
  <div class="listDetail">
    <van-list
      v-model="loading"
      :finished="finished"
      finished-text="没有更多了"
    >
      <van-cell v-for="item in tableList" :key="item.id" @click="toBusPay(item)">
        <div class="buslist-info-container">
          <div style="display: flex">
            <div class="bus-info-l">
              <div class="bus-time">{{item.time}}</div>
              <div class="bus-time-total">{{item.duration}}</div>
            </div>
            <div class="bus-seperate"></div>
            <div class="bus-info-m">
              <div class="bus-start">{{item.startStation}}</div>
              <div class="bus-arrive">{{item.endStation}}</div>
              <div class="car-type">{{item.distance}}</div>
            </div>
            <div class="bus-info-r">
              <div class="price">
                <small>￥</small>
                <span>{{item.money}}</span>
              </div>
              <div class="total">{{item.count}}</div>
            </div>
          </div>
        </div>
      </van-cell>
    </van-list>
  </div>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  name: 'ListDetail',
  props: {
    tableList: {
      type: Array,
    },
  },
  data() {
    return {
      loading: false,
      finished: true,
    };
  },
  methods: {
    ...mapActions(['queryTicketData']),
    onLoad() {
      // 异步更新数据
      // setTimeout 仅做示例，真实场景中一般为 ajax 请求
      // setTimeout(() => {
      //   for (let i = 0; i < 10; i++) {
      //     this.list.push(this.list.length + 1);
      //   }

      //   // 加载状态结束
      //   this.loading = false;

      //   // 数据全部加载完成
      //   if (this.list.length >= 40) {
      //     this.finished = true;
      //   }
      // }, 1000);
    },
    toBusPay(data) {
      const obj = {};
      if(this.$route.query.changeTicket == 1) {
        obj.changeTicket = 1;
        obj.ticketId = this.$route.query.ticketId;
        obj.tableId = this.$route.query.tableId;
        obj.newTableId = data.id;
      }
      this.$router.push({
        path: '/busPay',
        query: obj,
      });
      this.queryTicketData(data);
    },
  },
};
</script>

<style scoped>
.listDetail {
  margin-top: 89px;
  padding-top: 1vh;
}

.buslist-info-container {
  font-size: 20px;
  font-family: PingFang SC;
}

.bus-info-l {
  flex: 0 0 85px;
}
.bus-time {
  font-size: 20px;
  font-weight: 600;
  height: 22px;
  line-height: 22px;
  margin-bottom: 2px;
}
.bus-time-total {
  margin-top: 6px;
  font-size: 11px;
  height: 12px;
  line-height: 12px;
  color: #666;
}

.bus-seperate {
  width: 4px;
  height: 30px;
  margin: 9px 10px auto 5px;
  background: url(//pages.c-ctrip.com/bus-images/busH5/bus-seo/1123-seo/%E7%BA%BF%E8%B7%AF.png)
    no-repeat;
  background-size: 100% 100%;
}

.bus-info-m {
  font-size: 14px;
  flex: 1;
}
.bus-start{
  font-weight: 500;
}
.bus-arrive {
  font-weight: 500;
  margin-top: 7px;
}
.car-type {
  color: #b0b0b0;
  margin-top: 9px;
  font-size: 10px;
  display: flex;
  align-items: center;
}

.bus-info-r {
  text-align: right;
  font-size: 20px;
}
.price {
  color: #f70;
}
.total {
  font-size: 11px;
  color: #666;
}
</style>
