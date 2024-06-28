use anyhow::Error;
use rusqlite::{Connection, Result};
use serde::{Deserialize, Serialize};
use tauri::api::path;
#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Link {
    // id
    pub id: i64,
    // 连接名称
    pub link_name: String,
    // 数据库类型
    pub db_type: String,
    // 主机地址
    pub host: String,
    // 端口
    pub port: u16,
    // 用户名
    pub user: String,
    // 密码
    pub password: String,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct History {
    // id
    pub id: i64,
    // 保存标题
    pub title: String,
    // sql文本
    pub sql_text: String,
    // 连接名称
    pub link_name: String,
    // 数据库名称
    pub db_name: String,
    // 创建时间
    pub create_time: String,
    // 更新时间
    pub update_time: String,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Param {}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub enum System {
    Link,
}

/**
 * 获取数据连接句柄
 */
fn get_conn() -> Connection {
    let mut path = path::home_dir().unwrap_or("palm.db".into());
    path.push(".palm");
    path.push("palm.db");
    let conn = Connection::open(path);
    match conn {
        core::result::Result::Ok(conn) => conn,
        Err(_) => todo!(),
    }
}

// 初始化系统基本数据
#[allow(dead_code)]
pub fn init() -> Result<(), Error> {
    // 初始化连接
    create(
        "CREATE TABLE IF NOT EXISTS palm_link (
        id INTEGER PRIMARY KEY,
        link_name TEXT NOT NULL,
        db_type TEXT NOT NULL,
        host TEXT NOT NULL,
        port INTEGER NOT NULL,
        user TEXT NOT NULL,
        password  TEXT NOT NULL
    )",
    );
    create(
        "CREATE TABLE IF NOT EXISTS palm_history (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        sql_text TEXT NOT NULL,
        link_name TEXT NOT NULL,
        db_name TEXT NOT NULL,
        create_time TEXT NOT NULL,
        update_time TEXT
    )",
    );
    Ok(())
}

// 删除表 DROP TABLE palm_history;

// 创建表
#[allow(dead_code)]
fn create(sql_text: &str) -> super::Response<String> {
    let res = get_conn().execute(sql_text, ());
    match res {
        Ok(_) => super::Response::new(1, "创建成功", None),
        Err(err) => super::Response::new(0, "创建失败", Some(err.to_string())),
    }
}

// 查询连接信息
fn query_links() -> Result<Vec<Link>, Error> {
    let binding = get_conn();
    let mut stmt =
        binding.prepare("SELECT id,link_name,db_type,host,port,user,password FROM palm_link")?;
    let links = stmt.query_map([], |row| {
        Ok(Link {
            id: row.get(0)?,
            link_name: row.get(1)?,
            db_type: row.get(2)?,
            host: row.get(3)?,
            port: row.get(4)?,
            user: row.get(5)?,
            password: row.get(6)?,
        })
    })?;
    let mut ls: Vec<Link> = Vec::new();
    for l in links {
        match l {
            Ok(l) => ls.push(l),
            Err(_) => break,
        }
    }
    Ok(ls)
}

// 查询连接列表
#[tauri::command]
pub async fn get_links() -> super::Response<Vec<Link>> {
    let data = query_links();
    match data {
        Ok(data) => super::Response::new(1, "查询成功", Some(data)),
        Err(_) => super::Response::new(0, "查询失败", None),
    }
}

// 查询保存的历史记录
#[tauri::command]
pub async fn get_history_query_list(
    _page_info: super::Request<Param>,
) -> super::Response<Vec<History>> {
    println!("{:?}", _page_info); // 打印参数信息
    let data = query_historys();
    match data {
        Ok(data) => super::Response::new(1, "查询成功", Some(data)),
        Err(_) => super::Response::new(0, "查询失败", None),
    }
}

// 查询历史记录
fn query_historys() -> Result<Vec<History>, Error> {
    let binding = get_conn();
    let mut stmt = binding.prepare(
        "SELECT id,title,sql_text,link_name,db_name,create_time,update_time FROM palm_history",
    )?;
    let links = stmt.query_map([], |row| {
        // println!("{:?}", row); // 打印调试是否取得数据
        Ok(History {
            id: row.get(0)?,
            title: row.get(1)?,
            sql_text: row.get(2)?,
            link_name: row.get(3)?,
            db_name: row.get(4)?,
            create_time: row.get(5)?,
            update_time: row.get(6)?,
        })
    })?;
    let mut ls: Vec<History> = Vec::new();
    for l in links {
        match l {
            Ok(l) => ls.push(l),
            Err(_) => break,
        }
    }
    Ok(ls)
}

// 保存信息
#[tauri::command]
pub fn save_link(data: Link) -> super::Response<String> {
    let res =  get_conn().execute(
        "INSERT INTO palm_link (link_name,db_type,host,port,user,password) VALUES (?1,?2,?3,?4,?5,?6)",
        (
            data.link_name,
            data.db_type,
            data.host,
            data.port,
            data.user,
            data.password,
        ),
    );
    match res {
        Ok(_) => super::Response::new(1, "保存成功", None),
        Err(e) => super::Response::new(0, "保存失败", Some(e.to_string())),
    }
}

#[tauri::command]
pub fn save_history(data: History) -> super::Response<String> {
    let res =  get_conn().execute(
        "INSERT INTO palm_history (title,sql_text,link_name,db_name,create_time,update_time) VALUES (?1,?2,?3,?4,?5,?6)",
        (
            data.title,
            data.sql_text,
            data.link_name,
            data.db_name,
            data.create_time,
            data.update_time,
        ),
    );
    match res {
        Ok(_) => super::Response::new(1, "保存成功", None),
        Err(e) => super::Response::new(0, "保存失败", Some(e.to_string())),
    }
}

// 删除信息
#[tauri::command]
pub fn delete(id: &str, tb_mark: u8) -> super::Response<String> {
    println!("{},{}", id, tb_mark);
    let tb = match tb_mark {
        1 => "palm_link",
        2 => "palm_history",
        _ => "",
    };
    let res = get_conn().execute(&format!("delete from {} where id= (?1)", &tb), &[&id]);
    match res {
        Ok(_) => super::Response::new(1, "删除成功", None),
        Err(e) => super::Response::new(0, "删除失败", Some(e.to_string())),
    }
}
