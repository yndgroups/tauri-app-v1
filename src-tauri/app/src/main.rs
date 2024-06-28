// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

pub use cmd;
pub use dm;
pub use kingbase;
pub use mariadb;
pub use mongodb;
pub use mysql;
pub use oracle;
pub use postgresql;
pub use redis;
pub use sqlite;
pub use sqlserver;
use tauri::Manager;

#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

mod core;
use core::menu;

#[tokio::main]
async fn main() -> std::result::Result<(), Box<dyn std::error::Error>> {
    // 启动系统
    let context = tauri::generate_context!();
    tauri::Builder::default()
        .menu(menu::init(&context))
        .on_menu_event(menu::handler)
        .plugin(mysql::MysqlPlugin::new()) // mysql
        .plugin(sqlite::SqlitePlugin::new()) // sqlite
        .plugin(redis::RedisPlugin::new()) // redis
        .plugin(sqlserver::SqlServerPlugin::new()) // sqlserver
        .plugin(postgresql::PostgreSqlPlugin::new()) //postgresql
        .plugin(oracle::OraclePlugin::new()) // oracle
        .plugin(dm::DmPlugin::new()) // dm
        .plugin(kingbase::KingbasePlugin::new()) // kingbase
        .plugin(mariadb::MariadbPlugin::new()) // mariadb
        .plugin(mongodb::MongodbPlugin::new()) // mongodb
        .plugin(cmd::CmdPlugin::new()) // cmd
        .setup(|app| {
            #[cfg(debug_assertions)]
            {
                let main_window = app.get_window("main").unwrap();
                main_window.open_devtools();
            }
            Ok(())
        })
        .invoke_handler(tauri::generate_handler![greet])
        .run(context)
        // 开启debug窗口
        .expect("error while running tauri application");
    Ok(())
}
