use std::thread;

use tauri::{
    plugin::{Plugin, Result as PluginResult},
    AppHandle, Invoke, PageLoadPayload, Runtime, Window,
};
use ws::listen;

// invoke('plugin:cmd|start_ws')
#[tauri::command]
fn start_ws() {
    thread::spawn(|| {
        let _ = listen("127.0.0.1:8080", |out| {
            // 处理程序需要获取out的所有权，因此我们使用move
            move |data| {
                // 处理在此连接上接收的消息
                println!("服务器收到消息 '{}'. ", data);
                // 使用输出通道发送消息
                out.send("{\"data\":\"lsdasdasdasdasdas\",\"operation\":\"stdout\"}")
            }
        });
        /* if let Err(error) = listen("127.0.0.1:8080", |out| {
            // 处理程序需要获取out的所有权，因此我们使用move
            move |msg| {
                // 处理在此连接上接收的消息
                println!("服务器收到消息 '{}'. ", msg);
                // 使用输出通道发送消息
                out.send(msg)
            }
        }) {
            // 通知用户故障
            println!("创建Websocket失败,原因: {:?}", error);
        } */
    });
}

//插件状态，配置字段
pub struct CmdPlugin<R: Runtime> {
    invoke_handler: Box<dyn Fn(Invoke<R>) + Send + Sync>,
}

// invoke('plugin:cmd|initialize')
#[tauri::command]
fn initialize() {
    println!("cmd -  initialize")
}

// invoke('plugin:awesome|do_something')
#[tauri::command]
fn do_something() {
    println!("cmd -  do_something")
}

impl<R: Runtime> CmdPlugin<R> {
    pub fn new() -> Self {
        Self {
            invoke_handler: Box::new(tauri::generate_handler![initialize, do_something, start_ws]),
        }
    }
}

impl<R: Runtime> Plugin<R> for CmdPlugin<R> {
    ///插件名称。必须定义并用于“invoke”调用
    fn name(&self) -> &'static str {
        "cmd"
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
