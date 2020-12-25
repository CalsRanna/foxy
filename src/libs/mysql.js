let mysql = require("mysql");

let pool;

exports.createPool = config => {
  pool = mysql.createPool({
    host: config.host,
    port: config.port,
    user: config.username,
    password: config.password,
    database: config.database,
    connectionLimit: config.limit,
    supportBigNumbers: true
  });
};

exports.release = connection => {
  connection.end(error => {
    throw new Error(error);
  });
};

exports.query = sql =>
  new Promise((resolve) => {
    pool.getConnection((error, connection) => {
      if (error) {
        throw new Error(error);
      }
      connection.query(sql, (error, results) => {
        if (error) {
          throw new Error(error);
        } else {
          resolve(results);
        }
        let packagedError = new Error(sql);
        packagedError.code = "MSG_SQL";
        throw packagedError;
      });
      connection.release(error => {
        throw new Error(error);
      });
    });
  });
