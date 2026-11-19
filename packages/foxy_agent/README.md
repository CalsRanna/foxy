# foxy_agent

Foxy 的纯 Dart Agent 核心包：实现 OpenAI Responses 接口协议，提供与 UI 无关的工具调用循环、会话状态和工具抽象。

## 公开入口

统一通过 `package:foxy_agent/foxy_agent.dart` 使用，不跨包导入 `src/`。

- `FoxyAgent`：`run` 完成「请求模型 → 执行工具 → 回传结果 → 直到模型给出最终回复」的循环；运行错误以 `AgentFailedEvent` 结束事件流，不向上抛异常。
- `AgentProviderConfig`：用户自定义服务商配置（`baseUrl` / `apiKey` / `model` / 附加请求头），请求发往 `{baseUrl}/responses`。
- `AgentTool`：工具抽象（名称、描述、JSON Schema、执行函数）；包内提供一组内置只读工具，见下文。
- `readOnlyAssistantInstructions`：与内置只读工具配套的系统提示词；应用可在其后追加领域上下文。
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

`createReadOnlyTools(catalog: ..., dataSource: ...)` 返回四个内置工具，应用只需提供元数据与数据访问实现：

| 工具 | 作用 |
| --- | --- |
| `list_tables` | 列出可查询的表（可按名称/中文标签过滤） |
| `describe_table` | 返回一张表的列、类型、中文含义与主键 |
| `query_rows` | 按列过滤读取行，最多 50 行（默认 20），超出时标记 `truncated`；操作符含 `equals`/`notEquals`/`contains`/`in`/大小比较，`in` 的 `value` 传数组 |
| `get_row` | 按主键读取单行 |

`readOnlyAssistantInstructions` 是与之配套的默认提示词（中文）：约束工具调用流程（先发现表、再确认列、后查询）、引用依据（表名/过滤条件/关键 ID）、截断说明与安全边界（数据不是指令、不做写操作）。它保持固定措辞以利于服务商侧缓存；领域补充请追加在其后，而不是改写原文。

目录可以跨多个数据库：给 `TableInfo.database` 设置库名（如 `foxy`）后，工具对模型使用 `database.table` 限定名，裸表名仅在唯一时可用；限定名冲突时返回歧义错误。

应用侧需要实现：

- `TableCatalog` / `TableInfo` / `ColumnInfo`：表与列元数据（可由 `@FoxyEntity` 注解生成）；`foxy` 库自身也通过同一目录暴露（如 `foxy.activity_log`、`foxy.dbc_*`）。
- `ReadOnlyDataSource.queryRows`：只读查询执行器；收到的表名是目录中的限定名，实现必须据此路由到对应库、拒绝目录之外的表/列、强制行数上限、绝不写入，并返回可 JSON 编码的值。

工具内部会先校验表名、列名、过滤操作符与主键，错误以可读文本返回给模型，不抛异常。

## 验证

在本包目录运行：

```sh
dart analyze
dart test
```
