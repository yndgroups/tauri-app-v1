use tauri::Window;

use super::menu::Payload;

pub enum OpenType {
    Local,
    Href,
}

// 设置主题
pub fn set_theme(app: Window) {
    let status = app.emit("setTheme", "light");
    match status {
        Ok(_) => println!("主题设置成功"),
        Err(_) => println!("主题设置失败"),
    }
}

pub fn change_window_layout(app: Window) {
    app.emit(
        "changeWindowLayout",
        Payload {
            message: "窗口改变了".into(),
            code: 1,
        },
    )
    .unwrap();
}

// 打开新串口
pub fn open_window(open_type: OpenType, app: Window, label: String, target: String) {
    match open_type {
        OpenType::Local => {
            std::thread::spawn(move || {
                let _docs_window = tauri::WindowBuilder::new(
                    &app,
                    label,
                    tauri::WindowUrl::App(target.parse().unwrap()),
                )
                .inner_size(1366.0, 768.0)
                .max_inner_size(1920.0, 1080.0)
                .min_inner_size(1366.0, 768.0)
                .build();
            });
        }
        OpenType::Href => {
            std::thread::spawn(move || {
                let _local_window = tauri::WindowBuilder::new(
                    &app,
                    label,
                    tauri::WindowUrl::External(target.parse().unwrap()),
                )
                .inner_size(1366.0, 768.0)
                .max_inner_size(1920.0, 1080.0)
                .min_inner_size(1366.0, 768.0)
                .build();
            });
        }
    }
}
