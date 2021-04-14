<template>
  <div class="ticketTable">
    <a-form-model layout="inline" :model="formInline" :label-col="{span: 6}" :wrapper-col="{span: 18}"
      style="margin-bottom: 10px">
      <a-form-model-item label="日期">
        <a-date-picker size="small" v-model="formInline.day" placeholder="请选择日期"/>
      </a-form-model-item>
      <a-form-model-item label="时间">
        <a-time-picker size="small" format="HH:mm" v-model="formInline.time" placeholder="请选择时间"/>
      </a-form-model-item>
      <a-form-model-item label="起点站">
        <a-cascader size="small" v-model="formInline.startStation" allowClear :options="options"
          :load-data="loadStation" :display-render="displayRender" placeholder="请选择起点站"/>
      </a-form-model-item>
      <a-form-model-item label="终点站">
        <a-cascader size="small" v-model="formInline.endStation" allowClear :options="options" 
          :load-data="loadStation" :display-render="displayRender" placeholder="请选择终点站" />
      </a-form-model-item>
      <a-form-model-item label="类型">
        <a-select style="min-width: 100px" size="small" v-model="formInline.distance" allowClear>
          <a-select-option v-for="item in selectOption" :key="item">
            {{item}}
          </a-select-option>
        </a-select>
      </a-form-model-item>
      <a-form-model-item>
        <a-button type="primary" size="small" style="margin-left: 5px" @click="search">查询</a-button>
      </a-form-model-item>
      <a-form-model-item  style="float: right">
        <a-button type="primary" size="small" @click="editRow({})">新增</a-button>
      </a-form-model-item>
    </a-form-model>
    <a-table :columns="columns" :data-source="tableData" :pagination="pageData" row-key="id"
      @change="paginationChange">
      <span slot="time" slot-scope="text">
        {{timeFormatter(text)}}
      </span>
      <span slot="action" slot-scope="text">
        <a-button size="small" style="margin-right: 15px;" @click="editRow(text)">编辑</a-button>
        <a-popconfirm title="确定删除吗" ok-text="确定" cancel-text="取消" @confirm="deleteRow(text)">
          <a-button size="small" type="danger">删除</a-button>
        </a-popconfirm>
      </span>
    </a-table>
    <ticket-form :formData="formData" :showModal="showModal" :modalTitle="modalTitle"
      @changeForm="changeForm" @createForm="createForm"></ticket-form>
  </div>
</template>

<script>
import moment from 'moment';
import axios from 'axios';
import {cloneDeep} from 'lodash';
import { Base64 } from 'js-base64';
import root from '../router/root';
import TicketForm from '../components/ticketForm';

const columns = [
  {
    title: 'ID',
    dataIndex: 'id',
    key: 'id',
  },
  {
    title: '日期',
    dataIndex: 'day',
    key: 'day',
  },
  {
    title: '时间',
    dataIndex: 'time',
    key: 'time',
    scopeSlots: {customRender: 'time'},
  },
  {
    title: '起点站',
    key: 'startStation',
    dataIndex: 'startStation',
  },
  {
    title: '终点站',
    key: 'endStation',
    dataIndex: 'endStation',
  },
  {
    title: '价格',
    key: 'money',
    dataIndex: 'money',
  },
  {
    title: '剩余票数',
    key: 'count',
    dataIndex: 'count',
  },
  {
    title: '时长',
    key: 'duration',
    dataIndex: 'duration',
  },
  {
    title: '类型',
    key: 'distance',
    dataIndex: 'distance',
  },
  {
    title: '操作',
    key: 'action',
    width: '150px',
    scopedSlots: { customRender: 'action' },
  }
];

export default {
  name: 'TicketTable',
  mounted() {
    this.init();
  },
  data() {
    return {
      tableData: [],
      columns,
      options: [],
      pageData: {
        pageSize: 10,
        current: 1,
        total: 0,
      },
      formInline: {
        day: '',
        time: '',
        startStation: [],
        endStation: [],
        distance: '',
      },
      formData: {},
      selectOption: [
        '短途车',
        '长途车',
      ],
      sort: '',
      showModal: false,
      modalTitle: '编辑车次',
    };
  },
  methods: {
    init() {
      this.searchList();
      this.loadCity();
    },
    searchList(params) {
      const token = sessionStorage.getItem('token');
      axios.get(`${root.baseUrl}/ticketTable/list`, {
        params: {
          formInline: {...params},
          pageData: this.pageData,
        },
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
      }).then((res) => {
        const data = res.data;
        this.tableData = data.tableList.rows;
        this.pageData.total = data.tableList.count;
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    search() {
      let params = this.formatData(this.formInline);
      this.searchList({...params});
    },
    loadCity() {
      axios.get(`${root.baseUrl}/cityStation/city`)
        .then((res) => {
          const data = res.data.city;
          for(let i = 0; i < data.length; i++) {
            let obj = {};
            obj.id = data[i].id;
            obj.label = data[i].text;
            obj.value = data[i].text;
            obj.isLeaf = false;
            this.options.push(obj);
          }
        }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    loadStation(selectedOptions) {
      const targetOption = selectedOptions[selectedOptions.length - 1];
      targetOption.loading = true;
      axios.get(`${root.baseUrl}/cityStation/station`, {
        params: {
          id: targetOption.id,
        },
      }).then((res) => {
        targetOption.loading = false;
        const data = res.data.station;
        let arr = [];
        for(let i = 0; i < data.length; i++) {
          let obj = {};
          obj.label = data[i].text;
          obj.value = data[i].text;
          arr.push(obj);
        }
        targetOption.children = arr;
        this.options = [...this.options];
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    displayRender({ labels }) {
      return labels[labels.length - 1];
    },
    editRow(text) {
      this.showModal = true;
      console.log('text', text);
      if (JSON.stringify(text) === '{}') {
        this.formData = {};
      }
      else {
        let obj = cloneDeep(text);
        obj.time = new Date().toLocaleDateString() + ' ' + obj.time;
        obj.duration = new Date().toLocaleDateString() + ' ' + obj.duration;
        obj.startStation = [obj.startStation];
        obj.endStation = [obj.endStation];
        this.formData = obj;        
      }
    },
    deleteRow(text) {
      const token = sessionStorage.getItem('token');
      axios.delete(`${root.baseUrl}/ticketTable/delete`, {
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
        data: {
          id: text.id,
        },
      }).then(() => {
        this.searchList();
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    changeForm(data) {
      const obj = this.formatData(data);
      obj.id = data.id;
      const token = sessionStorage.getItem('token');
      axios.post(`${root.baseUrl}/ticketTable/edit`, obj, {
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
      }).then(() => {
        this.searchList();
        this.showModal = false;
        this.$message.success('修改成功');
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    createForm(data) {
      const obj = this.formatData(data);
      const token = sessionStorage.getItem('token');
      axios.post(`${root.baseUrl}/ticketTable/create`, obj, {
        headers: {
          Authorization: `Basic ${Base64.encode(token)}`,
        },
      }).then(() => {
        this.searchList();
        this.showModal = false;
        this.$message.success('新增成功');
      }).catch((error) => {
        const { errorCode, msg } = error.response.data;
        this.$message.error(`code${errorCode}，message${msg}`);
      });
    },
    // 分页，排序
    paginationChange(pagination, filters, sorter){
      this.pageData = pagination;
      let order = "";
      if (sorter.order) {
        order = sorter.order === "ascend" ? "+" : "-";
        this.sort = order + sorter.columnKey;
      } else {
        this.sort = "";
      }
      let params = this.formatData(this.formInline);
      if (this.sort) {
        this.searchList({sorts: this.sort, ...params});
      } else {
        this.searchList({...params});
      }
    },
    // 处理数据
    formatData(data) {
      let params = {};
      if (data) {
        if (data.day) {
          if (typeof data.day === 'object') {
            params.day = data.day.format('YYYY-MM-DD');            
          } else {
            params.day = data.day;
          }
        }
        if (data.time) {
          if (typeof data.time === 'object') {
            params.time = data.time.format('HH:mm') + ':00.000000';            
          } else {
            params.time = data.time.split(' ')[1];
          }
        }
        if (data.duration) {
          if (typeof data.duration === 'object') {
            params.duration = data.duration.format('HH:mm') + ':00.000000';            
          } else {
            params.duration = data.duration.split(' ')[1];
          }
        }
        if (data.startStation.length !== 0) {
          params.startStation = data.startStation[data.startStation.length - 1];
        }
        if (data.endStation.length !== 0) {
          params.endStation = data.endStation[data.endStation.length - 1];
        }
        if (data.distance) {
          params.distance = data.distance;
        }
        if (data.count) {
          params.count = parseInt(data.count);
        }
        if (data.money) {
          params.money = parseInt(data.money);
        }
      }
      return params;
    },
    timeFormatter(time) {
      return this.moment(time, 'HH:mm:ss');
    },
    moment,
  },
  components: {
    TicketForm,
  }
}
</script>

<style scoped>

</style>
