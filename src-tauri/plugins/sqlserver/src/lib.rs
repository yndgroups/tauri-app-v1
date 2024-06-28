use tauri::{
    plugin::{Plugin, Result as PluginResult},
    AppHandle, Invoke, PageLoadPayload, Runtime, Window,
};

mod handle;

use common::{self, SqlExecute};

#[tauri::command]
fn query(sql: &str) {
    handle::Qeury::sql_query(sql);
}

//插件状态，配置字段
pub struct SqlServerPlugin<R: Runtime> {
    invoke_handler: Box<dyn Fn(Invoke<R>) + Send + Sync>,
}

// invoke('plugin:awesome|initialize')
#[tauri::command]
fn initialize() {
    println!("sqlserver -  initialize")
}

// invoke('plugin:awesome|do_something')
#[tauri::command]
fn do_something() {
    println!("sqlserver -  do_something")
}

impl<R: Runtime> SqlServerPlugin<R> {
    pub fn new() -> Self {
        Self {
            invoke_handler: Box::new(tauri::generate_handler![initialize, do_something, query]),
        }
    }
}

impl<R: Runtime> Plugin<R> for SqlServerPlugin<R> {
    ///插件名称。必须定义并用于“invoke”调用
    fn name(&self) -> &'static str {
        "sqlserver"
    }

    ///初始化时要评估的JS脚本。
    ///当您的插件可以通过`window访问时很有用`
    ///或者需要在应用程序初始化时执行JS任务
    ///例如“window.awesomePlugin={…插件接口}”
    fn initialization_script(&self) -> Option<String> {
        None
    }

    ///使用`tauri.conf.json>plugins>$yourPluginName`上提供的配置或默认值初始化插件
    #[allow(warnings, unused)]
    fn initialize(&mut self, app: &AppHandle<R>, config: serde_json::Value) -> PluginResult<()> {
        // println!("window: {:?}, payload: {:?} ", app, config);
        Ok(())
    }

    ///创建窗口时调用的回调。
    #[allow(warnings, unused)]
    fn created(&mut self, window: Window<R>) {
        // println!("window: {:?}", window)
    }

    ///当Web视图执行导航时调用的回调
    #[allow(warnings, unused)]
    fn on_page_load(&mut self, window: Window<R>, payload: PageLoadPayload) {
        // println!("window: {:?}, payload: {:?} ", window, payload)
    }

    ///扩展调用处理程序。
    fn extend_api(&mut self, message: Invoke<R>) {
        (self.invoke_handler)(message)
    }
}
