exports.objectToSql = object => {
  let values = Object.values(object);
  let sql = "";
  for (let value of values) {
    if (value === null) {
      sql = `${sql},null`;
    } else {
      if (typeof value === "string") {
        sql = `${sql},"${value}"`;
      } else {
        sql = `${sql},${value}`;
      }
    }
  }
  return sql.substring(1, sql.length);
};

exports.payloadToInsertSql = (table, payload) => {
  let keys = Object.keys(payload);
  let keySql = "";
  for (let key of keys) {
    keySql = `${keySql},${key}`;
  }
  keySql = keySql.substring(1, keySql.length);

  let values = Object.values(payload);
  let valueSql = "";
  for (let value of values) {
    if (value === null) {
      valueSql = `${valueSql},null`;
    } else {
      if (typeof value === "string") {
        valueSql = `${valueSql},"${value}"`;
      } else {
        valueSql = `${valueSql},${value}`;
      }
    }
  }
  valueSql = valueSql.substring(1, valueSql.length);
  return `insert into ${table} (${keySql}) values (${valueSql})`;
};
