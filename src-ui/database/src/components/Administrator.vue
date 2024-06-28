<template>
  <div class="result-table">
    <a-table
      :columns="state.columns"
      :data-source="dataSource"
      :scroll="{ y: 300 }"
      bordered>
      <template #bodyCell="{ column, text, record }">
        <template v-if="['name', 'age', 'address'].includes(column.dataIndex)">
          <div>
            <a-input
              v-if="editableData[record.key]"
              v-model:value="editableData[record.key][column.dataIndex]"
              style="margin: -5px 0"
              size="small" />
            <template v-else>
              {{ text }}
            </template>
          </div>
        </template>
        <template v-if="column.key === 'operation'">
          <span v-if="editableData[record.key]">
            <!-- <a-typography-link
                @click="save(record.key)"
                class="mg-r5"
                >保存</a-typography-link
              > -->
            <a-popconfirm
              title="确定修改?"
              @confirm="save(record.key)">
              <a-button
                type="text"
                danger
                size="small"
                >保存</a-button
              >
            </a-popconfirm>
            <a-popconfirm
              title="确定取消?"
              @confirm="cancel(record.key)">
              <a-button
                type="text"
                info
                size="small"
                >保存</a-button
              >
            </a-popconfirm>
          </span>
          <span v-else>
            <span @click="edit(record.key)">编辑</span>
          </span>
        </template>
      </template>
    </a-table>
  </div>
</template>
<script lang="ts" setup>
import { cloneDeep } from 'lodash-es';
import { onBeforeMount, reactive, ref } from 'vue';
console.time('test');
const columns = [
  {
    title: 'PID',
    dataIndex: 'name',
    width: '25%',
  },
  {
    title: '用户',
    dataIndex: 'age',
    width: '15%',
  },
  {
    title: '主机',
    dataIndex: 'address',
    width: '40%',
  },
  {
    title: '数据库',
    dataIndex: 'address',
    width: '40%',
  },
  {
    title: '命令',
    dataIndex: 'address',
    width: '40%',
  },
  {
    title: '时间',
    dataIndex: 'address',
    width: '40%',
  },
  {
    title: '状态',
    dataIndex: 'address',
    width: '40%',
  },
  {
    title: '活动查询',
    dataIndex: 'address',
    width: '40%',
  },
];

// 初始化数据
const state = reactive({
  activeKey: 'queryResult',
  columns: columns as any,
});

interface DataItem {
  key: string;
  name: string;
  age: number;
  address: string;
}

const data: DataItem[] = [];
for (let i = 0; i < 100; i++) {
  data.push({
    key: i.toString(),
    name: `Edrward ${i}`,
    age: 32,
    address: `London Park no. ${i}`,
  });
}

onBeforeMount(() => {
  state.columns.push({
    title: '操作',
    key: 'operation',
    fixed: 'right',
    align: 'center',
    width: 120,
  });
});

const dataSource = ref(data);
// const editableData: UnwrapRef<Record<string, DataItem>> = reactive({});
const editableData: any = reactive({});

const edit = (key: string) => {
  editableData[key] = cloneDeep(dataSource.value.filter((item) => key === item.key)[0]);
};

/**
 * 保存编辑的数据
 * @param key
 */
const save = (key: string) => {
  Object.assign(dataSource.value.filter((item) => key === item.key)[0], editableData[key]);
  console.log(editableData[key]);
  delete editableData[key];
};
// 取消编辑
const cancel = (key: string) => {
  delete editableData[key];
};
console.timeEnd('test');
</script>
<style lang="scss" scoped>
.result-table {
  width: 100%;
  overflow: hidden;
}
:deep(.ant-table-wrapper .ant-table-thead > tr > th) {
  padding-top: 10px;
  padding-bottom: 10px;
}
:deep(.ant-table-wrapper .ant-table-tbody > tr > td) {
  padding-top: 8px;
  padding-bottom: 4px;
}
:deep(.ant-table-wrapper tfoot > tr > th) {
  padding-top: 0;
  padding-bottom: 0;
}
:deep(.ant-table-wrapper tfoot > tr > td) {
  padding-top: 0;
  padding-bottom: 0;
}
</style>
