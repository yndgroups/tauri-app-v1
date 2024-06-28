import { defineStore } from 'pinia';
import { store } from './index';
import { Link } from '../types';

export const useLinkStore = defineStore({
  id: 'file',
  state: () => ({
    // 打开的文件列表
    linkList: new Array<Link>(),
    // 当前激活文件
    link: {} as Link,
    // 当前激活索引
    activeKey: 0,
  }),
  getters: {
    getFileList() {
      return {};
    },
  },
  actions: {
    setFileList(link: Link) {
      if (this.file && this.link.path !== link.id) {
        this.file = link;
      }
      // console.log(this.fileList, 'this.fileList');
      if (this.fileList && this.fileList.length > 0) {
        let bool = true;
        this.fileList.forEach((item) => {
          if (item.id == link.id) {
            bool = false;
          }
        });
        if (bool) {
          this.fileList.push(link);
          let len = this.fileList.length - 1;
          this.setActive(len);
        }
      } else {
        this.setActive(0);
        this.fileList.push(link);
      }
    },
    removeFileList(index: number) {
      this.linkList.splice(index, 1);
    },
    setActive(activeKey: number) {
      this.activeKey = activeKey;
    },
  },
});

// 初始化store
export function useLinkStoreWithOut() {
  return useLinkStore(store);
}
