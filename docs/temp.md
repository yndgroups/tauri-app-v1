```
const handleClick: MenuProps['onClick'] = (e) => {
  console.log('click', e);
};

function recursion(dataArr) {
  const _this = this;
  const arr = [] as any;
  if (dataArr && Array.isArray(dataArr)) {
    dataArr.forEach((item: any, index: number) => {
      if (item.children && item.children.length > 0) {
        const children = recursion(item.children);
        item.children = children;
        item.title = item.name;
        item.key = item.path;
        item.label = item.name;
        item.icon = () => h(FolderOutlined);
        arr.push(item);
      } else {
        item.title = item.name;
        item.key = item.path;
        item.label = item.name;
        item.icon = () => h(FileOutlined);
        arr.push(item);
      }
    });
  }
  return arr;
}

function processEntries(entries) {
  let fileList: Array<string> = new Array();
  for (const entry of entries) {
    console.log(`Entry: ${entry.path}`);
    fileList.push(entry.path);
    if (entry.children) {
      fileList.concat(processEntries(entry.children));
    }
  }
  return fileList;
}
```
