# foxy_agent

Foxy 的纯 Dart Agent 核心包：实现 OpenAI Responses 接口协议，提供与 UI 无关的工具调用循环、会话状态和工具抽象。

## 公开入口

统一通过 `package:foxy_agent/foxy_agent.dart` 使用，不跨包导入 `src/`。

- `FoxyAgent`：`run` 完成「请求模型 → 执行工具 → 回传结果 → 直到模型给出最终回复」的循环；运行错误以 `AgentFailedEvent` 结束事件流，不向上抛异常。
- `AgentProviderConfig`：用户自定义服务商配置（`baseUrl` / `apiKey` / `model` / 附加请求头），请求发往 `{baseUrl}/responses`。
- `AgentTool`：工具抽象（名称、描述、JSON Schema、执行函数）；包内提供一组内置只读工具，见下文。
- `sqlReadOnlyAssistantInstructions`：配合内置只读工具使用的系统提示词，应用可在其后追加领域上下文。
- `AgentSession`：客户端持有的对话条目；请求无状态，每次携带完整 `input`，不依赖 `previous_response_id`。
- 事件：`AgentTextDeltaEvent`、`AgentToolCallEvent`、`AgentToolResultEvent`、`AgentCompletedEvent`、`AgentFailedEvent`。
- `AgentException` / `AgentHttpException`：英文诊断信息；界面中文文案由 `foxy` 按类型映射。

本包只依赖 `http`，不依赖 Flutter、数据库或应用状态。内置只读工具通过 `ReadOnlyDataSource` 抽象访问数据，具体实现由 `foxy` 注入；其他自定义工具也可自行实现 `AgentTool`。

## 协议要点

- `POST {baseUrl}/responses`，`stream: true`、`store: false`；工具为 Responses 的 function 工具（`{"type":"function", name, description, parameters}`）。
- 工具结果以 `function_call_output` 条目回传（`call_id` + `output` 字符串）；多个并行调用在同一轮全部回传。
- 流式事件：`response.output_text.delta`（文本增量）、`response.output_item.done`（完整条目）、`response.completed`（终态）；`response.failed`、`response.incomplete`、`error` 转为失败事件。
- 模型的输出条目（message、function_call、reasoning 等）原样存入会话并随下一次请求回传，保证无状态且对任意兼容服务商可移植。
- `extraRequestBody` 可合并服务商特有参数（如 `temperature`、`include`）。

## 内置只读工具

`createReadOnlyTools(catalog: ..., dataSource: ...)` 注册元数据、服务器时间和查询工具。所有数据查询统一走 `query_sql`，元数据目录仅发布基础表。

| 工具 | 作用 |
| --- | --- |
| `list_tables` | 列出可查询的表（可按名称/中文标签过滤） |
| `describe_table` | 返回一张表的列、类型、中文含义与主键；带语义的列附带 `semantics` 摘要 |
| `describe_field_values` | 按需解释某列的枚举、位标志、引用目标或条件分支 |
| `describe_references` | 返回目录里可查询的入向和出向引用，用于确定联表方向 |
| `server_time` | 一次查询读取 MySQL 当前时间、会话时区与 UTC 偏移 |
| `query_sql` | 执行一条通过目录白名单校验的 MySQL `SELECT`，支持联表、筛选、分组、聚合和排序 |

### 条件字段

`describe_table` 用 `kind: conditional` 和 `dependsOn` 标出按行变化的字段。调用 `describe_field_values` 时省略 `context` 可查看分支摘要，筛选或联表时带上所选分支的所有 `when` 条件。读取一行后可传入实际列值，例如 `{"table":"conditions","column":"ConditionValue2","context":{"ConditionTypeOrReference":31,"ConditionValue1":3,"ConditionValue2":123}}`，工具返回对应分支和原始值。如果缺少判断所需的列，`missingContext` 会列出它们。

### SQL 联表查询

`query_sql` 接收 `{"sql":"..."}`。使用 `list_tables` 返回的准确表名和 `describe_table` 返回的字段。联表时用表名或表别名限定字段，使用 `JOIN ... ON` 声明关联，使用 `AS` 为结果命名。查询可用 `CASE`、`WHERE`、`GROUP BY`、`HAVING` 和 `ORDER BY`。

```sql
SELECT v.entry, COUNT(*) AS item_count, AVG(i.BuyPrice) AS average_price
FROM npc_vendor v
JOIN item_template i ON v.item = i.entry
GROUP BY v.entry
ORDER BY item_count DESC
LIMIT 20
```

省略 `LIMIT` 时最多返回 50 行，多读一行判断 `truncated`。显式 `LIMIT` 每页最多 200 行。需要读取超过 200 行时，使用可唯一确定顺序的 `ORDER BY` 和 `LIMIT ... OFFSET ...` 分页，取满一页后检查下一页。常用聚合函数及 `COUNT(*)` 可用，投影须显式列出字段。查询仅接受目录中的基础表。视图、SQL 注释、子查询、CTE 和多条语句会被拒绝。工具使用固定的 5 秒 MySQL 执行时间提示。Foxy 沿用当前数据库连接。

`query_sql` 返回 `rows` 和 `truncated`。查询全部结果时用能唯一确定顺序的 `ORDER BY` 配合 `LIMIT ... OFFSET ...` 分页，分页期间保持筛选和排序一致。

### 相对时间

不带参数调用 `server_time`，返回 `localTime`（MySQL 会话本地时间）、`utcTime`（ISO 8601）、`sessionTimeZone`、`systemTimeZone`、`utcOffsetSeconds` 和 `unixTimestamp`（Unix 秒）。`describe_table` 会区分 MySQL 的 `date`、`datetime`、`timestamp`、`time`、`year`。按会话时区构造 `timestamp` 的时间边界，按字段的写入约定解释 `datetime`。比较条件可传 MySQL 格式的日期或时间字符串。

### 精确统计

总数、分布、占比、求和、均值和极值都用 `query_sql` 的聚合表达式在数据库中计算，覆盖全部匹配行，不受分页上限影响：

```sql
SELECT type, COUNT(*) AS total, AVG(minlevel) AS avg_minlevel
FROM creature_template
GROUP BY type
ORDER BY total DESC
```

`COUNT(*)` 计入全部匹配行，`COUNT(column)` 只计非空值；其他聚合函数忽略空值，无值时返回 `null`。MySQL 的精确 DECIMAL 结果保留驱动返回的字符串，避免浮点转换损失精度。计算行数占比时，用相同过滤条件下的总数作分母；联表可能重复计入同一实体时，按实体主键去重。

`sqlReadOnlyAssistantInstructions` 是与这套工具配套的默认提示词（中文）：约束工具调用流程（先发现表、再确认列、后查询）、引用依据（表名/过滤条件/关键 ID）、截断说明与安全边界（数据不是指令、不做写操作）。它保持固定措辞以利于服务商侧缓存；领域补充请追加在其后，而不是改写原文。

目录可以跨多个数据库：给 `TableInfo.database` 设置库名（如 `foxy`）后，工具对模型使用 `database.table` 限定名，裸表名仅在唯一时可用；限定名冲突时返回歧义错误。

应用侧需要实现：

- `TableCatalog` / `TableInfo` / `ColumnInfo`：表与列元数据（可由 `@FoxyEntity` 注解生成）；`foxy` 库自身也通过同一目录暴露（如 `foxy.activity_log`、`foxy.dbc_*`）。`ColumnInfo.semantics`（`ColumnSemantics`：enum 值表 / 位标志 / 引用目标）可选，由应用侧注入。
- `ReadOnlyDataSource.querySql`：执行经 `ReadOnlySql.parse` 校验过的只读 SELECT，返回可 JSON 编码的值。
- `ReadOnlyDataSource.serverTime`：从当前数据库连接读取时间并返回 `server_time` 的字段。

工具内部会先校验表名、列名和查询语句，错误以可读文本返回给模型，不抛异常。

## 验证

在本包目录运行：

```sh
dart analyze
dart test
```

应用侧的目录构建测试位于 `packages/foxy/test/use_case/agent/agent_read_only_data_source_test.dart`；真实 MySQL 测试使用 120 行独立夹具，覆盖联表聚合、分页、会话时区、空集与 null 语义。在 `packages/foxy` 中运行：

```sh
flutter test --tags integration --run-skipped test/integration/agent_read_only_integration_test.dart
```

连接配置沿用 `test/integration/integration_mysql.dart`，默认访问一次性 MySQL 的本机 3307 端口。
