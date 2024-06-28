```
// 装载插件代码
function actuatorPlugin(fn: string) {
  return new Function('return ' + fn)();
}
```
