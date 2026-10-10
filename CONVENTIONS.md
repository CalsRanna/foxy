# CONVENTIONS.md

Foxy 的项目级**硬性约定**（可判定的规则，不是建议）。行为准则见 `AGENTS.md`；架构与流程见 `README.md` 与 `doc/`；新增模块的逐步执行清单见 `doc/module-workflow.md`。

## 1. 语言与文案

- 代码注释一律英文（`//`、`///`、yaml `#`）。
- UI 文案、日志消息、文档（README / AGENTS / CONVENTIONS / doc）用中文。
- 异常消息一律英文 —— 由 lint `no_chinese_throw` 强制。
- 导入统一 `package:` 绝对路径，禁止相对导入（`always_use_package_imports`，在 `packages/foxy/analysis_options.yaml` 开启）。
- 提交信息 `type(scope): description`，描述用英文，如 `feat(codegen): add parent-key query layer`；主干分支 `main`。

## 2. 命名与结构

命名与文件布局在**代码生成时**校验：

- 类名 ↔ 文件名 snake_case：`XxxEntity` ↔ `xxx_entity.dart`，`XxxRepository` ↔ `xxx_repository.dart`，`XxxViewModel` ↔ `xxx_view_model.dart`；列表行 DTO 为 `BriefXxxEntity`。
- 生成的方法名固定：`getBriefXxx` / `countXxx` / `getXxx` / `storeXxx` / `updateXxx` / `destroyXxx` / `createXxx` / `copyXxx`；过滤器类为 `XxxFilter`。
- 手写类必须 `part 'xxx.g.dart';` + `with _XxxMixin`，实体还需保留委托工厂 `factory Xxx.fromJson(...) => _XxxMixin.fromJson(...);`（三件套缺一，构建期报错定位到元素）。
- 生成器只处理固定 glob（`packages/foxy/build.yaml` 的 `generate_for`）：`lib/entity/**_entity.dart`、`lib/repository/**_repository.dart`、`lib/view_model/**_view_model.dart`。注解类放到不匹配的文件里会被**静默跳过**。
- 物理列名只在 `@FoxyFullField('column')` 出现一次，其余从 Entity 派生。

## 3. 代码生成铁律

- **禁止手改 `*.g.dart`**：它们是 `// GENERATED CODE - DO NOT MODIFY BY HAND` part 文件（提交入库）。要改就改手写文件的注解，再重跑生成。
- 任何注解改动、或新增 entity/repository/view_model 文件后，必须先 `dart run build_runner build --delete-conflicting-outputs` 才能编译。
- 生成物一律是 mixin（`_XxxMixin on RepositoryMixin` / `FieldControllerMixin`），通过 `with` 混入手写类；定制行为靠手写类覆写生成方法。
- 改动注解或生成器**必须**补生成器测试（`packages/foxy_generator/test/`），见 `doc/codegen/extending.md`。

## 4. foxy_lint 规则

`packages/foxy_lint` 是项目专属 analyzer 插件。

- 插件**只在 IDE 分析服务器里运行**：`flutter analyze` / `dart analyze` CLI 不执行插件，因此 CI 的 analyze 关卡不覆盖这些规则。规则由自身测试（`packages/foxy_lint/test/`，官方 `analyzer_testing` 框架）端到端保证。
- 启用与否在**工作区根** `analysis_options.yaml` 的 `plugins.foxy_lint.diagnostics` 中声明（绝对路径，因 dart-lang/sdk#61477）。

已启用的规则：

| 规则 | 含义 |
| --- | --- |
| `entity_scalar_only` | Entity 只含标量字段（无 `List`/`Map`/`Set`） |
| `entity_no_flutter_import` | Entity 层禁止 import Flutter / UI 包 |
| `repository_no_save` | Repository 不得暴露裸 `save*`，改用生成的 store/update/destroy |
| `view_model_no_router_facade` | ViewModel 不得触碰路由 |
| `no_collection_loops` | 禁止手写 `List.generate` / `for-in` 集合循环，改用 `map/where/...` |
| `no_flex_in_view` | View 文件禁止 `flex:` 具名参数，等间距用 `Expanded` |
| `no_readonly_in_view` | View 文件禁止 `readOnly: true`（字段一律可编辑） |
| `no_chinese_throw` | 异常消息必须英文 |
| `min_table_column_width` | 表格列宽至少 120 |

已注册但未启用：`annotation_file_mismatch`、`class_file_name_match`（等价检查由生成器 reader 在构建期完成）、`avoid_top_level_declarations`、`no_k_prefixed_static_member`。

## 5. 错误处理

- 所有业务错误是 `sealed class FoxyException` 的子类型（`lib/infrastructure/errors/foxy_exceptions.dart`）：`RecordNotFoundException`、`DuplicateKeyException`、`InvalidPrimaryKeyException`、`BusyException`、`LinkNotLoadedException`、`IdExhaustedException`、`ValidationException`、`CopyNotSupportedException`、`DatabaseNotConnectedException`、`UpdateException`（带 `UpdateErrorKind`）。
- 异常 `implements Exception`（无 `Exception:` 前缀），消息一律英文，仅供日志。
- 用户可见的中文文案由 `FoxyExceptions.message(error)` 集中映射 —— **UI 展示错误的唯一入口**。
- 驱动边界的重复键判定统一走 `MysqlErrorUtil.isDuplicateEntry`：`LaconicException.driver == 'mysql' && code == '1062'`（不遍历 cause 链，不解析消息）。

## 6. 状态管理与 UI

- 状态用 **signals / signals_flutter**（VM 暴露 `signal(...)` 字段，页面用 `Watch`）；禁止 Provider / Riverpod / Bloc。
- 组件用 shadcn_ui + lucide_icons_flutter；中文界面。
- UI 一致性约定（audit 2026-08 后确立）：
  - **错误提示一律阻塞模态**：`DialogUtil.instance.error('失败类型：${FoxyExceptions.message(error)}')`（标题"错误"，需手动确认）；禁止非阻塞错误 toast 或对话框内联错误。成功提示才用 `DialogUtil.instance.success(...)`（唯一 toast 入口，全库禁止裸 `ShadSonner.of`）。
  - 统一外壳：`FoxyFormDialog`（子表增删改对话框）、`FoxyLoadingIndicator`（加载态）、`DialogUtil.width`（对话框宽度唯一来源）。
  - **间距**：新代码统一用 Row/Column 的 `spacing:` 参数；`SizedBox` 只做固定尺寸，不做元素间距。
  - **空态文案**：列表/表格统一"暂无数据"（`FoxyDataTable` 内置）；其他场景按语境自定，不必强行统一。
  - **控件映射**：数字 → `FoxyNumberInput`；文本 → `FoxyStringInput`；可空 → `FoxyNullableStringInput`；枚举 → `FoxyShadSelect`（placeholder 传字符串）；位标志 → `FoxyFlagPicker`；引用 → `FoxyEntityPicker`；本地化 → `FoxyLocalePicker`。placeholder 一律英文列名。
  - **详情页响应式两模式并存，均正确**：大模块在详情页层 `Watch` 包 `FoxyTab` + 主视图 `ValueKey('main-$key')` + `disabledTabIndexes`；小模块在视图内 per-field `Watch`。新模块按规模选择，不必改造存量。
  - **子表 linkKey 变化**：新代码统一在 `didUpdateWidget` 里调 `viewModel.setLinkKey(...)`（比依赖父页 ValueKey 重建更精确）。

## 7. 数据库层

- `Database.instance` 单例（`lib/database/database.dart`）：`connect(MysqlConfig)` → `Laconic(MysqlDriver)`。配置来自运行目录的 `config.yaml`，经 `ConfigUtil` 读取（原子重写，损坏文件自愈到 `.bak`）。
- **两个命名空间**：AzerothCore `world` 表（无前缀，如 `creature_template`）与应用自有 **`foxy` 元库**（`foxy.features` / `foxy.migrations` / `foxy.activity_log` / `foxy.dbc_*` 镜像表）。
- **迁移**：`lib/database/migration/migration_YYYYMMDDHHMM.dart`，按时间顺序追加到 `lib/database/migration_runner.dart` 的列表。Runner 还会强制建 `foxy` 库为 utf8mb4，并幂等地把非 utf8mb4 表转为 utf8mb4。
- **依赖装配全部显式**：`lib/di.dart` 用 get_it 显式注册（无服务定位器魔法）。
- **活动日志**：每次 create/update/delete/copy 由生成的 `_logActivity` 经 `EventBus` 发 `EntityWrittenEvent`；**单个** `ActivityLogListener`（eager singleton）通过 `ActivityLogService.recordBestEffort` 落库（日志永不拖垮主写入）。
- **事务**：跨表用例用 `DatabaseTransaction.execute()`（`lib/infrastructure/database/database_transaction.dart`）；嵌套调用经 zone marker **合并**为同一事务（laconic_mysql 每次 `transaction()` 都新开连接，嵌套会独立提交）。Repository 从不协调事务。
- **本地化**：`RepositoryMixin.localeEnabled` 控制 zhCN JOIN 开关；`@FoxyBriefField.text` 标记 locale 展示名列；DBC 宽表用 `DbcLocaleRepositoryMixin` + `DbcLocaleFields`（16 语言）。
- **游戏语义知识**（flags、enums、DBC schema、locale 字段表）集中在 `lib/constant/`，不得散落在页面里。

## 8. 测试

- 分类与位置：
  - 游戏数据测试（`test/game_data/`）：枚举/标志/列布局与服务端取值一致，纯内存。
  - 编辑语义测试（`test/database_editing/`）：键值语义、编辑流程、查询构建，纯内存。
  - 身份保持测试（`test/identity/`）：活动日志行 ID、locale 草稿 vs 原值、路由面包屑。
  - 基础设施 / widget / use case / 迁移 runner 测试。
  - 集成测试（`test/integration/`，标签 `integration`）：对真实 MySQL 跑应用启动链路与仓储读写。
- 集成测试默认跳过（见 `dart_test.yaml`），普通 `flutter test` 不需要数据库；本地用 `flutter test --tags integration --run-skipped -j 1` 运行，DBC 用例还需 `FOXY_TEST_MYSQL_ALLOW_DBC_WRITE=1`。必须串行（`-j 1`），且绝不能指向 `foxy` schema 有意义的库。
- 新增注解 / 生成器**必须**加生成器测试（`packages/foxy_generator/test/`，`dart test` 纯 Dart 运行）。
