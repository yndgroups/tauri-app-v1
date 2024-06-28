```
<template>
  <div class="sql-editor">
    <hljsVuePlugin.component
      contenteditable="true"
      :code="code" />
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue';
import hljs from 'highlight.js/lib/core';
import { onMounted } from 'vue';
import 'highlight.js/styles/stackoverflow-light.css';
import 'highlight.js/lib/common';
import hljsVuePlugin from '@highlightjs/vue-plugin';

const code = ref(`SELECT * FROM my_table WHERE id = 1 AND s = 'qwe'';
console.log(hello);`);

onMounted(() => {
  document.addEventListener('DOMContentLoaded', (event: any) => {
    console.log(event, 'event');
    document.querySelectorAll('code').forEach((block: any) => {
      hljs.highlightBlock(block);
    });
  });
});
</script>
<style lang="scss" scoped>
.sql-editor {
}
</style>
```
