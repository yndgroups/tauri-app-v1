- vue 递归

```
<template>
  <div class="palm-tree">
    <template v-if="treeData && treeData.length">
      <PalmTreeItem
        v-for="(item, index) in treeData"
        :key="`${item.value}_${index}`"
        :item="item"
        @watchHandler="watchHandler"
      />
    </template>
  </div>
</template>
<script lang="tsx" setup>
import { ref } from "vue";
import { Tree } from "../../global/types";
import PalmTreeItem from "./PalmTreeItem.vue";
const emits = defineEmits(["click", "checked", "right-click"]);
const props = defineProps({
  checked: {
    type: Boolean,
    default: false,
  },
  data: {
    type: Array<Tree>,
    default: () => [],
  },
});
const treeData = ref(props.data);

const watchHandler = (o: any) => {
  console.log(">>pppp>", o);
  switch (o.handleType) {
    case "click": // 点击事件
      emits("click", o);
      break;
    case "checked": // 选中事件
      emits("checked", o);
      break;
    case "rright-click": // // 右击事件
      emits("right-click", o);
      break;
  }
};
</script>
<style scoped lang="scss">
.palm-tree {
  padding-bottom: 20px;
}
</style>
```

- jsx 递归

```
<template>
  <div class="palm-tree">
    <DataTree />
  </div>
</template>
<script lang="tsx" setup>
import { computed, watch } from "vue";
import { Tree } from "../../global/types";
const emits = defineEmits(["on-change", "on-click", "on-right-click"]);
const props = defineProps({
  checked: {
    type: Boolean,
    default: false,
  },
  data: {
    type: Array<Tree>,
    default: () => [],
  },
});

// 创建tree dom
const renderTree = (data: Array<Tree>) => {
  return (
    <>
      {data.map((o, i) => {
        return (
          <dl key={`${o.value}_${i}`} style="padding-left: 10px">
            <dt
              onClick={(evt) => clickHandle(evt, o)}
              onContextmenu={(evt) => rightClick(evt, o)}
            >
              {o.children && o.children.length ? (
                <div class="icon expand"></div>
              ) : (
                <div class="icon"></div>
              )}
              {props.checked ? (
                <input
                  onChange={(evt) => changeHandle(evt, o)}
                  disabled={o.disabled}
                  type="checkbox"
                />
              ) : (
                ""
              )}
              <div>{o.label}</div>
            </dt>
            <dd>
              <div
                class={
                  (o.children && o.children.length ? "line" : "",
                  o.expand ? "expand" : "")
                }
              >
                {o.children && o.children.length ? renderTree(o.children) : ""}
              </div>
            </dd>
          </dl>
        );
      })}
    </>
  );
};

// 点击事件
const clickHandle = (evt: Event, o: Tree) => {
  evt.preventDefault();
  emits("on-click", o);
};

// 选中事件
const changeHandle = (evt: Event, o: Tree) => {
  evt.preventDefault();
  emits("on-change", o);
};

// 右击事件
const rightClick = (evt: any, o: Tree) => {
  evt.preventDefault();
  evt.stopPropagation();
  emits("on-right-click", { ...o, x: evt?.clientX, y: evt?.clientY });
};

const DataTree = computed(() => renderTree(props.data));

watch(
  () => DataTree,
  (nv) => {
    console.log(nv, "DataTree");
    // DataTree = renderTree(props.data);
  },
  {
    deep: true,
  }
);
</script>
<style lang="scss">
.line {
  position: relative;
  &::before {
    content: "";
    border-left: 1px dashed #ccc;
    position: absolute;
    height: 100%;
    left: 4px;
    top: -5px;
  }
}
palm-tree {
  height: calc(100vh - 200px);
  overflow-x: hidden;
  overflow-y: auto;
  min-height: 100vh;
}
.palm-tree dl {
  dt {
    display: flex;
    align-items: center;
    font-size: 14px;
    cursor: pointer;
    input {
      margin-right: 5px;
    }
  }
  dd {
    align-items: center;
    input {
      margin-right: 5px;
    }

    .expand {
      display: hidden;
    }
  }

  .icon {
    display: inline-block;
    width: 0;
    height: 0;
    margin-top: 2px;
    margin-right: 5px;

    &.expand {
      border-top: 5px solid rgb(94, 93, 92);
      border-right: 5px solid transparent;
      border-left: 5px solid transparent;
      border-bottom: 5px solid transparent;
    }
  }
}
</style>
```
