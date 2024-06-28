use super::handle::{self, change_window_layout, OpenType};
use handle::{open_window, set_theme};
use once_cell::sync::OnceCell;
use tauri::{
    utils::assets::EmbeddedAssets, AboutMetadata, Context, CustomMenuItem, Manager, Menu, MenuItem,
    Submenu, WindowMenuEvent,
};

// the payload type must implement `Serialize` and `Clone`.
#[derive(Clone, serde::Serialize)]
pub struct Payload {
    pub(crate) message: String,
    pub(crate) code: i8,
}

static ENV: OnceCell<OpenType> = OnceCell::new();

// 应用菜单项
pub fn init(context: &Context<EmbeddedAssets>) -> Menu {
    if context.config().tauri.bundle.identifier == "com.tauri.dev" {
        let _ = ENV.set(OpenType::Href);
    } else {
        let _ = ENV.set(OpenType::Local);
    }
    // 应用名称
    let name = &context.package_info().name;
    // tauri::Menu::os_default(name)
    // 应用主菜单
    let app_menu = Submenu::new(
        "",
        // MenuItem::About 为原生菜单
        Menu::new()
            .add_native_item(MenuItem::About(name.into(), AboutMetadata::new()))
            .add_item(CustomMenuItem::new(
                "create_database_window",
                "新建数据管理",
            ))
            .add_item(CustomMenuItem::new("create_codding_window", "新建代码编辑"))
            .add_item(CustomMenuItem::new(
                "create_markdown_window",
                "新建markdown",
            )),
    );
    // 文件菜单（自定义菜单）
    let file_menu = Submenu::new(
        "文件",
        Menu::new()
            .add_item(CustomMenuItem::new("new_pro".to_string(), "新建项目"))
            .add_item(CustomMenuItem::new("create_link".to_string(), "新建连接"))
            .add_item(CustomMenuItem::new("open_link".to_string(), "打开链接"))
            .add_item(CustomMenuItem::new(
                "edit_file".to_string(),
                "打开最近使用过的",
            ))
            .add_item(CustomMenuItem::new("import_link".to_string(), "导入链接"))
            .add_item(CustomMenuItem::new("import_export".to_string(), "导出链接"))
            .add_item(CustomMenuItem::new("close_window".to_string(), "关闭窗口"))
            .add_item(CustomMenuItem::new("exit".to_string(), "退出")),
    );
    // 编辑菜单（自定义菜单）
    let edit_menu = Submenu::new(
        "编辑",
        Menu::new()
            .add_item(CustomMenuItem::new("copy".to_string(), "复制"))
            .add_item(CustomMenuItem::new("paste".to_string(), "粘贴"))
            .add_item(CustomMenuItem::new("check_all".to_string(), "全选")),
    );

    // 查看（自定义菜单）
    let view_menu = Submenu::new(
        "查看",
        Menu::new()
            .add_item(CustomMenuItem::new(
                "change_window_layout".to_string(),
                "导航窗格",
            ))
            .add_item(CustomMenuItem::new("set_theme".to_string(), "设置主题")),
    );

    // 帮助（自定义菜单）
    let inline: Submenu = Submenu::new(
        "在线文件",
        Menu::new()
            .add_item(CustomMenuItem::new("docs-inline", "百度"))
            .add_item(CustomMenuItem::new("doc-gg", "谷歌")),
    );
    let help_menu: Submenu = Submenu::new(
        "帮助",
        Menu::new()
            .add_item(CustomMenuItem::new("help".to_string(), "帮助F1"))
            .add_submenu(inline)
            .add_item(CustomMenuItem::new(
                "service_center".to_string(),
                "服务中心",
            ))
            .add_item(CustomMenuItem::new("exchange".to_string(), "交流"))
            .add_native_item(MenuItem::Separator)
            .add_item(CustomMenuItem::new("check_update".to_string(), "检查更新"))
            .add_item(CustomMenuItem::new("register".to_string(), "注册"))
            .add_item(CustomMenuItem::new("buy_now".to_string(), "立即购买"))
            .add_native_item(MenuItem::Separator)
            .add_item(CustomMenuItem::new("new_fun".to_string(), "新功能"))
            .add_item(CustomMenuItem::new("about".to_string(), "关于")),
    );

    Menu::new()
        .add_submenu(app_menu)
        .add_submenu(file_menu)
        .add_submenu(edit_menu)
        .add_submenu(view_menu)
        .add_submenu(help_menu)
}

// 应用菜单处理事件
pub fn handler(event: WindowMenuEvent) {
    let app = event.window().get_window("main").unwrap();

    // 匹配菜单 id
    match event.menu_item_id() {
        "create_database_window" => match ENV.get() {
            Some(opt) => match opt {
                OpenType::Local => {
                    open_window(
                        handle::OpenType::Local,
                        app,
                        "database_window".to_string(),
                        "database.html".to_string(),
                    );
                }
                OpenType::Href => {
                    open_window(
                        handle::OpenType::Href,
                        app,
                        "database_window".to_string(),
                        "http://localhost:1421/index.html".to_string(),
                    );
                }
            },
            None => todo!(),
        },
        "create_markdown_window" => match ENV.get() {
            Some(opt) => match opt {
                OpenType::Local => {
                    open_window(
                        handle::OpenType::Local,
                        app,
                        "markdown_window".to_string(),
                        "markdown.html".to_string(),
                    );
                }
                OpenType::Href => {
                    open_window(
                        handle::OpenType::Href,
                        app,
                        "markdown_window".to_string(),
                        "http://localhost:1422/index.html".to_string(),
                    );
                }
            },
            None => todo!(),
        },
        "create_codding_window" => match ENV.get() {
            Some(opt) => match opt {
                OpenType::Local => {
                    open_window(
                        handle::OpenType::Local,
                        app,
                        "codding_window".to_string(),
                        "codding.html".to_string(),
                    );
                }
                OpenType::Href => {
                    open_window(
                        handle::OpenType::Href,
                        app,
                        "codding_window".to_string(),
                        "http://localhost:1423/index.html".to_string(),
                    );
                }
            },
            None => todo!(),
        },
        "change_window_layout" => change_window_layout(app),
        "set_theme" => set_theme(app),
        "new_pro" => {
            // debug 信息（终端输出）
            dbg!("新建文件");
            // message(win, "新建文件", "TODO")
        }
        "edit_file" => {
            // 发送信息到菜单所属窗口（弹窗形式）
            // message(win, "Eidt File", "TODO");
        }
        "undo" => {
            dbg!("undo");
        }
        "redo" => {
            dbg!("redo");
        }
        "docs-inline" => {
            let _docs_window = tauri::WindowBuilder::new(
                &app,
                "docsLine",
                tauri::WindowUrl::External("https://tauri.app/".parse().unwrap()),
            )
            .build();
        }
        _ => {}
    }
}
