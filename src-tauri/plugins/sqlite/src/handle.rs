use super::common::{Response, SqlExecute};

pub struct Qeury {}

impl SqlExecute for Qeury {
    fn sql_query(sql: &str) -> Response<std::string::String> {
        Response::new(1, "hello".to_string(), sql.to_string())
    }
}
