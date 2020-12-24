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
  new Promise((resolve, reject) => {
    pool.getConnection((error, connection) => {
      if (error) {
        reject(error);
        throw new Error(error);
      }
      connection.query(sql, (error, results) => {
        if (error) {
          reject(error);
          throw new Error(error);
        } else {
          resolve(results);
        }
        let packagedError = new Error(sql);
        packagedError.code = "MSG_SQL";
        throw packagedError;
      });
      connection.release(error => {
        reject(error);
        throw new Error(error);
      });
    });
  });
