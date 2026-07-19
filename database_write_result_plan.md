# Foxy 数据库写入结果方案

## 1. 问题

Foxy 需要区分以下写入结果：

- `UPDATE` 没有找到原始行；
- `UPDATE` 找到原始行，但 candidate 与当前数据完全相同；
- `DELETE` 实际删除一行；
- `DELETE` 没有找到原始行。

旧版 Laconic 的更新和删除返回 `Future<void>`，Repository 无法可靠判断旧行是否存在。

## 2. 范围

本方案只负责：

- 升级 Laconic 写入结果 API；
- 定义 MySQL matched-row 语义；
- 提供参数化、返回结果的 raw write；
- 定义重复键错误的统一识别方式；
- 为普通表和 `LIMIT 1` 写入建立结果合同。

本方案不负责强类型 Key、主键控件、ViewModel 页面身份、Brief Entity 或业务表迁移。

## 3. 当前与目标版本

项目当前依赖：

```yaml
laconic: ^2.3.0
laconic_mysql: ^1.3.2
```

目标版本：

```yaml
laconic: ^3.0.0
laconic_mysql: ^2.0.0
```

目标版本已经提供：

```dart
Future<int> QueryBuilder.update(Map<String, Object?> data);
Future<int> QueryBuilder.delete(...);
Future<int> Laconic.affectingStatement(
  String sql, [
  List<Object?> params = const [],
]);
```

## 4. UPDATE 的 matched-row 语义

MySQL 默认返回实际变化行数。以下两种情况都会返回 `0`：

- 原始行存在，但所有字段都保持原值；
- 原始行不存在。

Foxy 需要 matched-row / found-rows 语义。MySQL 连接必须支持并启用 `CLIENT_FOUND_ROWS` 或提供等价保证。启用后，Repository 将 `update()` 返回值命名为 `matchedRows`：

- `matchedRows == 0`：原始行不存在；
- `matchedRows == 1`：原始行存在，保存成功，包括无变化保存。

Foxy 不需要额外获取 `changedRows`。不得把默认 changed-row 返回值误命名为 `matchedRows`。

不使用普通预读或 `SELECT ... FOR UPDATE` 弥补这一语义，因为它会增加查询、锁和并发窗口。

## 5. DELETE 的结果语义

MySQL 删除返回值就是实际删除行数。Repository 将其命名为 `deletedRows`：

```dart
final deletedRows = await _whereKey(
  laconic.table(_table),
  key,
).delete();

if (deletedRows == 0) {
  throw StateError('原记录不存在，可能已被其他操作修改或删除');
}
```

只有 `deletedRows == 1` 后才能写成功活动日志。

## 6. 参数化 raw write

Laconic QueryBuilder 当前不会把 builder 的 `limit` 编译进 `UPDATE` / `DELETE`。需要写入限制的 Repository 使用固定 SQL 结构和绑定参数：

```dart
final matchedRows = await laconic.affectingStatement(
  'UPDATE some_table SET value = ? WHERE key_col = ? LIMIT 1',
  [candidate.value, originalKey.value],
);
```

- 表名和列名只能来自 Repository 中的固定常量。
- 所有 Key 和 candidate 值都通过绑定参数传递。
- 禁止把用户数据插值进 SQL 字符串。
- `UPDATE ... LIMIT 1` 同样依赖 matched-row 语义。

## 7. 重复键错误

更新和插入的唯一约束错误由数据库作为最终并发保证。Foxy 应提供共享的底层错误分类器，通过稳定的 MySQL 错误码识别 duplicate-key，而不是匹配英文消息文本。

Repository 或统一写入错误转换层将错误翻译为中文：

```text
修改后的主键已存在，无法保存。
```

错误转换不得吞掉其他数据库错误，也不得把失败写入报告为成功。

## 8. 实施步骤

1. 升级 `laconic` 与 `laconic_mysql`。
2. 为 MySQL 连接补充并启用 matched-row / found-rows 配置。
3. 增加真实 MySQL 写入结果集成测试。
4. 建立 duplicate-key 错误分类器与测试。
5. 验证参数化 `affectingStatement()` 支持 `UPDATE/DELETE ... LIMIT 1`。
6. Repository 对外方法继续返回 `Future<void>`，只在内部消费整数结果。

## 9. 测试

至少覆盖：

- 更新存在行且数据变化，返回 `1`；
- 更新存在行但数据不变，仍返回 `1`；
- 更新不存在行，返回 `0`；
- 更新触发重复主键，错误码可被稳定识别；
- 删除存在行，返回 `1`；
- 删除不存在行，返回 `0`；
- 参数化 raw `UPDATE ... LIMIT 1` 最多匹配一行；
- 参数化 raw `DELETE ... LIMIT 1` 最多删除一行；
- query listener 仍收到 raw write SQL 与 bindings；
- 事务中写入结果语义与非事务连接一致。

MySQL 集成测试只能使用明确隔离且非默认的测试 schema。

## 10. 验收标准

- Foxy 使用的 MySQL 连接明确处于 matched-row / found-rows 模式。
- 无变化更新和原始行不存在能够可靠区分。
- 删除零行能够可靠报告。
- 参数化 raw write 返回行数且不插值用户值。
- 重复键错误使用稳定错误码转换。
- 上层 Repository 不依赖 `changedRows`，也不暴露数据库结果类型。
