<template>
  <div class="busList">
    <div class="busList-header">
      <van-nav-bar
        :title="startStation + '->' + endStation" left-text="返回" left-arrow
        @click-left="onClickLeft"
      />
      <div style="display: flex">
        <van-tabs color="#1872fc" style="width: 85vw">
          <van-tab v-for="item in navDate" :key="item.date">
            <template #title>
              <van-button type="default" style="border: none;" @click="navChangeTime(item.date)">
                <div style="height:100%; line-height:normal">
                  <div style="height: 50%; verticalAlign: center">{{item.date}}</div>
                  <div style="height: 50%; verticalAlign: center">{{item.day}}</div>
                </div>
              </van-button>
            </template>
          </van-tab>
        </van-tabs>
        <div style="width:15vw; background-color:#fff" @click="showCalendar = true">
          <van-icon class="busList-header-icon" name="calendar-o" size="7vw"/>
          <van-icon class="busList-header-icon" name="arrow-down" />
        </div>
      </div>
    </div>
    <list-detail v-if="!showEmpty" :tableList="tableList"></list-detail>
    <van-empty v-if="showEmpty" description="没有找到班次" style="margin-top: 89px" />
    <div class="busList-tool">
      <van-button class="busList-tool-button left-border-radius" icon="clock-o"
        @click="changeStartOrder"
      >
        {{startOrder}}
      </van-button>
      <van-button class="busList-tool-button right-border-radius" icon="filter-o"
        @click="showFilterPopup" style="margin-left: -2vw"
      >
        出发时段
      </van-button>
    </div>
    <van-calendar color="#1872fc" v-model="showCalendar" :default-date="new Date(date)"
      :max-date="maxDate" @confirm="onConfirm" />
    <van-popup v-model="showPopup" round closeable position="bottom">
      <van-tree-select :items="items" :active-id.sync="activeId" style="margin-top: 45px"
        :main-active-index.sync="activeIndex" @click-item="clickTime"
      />
      <div class="popup-bottom">
        <van-button color="#dedede" @click="resetStartTime"
          style="margin-right: 2vw; flex: 1; border-radius: 5px;"
        >
          重置
        </van-button>
        <van-button color="#1872fc" @click="searchStartTime"
          style="flex: 2; border-radius: 5px;"
        >
          确定
        </van-button>
      </div>
    </van-popup>
  </div>
</template>

<script>
import axios from 'axios';
import root from '../store/root';
import ListDetail from '../components/listDetail';
import { getWeek } from '../utils/util';

export default {
  name: 'BusList',
  mounted() {
    this.init();
  },
  data() {
    return {
      startStation: '',
      endStation: '',
      maxDate: new Date(new Date().setMonth(new Date().getMonth() + 1)),
      date: '',
      navDate: [],
      tableList: [],
      startOrder: '出发早-晚',
      timeOrder: 'time+',
      items: [{
        text: '出发时段',
        children: [{
          text: '不限', id: 0,
        }, {
          text: '00:00-06:00', id: 1,
        }, {
          text: '06:00-12:00', id: 2,
        }, {
          text: '12:00-18:00', id: 3,
        }, {
          text: '18:00-00:00', id: 4,
        }],
      }],
      timeRange: 0,
      activeId: 0,
      activeIndex: 0,
      showCalendar: false,
      showPopup: false,
      showEmpty: false,
    };
  },
  methods: {
    init() {
      this.startStation = sessionStorage.getItem('startStation');
      this.endStation = sessionStorage.getItem('endStation');
      this.date = sessionStorage.getItem('date');
      this.getDate();
      this.getList(this.date);
    },
    // 处理首页传的时间值
    getDate() {
      this.navDate = [];
      let date = this.date;
      date = new Date(date);
      const time = this.maxDate.getTime();
      const len = (time - date.getTime()) / (1000 * 3600 * 24) - 1;
      this.navDate[0] = {
        date: (date.getMonth() + 1) + '/' + date.getDate(),
        day: getWeek(date.getDay()),
      };
      for (let i = 0; i < len; i += 1) {
        const obj = {};
        date.setDate(date.getDate() + 1);
        obj.date = (date.getMonth() + 1) + '/' + date.getDate();
        obj.day = getWeek(date.getDay());
        this.navDate.push(obj);
      }
    },
    // 根据操作获取列表
    getList(date) {
      axios.get(`${root.baseUrl}/ticket/list`, {
        params: {
          day: date,
          startStation: this.startStation,
          endStation: this.endStation,
          order: this.timeOrder,
          timeRange: this.timeRange,
        },
      })
        .then((res) => {
          const list = res.data.ticketList;
          if (list.length !== 0) {
            this.showEmpty = false;
            for (let i = 0; i < list.length; i += 1) {
              if (list[i].count > 0) {
                list[i].count = '余票：' + list[i].count + '张';
                const temp1 = list[i].duration.split(':');
                const temp2 = list[i].time.split(':');
                list[i].duration = '约' + temp1[0].replace(/\b(0+)/gi, '') + '时' + temp1[1].replace(/\b(0+)/gi, '') + '分';
                list[i].time = temp2[0] + ':' + temp2[1];
              } else {
                list.splice(i, 1);
                i -= 1;
              }
            }
            this.tableList = list;
          } else {
            this.tableList = [];
            this.showEmpty = true;
          }
        }).catch((error) => {
          this.tableList = [];
          this.showEmpty = true;
          const { errorCode, msg } = error.response.data;
          this.$notify({ type: 'danger', message: `code${errorCode}，statusText${msg}` });
        });
    },
    navChangeTime(date) {
      const temp = new Date(date);
      this.activeId = 0;
      this.activeIndex = 0;
      this.timeRange = 0;
      this.date = '2021-' + (temp.getMonth() + 1) + '-' + temp.getDate();
      this.getList(this.date);
    },
    onClickLeft() {
      this.$router.push('/');
    },
    formatDate(date) {
      return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
    },
    onConfirm(date) {
      this.showCalendar = false;
      this.date = this.formatDate(date);
      this.getDate();
      this.getList(this.date);
    },
    changeStartOrder() {
      this.startOrder = this.startOrder === '出发早-晚' ? '出发晚-早' : '出发早-晚';
      this.timeOrder = this.timeOrder === 'time+' ? 'time-' : 'time+';
      this.getList(this.date);
    },
    showFilterPopup() {
      this.showPopup = true;
    },
    resetStartTime() {
      this.activeId = 0;
      this.activeIndex = 0;
      this.timeRange = 0;
    },
    searchStartTime() {
      this.showPopup = false;
      this.getList(this.date);
    },
    clickTime(data) {
      this.timeRange = data.id;
    },
  },
  components: {
    ListDetail,
  },
};
</script>

<style scoped>
.busList .van-hairline--bottom::after {
  border-bottom-width: 0;
}
.busList .van-tree-select__item--active {
  color: #1872fc;
}
.busList .van-sidebar-item--select::before {
  background-color: #1872fc;
}
/* .busList .van-tabs__wrap--scrollable .van-tab {
  padding: 0 0;
} */
.busList-header {
  position: fixed !important;
  top: 0;
  left: 0;
  z-index: 999;
  width: 100%;
}
.busList-header-icon {
  display: block;
  text-align: center;
}

.busList-tool {
  position: fixed !important;
  width: 100%;
  display: flex;
  justify-content: center;
  bottom: 8vw;
  z-index: 888;
}
.busList-tool-button {
  color: #0086f6;
  font-size: 14px;
  background-color: #fff;
}
.left-border-radius {
  border-top-left-radius: 24px;
  border-bottom-left-radius: 24px;
}
.right-border-radius {
  border-top-right-radius: 24px;
  border-bottom-right-radius: 24px;
}
.popup-bottom {
  display: flex;
  background: #fff;
  padding: 12px 16px;
}
</style>
