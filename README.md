# Foxy

Foxy 是一个面向 [AzerothCore](https://www.azerothcore.org/) 3.3.5a 的桌面数据库可视化管理工具，用于编辑生物、物品、任务、法术、对话、Smart Scripts 等游戏数据，并支持 DBC 数据导入与导出。

项目使用 Flutter 构建桌面界面，通过 MySQL 直接连接 AzerothCore world 数据库。普通服务端表保存在所连接的 world schema 中；DBC 镜像及 Foxy 自身数据保存在独立的 `foxy` schema 中。

## 功能概览

- 编辑 AzerothCore world 数据：
  - 生物与生物关联数据（掉落、训练师、商人、任务关系等）
  - 物品与掉落模板
  - 任务及任务关系
  - 游戏对象
  - NPC 对话与菜单选项
  - Conditions 与 Smart Scripts
  - 玩家出生数据等
- 编辑 3.3.5a DBC 数据：
  - 法术、天赋、成就、货币、物品集合等
  - DBC 本地化字段（16 语言槽位）
  - DBC 文件批量导入、导出与进度反馈
- 支持基础表与 `*_locale` 本地化表联合展示
- 支持列表筛选、分页、实体选择器及复合主键编辑
- 记录创建、修改、删除、复制等操作活动
- 保存窗口尺寸和本地连接配置
- 从魔兽客户端 MPQ 提取游戏图标并渲染

## 技术栈

- Flutter / Dart
- [shadcn_ui](https://pub.dev/packages/shadcn_ui)
- Signals (`signals` / `signals_flutter`)
- GetIt
- AutoRoute
- Laconic / Laconic MySQL
- [warcrafty](https://pub.dev/packages/warcrafty)（DBC 与 MPQ 二进制解析）
- 自研注解代码生成器（基于 `build_runner` / `source_gen`）
- 自研 `custom_lint` 插件（架构约束检查）

具体依赖版本以 [`pubspec.yaml`](pubspec.yaml) 和 [`pubspec.lock`](pubspec.lock) 为准。

## 支持平台

仓库包含以下 Flutter 桌面平台工程：

- Windows
- macOS
- Linux

项目不包含 Android、iOS 或 Web 的受维护运行工程。

## 环境要求

- Flutter stable
- Dart SDK `^3.9.2`
- 对应平台的 Flutter 桌面构建工具链
- 可访问的 MySQL 实例
- AzerothCore 3.3.5a world 数据库
- 对以下操作具备权限的 MySQL 用户：
  - 读取和修改目标 world 数据库
  - 创建并使用 `foxy` 数据库
  - 创建及变更 Foxy 自有表

> Foxy 启动连接后会自动运行 `lib/database/migration/` 中的迁移。请先备份重要数据库，并优先在开发或测试环境验证修改。

## 快速开始

### 1. 获取依赖

```bash
flutter pub get
```

### 2. 运行应用

在项目根目录运行当前平台对应命令：

```bash
flutter run -d macos
# 或
flutter run -d windows
# 或
flutter run -d linux
```

首次启动时，在连接页面填写：

- MySQL 主机
- 端口
- AzerothCore world 数据库名
- 用户名
- 密码

连接成功后，Foxy 会：

1. 连接所选 world 数据库；
2. 检测 AzerothCore locale 表；
3. 创建或迁移 `foxy` schema；
4. 加载功能菜单；
5. 将连接设置保存到项目根目录的 `config.yaml`。

`config.yaml` 已被 `.gitignore` 排除。它可能包含明文数据库密码，请勿提交、分享或放入构建产物。

也可以预先创建配置文件：

```yaml
host: 127.0.0.1
port: "3306"
database: acore_world
username: root
password: your-password
dbc_path: /path/to/dbc
```

配置路径基于应用启动时的当前工作目录。开发时应从项目根目录启动应用。

## DBC 导入与导出

DBC 功能面向客户端版本 `3.3.5.12340` / 3.3.5a。表、文件名及物理字段定义位于 [`lib/constant/dbc_definitions.dart`](lib/constant/dbc_definitions.dart)，二进制结构以 warcrafty 包的 schema 为准。

- 导入：从选定目录扫描 `.dbc` 文件，在后台 isolate 中解析，经 staging 表校验后原子替换 `foxy.dbc_*` 正式表。
- 导出：从已注册的 `foxy.dbc_*` 表生成 DBC 文件，写入临时文件后回读校验再原子替换。
- 文件名匹配不区分大小写。
- 导入前请备份已有 DBC 镜像数据。

游戏物品和法术图标不随应用内置。在设置页「游戏图标」中填写魔兽客户端目录后，应用扫描 `Data/` 根目录与 `Data/<语言>/` 下**全部 MPQ 归档**（含自定义 patch 包），提取图标（BLP 原始格式）到运行时当前目录的 `data/icon/`（与 `config.yaml` 位置一致），列表页直接渲染。未提取（如 DBC 引用了客户端不存在的资源）时显示占位符。

## 代码生成

项目大量代码由自研注解代码生成器产出。生成器位于 [`lib/infrastructure/codegen/`](lib/infrastructure/codegen/)，通过 `build_runner` 在构建期把注解展开为 `.g.dart` 文件（纳入版本控制，**请勿手工修改**）。

### 生成器

[`build.yaml`](build.yaml) 注册了三个 builder：

| Builder           | 作用域                              | 生成内容                                       |
| ----------------- | ----------------------------------- | ---------------------------------------------- |
| `foxy_entity`     | `lib/entity/**_entity.dart`         | Full Entity 值语义 mixin、Brief 实体、复合 Key |
| `foxy_repository` | `lib/repository/**_repository.dart` | 标准 CRUD、列表/统计/复制/新建查询层、Filter 查询输入 |
| `foxy_view_model` | `lib/view_model/**_view_model.dart` | 列表 ViewModel 样板、表单 controller 与收集    |

### 注解一览

| 注解                                                                            | 目标             | 作用                                                                                       |
| ------------------------------------------------------------------------------- | ---------------- | ------------------------------------------------------------------------------------------ |
| `@FoxyFullEntity(table:)`                                                       | Entity class     | 声明 Full Entity，生成 `fromJson` / `copyWith` / `toJson` / `==` / `hashCode` / `toString` |
| `@FoxyFullField(column, key:)`                                                  | Entity 字段      | 映射物理列；`key: true` 标记物理主键                                                       |
| `@FoxyBriefEntity`                                                              | Entity class     | 同时生成只读 `Brief<Name>Entity`（值语义，无写 API）                                       |
| `@FoxyBriefField()`                                                             | Entity 字段      | 把该物理字段纳入 Brief 投影                                                                |
| `@FoxyBriefField.text/integer/decimal/boolean(name)`                            | Entity class     | 声明 Brief 投影补充字段（由查询 alias 提供）                                               |
| `@FoxyRepository(Entity, parentKey:)`                                           | Repository class | 生成 CRUD + 查询层；`parentKey` 声明子表(父详情页 Tab),列表/新建按父键过滤 |
| `@FoxyFilter.text/integer/decimal/boolean(name, column:)`                       | Repository class | 生成该仓库的 `<Name>Filter` 查询输入；`column` 显式指定物理列（无法按字段名推断时必填）   |
| `@FoxyListViewModel(entity:, repository:)`                                      | List ViewModel   | 生成列表状态、筛选 controller 与 search/reset/paginate/copy/destroy/刷新                   |
| `@FoxyDetailViewModel(entity:, selects:, flags:, groups:, nullable:, exclude:, repository:)` | Detail ViewModel | 生成表单 controller + 行为骨架(信号 / initSignals / persist / dispose / `_logActivity` 钩子) |
| `@FoxyCollectionEditorViewModel(entity:, repository:, ...)`                        | Collection Editor ViewModel | 生成子表行编辑器全套骨架(父键子集信号 / 分页 / 竞态 token / CRUD / persist / setParentKey) |

典型用法：Entity 声明字段与物理列的对应关系（单一事实来源），Repository 声明表名与筛选字段，Detail ViewModel 只声明表单例外（select/flag/group/nullable/exclude），列表筛选字段直接从 Repository 的 `@FoxyFilter` 读取。生成器在构建期校验文件名、`part` 声明、mixin 混入、字段类型、命名约定等约束，违规即构建失败，而不是留到运行时。

查询层（`create` / `copy` / `getBrief*` / `count*` / `get*` / `_applyFilter`）按命名约定全量生成，手写方法同签名时自动成为 `@override`（类成员优先于 mixin 成员）——带 join / LIKE / 上限校验等特殊逻辑的仓库保留手写版本即可。列表查询方法名固定为 `getBrief<Base>s` / `count<Base>s` / `copy<Base>` / `destroy<Base>`（辅音 + y 结尾按 y → ies 复数化，如 `GemProperty` → `GemProperties`）。子表仓库声明 `@FoxyRepository(..., parentKey: ['field'])` 后生成父键形态查询（列表只查该父记录的子集合，如「生物详情页的掉落 Tab」）；Detail/Collection Editor ViewModel 声明 `repository:` 后生成行为骨架，模块特殊逻辑经 `@override` 保留。

### 重新生成

```bash
dart run build_runner build --delete-conflicting-outputs
```

修改 Entity 字段、Repository 方法签名或 ViewModel 注解后需要重新生成。生成产物已入库，提交时包含对应 `.g.dart` diff。

## 开发

### 常用命令

```bash
# 静态检查（含 custom_lint 规则）
flutter analyze

# 全部测试
flutter test

# 单个测试文件
flutter test test/<name>_test.dart

# 按名称运行单个测试
flutter test test/<name>_test.dart --plain-name '<exact test name>'

# 代码生成器套件（flutter test 下会被跳过，需要 dart test）
dart test test/infrastructure/codegen

# 格式化本次修改的 Dart 文件
dart format <changed .dart files>

# 构建桌面应用
flutter build macos
flutter build windows
flutter build linux
```

不要对全仓库执行全局格式化（见下文「已知开发环境注意事项」）。

### 项目结构

```text
lib/
├── constant/        # AzerothCore/DBC 枚举、Flags、Schema 与选项
├── database/        # 数据库连接与 Foxy migrations
├── entity/          # Full/Brief 实体、Key、筛选输入（注解驱动生成）
├── event/           # 应用事件总线
├── infrastructure/  # 配置、DBC、日志、偏好、窗口、代码生成及工具
├── lint/            # custom_lint 插件与规则
├── page/            # 按功能组织的 Page / View（路由页与纯视图）
├── repository/      # Laconic 查询与持久化层（CRUD 由注解生成）
├── router/          # AutoRoute 配置和导航门面
├── use_case/        # 跨 Repository、事务及长流程的具体用户用例
├── view_model/      # 全部 ViewModel（列表/详情/编辑器样板由注解生成）
├── widget/          # 表单、表格、Picker、Dialog 等共享组件
├── di.dart          # GetIt 依赖注册
└── main.dart        # 应用入口

test/                # 单元、Widget、契约及代码生成行为测试
asset/image/         # Flutter asset 图片
linux|macos|windows/ # 桌面平台工程
```

详细的仓库架构、持久化约束和 AI 编码规范参见 [`AGENTS.md`](AGENTS.md)。

### 代码生成与 Lint

项目使用代码生成和 custom_lint 保证架构约束，不再依赖手工编写的源码级契约测试：

- **代码生成**（[`lib/infrastructure/codegen/`](lib/infrastructure/codegen/)）：从注解生成 Entity 样板代码、Repository CRUD 方法、Filter 查询输入和 ViewModel 表单样板，构建期即可发现字段类型、文件命名、约定混入等问题。
- **Lint 规则**（[`lib/lint/`](lib/lint/)）：通过 `custom_lint` 在 `flutter analyze` 中检查 Entity 字段类型、Repository 方法签名、View 布局参数等 7 条约束，详见 [`AGENTS.md`](AGENTS.md)。

### 数据编辑约定

主要原则：

- 编辑中的候选值与数据库中原始行身份分离；
- 更新始终使用完整原始 Key 定位旧行；
- 更新和删除必须检查 MySQL 返回的匹配行数；
- Repository 不隐式删除关联表数据；
- DBC Entity 的字段必须精确覆盖物理 Schema。

### ViewModel 与 UseCase 边界

ViewModel 按交互状态机分为七类，并通过类名和文件名后缀声明类别：
`ListViewModel`、`DetailViewModel`、`CollectionEditorViewModel`、
`SingleEditorViewModel`、`ReadViewModel`、`WorkflowViewModel` 和
`StateViewModel`。ViewModel 只持有可渲染状态、typed controller、明确的
`persistedKey`/`editingKey` 以及异步刷新保护；不接收 `BuildContext`，不显示
Dialog/Toast，不导航，也不直接访问数据库事务。

简单单表操作可由 ViewModel 直接调用具体 Repository。一次操作涉及多个
Repository、事务、跨表校验或可取消长流程时，使用 `lib/use_case/` 下的具体
UseCase。UseCase 使用具体输入输出和 `execute()`，不引入泛型 CRUD 基类；
Dialog、Toast、mounted 检查和导航均由 UI 交互面负责。

## 测试数据库

普通测试不要求真实 MySQL。MySQL 写入语义集成测试默认跳过，只能使用独立且不名为 `foxy` 的测试 schema：

```bash
FOXY_TEST_MYSQL=1 \
FOXY_TEST_MYSQL_FOXY_SCHEMA=foxy_test_isolated \
FOXY_TEST_MYSQL_HOST=127.0.0.1 \
FOXY_TEST_MYSQL_PORT=3306 \
FOXY_TEST_MYSQL_USERNAME=root \
FOXY_TEST_MYSQL_PASSWORD=your-password \
flutter test test/dbc_mysql_integration_test.dart
```

该测试会在指定 schema 中创建并删除 `_foxy_write_result_contract` 表。不要将生产 schema 传给测试。

## 已知开发环境注意事项

- `test/dbc_sync_util_test.dart` 中“同一定义匹配多个文件”测试需要同一目录同时存在仅大小写不同的文件名。在默认大小写不敏感的 macOS 文件系统上，这两个文件无法共存，因此该测试可能进入 MySQL 连接分支并失败。
- 全仓库 `dart format` 检查有 161 个手写文件与当前格式化器存在风格差异（参数展开形式），仅格式化本次修改的文件即可，不要全局格式化。
- 部分 Widget 测试会故意触发并记录错误堆栈，以验证错误提示行为；应以测试命令最终状态为准。

## 许可证

本项目使用 [MIT License](LICENSE)。
