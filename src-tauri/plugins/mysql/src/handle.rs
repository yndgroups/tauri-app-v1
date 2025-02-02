use std::collections::HashMap;

use common::Response as Resp;
use mysql::{prelude::Queryable, Pool, PooledConn, Row};
use once_cell::sync::OnceCell;
use serde::{Deserialize, Serialize};
use tracing::instrument;

static DB_POOL: OnceCell<Pool> = OnceCell::new();

#[derive(Debug, PartialEq, Eq, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct Account {
    pub id: Option<String>,
    pub account: Option<String>,
    pub password: Option<String>,
    pub enabled: Option<i32>,
    pub create_time: Option<String>,
    pub modify_time: Option<String>,
}

#[derive(Debug, PartialEq, Eq, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct LinkInfo {
    pub host: String,
    pub user: String,
    pub password: String,
    pub db_type: String,
    pub port: i32,
    pub link_name: String,
}

#[derive(Debug, PartialEq, Eq, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
struct Item {
    field: String,
    value: String,
}

// sql执行
#[instrument]
#[tauri::command]
pub fn execute_sql(sql: &str) -> Resp<Option<Vec<HashMap<String, Option<String>>>>> {
    // print!("execute_sql = {:?}", sql); // 打印sql
    match DB_POOL.get() {
        Some(pool) => match pool.get_conn() {
            Ok(conn) => match execute_query(conn, sql) {
                Ok(resp) => Resp::new(1, "查询成功", Some(resp)),
                Err(err) => Resp::new(0, &format!("查询失败:{}", err.to_string()), None),
            },
            Err(err) => Resp::new(
                0,
                &format!("查询失败: 连接获取失败,{}", err.to_string()),
                None,
            ),
        },
        None => Resp::new(0, "查询失败: 连接池获取失败", None),
    }
}

/*
let result: Vec<Row> = conn.query("SELECT * FROM students WHERE age >= ?").unwrap();
for row in result {
    let age: i32 = from_value(row.get("age").unwrap());
    let name: String = from_value(row.get("name").unwrap());
    println!("{} is {} years old", name, age);
}
*/
fn execute_query(
    mut conn: PooledConn,
    sql: &str,
) -> Result<Option<Vec<HashMap<String, Option<String>>>>, mysql::Error> {
    let rows: Result<Vec<Row>, mysql::Error> = conn.query(sql);
    match rows {
        Ok(data) => {
            let mut list: Vec<HashMap<String, Option<String>>> = Vec::new();
            let fields = "app_id,name,introduce,md_id,sort_by,status,del_status,create_by,update_by,create_time,update_time";
            for row in data {
                list.push(get_row(row, &fields));
            }
            Ok(Some(list))
        }
        Err(err) => Err(err),
    }
}

// 获取当前行的数据
fn get_row(row: Row, fields: &str) -> HashMap<String, Option<String>> {
    let mut maps: HashMap<String, Option<String>> = HashMap::new();
    for (i, v) in fields.split(",").enumerate() {
        let val: Option<String> = row.get(v).unwrap_or(Some("".to_string()));
        // let k = common::underline_to_small_hump(f);
        maps.insert(v.to_string(), val);
        maps.insert("fileds_sort".to_string(), Some(i.to_string()));
    }
    maps
}

// 初始化数据库链接池
#[instrument]
#[tauri::command]
pub fn link_db(params: LinkInfo) -> Resp<String> {
    // println!("params: {:?}", params);
    if !DB_POOL.get().is_none() {
        return Resp::new(1, "连接成功", None);
    }
    let db_url = format!(
        "mysql://{}:{}@{}:{}/information_schema",
        params.user, params.password, params.host, params.port
    );
    let con: Result<Pool, mysql::Error> = mysql::Pool::new(db_url.as_str());
    match con {
        Ok(con) => {
            let _ = DB_POOL.set(con);
            if DB_POOL.get().is_none() {
                Resp::new(0, "连接创建失败", None)
            } else {
                Resp::new(1, "连接创建成功", None)
            }
        }
        Err(err) => Resp::new(0, "连接创建失败", Some(err.to_string())),
    }
}

/// 查询数据库信息
#[instrument]
#[tauri::command]
pub fn query_schema() -> Resp<Vec<String>> {
    match DB_POOL.get() {
        Some(pool) => match pool.get_conn() {
            Ok(mut conn) => {
                let list: Vec<String> = match conn.query("SHOW DATABASES") {
                    Ok(res) => res,
                    Err(_) => vec![],
                };
                Resp::new(1, "查询成功", Some(list))
            }
            Err(_) => Resp::new(0, "查询失败", None),
        },
        None => Resp::new(0, "查询失败", None),
    }
}

// 插入数据
#[allow(warnings, unused)]
#[tauri::command]
pub fn insert(account: &str, password: &str) -> Resp<String> {
    // 生成主键id 目前id写死，后续会修改
    match get_connect() {
        Some(conn) => Resp::new(1, "插入成功", None),
        None => Resp::new(1, "插入失败", None),
    }
}

// 根据id获取数据
#[allow(warnings, unused)]
#[tauri::command]
pub fn get_by_id(id: &str) -> Resp<String> {
    match get_connect() {
        Some(conn) => Resp::new(1, "插入成功", None),
        None => Resp::new(0, "插入失败:获取连接失败", None),
    }
}

// 数据更新
#[allow(warnings, unused)]
#[tauri::command]
pub fn update(account: Account) -> Resp<String> {
    let mut conn = get_connect();
    match get_connect() {
        Some(conn) => Resp::new(1, "修改成功", None),
        None => Resp::new(0, "插入失败", None),
    }
}

// 更具id删除
#[allow(warnings, unused)]
#[tauri::command]
pub fn delete_by_id(id: &str) -> Resp<String> {
    let mut conn = get_connect();
    match get_connect() {
        Some(conn) => Resp::new(1, "删除成功", None),
        None => Resp::new(0, "删除失败", None),
    }
}

// 从链接链接池里面获取链接
#[instrument]
#[tauri::command]
pub fn get_connect() -> Option<PooledConn> {
    match DB_POOL.get() {
        Some(conn) => match conn.get_conn() {
            Ok(cn) => Some(cn),
            Err(_) => None,
        },
        None => None,
    }
}

/// 测试连接数据库  mysql://root:password@localhost:3306/MYDB
#[instrument]
#[tauri::command]
pub fn test_link(params: LinkInfo) -> Resp<String> {
    let db_url = format!(
        "mysql://{}:{}@{}:{}/information_schema",
        params.user, params.password, params.host, params.port
    );
    let link = mysql::Conn::new(db_url.as_str());
    match link {
        Ok(_) => Resp::new(1, "测试连接成功", None),
        Err(err) => Resp::new(
            0,
            &format!("测试连接失败:{:?}", err.to_string()),
            Some(err.to_string()),
        ),
    }
}
