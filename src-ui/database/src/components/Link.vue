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
    { name: '用户', key: 'user', icon: TeamOutlined },
    { name: '管理员', key: 'administrator', icon: UserSwitchOutlined },
    { name: '系统信息', key: 'system', icon: RobotOutlined },
  ],
});
</script>
