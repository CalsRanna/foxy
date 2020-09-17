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
