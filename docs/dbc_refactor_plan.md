# DBC 导入导出重构方案

> 状态：阶段 1—4 重构代码已完成；自动化与真实 MySQL staging 验收按当前安排延后  
> 最后更新：2026-07-10  
> 适用范围：Foxy 中 DBC 导入、导出、完整性检查和进度展示

## 1. 目标

在不引入新架构层、不重复实现 `warcrafty` 的前提下，重构 Foxy 现有 DBC 导入导出功能，使其：

- 符合 Foxy 现有 `Page → ViewModel → Repository + Util` 的调用方向。
- 由 `warcrafty` 继续负责 DBC Schema、读取和写入。
- 由 Repository 继续负责正常的单表数据访问。
- 由 Util 负责 DBC 文件、isolate、批处理和导入导出调度。
- 导入失败时不破坏正式表。
- 导出失败时不破坏已有 DBC 文件。
- 任务成功、失败、worker 崩溃和取消都能产生唯一终态。
- 导入导出进度具有统一且可测试的数据模型。

## 2. 明确不做的事情

本次重构不做以下改动：

- 不在 `lib/` 下新增独立 `dbc/` 顶级目录。
- 不新增 Service、Domain、Application、Port 或 Adapter 层。
- 不在 Foxy 内重新实现 DBC Header、Reader、Writer 或 string block。
- 不在首轮重构中改变「非空 DBC 表自动跳过」的启动导入语义。
- 不在首轮重构中强制引入分批导出 Repository API。
- 不把配置读写、SQL 错误或文件细节放进 Page。

## 3. 架构边界

### 3.1 总体调用方向

```text
Page
  ↓
ViewModel
  ├─ Repository：数据库业务数据
  └─ Util：warcrafty、文件、isolate、批处理调度
```

### 3.2 导入调用链

```text
ScaffoldPage
  ↓
ScaffoldViewModel
  ├─ ConfigUtil
  └─ DbcSyncUtil
       ↓
     DbcImportWorker
       ├─ warcrafty.DbcLoader
       └─ 独立 Laconic/MySQL 连接
```

DBC 导入不强制经过 30 个单表 Repository，原因是：

- 目标表可能尚不存在。
- 导入过程需要动态创建 staging 表。
- worker isolate 必须自行建立数据库连接。
- 输入是 `warcrafty` 的原始 record，不是业务 Entity。
- 这是数据库初始化/同步过程，不是正常 Entity CRUD。

这是一个明确的基础设施例外。导入完成后，所有正常 CRUD 仍由一表一 Repository 负责。

### 3.3 导出调用链

```text
BasicSettingPage
  ↓
SettingViewModel
  ├─ DbcExportRegistry
  │    ↓
  │  各 DBC Repository.get{Entities}()
  │
  └─ DbcSyncUtil
       ↓
     DbcExportUtil
       └─ warcrafty.DbcWriter
```

ViewModel 组合 Repository 数据源和 Util，但整批导出的任务锁和循环由
`DbcSyncUtil` 持有：

```dart
final stream = _dbcSync.export(
  definitions: selectedDefinitions,
  outputDirectory: outputDirectory,
  loadRows: _dbcExportRegistry.loadRows,
);

await for (final progress in stream) {
  // ViewModel 将结构化进度转换成 signals。
}
```

`DbcExportUtil` 不再自己通过 GetIt 获取 Repository。

## 4. 目标文件结构

```text
lib/
├── constant/
│   └── dbc_definitions.dart
├── page/
│   ├── scaffold/
│   │   ├── scaffold_page.dart
│   │   └── scaffold_view_model.dart
│   └── setting/
│       ├── basic_setting.dart
│       └── setting_view_model.dart
├── repository/
│   ├── creature_model_data_repository.dart
│   └── ...现有 DBC Repository
└── util/
    ├── config_util.dart
    ├── dbc_sync_progress.dart
    ├── dbc_sync_util.dart
    ├── dbc_import_worker.dart
    ├── dbc_export_util.dart
    └── dbc_export_registry.dart
```

## 5. 统一 DBC 定义

新增 `lib/constant/dbc_definitions.dart`：

```dart
class DbcDefinition {
  final String tableName;
  final DbcSchema schema;

  const DbcDefinition({
    required this.tableName,
    required this.schema,
  });

  String get qualifiedTableName => 'foxy.$tableName';
  String get fileName => '${schema.name}.dbc';
}

final dbcDefinitions = <DbcDefinition>[
  DbcDefinition(
    tableName: 'dbc_achievement',
    schema: Definitions.achievement,
  ),
  DbcDefinition(
    tableName: 'dbc_spell',
    schema: Definitions.spell,
  ),
  // ...
];

final dbcDefinitionByTable = <String, DbcDefinition>{
  for (final definition in dbcDefinitions)
    definition.tableName: definition,
};

final dbcDefinitionByFileName = <String, DbcDefinition>{
  for (final definition in dbcDefinitions)
    definition.fileName.toLowerCase(): definition,
};
```

由该文件统一派生：

- 必需 DBC 表名。
- DBC 文件名。
- 表名到 `DbcSchema` 的映射。
- 导入扫描的文件匹配。
- 导出界面的可选项。

删除当前重复定义：

- `requiredDbcTableNames`
- `kTableSchemaMap`
- `kTableDbcNameMap`
- `_buildSchemaRegistry()`
- `_buildTableSchemaMap()`
- `_buildTableDbcNameMap()`

## 6. 进度与结果模型

新增 `lib/util/dbc_sync_progress.dart`：

```dart
enum DbcSyncOperation {
  import,
  export,
}

enum DbcSyncStage {
  preparing,
  scanning,
  reading,
  writing,
  validating,
  committing,
}

sealed class DbcSyncProgress {}

class DbcSyncStatus extends DbcSyncProgress {
  final DbcSyncOperation operation;
  final DbcSyncStage stage;
  final String message;
  final String? fileName;
}

class DbcSyncCount extends DbcSyncProgress {
  final DbcSyncOperation operation;
  final String fileName;
  final int completedFiles;
  final int totalFiles;
  final int processedRows;
  final int? totalRows;
}

class DbcSyncError {
  final String? tableName;
  final String? fileName;
  final DbcSyncStage stage;
  final String message;
}

class DbcSyncResult extends DbcSyncProgress {
  final DbcSyncOperation operation;
  final int completed;
  final int skipped;
  final List<DbcSyncError> errors;
  final bool cancelled;

  bool get success => !cancelled && errors.isEmpty;
}
```

约束：

- 一个任务只产生一个 `DbcSyncResult`。
- Result 发出后立即关闭 Stream 和所有 Port。
- `completedFiles` 不再通过 `completed + skipped + errors.length` 间接计算。
- `completed`、`skipped` 和 `errors` 互不重叠。
- worker 错误跨 isolate 保留 table、file、stage 和 message，不退化成裸字符串。
- ViewModel 负责把结构化进度转换为界面文字。
- Util 不调用 Dialog，不直接修改 signal。

## 7. `DbcSyncUtil`

`DbcSyncUtil` 作为 DBC 同步的公共 Util，负责公共 API 和任务生命周期。

```dart
class DbcSyncUtil {
  Isolate? _activeIsolate;
  ReceivePort? _receivePort;
  bool _running = false;

  Future<List<DbcTableCheckResult>> checkTables();

  Stream<DbcSyncProgress> import({
    required String directory,
    required MysqlConfig mysqlConfig,
  });

  Stream<DbcSyncProgress> export({
    required List<DbcDefinition> definitions,
    required String outputDirectory,
    required DbcExportRowLoader loadRows,
  });

  Future<void> cancel();
}
```

它只负责：

- 同一时间只允许一个 DBC 任务，导出锁覆盖整批 Repository 读取和文件写入。
- 创建、监听和销毁 isolate。
- 监听 worker 的 `onError` 和 `onExit`。
- 确保终态唯一。
- 关闭 ReceivePort、error port、exit port 和 Stream。
- 调用具体的导入 worker 和导出 Util。

它不再负责：

- 读写 `config.yaml`。
- 定义 DBC 清单。
- Repository 路由。
- 拼接导出 records。
- 具体导入 SQL。

### 7.1 isolate 生命周期

当前收到结果后的 `break` 只会退出 `switch`，不会退出 `await for`。重构后在收到终态时立即返回：

```dart
case WorkerCompleted(:final result):
  controller.add(result);
  receivePort.close();
  await controller.close();
  _clearActiveTask();
  return;
```

`Isolate.spawn` 同时传入：

```dart
onError: errorPort.sendPort,
onExit: exitPort.sendPort,
errorsAreFatal: true,
```

如果 worker 在发送 Result 前退出，`DbcSyncUtil` 生成一次失败 Result，而不是让 UI 永久等待。

### 7.2 取消

`cancel()` 必须：

1. 标记当前任务正在取消。
2. 通知 worker 停止下一批处理，或必要时终止 isolate。
3. 清理 staging 表或导出临时文件。
4. 发出一次 cancelled 结果。
5. 关闭所有 Port 和 Stream。

## 8. DBC 表状态检查

不再把「查询失败」当成「表缺失」。

```dart
enum DbcTableState {
  missing,
  empty,
  ready,
  incompatible,
  error,
}

class DbcTableCheckResult {
  final DbcDefinition definition;
  final DbcTableState state;
  final String? message;
}
```

检查流程：

1. 从 `information_schema.TABLES` 一次性获取存在的 DBC 表。
2. 缺失表标记为 `missing`。
3. 已存在表使用批量 `EXISTS` 判断是否为空。
4. 必要时从 `information_schema.COLUMNS` 校验字段集合。
5. SQL 失败标记为 `error`，不自动启动导入。

`ScaffoldViewModel` 只在存在 `missing` 或 `empty` 时提示导入；`error` 和 `incompatible` 显示明确错误。

## 9. 导入 worker

新增 `lib/util/dbc_import_worker.dart`。

### 9.1 Worker 参数

只跨 isolate 传递可安全复制的简单数据：

```dart
typedef DbcImportWorkerArgs = ({
  SendPort sendPort,
  String directory,
  String host,
  int port,
  String database,
  String username,
  String password,
});
```

不跨 isolate 传递 Repository、GetIt、Database singleton 或闭包。Worker 根据表名或文件名从静态 `dbcDefinitions` 重新找到 Schema。

### 9.2 扫描阶段

- 保存扫描得到的真实文件路径。
- `.dbc` 扩展名大小写不敏感。
- 文件名匹配大小写不敏感。
- 同一定义匹配到多个文件时直接报错。
- 所有文件扫描和基础校验完成后才连接数据库。
- 不再通过 `${schema.name}.dbc` 重建文件路径。

### 9.3 staging 导入

保留首轮重构的 bootstrap 语义：

```text
目标表非空
  → 跳过

目标表不存在或为空
  → 创建 staging 表
  → DbcLoader 加载文件
  → 分批写入 staging
  → 校验 staging 行数
  → 替换正式表
```

创建 staging：

- 目标表存在：`CREATE TABLE staging LIKE target`。
- 目标表不存在：根据 `schema.fields` 创建。
- staging 表名包含任务 ID，避免残留表冲突。

对于已存在的空目标表，提交使用同一条 `RENAME TABLE` 交换：

```sql
RENAME TABLE
  foxy.dbc_spell TO foxy.dbc_spell__backup_xxx,
  foxy.dbc_spell__staging_xxx TO foxy.dbc_spell;
```

提交成功后删除 backup。失败时保留原表并删除 staging。如果目标表原本不存在，则只将 staging rename 为正式表。

### 9.4 批量 INSERT

保留当前多行 INSERT 策略，但调整为：

- 使用 UTF-8 实际字节长度，不使用 `StringBuffer.length` 估算数据包大小。
- 每批控制在约 1 MiB。
- 表名和列名只允许来自 `DbcDefinition` 和 `DbcSchema`。
- 普通字符串直接使用安全单引号字面量；包含引号、反斜杠或控制字符时改用
  UTF-8 十六进制字面量，不依赖 MySQL `NO_BACKSLASH_ESCAPES` 模式。
- 每批发送真实的行级进度。
- 取消时停止下一批写入并清理 staging。

Foxy 仍然使用 `warcrafty.DbcLoader`，不处理 Header、ByteData 或 string block。

## 10. 导出 Repository Registry

保留 `lib/util/dbc_export_registry.dart`，但去掉两个大型 switch 和动态 `toJson()`。

```dart
class DbcExportDelegate {
  final Future<List<Map<String, dynamic>>> Function() loadRows;
  final Future<int> Function() countRows;

  static DbcExportDelegate typed<T>({
    required Future<List<T>> Function() load,
    required Future<int> Function() count,
    required Map<String, dynamic> Function(T entity) toJson,
  });
}
```

Registry 在构造时注册：

```dart
_delegates['dbc_spell'] = DbcExportDelegate.typed<SpellEntity>(
  load: spellRepository.getSpells,
  count: spellRepository.countSpells,
  toJson: (spell) => spell.toJson(),
);
```

公共方法：

```dart
Future<List<Map<String, dynamic>>> loadRows(String tableName);
Future<DbcExportCountResult> countRows(String tableName);
```

要求：

- 计数失败按表返回错误，不再因一张表失败把全部表显示为 0。
- 未注册的表返回明确错误，不默认返回 0。
- 注册时使用强类型 Entity 转换，不使用 `(e as dynamic).toJson()`。
- 导出读取仍然经过 Repository.`get{Entities}`。

### 10.1 补齐 `creature_model_data`

原先 `dbc_creature_model_data` 是唯一绕过 Repository 直接裸读数据库的特例。本轮已新增：

- `CreatureModelDataEntity`
- `CreatureModelDataRepository`
- 标准完整 CRUD
- DI 注册
- `getCreatureModelDatas()` 导出全量数据

完成后，所有 DBC 导出表都遵守一表一 Repository 约定。

## 11. 导出 Util

新增 `lib/util/dbc_export_util.dart`：

```dart
class DbcExportUtil {
  Future<void> write({
    required DbcDefinition definition,
    required List<Map<String, dynamic>> rows,
    required String outputDirectory,
    void Function(DbcExportPhase phase)? onPhase,
  });
}
```

职责仅限：

1. 校验输出目录。
2. 将 Repository JSON 转换成 `warcrafty` record。
3. 调用 `DbcWriter`。
4. 使用 `DbcLoader` 回读校验。
5. 安全替换目标文件。

### 11.1 严格字段转换

以 `schema.format[index]` 决定 DBC 物理类型，不仅依赖 schema field 的语义类型。

- 必需字段缺失：报错。
- `uint8` 越界：报错，不静默 `clamp`。
- int/float 类型不合法：报错。
- unused 字段填 0。
- 布尔字段兼容 `bool` 和明确的 0/1。
- 不对任意 null 静默补默认值。
- 错误包含 table、record index 和 field name。

### 11.2 临时文件和回读

```text
写入 FileName.dbc.foxy.tmp
→ DbcLoader(temp, schema.format)
→ 校验 recordCount 和 fieldCount
→ 原文件改名为 .bak
→ temp 改名为正式文件
→ 删除 .bak
```

如果替换失败，恢复 `.bak`。

该方案在 Windows 上是「可恢复替换」，不是严格意义上的单操作原子替换。如果后续确实需要真正原子替换，应通过 Windows `ReplaceFileW` 或等价 API 实现，不在本轮强制引入。

### 11.3 确定性输出

`DbcExportRegistry` 在 Repository Entity 转成 JSON 后，统一按 `ID`
稳定排序：

```dart
rows.sort((left, right) {
  final leftId = left['ID'] as num;
  final rightId = right['ID'] as num;
  return leftId.compareTo(rightId);
});
```

这样无需为了文件层的确定性修改 30 个 Repository 的 CRUD
实现，同时使相同数据库快照生成相同的记录顺序和字符串池顺序。

## 12. ViewModel 改造

### 12.1 `ScaffoldViewModel`

保留：

- DBC 完整性检查。
- 导入路径。
- 自动导入。
- 导入 signals。
- 重试。
- 取消。

移除：

- `DbcExportItem`
- 所有 `dbcExport*` signals
- `_exportSub`
- `loadExportItems()`
- `exportDbc()`
- `retryExport()`
- `_runExport()`

`ScaffoldViewModel` 通过 GetIt 获取共享 `DbcSyncUtil`，不再自行 `DbcSyncUtil()`，以便跨页共享任务互斥状态。

### 12.2 `SettingViewModel`

增加：

- `DbcExportItem`
- `dbcExportItems`
- `dbcExporting`
- `dbcExportProgress`
- `dbcExportError`
- `loadDbcExportItems()`
- `exportDbc()`
- `retryExport()`

导出流程：

```dart
final stream = _dbcSync.export(
  definitions: selectedItems.map((item) => item.definition).toList(),
  outputDirectory: directory,
  loadRows: _dbcExportRegistry.loadRows,
);

await for (final progress in stream) {
  // 更新进度和最终结果 signals。
}
```

不能在 ViewModel 中逐表调用只覆盖单文件的锁，否则 Repository 读取阶段以及
两个文件之间可能被导入任务插入，同一次导出就可能来自不同数据库状态。

重试必须调用统一的 `_startExport()`，完整恢复 exporting、progress、error 和 success 状态，不直接跳到底层执行方法。

### 12.3 `BasicSettingPage`

删除：

```dart
final scaffoldViewModel = GetIt.instance.get<ScaffoldViewModel>();
```

导出对话框改为：

```dart
_DbcExportDialog(vm: viewModel)
```

`_DbcExportDialog` 接收 `SettingViewModel`，设置页不再跨页借用 `ScaffoldViewModel`。

## 13. 配置读写

当前 DBC Util 和 `SettingViewModel` 都在直接读写 YAML。新增通用 `ConfigUtil`：

```dart
class ConfigUtil {
  Future<Map<String, dynamic>> load();
  Future<void> update(Map<String, dynamic> values);
}
```

用法：

```dart
await configUtil.update({'dbc_path': path});
await configUtil.update({'locale_enabled': value});
```

`DbcSyncUtil` 不再知道 `config.yaml`。导入路径和 MySQL 配置由 `ScaffoldViewModel` 读取后传入。

## 14. DI 调整

新增懒汉单例：

```dart
registerLazySingleton(() => ConfigUtil());
registerLazySingleton(() => DbcSyncUtil());
registerLazySingleton(() => DbcExportRegistry());
registerLazySingleton(() => CreatureModelDataRepository());
```

保持现有生命周期约定：

- `ScaffoldViewModel` 继续为 Singleton。
- `SettingViewModel` 继续为 Factory。
- 所有单表 Repository 继续为 LazySingleton。

导出成功 signal 的订阅由 `_DbcExportDialog` 自身持有，并已在对话框
`dispose()` 中取消；`SettingViewModel` 本身不持有 StreamSubscription。

## 15. `warcrafty` 边界

Foxy 中保留：

- `Definitions.*` 作为 DBC Schema 来源。
- `DbcLoader` 读取 DBC。
- `DbcWriter` 写入 DBC。
- `schema.fields` 作为数据库列与 DBC 字段的映射依据。

Foxy 中不实现：

- WDBC Header 解析。
- record 字节偏移。
- string block 管理。
- DBC 物理文件写入器。

如果后续确认 `dbc_spell` 全量导出内存不可接受，应在 `warcrafty` 中增加流式 Writer，例如：

```dart
Future<void> writeStream(
  Stream<List<dynamic>> records, {
  int? recordCount,
});
```

之后再为 Foxy Repository 增加明确的 DBC 批处理 API，并同步修改 `docs/repository_crud_template.md`。该工作不和本轮重构混在同一阶段。

## 16. 分阶段实施

### 阶段 1：整理定义和依赖，不改变行为

- 新增 `dbc_definitions.dart`。
- 提取 `dbc_sync_progress.dart`。
- 提取 `dbc_export_util.dart`。
- 改造 `DbcExportRegistry` 为强类型 delegate 注册。
- 新增 CreatureModelData Entity/Repository。
- 保持现有 UI 和导入导出语义不变。

验收：

- `flutter analyze` 通过。
- `flutter test` 通过。
- 所有 DBC 定义都有导出 delegate。
- 导出不再存在裸表读取特例。

### 阶段 2：ViewModel 归位

- 导出状态和方法迁移到 `SettingViewModel`。
- `BasicSettingPage` 不再依赖 `ScaffoldViewModel`。
- 修复 retry 和 subscription 生命周期。
- 新增 `ConfigUtil`。
- `ScaffoldViewModel` 只保留导入状态。

验收：

- 设置页只访问 `SettingViewModel`。
- `ScaffoldViewModel` 不再包含任何导出字段。
- 设置页销毁后不保留进度订阅。

### 阶段 3：任务生命周期

- 提取 `dbc_import_worker.dart`。
- 监听 isolate `onError` 和 `onExit`。
- Result 后立即关闭所有 Port 和 Stream。
- 增加取消和防重入。
- 导入进度对话框提供实际可用的取消入口和 cancelling 状态。
- 导出任务锁覆盖整批读取与写入，而不是只覆盖单个文件。
- 修复进度重复计数。
- 修复查询失败被当成表缺失的问题。

验收：

- 成功、失败、worker 崩溃和取消都只产生一个终态。
- 终态后不存在存活的 ReceivePort。
- 任务进度不超过 100%。

### 阶段 4：数据安全

- 导入改为 staging table。
- 导出改为临时文件、回读和 backup 恢复。
- 扫描时保存真实文件路径。
- 加入严格字段校验。
- `DbcExportRegistry` 在导出前统一按 ID 稳定排序。

验收：

- 任意阶段注入异常，原数据库表保持可用。
- 任意阶段注入异常，已有 DBC 文件可以恢复。
- 相同数据库快照连续导出产生相同文件。

### 阶段 5：`warcrafty` 流式能力（可选、单独评估）

只有确认全量导出内存不可接受时才实施：

- 在 `warcrafty` 中增加流式 Writer。
- Foxy Repository 增加 DBC 专用批处理方法。
- 更新 `docs/repository_crud_template.md`。
- `DbcExportRegistry` 改为输出批次流。
- 完成 `dbc_spell` 峰值内存对比。

## 17. 测试方案

当前先完成重构，以下自动化测试扩充与真实数据验收待重构结束、准备好测试数据后集中执行。

### 17.1 定义和 Registry

- DBC tableName 唯一。
- DBC fileName 忽略大小写后唯一。
- 所有定义都存在 Schema。
- 所有定义都存在导出 delegate。
- 所有 delegate 的 `toJson()` 包含全部必需非 unused 字段。
- 未注册表返回明确错误。

### 17.2 导入

- 目录不存在。
- 文件扩展名大小写。
- 同一定义匹配多个文件。
- 目标表不存在。
- 目标表为空。
- 目标表非空时跳过。
- DBC 格式错误。
- 字符串包含引号、反斜杠、换行、NUL 和 Ctrl-Z。
- 中途 SQL 失败。
- worker 异常退出。
- 用户取消。
- staging 提交失败后原表不变。

### 17.3 导出

- 空表跳过。
- JSON 缺少必需字段。
- int/float/bool 类型不匹配。
- `uint8` 数值越界。
- 中文、空字符串和重复字符串。
- 目标文件已存在。
- 写盘失败。
- `DbcLoader` 回读失败。
- 替换失败后恢复 backup。
- 相同数据连续两次导出字节一致。

### 17.4 ViewModel

- `SettingViewModel` 正确初始化导出项。
- retry 完整恢复 exporting 状态。
- 导出对话框 dispose 时取消 success signal 订阅。
- `ScaffoldViewModel` 不再持有导出状态。
- `BasicSettingPage` 不再获取 `ScaffoldViewModel`。
- 导入失败时导入对话框正确显示错误。
- 导出部分失败时保留可重试状态。

### 17.5 集成和验收命令

```bash
dart format <本次改动的 Dart 文件>
flutter analyze
flutter test
```

DBC staging 表交换和失败恢复需要真实 MySQL 集成测试，不应只使用 mock 验证。

## 18. 完成标准

阶段 1—4 全部完成时，应满足：

- DBC 定义只有一份。
- 导出的每张 DBC 表都通过对应 Repository 读取。
- `creature_model_data` 不再存在裸表读取特例。
- `BasicSettingPage` 只依赖 `SettingViewModel`。
- `ScaffoldViewModel` 只保留 DBC 导入状态。
- `DbcSyncUtil` 不读写 YAML，不调用 Dialog，不获取 Repository。
- `DbcExportUtil` 不获取 Repository。
- 导入使用 staging 表，失败不会清空正式表。
- 导出先写临时文件并回读校验。
- 导出任务锁覆盖整批 Repository 读取和文件写入。
- 导入取消可以从进度对话框触发，并进入明确的 cancelling/终态。
- 任务终态唯一且会关闭所有 Port。
- 进度不超过 100%。
- `flutter analyze` 和 `flutter test` 通过。

## 19. 自我审查

| 检查项 | 结论 | 说明 |
|---|---|---|
| 符合 Foxy 架构 | 通过 | Page 只访问自己的 ViewModel；ViewModel 组合 Repository 和 Util |
| 复用 `warcrafty` | 通过 | Foxy 不解析 Header、不编码字节、不实现 Reader/Writer |
| 一表一 Repository | 通过 | 导出全部走对应 Repository，`creature_model_data` Entity/Repository 已补齐 |
| 导入绕过 Repository | 有意保留的例外 | 它是 isolate 内的动态数据库初始化，不属于 Entity CRUD |
| 命名和目录 | 通过 | 仅使用现有 constant/page/repository/util 目录 |
| ViewModel 职责 | 通过 | 只负责编排、signals 和错误展示，不处理 DBC 字节或 SQL |
| 数据安全 | 明显改善 | staging table、临时文件、回读校验和 backup 恢复 |
| 导入内存 | 未完全解决 | `DbcLoader` 的内存特征由 `warcrafty` 决定，但已放在 isolate 中 |
| 导出内存 | 首轮未解决 | 受 Repository.`get{Entities}` 和 `DbcWriter(List)` 约束，需后续单独修改 `warcrafty` |
| Windows 文件原子性 | 部分解决 | backup 恢复安全，但不是 `ReplaceFileW` 级别的真正原子操作 |
| 改动范围 | 可控 | 阶段 1—4 不要求修改 `warcrafty` API 和全部 Repository 契约 |
| 可测试性 | 改善 | 定义、Registry、文件转换和 ViewModel 可独立测试；MySQL staging 需集成测试 |

### 19.1 审查后的最终范围建议

本次 Foxy 重构建议仅承诺阶段 1—4：

1. 统一定义与依赖。
2. ViewModel 归位。
3. 任务生命周期正确。
4. 导入导出数据安全。

流式 Reader/Writer 属于 `warcrafty` 后续增强，不应为了本次重构在 Foxy 中重复实现。
