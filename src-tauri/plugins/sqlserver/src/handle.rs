use super::common::{Response, SqlExecute};

pub struct Qeury {}

impl SqlExecute for Qeury {
    #[allow(dead_code, warnings, unused)]
    fn sql_query(sql: &str) -> Response<std::string::String> {
        Response::new(1, "测试返回", None)
    }
}
