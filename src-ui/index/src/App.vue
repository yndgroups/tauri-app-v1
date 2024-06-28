<template>
  <div @click="do_something">index-hello world</div>
  <div @click="ms_something">index-hello world</div>
</template>
<script setup lang="ts">
import { invoke } from '@tauri-apps/api';

const do_something = () => {
  invoke('plugin:mysql|do_something');
};

const ms_something = () => {
  invoke('plugin:sqlite|do_something');
};
</script>
