<template>
  <a-tabs v-model:activeKey="activeKey">
    <a-tab-pane
      :key="item.key"
      v-for="item in state.actions">
      <template #tab>
        <span>
          <component :is="item.icon" />
        </span>
      </template>
      {{ item.name }}
    </a-tab-pane>
  </a-tabs>
</template>
<script lang="ts" setup>
import { TeamOutlined, UserSwitchOutlined, ProjectOutlined, RobotOutlined } from '@ant-design/icons-vue';
import { ref, reactive } from 'vue';
const activeKey = ref('1');
const state = reactive({
  actions: [
    { name: '属性', key: 'attribute', icon: ProjectOutlined },
    { name: '表', key: 'table', icon: TeamOutlined },
    { name: '视图', key: 'view', icon: UserSwitchOutlined },
    { name: '索引', key: 'index', icon: RobotOutlined },
    { name: '存储过程', key: 'storeProcedure', icon: RobotOutlined },
    { name: '触发器', key: 'trigger', icon: RobotOutlined },
    { name: '事件', key: 'event', icon: RobotOutlined },
    { name: '源', key: 'source', icon: RobotOutlined },
  ],
});
</script>
