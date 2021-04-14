<template>
  <div class="advice">
    <a-table :columns="columns" :data-source="tableData" :pagination="pageData" row-key="id"
      @change="paginationChange">
        <!-- <template slot="message" slot-scope="text,$item,index">
          <div v-if="$item.message.match(/^.*$/m)[0] == $item.message">
            <p style="margin-bottom: 0; white-space: normal" v-html="$item.message"></p>
          </div>
          <div style="width: 100%; position: relative" v-else>
            <div style="display: flex" v-if="expandArr.indexOf(index) !== -1">
              <a-tooltip placement="right">
                <template v-slot:title="">
                  <span>收起</span>
                </template>
                <div style="width: 100%; position: relative">
                  <p style="margin-bottom: 0; white-space: normal"
                    v-html="$item.message.replace(/\r?\n/g, '<br />')"></p>
                  <a-icon type="up" style="position: absolute; top: 0; right: 0; border: none; margin-right: 5px">
                  </a-icon>
                </div>
              </a-tooltip>
            </div>
            <div style="display: flex" v-else>
              <a-tooltip placement="right" style="display: flex">
                <template v-slot:title="">
                  <span>点击展开内容</span>
                </template>
                <div style="width: 100%; position: relative">
                  <p style="margin-bottom: 0; white-space: normal"
                    v-html="$item.message.match(/^.*$/m)[0] + '...'"></p>
                  <a-icon type="down"
                    style="margin-top: 3.5px; position: absolute; top: 0; right: 0; border: none; margin-right: 5px">
                  </a-icon>
                </div>
              </a-tooltip>
            </div>
          </div>
        </template> -->
    </a-table>
  </div>
</template>

<script>
import axios from 'axios';
import { Base64 } from 'js-base64';
import root from '../router/root';

const columns = [
  {
    title: 'ID',
    dataIndex: 'id',
    key: 'id',
  },
  {
    title: '意见',
    dataIndex: 'message',
    key: 'message',
    // scopeSlots: {customRender: 'message'},
    // "width": "auto",
  },
  {
    title: '用户',
    dataIndex: 'userName',
    key: 'userName',
  },
  {
    title: '乘坐路线',
    key: 'location',
    dataIndex: 'location',
  },
  {
    title: '乘坐时间',
    key: 'time',
    dataIndex: 'time',
  },
  {
    title: '手机号',
    key: 'phone',
    dataIndex: 'phone',
  },
];

export default {
  name: 'Advice',
  mounted() {
    this.searchList();
  },
  data() {
    return {
      tableData: [],
      columns,
      pageData: {
        pageSize: 10,
        current: 1,
        total: 0,
      },
      expandArr: [],
    };
  },
  methods: {
    searchList() {
      const token = sessionStorage.getItem('token');
      axios.get(`${root.baseUrl}/advice/list`, {
        params: {
          pageData: this.pageData,
        },
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
      }).then((res) => {
        const data = res.data;
        this.tableData = data.searchAdvice.rows;
        this.pageData.total = data.searchAdvice.count;
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    // 分页
    paginationChange(pagination) {
      this.pageData = pagination;
      this.searchList();
    },
    // 展开和收起内容
    // expandContent(t, index) {
    //   if (t == 1) {
    //     this.expandArr.push(index);
    //   } else {
    //     let i = this.expandArr.indexOf(index);
    //     this.expandArr.splice(i, i + 1);
    //   }
    // },
    // // 点击表格行
    // rowClick(record, index) {
    //   return {
    //     on: {
    //       click: () => {
    //         if (this.expandArr.indexOf(index) !== -1) {
    //           this.expandContent(0, index);
    //         } else {
    //           this.expandContent(1, index);
    //         }
    //       }
    //     }
    //   }
    // },
  }
}
</script>

<style>

</style>
