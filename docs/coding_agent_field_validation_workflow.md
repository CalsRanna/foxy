# Coding Agent 字段映射与数据源逐项核验工作流

本文用于指导 Coding Agent 校准 Foxy 业务模块中的主表单、关联 Tab、世界库关系表和 DBC 引用。目标不是让页面“看起来合理”，而是让每个字段都能追溯到目标版本 AzerothCore 的数据库结构和服务端行为，并由自动化测试守住关键契约。

适用任务包括：

- 校准已有详情页的 label、输入类型、默认值、下拉值和标志位。
- 审计一个详情页下所有关联 Tab 是否覆盖了正确的表和字段。
- 把裸数字外键改为 `FoxyEntityPicker`。
- 为缺失的世界表或 DBC 表补充 Entity、Repository、Picker、导入/导出注册。
- 为已验证的字段集合增加契约测试。

本文不替代模块自身的业务设计，也不授权顺手重构无关代码。发现范围外问题时应记录，但不要扩大修改范围。

Foxy 只面向目标版本的 AzerothCore 核心实现，不计划兼容 AzerothCore custom modules、`data/sql/custom` 或部署方自定义字段。本文中的“模块”均指 Foxy 自身的业务模块。实际数据库中的自定义扩展只能记录为不受支持的结构漂移，不能作为修改 Foxy Entity、UI、枚举或 DBC 映射的依据。

## 1. 开始前固定输入和边界

开始编码前明确以下信息，并在最终报告中写出：

| 项目 | 内容 |
|---|---|
| Foxy 模块 | 例如 `creature_template`、`item`、`spell` |
| 详情 Page | 主表单和 Tab 容器所在文件 |
| 主表 | 例如 `creature_template` |
| 关联表范围 | 详情页中实际存在的全部 Tab，或任务明确指定的子集 |
| AzerothCore 根目录 | 例如 `D:\Simulators\AzerothCore\code` |
| AzerothCore 版本 | 分支、标签和 commit SHA |
| DBC 客户端版本 | 必须和目标服务端分支相匹配，通常为 3.3.5a |
| 数据库基线 | 目标 commit 的 AzerothCore core base + 官方 updates |

先记录目标源码版本，避免在核验过程中引用另一版本的定义：

```powershell
git -C D:\Simulators\AzerothCore\code branch --show-current
git -C D:\Simulators\AzerothCore\code rev-parse HEAD
git -C D:\Simulators\AzerothCore\code status --short
```

同时记录 Foxy 自身的基线和任务开始前已有改动：

```powershell
git rev-parse HEAD
git status --short
```

若 AzerothCore 工作树包含本地修改，需要先确认目标 commit 中的原始内容。本地修改不是 Foxy 的兼容目标，不能用作字段、枚举或加载语义的依据；应在报告中说明并排除其影响。不要静默混用 commit 内容和本地改动，也不要覆盖 Foxy 工作区中任务开始前已有的修改。

若需要连接实际数据库，只做任务所需的只读结构/样本检查。`config.yaml` 可能包含密码，不得把内容、连接串或脱敏前的查询输出写入日志、测试夹具、文档或提交。

## 2. 证据职责与冲突处理

不能用一个来源回答所有问题，也不能仅凭字段名或已有 UI 猜测。按问题类型选择权威证据：

| 要确认的问题 | 首要证据 | 补充证据 |
|---|---|---|
| 物理列、SQL 类型、NULL、默认值、主键和索引 | 目标版本 AzerothCore core 的 base 和官方 updates | 实际部署库的 `information_schema`，仅用于发现漂移 |
| 字段语义、单位、合法范围、回退行为 | 目标版本 C++ 加载、赋值、校验和使用点 | SQL 注释、官方文档 |
| 枚举和 Flags | 声明枚举/Mask 加实际校验与使用代码 | SQL 注释、Wiki |
| 世界表外键 | 服务端 Manager/Store 查询和校验代码 | 表名、索引、SQL 注释 |
| DBC 外键 | 服务端实际 `*Store.LookupEntry` 类型 | DBC Schema、`warcrafty Definitions.*` |
| DBC 二进制字段布局 | 与客户端版本匹配的 DBC Schema | `warcrafty` 实现与导入测试 |
| Foxy 当前行为 | Entity、Repository、ViewModel、View 和测试 | Git 历史；仅用于解释现状 |

这里没有全局统一的“SQL 永远高于 C++”或相反规则：SQL 决定物理类型，C++ 决定运行时语义。SQL 注释若与当前校验代码冲突，以校验代码解释合法值；C++ 变量类型若与实际列定义冲突，仍需按 SQL 和数据库驱动确认持久化类型。Wiki 只作解释补充，不能覆盖目标 commit 的源码。

任何冲突都要在字段矩阵中记录双方证据、最终选择和原因。若无法消解，不要猜测，应把该字段标为阻塞项。

## 3. 必须产出的字段核验矩阵

“逐个验证”必须有清单，不能只通读文件后宣称完成。建议在工作记录中维护以下矩阵；最终可以转为契约测试，不要求把临时矩阵提交到仓库。

| 页面/Tab | 表.列 | SQL 类型/默认值 | 约束/单位/特殊值 | Entity 字段/类型/默认值 | Controller/控件 | label | 值或外键来源 | 服务端证据 | 状态 |
|---|---|---|---|---|---|---|---|---|---|
| 主表单 | `foo.kind` | `tinyint unsigned DEFAULT 0` | 闭集 `0,1,2` | `kind: int = 0` | `SelectFieldController<int>` / `FoxyShadSelect<int>` | 类型 | `FooKind` | `<commit>: SharedDefines.h:<symbol/line>` | 已验证 |
| 关联 Tab | `foo_addon.path_id` | `int unsigned DEFAULT 0` | `0` 表示无路径 | `pathId: int = 0` | `IntFieldController` / 待判定 | 路径 | 路径表或服务端逻辑 | `<commit>: ObjectMgr.cpp:<symbol/line>` | 待修改 |

每个物理列一行，包括：

- 主键、复合主键的每一部分。
- `field1` 到 `fieldN` 这类重复槽位。
- locale 分表字段。
- 服务端声明保留、弃用或运行时生成的列。
- 当前 UI 没有控件的列。
- UI 有控件但 Entity/表中没有的派生字段；必须明确标记为“非持久化”。
- 分隔字符串、打包字节、数组槽位等特殊表示，并记录解析规则。
- 跨字段约束，例如最小值不得大于最大值、数量字段与 ID 槽位配对。

覆盖关系原则上应满足：

```text
SQL 中由 Foxy 持久化的列集合
  = Entity.toJson 写出键集合（忽略 Repository 的保留字转义）

Entity.fromJson 可识别键集合
  = 持久化查询列 + JOIN 派生别名 + 有意兼容的旧/驼峰别名

Foxy 支持编辑的列集合
  = ViewModel 初始化/收集字段集合
  = View 中持久化编辑控件集合

SQL 列集合
  = 支持编辑列 + 只读展示列 + 明确不支持列
```

UI 不需要机械暴露所有 SQL 列，但差集必须为空或逐项解释。`fromJson` 可以读取 JOIN 展示列或兼容别名，但这些键不得意外进入 `toJson`。允许的 UI 例外包括只读主键、服务端生成字段、明确不支持编辑的 blob、locale 分表字段，或仅供列表展示的 JOIN 派生字段。不要用“暂不支持”掩盖遗漏；必须说明不支持的原因和数据保存时是否会被保留。

## 4. 第一阶段：盘点模块和所有关联 Tab

### 4.1 从 Page 建立页面拓扑

先找到详情 Page 和 `FoxyTab`，列出 `tabs` 与 `contents` 的一一对应关系：

```powershell
$foxyModule = 'creature_template' # 替换为 Foxy 目标目录
rg -n "@RoutePage|FoxyTab|tabs|contents|View\(" "lib\page\$foxyModule"
```

对每个 Tab 建立以下链路：

```text
Tab 标题
  -> View
  -> ViewModel
  -> Entity / Filter Entity / Brief Entity
  -> Repository
  -> 一个或多个世界表 / foxy.dbc_* 表
```

必须检查 Tab 标题数和内容数相等，顺序一致，并检查 `disabledIndexes` 与实际可用状态。`FoxyTab` 使用 `LazyIndexedStack` 只会延迟未访问内容的构建，但这不能代替父 ID 校验。新建主记录时要区分 `null`、`0` 和真实 ID；父记录落库前应禁用依赖父键的 Tab 或在 ViewModel 中明确拒绝加载/保存，不能误写入 `parent_id = 0` 的数据。

### 4.2 盘点所有控件和 Controller

```powershell
$foxyModule = 'creature_template' # 替换为 Foxy 目标目录
rg -n "Foxy(FormItem|NumberInput|StringInput|ShadSelect|FlagPicker|EntityPicker|LocalePicker)" "lib\page\$foxyModule"
rg -n "registerController|Controller\(|_collectFromControllers|_initSignals|initSignals|dispose" "lib\page\$foxyModule"
```

逐项检查：

- View 的每个持久化控件都有 Controller。
- `_initSignals` 会把 Entity 值写入每个 Controller。
- `_collectFromControllers` 会收回每个可编辑值。
- 数值 Controller 不被错误地当作字符串，`double` 不被截断为 `int`。
- `dispose()` 最终释放全部 Controller。
- ViewModel 的保存方法调用正确的 `store*`、`update*` 或 `save*`。
- 控件的 `readOnly`/`enabled` 状态与新建、编辑和父记录状态一致。

### 4.3 确认每个 Tab 的关系模型

不要根据 Tab 名推断关系。通过 SQL 主键、唯一键和 Repository 查询条件确认：

- 一对一：父键通常也是子表主键，适合单表单和 upsert。
- 一对多：必须展示列表或支持多行 CRUD，不能用单 Entity 覆盖所有记录。
- 复合主键：读取、更新和删除必须包含所有键。
- 共享模板：父表字段可能引用另一个模板 ID，Tab 应按被引用模板查询，而不是按父主键查询。
- 多态表：例如掉落表可能由 `entry` 加类型或业务上下文区分，必须验证实际过滤条件。
- 有序子表：确认顺序列是主键一部分、自动分配值还是普通可编辑值。
- 级联行为：确认复制或删除父记录时，关联行应保留、复制、阻止还是显式删除；不要臆造数据库级联。

## 5. 第二阶段：逐表核对 SQL 结构

先定位基础建表 SQL，再搜索目标 commit 中会改变它的官方更新 SQL。常见位置为：

```powershell
$table = 'creature_template' # 替换为目标表
$ac = 'D:\Simulators\AzerothCore\code'
rg -n "CREATE TABLE.*$table|DROP TABLE.*$table" "$ac\data\sql\base"
rg -n "CREATE TABLE.*$table|ALTER TABLE.*$table|$table" "$ac\data\sql\updates"
```

`base` 描述目标 commit 的基础结构，官方 `updates` 可能继续增加、删除或修改列。应遵循 AzerothCore core 的 DB updater/assembler 顺序，不能把 `archive`、`old`、`custom` 或所有历史 SQL 无差别叠加。若任务目标是某个正在运行的数据库，还应只读查询 `information_schema.COLUMNS`、`STATISTICS` 和 `TABLE_CONSTRAINTS`，将实际结构与 core 源码基线比较。自定义列或表只记录为不受支持的漂移，不得吸收到 Foxy。未经用户明确授权，不要修改实际数据库结构或数据。

对每列记录：

- 精确列名和大小写。
- `tinyint`、`smallint`、`mediumint`、`int`、`bigint`、`float`、`double`、`decimal`、`varchar`、`text` 等类型及长度/精度。
- signed/unsigned。
- 默认值和 NULL 规则。
- 主键、唯一键、普通索引。
- 注释中的枚举、Flags 或外键提示。

### 5.1 SQL 到 Dart 的基础映射

| SQL/业务语义 | Entity | Controller | 默认 UI 控件 |
|---|---|---|---|
| 整数 | `int` | `IntFieldController` | `FoxyNumberInput<int>` |
| `float` / `double` | `double` | `DoubleFieldController` | `FoxyNumberInput<double>` |
| `varchar` / `text` | `String` | `StringFieldController` | `FoxyStringInput` |
| 0/1 且服务端确认为布尔 | `int` | `SelectFieldController<int>` | `FoxyShadSelect<int>` |
| 闭合集合枚举 | `int` | `SelectFieldController<int>` | `FoxyShadSelect<int>` |
| 位掩码 | `int` | `FlagFieldController` | `FoxyFlagPicker` |
| 世界表或 DBC 外键 | 通常为 `int` | `IntFieldController` | `FoxyEntityPicker` |
| 世界库 locale 分表文本 | `String` | `StringFieldController` | `FoxyLocalePicker` + `DatabaseLocaleEditorDelegate` |
| DBC 固定 16 语言列 | `String` | `StringFieldController` | `FoxyLocalePicker` + `DbcLocaleFieldEditorDelegate` |
| 主键 | 与 SQL 一致 | 对应 Controller | 只读；由 Repository 分配 |

注意：

- `tinyint` 不自动等于布尔；必须找到服务端使用证据。
- 整数字段不自动等于下拉框；只有合法值是有限闭集时才使用 Select。
- 注释写着 ID 不足以证明外键目标，必须找到服务端的 Store/Manager 查询。
- Dart `int` 可表示 MySQL unsigned 32 位值，但数据库驱动和位运算仍需测试高位值。
- SQL 默认值不一定是有效业务默认值；服务端可能在加载时修正它。
- `decimal` 不能不经评估直接映射为 `double`；若字段要求精确十进制，需要确认 ORM 支持和现有项目策略。
- `char`/`varchar` 可能保存以空格、逗号或其他语法分隔的结构化值，不能因 SQL 类型是字符串就默认允许任意文本。
- `FoxyEntityPicker` 当前回填单个 `int` ID；字符串键或复合键不能直接套用，需保留显式字段或实现专用选择器。

## 6. 第三阶段：从服务端确认语义、默认值和约束

对表名、列名、加载结构字段名和可能的枚举名分别搜索：

```powershell
$term = 'creature_template|unit_class|CreatureTemplate' # 替换检索词
$enumTerm = 'enum .*Creature|CREATURE_.*FLAG' # 替换枚举/Mask 检索词
$ac = 'D:\Simulators\AzerothCore\code'
rg -n $term "$ac\src\server"
rg -n $enumTerm "$ac\src"
```

重点查看：

- SQL SELECT 列顺序与 C++ 读取顺序。
- `LookupEntry`、`Get*Store`、`s*Store`：用于确定 DBC 外键类型。
- `Get*Template`、容器 `find`、Manager 查询：用于确定世界表外键。
- `if`、`switch`、范围判断、断言和错误日志：用于确认合法值。
- 加载时重置、clamp 或 fallback：用于确认 Foxy 新建默认值。
- `flags & ~allowedMask`、`flags &= allowedMask`：用于区分数据库允许位和运行时位。
- `0`、`-1`、最大值等 sentinel 的特殊含义。
- 字段单位、缩放因子和转换，例如毫秒/秒、铜币/金币、百分数/倍率。
- 分隔字符串、打包 bytes、位域和定长数组的解析逻辑。
- 跨字段校验和槽位关系，例如 `min <= max`、ID 与 Count 成对、连续数组的有效长度。
- 只在 custom module 中存在的扩展值应明确排除，不能混入 Foxy 的 core 选项集合。

默认值应同时比较三层：

```text
SQL DEFAULT
Entity 构造默认值 / fromJson 空值回退
服务端加载后的校验或回退值
```

若 SQL 默认值会被服务端立刻修正，应让新建 Entity 默认到服务端认可的值，并同步 ViewModel Controller 的默认值。不能只改 UI 显示。

### 6.1 类型判别和多态参数字段

部分表不能给一列指定唯一固定语义。例如 `gameobject_template.data*`、Conditions 的 value 字段、SmartAI 的 event/action 参数，会由 `type`、`SourceType`、`ConditionType`、`event_type` 或 `action_type` 决定含义。

遇到这类表时：

1. 先找出判别字段以及服务端针对每个类型读取参数的 switch/config。
2. 字段矩阵按“判别值 + 物理列”展开，不能只写一行笼统的 `data0`。
3. 每个类型分别确认 label、数值类型、单位、枚举、Flags、外键目标和未使用槽位。
4. 外键目标随类型变化时使用动态 delegate/config，不能绑定一个固定 Picker。
5. 切换类型时不得静默清空仍需保留的参数；若产品要求重置，必须提示并测试。
6. 隐藏的非当前类型槽位在保存时要么原值保留，要么有服务端依据地清零，不能被 Controller 默认值意外覆盖。
7. 数组/槽位的下标从 0 还是 1 开始、最大数量和空洞是否合法，都要从源码确认。

契约测试应验证全部受支持判别值都有配置，并为代表性类型检查物理列到动态控件的映射。发现服务端类型尚未被 Foxy 支持时，应列入明确差集，不能用通用数字框假装已经支持。

## 7. UI 控件选择决策树

按以下顺序为每个字段确定控件：

1. 是否主键？使用只读输入；单整数新建编号由 Repository 的 `create*` 分配。复合键或父键参与主键时按对应 Repository 的创建语义处理，ViewModel 不自行算号。
2. 是否 locale 文本？先区分世界库 `*_locale` 分表与 DBC 固定 16 语言宽表，再使用对应的 `FoxyLocalePicker` delegate。
3. 是否引用单整数主键的世界表或 DBC 记录？优先使用 `FoxyEntityPicker`。
4. 是否为位掩码？使用 `FoxyFlagPicker`，逐位列出可编辑值。
5. 是否为服务端定义的闭集枚举？使用 `FoxyShadSelect<int>`。
6. 是否为真正的 0/1 开关？使用项目统一布尔选项。
7. 语义或外键是否由另一个类型字段决定？使用经过验证的动态配置/控件，并保留非当前槽位数据。
8. 是否为分隔字符串、打包值或需要多字段联动？优先复用或实现专用编辑器和校验，不要伪装成无约束文本。
9. 否则按 SQL/Dart 类型使用数值或字符串输入。

### 7.1 label 和 placeholder 规则

- label 表达业务含义，例如“阵营模板”，不要只写模糊的“阵营编号”。
- 同名概念要区分目标类型，例如 `Faction.dbc` 与 `FactionTemplate.dbc`。
- 单位写入 label，例如“攻击间隔（毫秒）”“金币（铜币）”“速度倍率”。
- multiplier、variance、mask、flags、template、store 等概念不能随意互换。
- placeholder 保留精确数据库列名及大小写，方便开发者追溯。
- 标记废弃值时写清“已废弃”，但只要当前服务端仍接受就不要擅自删除。
- 运行时专用且数据库明确禁止的值不应提供给用户选择。
- 同一组重复槽位使用一致 label，并保留明确序号，不能把不同语义的槽位合并。
- 无法从源码确定可靠中文语义时，宁可保留准确英文术语并说明，也不要编造自然但错误的翻译。

## 8. 枚举和 Flags 的逐值验证

### 8.1 枚举

逐项记录整数值、C++ 常量名、中文 label 和服务端是否接受。必须处理：

- 非连续值和中间空洞。
- `0` 是否有效、未指定或无效。
- `-1` 等 sentinel。
- `MAX`、`END` 只用于边界、不能写入数据库的常量。
- 服务端 `switch` 中存在但 Wiki 未记录的值。
- 已声明但服务端明确拒绝的值。

不要用 `0..N` 自动生成选项，除非源码证明整个区间均有效。

还要考虑数据库里已经存在的越界或旧版本值。Select 不能把未知当前值显示为空白后静默回退到默认值；应保留并提示、阻止保存，或提供明确的修复动作。采用哪种策略取决于现有组件能力和服务端行为，但不得无提示改值。

### 8.2 Flags

逐位核对十六进制值或 `1 << bit`，不能只对比中文描述。需要区分：

- 当前数据库可编辑位。
- 已废弃但仍被服务端接受的位。
- 服务端加载后清除的非法位。
- 仅运行时设置、数据库不应持久化的位。
- 组合 mask；组合值通常不应作为单独 checkbox 重复提供。

读取已有记录时也要检查未知位的处理。切换一个已知位不应顺带清除其他仍需保留的位；若服务端明确禁止未知位，应在保存前提示并由用户确认修复，而不是借普通编辑静默归零。

契约测试应比较精确集合，而不只是断言几个常用值存在：

```dart
Set<int> valuesOf(List<FlagItem> flags) =>
    flags.map((flag) => flag.value).toSet();

Set<int> bits(int first, int last) => {
  for (var bit = first; bit <= last; bit++) 1 << bit,
};

expect(valuesOf(kFooFlags), expectedDatabaseAllowedBits);
expect(valuesOf(kFooFlags), isNot(contains(runtimeOnlyBit)));
```

## 9. 世界库外键和关联表工作流

发现字段引用 `acore_world` 中的表时：

1. 从 C++ 查询或校验代码确认目标表，不能只靠命名。
2. 检查 Foxy 是否已有对应 Entity、Repository 和 Picker delegate。
3. Picker 列表必须使用 `getBrief*` + `count*`，不得加载全表全字段。
4. 若缺失，按项目 CRUD 命名补充 Entity、Filter、Repository；Filter 字段保持项目现行的字符串输入约定，由 Repository 负责解析筛选语义。
5. Repository 使用实际世界表名，不加 `foxy.` 前缀。
6. 在 `lib/di.dart` 中将 Repository 注册为 `registerLazySingleton`。
7. 在 `FoxyEntityPickerDelegates` 增加搜索条件、列、`idOf`、fetch 和 count。
8. 将原始数字框替换为 Picker，但仍允许用户直接输入 ID，除非字段业务要求只读。

`FoxyEntityPickerDelegate.idOf` 当前返回单个 `int`。若目标使用字符串主键、复合主键，或一个 UI 选择需要回填多个列，不要强行丢失键的一部分；应实现专用选择流程，或保留多个经过验证的显式字段。

关联表还应核对保存语义：

- 一对一表使用完整父键判断 insert/update。
- 一对多表删除和更新必须限定所有复合键。
- 父记录不存在时禁止写入孤儿数据。
- 服务端没有数据库外键约束不代表 Foxy 可以忽略逻辑外键。
- world `*_locale` 分表要核对父键、`locale` 复合键、字段集合，以及 `FoxyLocalePickerDelegates` 的 load/save 映射；列表 JOIN 仍按项目全局 `localeEnabled` 规则处理。
- 当前主显示语言按项目约定为 `zhCN`。`FoxyLocalePicker` 在新记录 `entry == null` 时会禁用多语言弹窗，应先保存主记录取得真实主键，再允许编辑 locale 行。

### 9.1 数据库所有权和迁移边界

- AzerothCore 世界表结构由目标版本的 core base 和官方 updates 管理。普通 Foxy 字段校准不得擅自 `ALTER` 世界表，也不兼容 custom module 增加的列。
- 如果功能确实需要新增 Foxy 自有元数据表或列，应创建带时间戳的 `lib/database/migration/migration_*.dart`，实现 `Migration` 并在 `MigrationRunner` 注册；这属于显式 schema 变更，应在任务范围和报告中单列。
- `foxy.dbc_*` 是 DBC 镜像表，由 `dbcDefinitions` 和 DBC 导入流程创建/校验，不应再为同一表编写普通 Migration。
- 只需要读取已有世界表来提供 Picker 时，不需要迁移，也不要复制一份世界表到 `foxy` 库。

## 10. DBC 外键工作流

### 10.1 先确认“是哪一个 DBC”

字段名可能产生误导。必须找到服务端实际调用，例如：

```cpp
sFactionTemplateStore.LookupEntry(value)
sSpellStore.LookupEntry(value)
```

Store 名才是选择 `FactionTemplate.dbc`、`Spell.dbc` 等目标的关键证据。不要因为 Foxy 已有相近 Picker 就复用错误的 DBC 表。

### 10.2 检查 warcrafty 是否支持 Schema

在本地 package cache 或依赖源码中确认存在对应 `Definitions.*`。若不存在：

- 不要伪造 DBC Schema。
- 记录版本或依赖阻塞。
- 评估是否需要升级 `warcrafty`；升级依赖属于额外范围，需单独验证所有现有 DBC。

### 10.3 新增 DBC 支持的完整落点

若目标 DBC 尚未接入，通常需要同步修改：

1. `lib/constant/dbc_definitions.dart`
   - 添加唯一 `tableName`。
   - 绑定正确的 `Definitions.*`。
   - 这会让该表进入 required、导入和设置页清单。
2. Entity
   - `fromJson`/`toJson` 必须覆盖 Schema 中实际持久化的字段。
   - 按现有测试规则识别 `FieldType.isSkip` 和 `FieldType.sort`，不要把非持久化 Schema 指令误当数据库列。
   - 固定 16 语言字段遵循项目已有 locale 编码方式；对应的 `*_Flags` 是独立字段，局部语言更新不能顺带覆盖。
3. Filter Entity、Brief Entity 和 Repository
   - 表名使用全限定名 `foxy.dbc_*`。
   - Picker 使用 `getBrief*` + `count*`。
   - 全量 `get*` 只供导出。
4. `lib/di.dart`
   - 注册 Repository 懒汉单例。
5. `lib/widget/foxy_entity_picker_delegates.dart`
   - 增加 Picker delegate。
6. `lib/infrastructure/dbc/dbc_export_registry.dart`
   - 当前仓库要求每个 `dbcDefinitions` 条目都有导出 delegate，因此这是必选步骤。
7. DBC 本地化（Schema 存在本地化字段组时）
   - 在 `lib/constant/dbc_locale_fields.dart` 为每个发现的列前缀注册 `DbcLocaleFieldDefinition`。
   - Repository 混入或复用 `DbcLocaleRepositoryMixin`，公开本表命名的 get/save locale 方法。
   - 在 `FoxyLocalePickerDelegates` 注册 `DbcLocaleFieldEditorDelegate`，页面使用 `FoxyLocalePicker`。
   - `DbcLocaleFieldCodec` 只局部更新该字段组的 16 个字符串列，不应修改 `*_Flags` 或普通字段。
8. 测试
   - 更新 DBC 定义总数和 Entity 映射测试。
   - 验证导出 Registry 覆盖全部 definition。
   - 验证 Entity 覆盖全部持久化 Schema 字段并能 round-trip。
   - 验证 Schema 中的全部本地化前缀都已注册编辑器。

有些 DBC 本身没有可展示名称，需要 JOIN 它引用的另一张 DBC 才能给 Picker 提供可读列；JOIN 目标同样必须有源码或 Schema 证据。

新增 required DBC 会改变现有用户的启动检查：缺表、空表或 Schema 不兼容时可能提示重新导入。最终报告必须明确列出新增的 `.dbc` 文件名、客户端版本要求和操作影响，并确认用户选择的导入目录确实包含这些文件。

## 11. Entity、ViewModel、Repository 同步规则

### 11.1 Entity

逐字段检查：

- 构造参数、成员类型和默认值。
- 每个数据库物理列对应一个独立成员；`field1` 到 `fieldN` 等重复槽位也不得合并为 `List`、数组或 Map 字段管理。
- `fromJson` 使用精确数据库键名。
- `toJson` 没有漏列、多列或错误大小写。
- `copyWith` 未遗漏新字段。
- Brief Entity 只包含列表和 Picker 所需列。
- Filter Entity 的字符串字段与 Repository 筛选解析逻辑一致。
- 可空列不能在 `fromJson` 中被无声改成错误的业务值；若项目 Entity 有意消除 null，需记录采用的回退语义。
- 未在 UI 中编辑的持久化字段在读取后更新时不会被默认值覆盖丢失。

### 11.2 ViewModel

逐字段检查：

- Controller 类型与 Entity 类型一致。
- 每个持久化字段使用明确命名的 Controller；禁止用数组、索引分派方法或循环生成方式隐藏字段对应关系。
- 初始化、收集和 reset 路径均覆盖字段。
- Select/Flags Controller 默认值与 Entity 一致。
- 新建和编辑路径不会共享陈旧状态。
- `disposeControllers()` 被调用。
- 保存前执行源码已证明必要的单字段和跨字段校验，错误能反馈给用户。
- 页面 ViewModel 继续注册为 `registerFactory`；只有确有全局持久状态的 ViewModel 才使用 singleton。

### 11.3 Repository

遵循仓库的统一 CRUD 命名和顺序：

```text
getBrief* -> get*s -> count* -> get* -> create* -> store* ->
update* -> destroy* -> copy* -> save* -> 私有方法
```

另外检查：

- `getBrief*` 与 `count*` 使用相同筛选条件。
- 列表和 Picker 不调用全量 `get*s()`。
- 主键由 `create*`/`nextMaxPlusOne` 分配，ViewModel 不自行 `MAX+1`。
- 复合键 update/destroy 没有漏 where 条件。
- MySQL 保留字正确转义。
- DBC 表使用 `foxy.dbc_*` 全名。
- locale JOIN 是否受 `localeEnabled` 控制并使用正确 locale。
- `copy*`、父记录删除和关联表操作符合本次确认的级联语义，不因“方便”新增隐式级联。

## 12. 推荐实施顺序

按以下顺序修改可减少半成品状态：

1. 完成字段矩阵，不立即编码。
2. 修正或补充枚举、Flags 常量。
3. 修正 Entity 类型、默认值和 JSON 映射。
4. 补充缺失的世界表/DBC Entity、Filter 和 Repository。
5. 注册 DI、DBC definition、导出 Registry、locale registry 和 Picker delegate。
6. 修改 ViewModel Controller、初始化与收集逻辑。
7. 最后修改 View 的 label、placeholder 和控件类型。
8. 增加契约测试和 Registry 覆盖测试。
9. 格式化、静态分析、运行全部测试。

如果核验结果表明当前实现已经正确，不要为了制造 diff 而重写代码；在矩阵中标记“已验证、无需修改”。

## 13. 自动化测试最低要求

每个完成校准的主表或复杂关联表至少增加一组契约测试，覆盖：

- `toJson()` 字段数量与精确键集合。
- 每个键的 Dart 运行时类型。
- 世界表 Entity 的代表性 `fromJson -> toJson` round-trip，包括 JOIN 派生字段不进入写出 Map。
- 关键业务默认值，包括必须为零/空值以及必须非零/非空的情况。
- 枚举选项的精确值集合。
- Flags 的精确数据库允许位集合和明确排除的运行时位。
- 新 DBC Definition、Entity Schema 和 Export Registry 的覆盖。
- DBC 本地化前缀注册、16 语言 round-trip 和局部更新不覆盖其他列。
- Controller `init -> collect` 的类型和值往返，尤其是 double、Select fallback 和 Flags 高位。
- 特殊编码字段的合法/非法输入，以及跨字段边界条件。
- 类型判别字段的配置覆盖、动态 label/控件/Picker 映射和切换类型后的数据保留。
- 复合键 Repository 若可隔离测试，应验证所有 where 条件。

示例骨架：

```dart
test('FooEntity 覆盖 foo_table 的全部字段且类型正确', () {
  final json = const FooEntity().toJson();

  expect(json.keys.toSet(), expectedColumns);
  for (final name in stringColumns) {
    expect(json[name], isA<String>(), reason: name);
  }
  for (final name in doubleColumns) {
    expect(json[name], isA<double>(), reason: name);
  }
  for (final name in intColumns) {
    expect(json[name], isA<int>(), reason: name);
  }
});

test('Foo 枚举与目标 AzerothCore 取值集一致', () {
  expect(kFooOptions.keys.toSet(), expectedValues);
});
```

测试中的期望集合必须来自本次固定版本源码，并在测试名、注释或核验记录中保留版本依据。源码升级后测试失败是有价值的提醒，应重新核验，而不是直接把测试改到通过。若合法持有与目标版本匹配的本地 DBC 测试文件，可额外执行导入/导出 round-trip；不要把受版权保护的客户端 DBC 文件提交为测试夹具。

### 13.1 UI 与数据烟雾验证

静态分析和 Entity 测试不能证明页面控件确实接对。数据库环境可用时，应在 Windows 应用中抽样完成：

- 打开主表单以及每个关联 Tab，确认无构建、DI 或加载错误。
- 检查只读主键、新建记录和未保存父记录时的禁用状态。
- 逐类打开 Select、Flags、世界表 Picker、DBC Picker 和 locale 编辑器。
- 验证 Picker 的 fetch/count 筛选一致，选中后回填正确 ID。
- 加载至少一条已有记录，保存后比较未编辑字段，确认没有默认值覆盖或精度丢失。
- 抽查边界值、高位 Flags、未知旧值、空 locale 和包含特殊格式的字符串。
- 检查较长中文 label、选项文本和表格列没有明显截断或布局溢出。

若缺少可连接数据库或目标 DBC 文件，最终报告必须把这些运行时检查列为“未验证”，不能用 `flutter analyze` 或 mock 测试代替宣称通过。

## 14. 验证命令和完成门槛

仅格式化本次修改的 Dart 文件，避免污染用户的其他改动：

```powershell
dart format <changed-dart-files>
flutter analyze
flutter test
git diff --check
git status --short
git diff --stat
```

可以先运行新增的定向测试缩短反馈时间，但交付前仍需运行完整 `flutter test`。文档和其他新建未跟踪文件不会出现在普通 `git diff` 中，必须结合 `git status --short` 逐个审阅；不要把“diff 为空”误当作“没有新文件”。

如果修改了 `@RoutePage` 或路由配置，还必须执行：

```powershell
dart run build_runner build --delete-conflicting-outputs
```

完成门槛：

- 字段矩阵没有未解释的“待验证”。
- SQL、Entity、ViewModel、View 字段集合一致，例外有证据。
- 每个 Select 和 Flags 的值均有目标源码依据。
- 每个 Picker 都指向正确的世界表或 DBC Store。
- 所有关联 Tab 的父键、关系类型和保存条件已验证。
- 新增 DBC 已完成 definition、导入、查询、Picker、导出和测试闭环。
- 有本地化字段的 DBC 已完成字段注册、Repository、delegate 和 codec 覆盖测试。
- 特殊编码、单位和跨字段约束均已记录并在合理范围内验证。
- `flutter analyze` 无问题。
- `flutter test` 全部通过；若任务开始前已有可复现失败，必须单独记录基线和本次结果，不能把失败描述成通过。
- `git diff --check` 通过。
- 未覆盖或破坏用户原有无关修改。

## 15. 常见错误

- 只对比 View 和 Entity，没有读取 AzerothCore SQL/C++。
- 把字段名相近的 DBC 当成同一张表，例如 Faction 与 FactionTemplate。
- SQL 整数一律使用数字输入，漏掉枚举、Flags 和外键。
- 根据 Wiki 补下拉值，但没有检查当前服务端版本。
- 只读取 `data/sql/base`，遗漏目标 commit 中的官方 updates。
- 把 custom module、自定义 SQL 或实际库的扩展列吸收到 Foxy core Entity/UI。
- Flags 只补常用低位，漏掉高位、废弃位或运行时禁止位。
- 只修 label，没有同步默认值、Controller 或 JSON 映射。
- 只改主表单，遗漏详情 Page 中的关联 Tab。
- 把 SQL 字符串当成任意文本，漏掉分隔格式、打包字节或跨字段约束。
- 对类型判别参数使用固定 label/Picker，遗漏不同类型下完全不同的字段语义。
- 一对多或复合主键表按一对一保存，导致覆盖或误删。
- Picker 查询使用全量 `get*s()`，造成大表卡顿。
- 对字符串键、复合键强套只返回单个 `int` 的 `FoxyEntityPicker`。
- 新增 DBC definition，却遗漏 DI、导出 Registry 或测试计数。
- 新增带本地化列的 DBC，却遗漏 `DbcLocaleFields`、Repository mixin 或 locale delegate。
- 把新增 required DBC 对现有用户的导入影响藏在实现细节中。
- 为了通过测试直接照抄当前代码的错误集合，而不是从上游源码构建期望值。

## 16. Coding Agent 最终报告模板

```markdown
已完成 Foxy `<foxy-module>` 业务模块主表及 `<N>` 个关联 Tab 的逐字段核验。

核验基线：
- AzerothCore：`<branch/tag>` / `<commit SHA>`
- 数据库结构来源：`<core base / core base+官方 updates>`
- 实际库结构漂移：`<无 / 仅列出不受支持的自定义差异>`
- 主表：`<table>`，共 `<N>` 列
- 关联表：`<table1>(<N>列)`、`<table2>(<N>列)` ...
- DBC：`<dbc1>`、`<dbc2>` ...

结果：
- 已验证字段：`<N>/<N>`
- 修正 label：`<N>`
- 修正类型/默认值：`<N>`
- 数字框改枚举：`<N>`
- 数字框改 Flags：`<N>`
- 数字框改 Picker：`<N>`
- 无需修改但已验证：`<N>`
- 只读/明确不支持字段：`<N>`，原因 `<说明>`

关键修正：
- `<table.column>`：`<旧行为>` -> `<新行为>`，依据 `<commit>:<source:symbol/line>`

DBC 影响：
- 新增 required 文件：`<Name.dbc>`；客户端版本 `<version>`；现有用户需要 `<操作>`

验证：
- `flutter analyze`：`<结果>`
- `flutter test`：`<结果>`
- `git diff --check`：`<结果>`
- UI/数据烟雾验证：`<已验证环境与结果 / 因何未验证>`

未完成项/风险：
- `<没有则写“无”>`
```

## 17. 可直接交给 Coding Agent 的任务模板

```text
请按照 docs/coding_agent_field_validation_workflow.md，对 Foxy 的
<foxy-module> 业务模块执行逐字段校准。

范围：
- 详情 Page：<path>
- 主表：<table>
- 关联 Tab：<全部 / 指定列表>
- AzerothCore 源码：<path>
- 目标版本：<branch/tag/commit>
- 数据库基线：<AzerothCore core base/core base+官方 updates>

要求：
1. 先建立主表和每个关联 Tab 的字段核验矩阵，再编码。
2. 每个字段对照 AzerothCore core 最终 SQL 结构、Entity、ViewModel、View 和
   服务端 C++；不遗漏官方 updates，不吸收 custom modules 或自定义 SQL。
3. 逐值验证所有枚举和 Flags；确认运行时专用位不能进入数据库选项。
4. 逐个确认外键实际指向的世界表或 DBC Store，能选择实体时使用
   FoxyEntityPicker。
5. 缺少 DBC 支持时完成 definition、Entity、Repository、DI、Picker、
   export registry 和测试闭环；有本地化字段时同时完成 locale registry、
   Repository mixin、delegate 和 codec 测试，并说明现有用户的导入影响。
6. 覆盖全部关联 Tab，验证一对一/一对多/复合主键和父 ID 保存行为。
7. 增加字段、枚举、Flags、特殊编码、关键跨字段约束和 DBC 契约测试。
8. 数据库环境可用时执行主表和全部 Tab 的 UI/数据烟雾验证；不可用时明确
   列出未验证项。
9. 运行 dart format、flutter analyze、flutter test 和 git diff --check。
10. 不修改范围外代码，不覆盖工作区已有改动。
11. 最终按文档中的报告模板说明核验基线、字段数量、关键修正、测试结果
    和未完成风险。
```

## 18. 模块核验进度

| Foxy 模块 | 主表 / 关联范围 | 核验基线 | 状态 | 验证结果 | 完成日期 | 备注 |
|---|---|---|---|---|---|---|
| `creature_template` | `creature_template` 55 列；详情页全部 11 个关联 Tab，包括 Addon、击杀声望、抗性、技能、装备、任务物品、商人、训练师、生物掉落、偷窃掉落和剥皮掉落 | Foxy `64f34b230716d09a05698f2f96582c6657617497`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a DBC；实际 `acore_world` 库只读结构/数据检查 | **已完成** | `flutter analyze` 通过；模块、DBC 字段/本地化/导出契约测试通过；`git diff --check` 通过 | 2026-07-13 | 新增 required `Emotes.dbc`、`Item.dbc`、`SkillLine.dbc` 闭环。实际库保留的旧 `npc_trainer` 为当前 core 不加载的结构漂移，不纳入 Foxy 支持范围。全量 `flutter test` 仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
| `item_template` | `item_template` 138 列；详情页全部 5 个关联 Tab，包括随机附魔组、物品掉落、分解掉落、勘探掉落和研磨掉落 | Foxy `bed6afe9bfb600108ee868aad997589f3b4b88a6`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a DBC；实际 `acore_world` 库经 Laconic 只读结构/数据检查 | **已完成** | `flutter analyze` 通过；模块、DBC definition/字段/本地化/导出契约测试通过；`git diff --check` 通过 | 2026-07-13 | 新增 required `Holidays.dbc`、`ItemBagFamily.dbc`、`ItemLimitCategory.dbc`、`TotemCategory.dbc` 闭环，现有用户需重新导入 DBC；实测库尚无这 4 张镜像表。实测发现 2 个缺失的随机属性组，属于现有世界库数据问题。全量 `flutter test` 仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
| `quest_template` | `quest_template` 105 列；详情页全部 7 个关联 Tab，包括模板补充、提交物品、发放奖励、生物起止关系和游戏对象起止关系，共 42 个关联表物理列 | Foxy `d28ada0cd677d8f2b5d687d2c3a1a188cc6cb255`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a DBC；实际 `acore_world` / `foxy` 库经 Laconic + laconic_mysql 只读结构/数据检查 | **已完成** | `flutter analyze` 通过；模块、DBC definition/字段/本地化/导出契约测试通过；`git diff --check` 通过 | 2026-07-14 | `QuestType` 按 `Quest::Method` 的 `0/1/2` 校验，与 `QuestInfoID` 的 QuestInfo DBC 枚举严格分离；新增 required `MailTemplate.dbc` 全标量 Entity/Repository/Picker/本地化/导出闭环，现有用户需重新导入 DBC。实测 7 个关联表无孤立父键，实测库尚无 `dbc_mail_template`、`dbc_emotes`、`dbc_skill_line` 等所需镜像表。全量 `flutter test` 仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
| `spell` | `foxy.dbc_spell` 234 列；详情页全部 7 个关联 Tab，包括奖励系数、自定义属性、区域技能、技能组、链接技能、技能排行和技能掉落，共 37 个关联表物理列 | Foxy `325882ae2e359c7b37c2aabe0be407404387c0fe`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a DBC；实际 `acore_world` / `foxy` 库经 Laconic + laconic_mysql 只读结构、数据及 Repository 检查 | **已完成** | `flutter analyze` 通过；模块、DBC definition/字段/本地化/导出契约测试 30 项通过；Repository 冒烟通过；`git diff --check` 通过 | 2026-07-14 | 主表及重复效果/材料/语言槽位均为独立标量字段；`SpellCustomAttributes` 按当前 core 的 32 个独立位校验，不把组合别名作为可选位；区域任务状态、链接类型、能量类型及全部外键按对应加载链路校准，未新增 required DBC。实测库结构与 core 一致；`foxy.dbc_spell` 镜像相对世界表存在 8 条自定义属性、2 条区域和 29 条链接法术孤立引用，属于现有数据/镜像同步问题。全量 `flutter test` 仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
| `game_object` | `gameobject_template` 35 列；locale 5 列；详情页全部 3 个关联 Tab，包括模板补充 9 列、任务物品 4 列和游戏对象掉落 10 列 | Foxy `3bb140d1941fd492ae5e636779c1dfebeb96b012`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a DBC；实际 `acore_world` / `foxy` 库经 Laconic + laconic_mysql 只读结构、数据及 Repository 检查 | **已完成** | `flutter analyze` 通过；模块、DBC definition/字段/本地化/导出契约测试 41 项通过；Repository 非空记录冒烟通过；`git diff --check` 通过 | 2026-07-14 | `GameobjectTypes` 按 core 的 0..35 完整校验，`Data0..Data23` 按 `GameObjectData.h` 各类型联合体逐字段切换 label、枚举和精确 Picker，未使用数组管理且切换类型不清空未用槽位；修正 locale 使用说明误写 `name` 及相邻字段被清空问题。新增 required `CinematicSequences.dbc`、`DestructibleModelData.dbc`、`GameObjectArtKit.dbc`、`GameObjectDisplayInfo.dbc`、`SpellFocusObject.dbc`、`TaxiPath.dbc` 全标量 Entity/Repository/Picker/本地化/导出闭环，现有用户需重新导入 DBC，实测 `foxy` 库尚无这 6 张镜像表。实测 5 张世界表结构与 core 一致，Addon/任务物品/掉落关键外键无孤立记录；`gameobject_template_locale` 有 20 条孤立父键，属于现有数据问题。全量 `flutter test` 为 128 项通过、1 项跳过，仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
| `gossip_menu` | `gossip_menu` 2 列；详情页全部 2 个关联 Tab，包括 `npc_text` 90 列、`npc_text_locale` 18 列、`gossip_menu_option` 14 列和 `gossip_menu_option_locale` 5 列 | Foxy `362bf202ad02c7efe2eb1322038dc4eca780609f`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a DBC；实际 `acore_world` 库经 Laconic + laconic_mysql 只读结构、数据及 Repository 检查 | **已完成** | `flutter analyze` 通过；模块字段/枚举/布局/关系契约测试 7 项通过；主表、NPC 文本、locale、选项和 POI Repository 非空记录冒烟通过；`git diff --check` 通过 | 2026-07-14 | `npc_text` 及 locale 的全部重复列改为独立标量字段和显式 Controller；`emN_0..5` 按 core 校准为 3 组延迟/`Emotes.dbc` 表情，语言按 `SharedDefines.h::Language` 精确枚举。选项图标/类型、`BoxCoded`、NPC Flags、广播文本、子菜单及 `points_of_interest` 引用均按实际加载链路校准，表单为四列等宽并支持 zhCN 选项 locale；新建主记录落库前禁用关联 Tab，`OptionID` 新分配限制为 0..31。未新增 required DBC。实测结构与 core 一致；现有库有 127 条孤立 NPC locale、920 条孤立选项 locale、7 条超出 core 菜单容量的 OptionID 和 9 个非 core 语言值，均属于既有数据问题。全量 `flutter test` 为 135 项通过、1 项跳过，仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
| `smart_script` | `smart_scripts` 31 列；详情页无关联 Tab | Foxy `81751d9aec6180fae72a63b49846d6b0d79e9926`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a；实际 `acore_world` 库经 Laconic + laconic_mysql 只读结构、全量数据及 Repository 检查 | **已完成** | `flutter analyze` 通过；模块字段、枚举、Flags、联合参数、布局和保存契约测试 10 项通过；52,802 条记录全量读取及 Repository 冒烟通过；`git diff --check` 通过 | 2026-07-14 | 31 个物理列均为独立标量字段和显式 Controller，补齐 `event_param6`，修复新建 `copyWith` 丢失其余字段、`event_chance` 默认值错误及 `link` 无法新建编辑。Source/Event/Action/Target、事件阶段和 Flags 均按当前 `SmartScriptMgr.h/.cpp` 的实际 loader/运行时校准，明确排除场景版本值、哨兵、未支持动作、运行时临时位及 `LOOT_RECIPIENTS`；全部联合参数按判别类型动态显示精确语义、Picker/枚举/Flags，未使用槽位保留物理列但只读，表单统一四列等宽。未新增 required DBC。实测结构与 core 一致；52,796/52,802 条通过当前语义校验，5 条在运行时未使用参数中保留非零值、1 条 `event_chance=101`，另有 11 条断链和 4 组相同归属/ID 的多 link 记录，均为既有数据问题。全量 `flutter test` 为 145 项通过、1 项跳过，仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
| `condition` | `conditions` 15 列、10 列复合主键；详情页无关联 Tab | Foxy `3c8855b42071ace01b758245b426c6d30e71777f`；AzerothCore `master@a0b6553b5b83771e5a4a59bf3b68e76c6ce90826`；3.3.5a；实际 `acore_world` 库经 Laconic + laconic_mysql 只读结构、14,672 条全量数据及 Repository 检查 | **已完成** | `flutter analyze` 通过；模块字段、来源/条件/错误枚举、Flags、联合参数、引用模板、布局和保存契约测试 9 项通过；Repository 分页、计数和完整复合主键回读冒烟通过；`git diff --check` 通过 | 2026-07-14 | 15 个物理列均为独立标量字段和显式 Controller；SourceType、ConditionType、ConditionTarget 及 Value1/2/3 按 `ConditionMgr.h/.cpp` 的 loader 和 `Condition::Meets` 分别校准，负数引用 ID 使用可输入整数并保留合法枚举选择，不把当前样本中不存在的引用号伪造成枚举。`ErrorType` 精确使用 `SpellCastResult` 0..187，排除内部 255；`ErrorTextId` 仅在 CUSTOM_ERROR 下使用 `SpellCustomErrors` 0..99。全部行四列等宽，未新增说明文本或 required DBC；复制记录会跳过已占用 ElseGroup。实测结构与 core 一致，14,664/14,672 条通过当前语义校验；2 条任务状态含运行时不读取的旧位、2 条未使用 Value3 非零、4 条 SmartEvent 使用当前 SmartAI loader 不加载的 SourceId 3/4/6，均为既有数据问题。全量 `flutter test` 为 154 项通过、1 项跳过，仅剩任务前已可复现的 `dbc_sync_util_test.dart` 无效 MySQL 配置失败，与本模块无关。 |
