# foxy_agent

Foxy 的纯 Dart Agent 核心包：实现 OpenAI Responses 接口协议，提供与 UI 无关的工具调用循环、会话状态和工具抽象。

## 公开入口

统一通过 `package:foxy_agent/foxy_agent.dart` 使用，不跨包导入 `src/`。

- `FoxyAgent`：`run` 完成「请求模型 → 执行工具 → 回传结果 → 直到模型给出最终回复」的循环；运行错误以 `AgentFailedEvent` 结束事件流，不向上抛异常。
- `AgentProviderConfig`：用户自定义服务商配置（`baseUrl` / `apiKey` / `model` / 附加请求头），请求发往 `{baseUrl}/responses`。
- `AgentTool`：工具抽象（名称、描述、JSON Schema、执行函数）；包内提供一组内置只读工具，见下文。
- `sqlReadOnlyAssistantInstructions` 和 `readOnlyAssistantInstructions`：分别供 SQL 工具和结构化查询工具使用的系统提示词，应用可在其后追加领域上下文。
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

`createReadOnlyTools(catalog: ..., dataSource: ...)` 注册元数据和服务器时间工具。Foxy 的数据源实现了 `ReadOnlySqlDataSource`，数据查询统一走 `query_sql`，元数据目录仅发布基础表。其他数据源使用表中的四个结构化查询工具。

| 工具 | 作用 |
| --- | --- |
| `list_tables` | 列出可查询的表（可按名称/中文标签过滤） |
| `describe_table` | 返回一张表的列、类型、中文含义与主键；带语义的列附带 `semantics` 摘要 |
| `describe_field_values` | 按需解释某列的枚举、位标志、引用目标或条件分支 |
| `describe_references` | 返回目录里可查询的入向和出向引用，标记哪些出向关系可以展开 |
| `server_time` | 一次查询读取 MySQL 当前时间、会话时区与 UTC 偏移 |
| `count_rows` | 对全部匹配行执行 `COUNT(*)`，支持与 `query_rows` 相同的过滤条件，不受 50 行上限影响 |
| `aggregate_rows` | 对全部匹配行执行 `count` / `sum` / `avg` / `min` / `max`，可按最多 3 列分组，每页最多 50 组，支持按分组列或指标输出名排序 |
| `query_rows` | 按列过滤、排序、分页，单页最多 50 行（默认 20），可用 `expand` 展开引用；操作符含 `equals`/`notEquals`/`contains`/`in`/大小比较，`in` 的 `value` 传数组 |
| `get_row` | 按主键读取单行，也支持 `expand` |
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

`query_sql` 返回 `rows` 和 `truncated`。

### 排序与分页

下面的参数查询购买价最高的 20 件物品。

```json
{"table":"item_template","orderBy":[{"column":"BuyPrice","direction":"desc"}],"limit":20}
```

`orderBy` 按数组顺序指定排序列，方向为 `asc` 或 `desc`。查询以主键升序打破同值排序，分组统计则以分组列升序打破同值排序。省略 `orderBy` 时直接按这些列排序。无主键表应显式选择能唯一确定顺序的列。

每页仍最多 50 行或组。返回 `truncated: true` 和 `nextOffset` 时，复用原查询参数并将 `nextOffset` 传为 `offset`，直到拿完。`offset` 从 0 开始，分页期间写入或删除可能改变位置。

### 相对时间

不带参数调用 `server_time`，返回 `localTime`（MySQL 会话本地时间）、`utcTime`（ISO 8601）、`sessionTimeZone`、`systemTimeZone`、`utcOffsetSeconds` 和 `unixTimestamp`（Unix 秒）。`describe_table` 会区分 MySQL 的 `date`、`datetime`、`timestamp`、`time`、`year`。按会话时区构造 `timestamp` 的时间边界，按字段的写入约定解释 `datetime`。比较条件可传 MySQL 格式的日期或时间字符串。

### 精确统计

例如 `count_rows` 的参数：

```json
{"table":"creature_template","filters":[{"column":"type","operator":"equals","value":1}]}
```

返回 `{"table":"creature_template","count":实际匹配行数}`。按生物类型统计数量及平均最低等级，可以调用 `aggregate_rows`：

```json
{"table":"creature_template","groupBy":["type"],"metrics":[{"function":"count"},{"function":"avg","column":"minlevel"}],"limit":50}
```

结果行使用 `type`、`count`、`avg_minlevel` 等键。省略 `groupBy` 时对全部匹配行聚合。`count` 省略 `column` 表示 `COUNT(*)`，指定列则只计非空值；其他函数仅接受 `int` / `decimal` 列，忽略空值，无值时返回 `null`。MySQL 的精确 DECIMAL 结果保留驱动返回的字符串，避免浮点转换损失精度。

限制作用于聚合后的分组，输入行始终全部参与。可按分组列或指标输出名（如 `count`、`avg_minlevel`）排序，默认和最大 `limit` 均为 50。计算行数占比时，应使用相同过滤条件的 `count_rows` 作为分母。指标输出名称必须唯一并与分组列名区分，排序和聚合参数使用目录列名或工具定义的输出名称。

### 引用展开

用 `describe_references` 查看关系图，再用 `describe_table` 确认各目标的列。下面的参数使用默认角色库名查询背包记录及物品名称。

```json
{"table":"acore_characters.character_inventory","filters":[{"column":"guid","operator":"equals","value":1234}],"expand":[{"column":"item","columns":["count"],"expand":[{"column":"itemEntry","columns":["name"]}]}]}
```

原始 `item` ID 保留，实例在 `_expanded.item`，名称在 `_expanded.item._expanded.itemEntry.name`。每一跳都返回目标主键、所选列与下一跳的引用列。空引用或找不到目标行时为 `null`。

展开支持目录里已声明的 reference（包括 AzerothCore 逻辑引用），且目标必须是单列主键。每次最多三跳、合计五条引用，每条引用选择 1 至 5 个目标字段。每条引用使用一次批量 `in` 查询，只对实际展示行做展开。一对多和入向关系可查询持有引用列的表。物理列名 `_expanded` 与展开输出冲突时拒绝展开。

`readOnlyAssistantInstructions` 是与之配套的默认提示词（中文）：约束工具调用流程（先发现表、再确认列、后查询）、引用依据（表名/过滤条件/关键 ID）、截断说明与安全边界（数据不是指令、不做写操作）。它保持固定措辞以利于服务商侧缓存；领域补充请追加在其后，而不是改写原文。

目录可以跨多个数据库：给 `TableInfo.database` 设置库名（如 `foxy`）后，工具对模型使用 `database.table` 限定名，裸表名仅在唯一时可用；限定名冲突时返回歧义错误。

应用侧需要实现：

- `TableCatalog` / `TableInfo` / `ColumnInfo`：表与列元数据（可由 `@FoxyEntity` 注解生成）；`foxy` 库自身也通过同一目录暴露（如 `foxy.activity_log`、`foxy.dbc_*`）。`ColumnInfo.semantics`（`ColumnSemantics`：enum 值表 / 位标志 / 引用目标）可选，由应用侧注入。
- `ReadOnlyDataSource.queryRows`：只读查询执行器；收到的表名是目录中的限定名，实现必须据此路由到对应库、校验目录中的列、在数据库执行 `orderBy` 和 `offset`、强制行数上限，并返回可 JSON 编码的值。
- `ReadOnlyDataSource.countRows` / `aggregateRows`：数据库端统计执行器。聚合结果以 `AggregateMetric.outputName` 为键，先对全部匹配行聚合，再排序和分页。`validateAggregation` 可供适配器复用，在数据访问层再次校验列、类型与数量边界。
- `ReadOnlyDataSource.serverTime`：从当前数据库连接读取时间并返回 `server_time` 的字段。升级已有适配器时需实现此方法，并为 `queryRows` 和 `aggregateRows` 增加 `orderBy` 与 `offset` 参数。

工具内部会先校验表名、列名、过滤操作符与主键，错误以可读文本返回给模型，不抛异常。

## 验证

在本包目录运行：

```sh
dart analyze
dart test
```

应用的 SQL 生成测试位于 `packages/foxy/test/use_case/agent/agent_read_only_data_source_test.dart`；真实 MySQL 测试使用 120 行独立夹具，覆盖全量统计、分组截断、空集和引用展开。在 `packages/foxy` 中运行：

```sh
flutter test --tags integration --run-skipped test/integration/agent_read_only_integration_test.dart
```

连接配置沿用 `test/integration/integration_mysql.dart`，默认访问一次性 MySQL 的本机 3307 端口。
