<template>
  <div ref="editorDom"></div>
</template>
<script setup lang="ts">
import { onMounted, ref, watch } from 'vue';
import { useFileStoreWithOut } from '../store/file';
import { storeToRefs } from 'pinia';
import { File } from '../../types';
import Vditor from 'vditor';
const editorDom = ref();
const store = useFileStoreWithOut();
const { file } = storeToRefs(store);
const editor = ref();
console.log(file, 'filefilefilefile');
// console.log(file, 'file');

watch(
  () => file.value,
  (nv) => {
    editor.value.setValue(nv.fileContent || '');
  },
);

onMounted(() => {
  let content = file.value.fileContent || '';
  const initVditor = (language: any) => {
    editor.value = new Vditor(editorDom.value, {
      value: file.value.fileContent || '',
      cache: {
        enable: false,
      },
      placeholder: '输入内容',
      toolbar: [],
      after: () => {
        editor.value.setValue(content);
        editor.value.updateValue = (val) => {
          console.log(val, 'xxxx');
        };
      },
      input() {
        // console.log('xxx');
        file.value.fileContent = editor.value.getValue();
        // console.log(editor.value.getValue());
        file.value.editStatus = true;
      },
      height: '80vh',
      width: '100%',
    });
  };
  initVditor('zh_CN');
});
</script>
<style>
.vditor,
.vditor-toolbar {
  border: none;
}
</style>
