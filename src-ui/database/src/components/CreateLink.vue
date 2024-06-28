<template>
  <div class="create-link">
    <a-modal
      v-model:open="state.visible"
      title="创建连接"
      @cancel="cancel"
      width="60%"
      :footer="false">
      <div class="steps">
        <a-steps
          v-model:current="state.step"
          :items="state.items"></a-steps>
      </div>
      <div class="form">
        <a-tabs
          v-if="state.step == 0"
          v-model:activeKey="state.activeKey"
          :tab-position="state.mode"
          @tabScroll="callback">
          <a-tab-pane
            v-for="o in state.dbTypeList"
            :key="o.value"
            :tab="o.name">
            <a-row :gutter="40">
              <a-col
                :span="6"
                v-for="(item, index) in dbList">
                <div
                  class="list-item"
                  @click="checkedDbType(item)"
                  :class="{ active: state.checkedDbType === item.name }">
                  <div class="icon">
                    <PalmSvg
                      :name="item.icon"
                      :key="index"
                      :width="40"
                      :height="40" />
                  </div>
                  <p class="db-name">{{ item.name }}</p>
                </div>
              </a-col>
            </a-row>
          </a-tab-pane>
        </a-tabs>
        <a-form
          v-if="state.step == 1"
          ref="formRef"
          :model="formState"
          :rules="rules"
          :label-col="labelCol"
          :wrapper-col="wrapperCol">
          <a-form-item
            ref="linkName"
            label="连接名称"
            name="linkName">
            <a-input
              v-model:value="formState.linkName"
              autocomplete="false"
              placeholder="请输入连接名称"
              autocapitalize="off" />
          </a-form-item>
          <a-form-item
            label="主机地址"
            required
            name="host">
            <a-input
              v-model:value="formState.host"
              autocomplete="false"
              placeholder="请输入主机地址" />
          </a-form-item>
          <a-form-item
            label="端口"
            required
            name="port">
            <a-input
              v-model:value="formState.port"
              autocomplete="false"
              placeholder="请输入端口" />
          </a-form-item>
          <a-form-item
            label="用户名"
            required
            name="host"
            placeholder="请输入用户名">
            <a-input
              v-model:value="formState.user"
              autocomplete="false" />
          </a-form-item>
          <a-form-item
            label="密码"
            required
            name="password"
            placeholder="请输入密码">
            <a-input
              v-model:value="formState.password"
              autocomplete="false" />
          </a-form-item>
          <a-form-item :wrapper-col="{ span: 16, offset: 4 }">
            <div class="fl">
              <a-button
                @click="testLink"
                class="mg-r10"
                >测试连接</a-button
              >
            </div>
            <div class="fr">
              <a-button
                @click="cancel"
                class="mg-r10"
                >取消</a-button
              >
              <a-button
                type="primary"
                @click="onSubmit"
                >确定</a-button
              >
            </div>
          </a-form-item>
        </a-form>
      </div>
    </a-modal>

    <a-modal
      v-model:open="state.open"
      @ok="state.open = false">
      <template #title>
        <div class="err-title">
          <ExclamationCircleOutlined />
          <span>连接失败提示提示</span>
        </div>
      </template>
      <p class="err-content">{{ state.errMsg }}</p>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import { computed, reactive, ref, toRaw } from 'vue';
import { h } from 'vue';
import { AppstoreAddOutlined, ClusterOutlined } from '@ant-design/icons-vue';
import { StepProps, message } from 'ant-design-vue';
import { ExclamationCircleOutlined } from '@ant-design/icons-vue';
import type { TabsProps } from 'ant-design-vue';
import { Response } from '../../env';
import PalmSvg from '../components/PalmSvg.vue';
import type { Rule } from 'ant-design-vue/es/form';
let emits = defineEmits(['closeModal', 'refresh']);
let props = defineProps({
  visible: {
    type: Boolean,
    default: false,
  },
});

let state = reactive({
  visible: props.visible,
  activeKey: 'all',
  step: 0,
  mode: 'left',
  checkedDbType: '',
  dbTypeList: [
    {
      name: '全部',
      value: 'all',
    },
    {
      name: '关系型数据库',
      value: 'relational',
    },
    {
      name: 'noSQL',
      value: 'noSQL',
    },
  ],
  dbList: [
    { name: 'MySQL', icon: 'mysql', type: 'relational', mark: 'mysql' },
    { name: '达梦', icon: 'dmdb', type: 'relational', mark: 'dm' },
    { name: '人大金仓', icon: 'kingBase', type: 'relational', mark: 'kingbase' },
    { name: 'Sqlite', icon: 'sqlite', type: 'noSQL', mark: 'sqlite' },
    { name: 'MariaDb', icon: 'mariaDb', type: 'relational', mark: 'mariadb' },
    { name: 'Oracle', icon: 'oracle', type: 'relational', mark: 'oracle' },
    { name: 'PostgreSQL', icon: 'postgreSQL', type: 'relational', mark: 'postgresql' },
    { name: 'MongoDB', icon: 'mongoDB', type: 'noSQL', mark: 'mongodb' },
  ],
  items: [
    {
      title: '数据库类型',
      icon: h(AppstoreAddOutlined),
    },
    {
      title: '连接信息',
      icon: h(ClusterOutlined),
    },
  ] as StepProps[],
  open: false,
  errMsg: '',
});

const formRef = ref();
const labelCol = { span: 6 };
const wrapperCol = { span: 13 };
const formState = reactive<{ [key: string]: any }>({
  id: 0,
  linkName: 'linux-text',
  dbType: 'mysql',
  host: '10.211.55.10',
  user: 'root',
  password: 'Ynd@2025',
  port: 3306,
});
const rules: Record<string, Rule[]> = {
  linkName: [
    { required: true, message: '请输入连接名称', trigger: 'blur' },
    { min: 5, max: 50, message: '长度5-50位', trigger: 'blur' },
  ],
  host: [{ required: true, message: '请输入主机地址', trigger: 'blur' }],
  port: [{ required: true, message: '请输入端口', trigger: 'blur' }],
  user: [{ required: true, message: '请输入账号', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
};
const onSubmit = () => {
  formRef.value
    .validate()
    .then(async () => {
      formState.dbType = state.checkedDbType;
      console.log('values', formState, toRaw(formState));
      let { code, msg, data }: Response = await window.Bridge.invoke('plugin:sqlite|save_link', {
        data: formState,
      });
      console.log(code, msg, data);
      if (code === 1) {
        emits('refresh');
        emits('closeModal');
        message.success(msg);
      } else {
        message.error(msg);
      }
    })
    .catch((error: any) => {
      console.log('error', error);
    });
};

// 测试连接
const testLink = async () => {
  // 连接接口
  let { code, msg }: Response = await window.Bridge.invoke('plugin:mysql|test_link', {
    params: {
      host: formState.host,
      user: formState.user,
      password: formState.password,
      dbType: 'mysql',
      port: formState.port,
      linkName: formState.linkName,
    },
  });
  state.errMsg = msg;
  code === 1 ? message.success(msg) : (state.open = true);
};

const dbList = computed(() => {
  if (state.activeKey == 'all') {
    return state.dbList;
  } else {
    return state.dbList.filter((item: any) => item.type === state.activeKey);
  }
});

const checkedDbType = (item: any) => {
  state.checkedDbType = item.icon;
  state.step = 1;
};

const callback: TabsProps['onTabScroll'] = (val) => {
  console.log(val);
};

// 取消
const cancel = () => {
  for (let k in formState) {
    formState[k] = '';
  }
  emits('closeModal');
};
</script>
<style lang="scss" scoped>
.steps {
  padding: 10px 150px;
  border-bottom: 1px solid #f2f2f2;
}

.err-title {
  color: #ff0000;
  span {
    padding-left: 10px;
  }
}
.err-content {
  color: #ff0000;
  padding: 0 20px;
}

.list-item {
  text-align: center;
  margin-bottom: 20px;
  padding: 10px 0;
  border: 1px dashed #e3dfdf;
  border-radius: 8px;

  .icon {
    text-align: center;
    display: flex;
    justify-content: center;
  }
  .db-name {
    margin-top: 10px;
    font-weight: bold;
    color: #666060;
    font-size: 16px;
  }

  &:hover {
    border: 1px solid $color-primary;
    cursor: pointer;
  }
  &.active {
    border: 1px solid $color-primary;
  }
}
.form {
  padding: 30px 0 30px 0;
}
</style>
