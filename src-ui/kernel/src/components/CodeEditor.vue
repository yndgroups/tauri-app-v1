<template>
  <div class="code-editor">
    <!-- v-if="store.fileList && store.fileList.length" -->
    <template v-if="true">
      <!-- 打开文件显示 -->
      <div class="file-tabs">
        <a-tabs
          v-model:activeKey="store.activeKey"
          hide-add
          @tabScroll="callback"
          @edit="onEdit"
          @change="onChage">
          <a-tab-pane
            :key="i"
            v-for="(o, i) in store.fileList">
            <template #tab>
              <span class="file-name">
                {{ o.name }}
              </span>
              <span :style="editStatus"></span>
              <span
                class="close"
                @click.prevent.stop="store.removeFileList(i)"></span>
            </template>
            <!-- <template #moreIcon>
            <EllipsisOutlined class="more-icon" />
          </template> -->
          </a-tab-pane>
        </a-tabs>
      </div>
      <!-- 文件编辑区 -->
      <div class="file-editor">
        <div
          class="palm-editor-container"
          ref="codeEditor"></div>
      </div>
      <!-- 命令行 -->
      <Interactive />
    </template>
  </div>
  <!-- @update:value="codeVal = $event" -->
</template>
<script setup lang="ts">
import { ref, onMounted, watch, CSSProperties } from 'vue';
// import { EllipsisOutlined } from '@ant-design/icons-vue';
import PalmEditor, { LanguageType, Themes } from 'ynd-palm-editor/dist/index.es';
import { useFileStore } from '../store';
import { storeToRefs } from 'pinia';
import Interactive from './Interactive.vue';
let editStatus: CSSProperties = {
  display: 'inline-block',
  width: '8px',
  height: '8px',
  backgroundColor: '#f3f6d0',
  borderRadius: '50%',
  marginLeft: '15px',
};

// import { createTheme } from '@uiw/codemirror-themes';
// import { tags as t } from '@lezer/highlight';
const store = useFileStore();
const { file } = storeToRefs(store);
const codeEditor = ref();
const editor = ref();

// const myTheme = createTheme({
//   theme: 'light',
//   settings: {
//     background: '#ffffff',
//     backgroundImage: '',
//     foreground: '#75baff',
//     caret: '#5d00ff',
//     selection: '#036dd626',
//     selectionMatch: '#036dd626',
//     lineHighlight: '#8a91991a',
//     gutterBorder: '1px solid #ffffff10',
//     gutterBackground: '#fff',
//     gutterForeground: '#8a919966',
//   },
//   styles: [
//     { tag: t.comment, color: '#787b8099' },
//     { tag: t.variableName, color: '#0080ff' },
//     { tag: [t.string, t.special(t.brace)], color: '#5c6166' },
//     { tag: t.number, color: '#5c6166' },
//     { tag: t.bool, color: '#5c6166' },
//     { tag: t.null, color: '#5c6166' },
//     { tag: t.keyword, color: '#5c6166' },
//     { tag: t.operator, color: '#5c6166' },
//     { tag: t.className, color: '#5c6166' },
//     { tag: t.definition(t.typeName), color: '#5c6166' },
//     { tag: t.typeName, color: '#5c6166' },
//     { tag: t.angleBracket, color: '#5c6166' },
//     { tag: t.tagName, color: '#5c6166' },
//     { tag: t.attributeName, color: '#5c6166' },
//   ],
// });
watch(
  () => file.value,
  (nv) => {
    editor.value.destroy();
    initCode(nv.fileContent || '');
  },
);

onMounted(() => {
  let text = file.value.fileContent || '';
  initCode(text);
});

function onChage(val: string) {
  if (store.fileList[val].path === store.file.path) {
    return;
  }
  store.file = store.fileList[val];
}

function initCode(val: string) {
  editor.value = new PalmEditor(codeEditor.value, val, {
    view: {
      placeholder: '请输入',
      change: (val: string) => {
        console.log(val, '值改变执行');
      },
      theme: Themes.monokai,
      // extensions: extensions,
    },
    state: {
      // extensions: [EditorView.theme(monokai, { dark: false })],
    },
    type: LanguageType.javascript,
  });

  console.log(editor.value, '---editor');
}

const callback = () => {
  console.log('callback');
};

const onEdit = (targetKey: any, action: any) => {
  if (action === 'add') {
    // add();
  } else {
    console.log(targetKey);
    // remove(targetKey as string);
  }
};

const getData = (type: number) => {
  if (type == 1) {
    return editor.value.getSelection();
  }
};

// 初始化
// 主题样式设置
// {
//   '&': {
//     color: 'white',
//     backgroundColor: '#1e1e1e',
//   },
//   '.cm-content': {
//     caretColor: '#1e1e1e',
//   },
//   '&.cm-focused .cm-cursor': {
//     borderLeftColor: '#1e1e1e',
//   },
//   '&.cm-focused .cm-selectionBackground, ::selection': {
//     backgroundColor: '#1e1e1e',
//     color: '#FFF',
//   },
//   '.cm-gutters': {
//     backgroundColor: '#1e1e1e',
//     color: '#74715e',
//     border: 'none',
//   },
//   '.cm-line': {
//     // borderBottom: '1px solid #f00',
//   },
//   'cm-s-cobalt': {
//     borderLeft: '1px solid #30aaed !important',
//   },
// };

defineExpose({
  getData,
});
</script>
<style lang="scss" scoped>
.close {
  width: 15px;
  height: 15px;
  display: inline-block;
  margin-left: 10px;
  position: relative;
  top: 5px;
  padding-left: 10px;

  &::after,
  &::before {
    content: '';
    display: block;
    width: 2px;
    height: 12px;
    background-color: #f3f6d0;
    position: absolute;
  }
  &::after {
    transform: rotate(45deg);
  }
  &::before {
    transform: rotate(-45deg);
  }
}
.cm-s-cobalt .CodeMirror-cursor {
  border-left: 1px solid #30aaed !important;
}
:deep(.ant-tabs-ink-bar) {
  background-color: #f1f7b2;
}
:deep(.ant-tabs-tab-active) {
  background-color: $thirdColor;
  .file-name {
    color: #f1f7b2;
  }
}
:deep(.ant-tabs-tab) {
  background-color: $thirdColor;
  margin: 0 !important;
  padding-left: 20px;
  padding-right: 20px;
  .file-name {
    color: #f1f7b2;
  }
}
:deep(.ant-tabs) {
  background-color: $mainColor;
  color: #7b7d6b;
  &:hover {
    color: #f1f7b2;
  }
}

:deep(.ant-tabs-nav) {
  margin-bottom: 0;
  overflow: hidden;
}
.code-editor {
  position: relative;
  overflow: hidden;
  height: calc(100vh - $top-bar-height);
}

.file-editor {
  height: calc(100vh - $top-bar-height - $file-tabs-height - $cmd-interactive-height);
  overflow: hidden;
  overflow-y: scroll;
  box-sizing: border-box;
  padding: 5px;
  margin-top: $file-tabs-height;
  overflow-x: hidden;

  .palm-editor-container {
    height: 100%;
  }
}
.file-tabs {
  width: calc(100vw - $actions-width - $file-tree-width);
  box-sizing: border-box;
  height: $file-tabs-height;
  position: absolute;
  left: 0;
  top: 0;
  z-index: 999;
  box-shadow: 5px 0px 2px $mainColor;
}

.tab-name {
  color: $white;
  padding: 0 5px;
}

:deep(.ant-tabs-nav-operations) {
  background-color: $thirdColor;
}

.more-icon {
  font-size: 30px;
  color: #fff;
}

.palm-editor {
  height: 100%;
  background: $mainColor;
}
</style>
