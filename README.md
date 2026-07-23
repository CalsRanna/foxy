# Foxy

Foxy 是一个面向 [AzerothCore](https://www.azerothcore.org/) 3.3.5a 的桌面数据库可视化管理工具，用于编辑生物、物品、任务、法术、对话、Smart Scripts 等游戏数据，并支持 DBC 数据导入与导出。

项目使用 Flutter 构建桌面界面，通过 MySQL 直接连接 AzerothCore world 数据库。普通服务端表保存在所连接的 world schema 中；DBC 镜像及 Foxy 自身数据保存在独立的 `foxy` schema 中。

## 功能概览

- 编辑 AzerothCore world 数据：
  - 生物与生物关联数据
  - 物品与掉落模板
  - 任务及任务关系
  - 游戏对象
  - NPC 对话与菜单选项
  - Conditions 与 Smart Scripts
  - 玩家出生数据等
- 编辑 3.3.5a DBC 数据：
  - 法术、天赋、成就、货币、物品集合等
  - DBC 本地化字段
  - DBC 文件批量导入、导出与进度反馈
- 支持基础表与 `*_locale` 本地化表联合展示
- 支持列表筛选、分页、实体选择器及复合主键编辑
- 记录创建、修改、删除等操作活动
- 保存窗口尺寸和本地连接配置

## 技术栈

- Flutter / Dart
- [shadcn_ui](https://pub.dev/packages/shadcn_ui)
- Signals (`signals` / `signals_flutter`)
- GetIt
- AutoRoute
- Laconic / Laconic MySQL
- MySQL

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

DBC 功能面向客户端版本 `3.3.5.12340` / 3.3.5a。表、文件名及物理字段定义位于 [`lib/constant/dbc_definitions.dart`](lib/constant/dbc_definitions.dart)。

- 导入：从选定目录扫描 `.dbc` 文件，并将数据写入 `foxy.dbc_*` 表。
- 导出：从已注册的 `foxy.dbc_*` 表生成 DBC 文件。
- 文件名匹配不区分大小写。
- 导入前请备份已有 DBC 镜像数据。

游戏物品和法术图标位于 `asset/icon/`，不会加入 Flutter asset bundle。应用运行时从可执行文件旁的 `data/icon/` 读取这些图标，以避免将大量图标打入 Flutter 资源包。目前 Windows CMake 构建包含对应复制规则；其他平台分发时需要确保图标目录位于相同位置。

## 开发

### 常用命令

```bash
# 静态检查
flutter analyze

# 全部测试
flutter test

# 单个测试文件
flutter test test/<name>_test.dart

# 按名称运行单个测试
flutter test test/<name>_test.dart --plain-name '<exact test name>'

# 格式化本次修改的 Dart 文件
dart format <changed .dart files>

# 路由代码生成
dart run build_runner build --delete-conflicting-outputs

# 构建桌面应用
flutter build macos
flutter build windows
flutter build linux
```

`lib/router/router.gr.dart` 由 AutoRoute 生成并纳入版本控制，请勿手工修改。

### 项目结构

```text
lib/
├── constant/        # AzerothCore/DBC 枚举、Flags、Schema 与选项
├── database/        # 数据库连接与 Foxy migrations
├── entity/          # 完整实体、Brief 实体、筛选条件与复合 Key
├── event/           # 应用事件总线
├── infrastructure/  # 配置、DBC、日志、偏好、窗口及工具
├── page/            # 按功能组织的 Page / View / ViewModel
├── repository/      # Laconic 查询与持久化层
├── router/          # AutoRoute 配置和导航门面
├── use_case/        # 跨 Repository、事务及长流程的具体用户用例
├── widget/          # 表单、表格、Picker、Dialog 等共享组件
├── di.dart          # GetIt 依赖注册
└── main.dart        # 应用入口

test/                # 单元、Widget、数据库编辑及架构契约测试
asset/image/         # Flutter asset 图片
asset/icon/          # 外置游戏图标
linux|macos|windows/ # 桌面平台工程
```

详细的仓库架构、持久化约束和 AI 编码规范参见 [`AGENTS.md`](AGENTS.md)。

### 数据编辑约定

项目通过契约测试严格约束数据库编辑行为，主要原则包括：

- 编辑中的候选值与数据库中原始行身份分离；
- 更新始终使用完整原始 Key 定位旧行；
- 单列主键使用标量，复合主键使用专用 Key 类型；
- 更新和删除必须检查 MySQL 返回的匹配行数；
- 列表与 Picker 使用只包含展示字段和完整身份的 Brief 实体；
- Repository 不隐式删除关联表数据；
- DBC Entity 的字段必须精确覆盖物理 Schema。

新增模块前，建议先寻找主键形态和存储类型最接近的现有模块，并同步添加对应契约测试。

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
- 部分 Widget 测试会故意触发并记录错误堆栈，以验证错误提示行为；应以测试命令最终状态为准。

## 许可证

本项目使用 [MIT License](LICENSE)。
