<template>
  <div class="ticketForm">
    <a-modal v-model="showModal" :title="modalTitle" ok-text="确定" cancel-text="取消" @ok="submitModal"
      :dialog-style="{ top: '20px' }">
      <a-form-model :model="formInline" :label-col="{span: 6}" :wrapper-col="{span: 12}">
        <a-form-model-item label="日期">
          <a-date-picker v-model="formInline.day" placeholder="请选择日期"/>
        </a-form-model-item>
        <a-form-model-item label="时间">
          <a-time-picker format="HH:mm" v-model="formInline.time" placeholder="请选择时间"/>
        </a-form-model-item>
        <a-form-model-item label="时长">
          <a-time-picker format="HH:mm" v-model="formInline.duration" placeholder="请选择时间"/>
        </a-form-model-item>
        <a-form-model-item label="起点站">
          <a-cascader v-model="formInline.startStation" allowClear :options="options"
            :load-data="loadStation" :display-render="displayRender" placeholder="请选择起点站"/>
        </a-form-model-item>
        <a-form-model-item label="终点站">
          <a-cascader v-model="formInline.endStation" allowClear :options="options" 
            :load-data="loadStation" :display-render="displayRender" placeholder="请选择终点站"/>
        </a-form-model-item>
        <a-form-model-item label="类型">
          <a-select v-model="formInline.distance" allowClear placeholder="请选择类型">
            <a-select-option v-for="item in selectOption" :key="item">
              {{item}}
            </a-select-option>
          </a-select>
        </a-form-model-item>
        <a-form-model-item label="剩余票数">
          <a-input v-model="formInline.count" allowClear placeholder="请输入剩余票数"></a-input>
        </a-form-model-item>
        <a-form-model-item label="价格">
          <a-input v-model="formInline.money" allowClear placeholder="请输入价格"></a-input>
        </a-form-model-item>
      </a-form-model>
    </a-modal>
  </div>
</template>

<script>
import axios from 'axios';
import root from '../router/root';

export default {
  name: 'TicketForm',
  props: {
    showModal: {
      type: Boolean,
    },
    modalTitle: {
      type: String,
    },
    formData: {
      type: Object,
    },
  },
  watch: {
    formData(newV) {
      this.formInline = newV;
    },
  },
  data() {
    return {
      formInline: {},
      options: [],
      selectOption: [
        '短途车',
        '长途车',
      ],
    }
  },
  mounted() {
    this.formInline = this.formData;
    this.loadCity();
  },
  methods: {
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
    submitModal() {
      if (!this.formInline.id) {
        this.$emit('createForm', this.formInline);
      }
      else {
        this.$emit('changeForm', this.formInline);        
      }
    }
  },
}
</script>

<style scoped>

</style>>
