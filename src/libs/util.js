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

exports.payloadToUpdateSql = (table, payload, primaryKey) => {
  let sql = `update ${table} set `;
  let keys = Object.keys(payload);
  let setSql = "";
  for (let key of keys) {
    let value = payload[key];
    if (value === null) {
      setSql = `${setSql}, ${key}=null`;
    } else {
      if (typeof value === "string") {
        setSql = `${setSql}, ${key}="${value}"`;
      } else {
        setSql = `${setSql},${key}=${value}`;
      }
    }
  }
  setSql = setSql.substring(1, setSql.length);
  return `update ${table} set ${setSql} where ${primaryKey}=${payload[primaryKey]}`;
};
