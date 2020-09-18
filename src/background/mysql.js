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
    console.log(error);
  });
};

exports.query = sql =>
  new Promise((resolve, reject) => {
    pool.getConnection((error, connection) => {
      if (error) {
        reject(error);
      }
      connection.query(sql, (error, results) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
      });
      connection.release(error => {
        reject(error);
      });
    });
  });
