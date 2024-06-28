```
<template>
  <div class="palm-db-main">
    <!-- <div class="editor-tools">
      <dl v-for="(o, i) in state.actions" :key="i" @click="toolChange(o)">
        <dt>
          <PalmSvg :name="o.icon" :width="24" :color="o.color"></PalmSvg>
        </dt>
        <dd>{{ o.name }}</dd>
      </dl>
    </div> -->
    <div class="editor-work">
      <!-- 连接区 -->
      <div v-show="state.showLeft" ref="dragLeftParent" class="editor-links">
        <div class="filter">
          <div class="search">
            <input autocomplete="false" placeholder="请输入关键词" />
          </div>
          <div class="create-database" @click="toolChange({ id: 1 })">
            <PalmSvg
              :name="'createDatabase'"
              :width="20"
              :color="'#f00'"
            ></PalmSvg>
          </div>
        </div>
        <div class="link-box">
          <palm-tree
            v-if="state.treeData && state.treeData.length"
            :data="state.treeData"
            :checked="false"
            @on-change="treeOnChange"
            @on-click="treeOnClick"
            @on-right-click="onRightClick"
          />
        </div>
        <div
          ref="dragLeft"
          class="drag-line"
          @mousedown="leftMousedown($event)"
        ></div>
      </div>
      <!-- 操作区 -->
      <div class="editor-operation">
        <div @click="saveDbLinksTree">保存配置</div>
      </div>
      <!-- 信息区 -->
      <!-- <div v-show="state.showRight" ref="dragRightParent" class="editor-info">
        <div>信息区</div>
        <div ref="dragRight" class="drag" @mousedown="rightMousedown()"></div>
      </div> -->
    </div>
    <div class="editor-views">
      <div class="left icon" @click="state.showLeft = !state.showLeft"></div>
      <div class="right icon" @click="state.showRight = !state.showRight"></div>
    </div>

    <!-- 工具栏 -->
    <plam-create-links v-model:visible="state.visible" />
  </div>
</template>
<script lang="ts" setup>
import { reactive, ref, onMounted } from "vue";
import PlamCreateLinks from "../components/palm/PlamCreateLinks.vue";
import PalmTree from "../components/palm/PalmTree.vue";
import PalmSvg from "../components/palm/PalmSvg.vue";
import { LinkTreeData } from "../global/types";
import { invoke } from "@tauri-apps/api/tauri";
const dragLeft = ref<HTMLElement>();
// const dragRight = ref<HTMLElement>();
const dragLeftParent = ref<HTMLElement>();
// const dragRightParent = ref<HTMLElement>();

const state = reactive({
  showLeft: true,
  showRight: true,
  visible: false,
  actions: [
    { name: "连接", icon: "createLink", id: 1, width: 20, color: "#F00" },
    { name: "新建查询", icon: "createQuery", id: 2, width: 20, color: "#F00" },
    { name: "表", icon: "table", id: 2, width: 20, color: "#F00" },
    { name: "视图", icon: "views", id: 3, width: 20, color: "#F00" },
    { name: "函数", icon: "fn", id: 4, width: 20, color: "#F00" },
    { name: "事件", icon: "event", id: 5, width: 20, color: "#F00" },
    { name: "用户", icon: "user", id: 6, width: 20, color: "#F00" },
    { name: "查询", icon: "tableQuery", id: 7, width: 20, color: "#F00" },
    { name: "报表", icon: "report", id: 8, width: 20, color: "#F00" },
    { name: "备份", icon: "bak", id: 9, width: 20, height: 10, color: "#F00" },
    { name: "自动运行", icon: "autoRun", id: 10, width: 20, color: "#F00" },
    { name: "模型", icon: "model", id: 11, width: 20, color: "blue" },
  ],
  lX: 0,
  rX: 0,
  treeData: new Array<LinkTreeData>(),
});

onMounted(async () => {
  getDbLinksTree();
});

// 保存配置
const saveDbLinksTree = () => {
  getDbLinksTree();
};

// 获取树
const getDbLinksTree = async () => {
  let reslt = await invoke("query_information_schema");
  if (typeof reslt === "string") {
    let temApp = JSON.parse(reslt);
    temApp = temApp.map((item: string) => {
      return {
        name: item,
        label: item,
        value: item,
        icon: "database",
      };
    });

    state.treeData = [
      {
        name: "localhost",
        label: "locahost",
        value: "localhost",
        children: temApp,
        port: 3306,
        user: "root",
        password: "123456",
        charset: "utf8",
        id: "1",
        disableCheckbox: false,
        type: "mysql",
        icon: "mysql",
      } as any,
    ];
  }
  console.log(reslt, "reslt");
};

// 工具栏切换
const toolChange = (o: any) => {
  switch (o.id) {
    case 1:
      if (!state.visible) {
        state.visible = true;
      }
      break;
  }
  console.log(o, "工具栏切换");
};

// 左边菜单右键事件
const onRightClick = async (evt: any) => {
  console.log(evt);
};

// tree 选中事件
const treeOnChange = (item: any) => {
  console.log(item, "item");
};

// tree 点击事件
const treeOnClick = (item: any) => {
  console.log(item, "item");
};

// 左边拖动
const leftMousedown = (event: any) => {
  let dragWidth = 0;
  let dragContainerWidth = 0;
  if (dragLeft.value && dragLeftParent.value) {
    state.lX = event.clientX - dragLeft.value.offsetLeft;
    dragWidth = dragLeft.value.offsetWidth;
    dragContainerWidth = dragLeftParent.value.offsetWidth + 100;
  }
  document.onmousemove = (el) => {
    let moveX = el.clientX - state.lX;
    if (moveX <= 0) {
      moveX = 0;
    }

    if (moveX >= dragContainerWidth - dragWidth) {
      moveX = dragContainerWidth - dragWidth;
    }
    if (moveX > 20) {
      if (dragLeftParent.value) {
        dragLeftParent.value.style.width = `${moveX}px`;
      }
    }
  };

  document.onmouseup = () => {
    document.onmousemove = null;
  };
};

// 右边拖动
// const rightMousedown = () => {
//   const winWidth = window.innerWidth;
//   document.onmousemove = (el) => {
//     const moveX = winWidth - el.clientX;
//     if (moveX > 20 && moveX < 300) {
//       if (dragRightParent.value) {
//         dragRightParent.value.style.width = `${moveX}px`;
//       }
//     }
//   };
//   document.onmouseup = () => {
//     document.onmousemove = null;
//   };
// };
</script>
<style lang="scss" scoped>
$c1: #f0f0f0;
$c2: #636363;
.palm-db-main {
  min-height: 100vh;
  min-width: 100vw;
  overflow: hidden;

  .editor-tools {
    height: 80px;
    background-color: $c1;
    display: flex;
    align-items: center;
    padding-left: 10px;

    dl {
      background-color: hsl(0, 2%, 92%);
      margin-right: 10px;
      min-width: 60px;
      text-align: center;
      font-size: 14px;
      border-radius: 8px;
      padding: 6px 5px 5px 5px;
      cursor: pointer;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;

      dt {
        text-align: center;
        height: 30px;
      }

      dd {
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
        font-size: 12px;
      }
    }
  }

  .editor-work {
    height: calc(100vh - 30px);
    background-color: #fff;
    display: flex;

    .editor-links {
      width: 350px;
      background-color: #fff;
      position: relative;
      margin-right: 4px;
      box-sizing: border-box;
      overflow: hidden;

      .filter {
        display: flex;
        white-space: nowrap;
        justify-content: space-between;
        user-select: none;
        overflow: hidden;
        margin: 10px;
        height: 26px;

        .search {
          border: 1px solid #f00;
          flex: 1;
          border-radius: 15px;
          overflow: hidden;
          margin-right: 10px;
          align-items: center;

          input {
            width: 100%;
            display: block;
            height: 100%;
            font-size: 14px;
            text-indent: 10px;
          }
        }
        .create-database {
          margin-top: -3px;
        }
      }

      .link-box {
        padding: 10px;
        overflow-x: hidden;
        overflow-y: auto;
        box-sizing: border-box;
        height: calc(100vh - 80px);
      }

      .drag-line {
        position: absolute;
        width: 4px;
        height: 100%;
        background: $c1;
        z-index: 9;
        right: 0px;
        top: 0;
        cursor: col-resize;
      }
    }

    .editor-operation {
      flex: 1;
    }

    .editor-info {
      width: 220px;
      background-color: #fff;
      position: relative;
      padding-left: 4px;
      box-sizing: border-box;
      overflow: hidden;

      .drag {
        position: absolute;
        width: 4px;
        height: 100%;
        background: $c1;
        z-index: 9;
        left: 0px;
        top: 0;
        cursor: col-resize;
      }
    }
  }

  .editor-views {
    height: 30px;
    background-color: $c1;
    display: flex;
    justify-content: right;
    align-items: center;
    padding-right: 20px;

    .icon {
      border: 1px solid $c2;
      width: 18px;
      height: 20px;
      margin-right: 5px;
      display: flex;
      align-items: center;
      cursor: pointer;

      &.left::after,
      &.right::after {
        content: "";
        width: 6px;
        height: 15px;
        background-color: $c2;
      }

      &.left {
        box-sizing: border-box;
        padding-left: 2px;
        justify-content: left;
      }
      &.right {
        box-sizing: border-box;
        padding-right: 2px;
        justify-content: right;
      }
    }
  }
}
</style>
```
