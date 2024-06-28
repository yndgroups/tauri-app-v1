<template>
  <div class="cmd-interactive">
    <div class="tabs">
      <dl>
        <dt>
          <a-tabs v-model:activeKey="state.activeKey">
            <a-tab-pane
              :key="i"
              v-for="(o, i) in state.tabs">
              <template #tab>
                <span class="tab-name"><FileTextOutlined />{{ o.name }}</span>
              </template>
            </a-tab-pane>
          </a-tabs>
        </dt>
        <dd>+</dd>
      </dl>
    </div>
    <div class="bord">
      <Terminal />
    </div>
  </div>
</template>
<script lang="ts" setup>
import { reactive } from 'vue';
import { FileTextOutlined } from '@ant-design/icons-vue';
import Terminal from './Terminal.vue';

const state = reactive({
  activeKey: '1',
  tabs: [
    { name: '问题', status: false },
    { name: '输出', status: false },
    { name: '调试控制台', status: false },
    { name: '终端', status: false },
    { name: '端口', status: false },
  ],
});
</script>

<style scoped lang="scss">
:deep(.ant-tabs) {
  background-color: $thirdColor;
}

:deep(.ant-tabs-nav) {
  margin-bottom: 0;
  overflow: hidden;
}

:deep(.ant-tabs-nav-operations) {
  background-color: $thirdColor;
}
.cmd-interactive {
  height: $cmd-interactive-height;
  background-color: $thirdColor;
  overflow: hidden;

  .tabs dl {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: $thirdColor;
    padding-right: 20px;
  }

  .tab-name {
    color: $white;
  }

  .bord {
    background-color: $mainColor;
    padding: 10px 0 10px 10px;
    height: $cmd-interactive-height;
    box-sizing: border-box;
  }
}
</style>
