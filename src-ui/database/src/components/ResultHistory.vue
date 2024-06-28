<template>
  <div class="result-table">
    <a-tabs v-model:activeKey="state.activeKey">
      <a-tab-pane
        key="queryResult"
        tab="查询结果"></a-tab-pane>
      <a-tab-pane
        key="historyQuery"
        tab="历史查询"
        force-render></a-tab-pane>
      <a-tab-pane
        key="saveQuery"
        tab="保存的查询"></a-tab-pane>
      <a-tab-pane
        key="historyExport"
        tab="历史导出"></a-tab-pane>
    </a-tabs>
    <a-table
      :columns="state.columns"
      :data-source="dataSource"
      :scroll="{ y: 350 }"
      @resizeColumn="handleResizeColumn"
      :row-class-name="(_record: any, index: number) => (index % 2 === 1 ? 'table-striped' : null)"
      :row-selection="{ selectedRowKeys: state.selectedRowKeys, onChange: onSelectChange }">
      <template #bodyCell="{ column, text, record }">
        <template v-if="column.key === 'sqlText'">
          <a-tooltip>
            <template #title>{{ record.sqlText }}</template>
            {{ slicingStr(record) }}
          </a-tooltip>
        </template>
        <template v-if="column.key === 'operation'">
          <span v-if="editableData[record.key]">
            <a-popconfirm
              title="确定修改?"
              @confirm="save(record.key)">
              <a-button
                type="text"
                primary
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
                >取消</a-button
              >
            </a-popconfirm>
          </span>
          <span v-else>
            <span @click="edit(record.key)">编辑</span>
          </span>
        </template>
      </template>
    </a-table>
    <div class="export">
      <a-button
        size="samll"
        class="mg-r5"
        type="primary"
        @click="Palm.urls.exportCsv"
        >导出选中</a-button
      >
      <a-button
        @click="out"
        size="samll"
        >导出全部</a-button
      >
    </div>
  </div>
</template>
<script lang="ts" setup>
import { cloneDeep } from 'lodash-es';
import { onBeforeMount, reactive, ref, onMounted } from 'vue';
import Palm from 'palmjs/dist';
import { Response } from '../../env';

const slicingStr = (item: any) => {
  console.log(typeof item.sqlText, 'slicingStr');
  if (typeof item.sqlText === 'string') {
    return item.sqlText.substring(0, 20) + '...';
  }
  return '';
};

const out = () => {
  // const JSONData = [{}];
  // JSONToExcelConvertor([], ['文件名'], false);
};

console.time('test');
const columns = [
  // {
  //   title: '序号',
  //   align: 'index',
  //   key: 'index',
  //   width: 60,
  //   customRender: ({ record }: any) => {
  //     return `${parseInt(record.id)}`;
  //   },
  // },
  {
    title: 'id',
    dataIndex: 'id',
  },
  {
    title: '连接名称',
    dataIndex: 'linkName',
    resizable: true,
  },
  {
    title: 'SQL',
    dataIndex: 'sqlText',
    key: 'sqlText',
    resizable: true,
  },
  {
    title: '数据库名称',
    dataIndex: 'dbName',
    resizable: true,
  },
  {
    title: '创建时间',
    dataIndex: 'createTime',
    resizable: true,
  },
  {
    title: '更新时间',
    dataIndex: 'updateTime',
    resizable: true,
  },
];

// 初始化数据
const state = reactive({
  activeKey: 'queryResult',
  columns: columns as any,
  selectedRowKeys: [] as any,
});

const onSelectChange = (selectedRowKeys: any[]) => {
  console.log('selectedRowKeys changed: ', selectedRowKeys);
  state.selectedRowKeys = selectedRowKeys;
};

function handleResizeColumn(w, col) {
  col.width = w;
}

onMounted(async () => {
  let { code, msg, data }: Response = await window.Bridge.invoke('plugin:sqlite|get_history_query_list', {
    pageInfo: {
      pageIndex: 1,
      pageSize: 10,
      params: {},
    },
    operationType: 2,
  });
  if (data && Array.isArray(data)) {
    dataSource.value = data;
  }
  console.log(code, msg, data, 'xxxx----');
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
    width: 150,
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
.export {
  bottom: 0;
  left: 0;
}
:deep(.ant-table-wrapper .ant-table-thead > tr > th),
:deep(.ant-table-wrapper tfoot > tr > th) {
  padding: 6px;
}
:deep(.ant-table-wrapper .ant-table-tbody > tr > td),
:deep(.ant-table-wrapper tfoot > tr > td) {
  padding: 3px 6px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

:deep(.table-striped) td {
  background-color: #fafafa;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
:deep(.table-striped) td {
  background-color: #ebf3fe;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
