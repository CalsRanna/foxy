# AGENTS.md — Foxy

> **Pi 快速入门指南**：这是一份为 AI 编程助手准备的仓库上下文文档。阅读本文后，你应该能理解项目架构、约定和工作流，从冷启动直接进入高效编码。

---

## 项目概况

**Foxy** 是一个 **Flutter 桌面应用**（目标平台为 Windows），用于可视化管理 [AzerothCore](https://www.azerothcore.org/) 的 `acore_world` 数据库——即《魔兽世界》服务端的游戏数据（生物、物品、任务、法术、对话、SmartAI 等）。同时也管理一个辅助库 `foxy`（应用元数据、DBC 镜像表、迁移记录）。

- **语言**：Dart 3.9+
- **框架**：Flutter
- **许可**：MIT © Cals Ranna
- **仓库**：https://github.com/CalsRanna/foxy

---

## 技术栈速查

| 分类 | 库 | 用途 |
|------|-----|------|
| UI | `shadcn_ui` | 组件库（按钮、卡片、表格、对话框、Toast 等） |
| Icons | `lucide_icons_flutter` | 图标集（`LucideIcons.xxx`） |
| 状态管理 | `signals` / `signals_flutter` | 响应式信号；UI 用 `Watch((_) => ...)` 订阅 |
| DI | `get_it` | 服务定位器，`di.dart` 集中注册 |
| 路由 | `auto_route` + `build_runner` | 注解生成路由代码（`router.gr.dart`） |
| 数据库 | `laconic` + `laconic_mysql` | 轻量 MySQL ORM，无代码生成 |
| DBC | `warcrafty` | 解析/写入 `.dbc` 文件 |
| 桌面窗口 | `window_manager` | 无边框窗口、拖拽、尺寸记忆 |
| 文件选择 | `file_selector` | 目录/文件选择对话框 |
| YAML | `yaml` + `yaml_edit` | 读写 `config.yaml` |

---

## 架构：分层模型

```
Page / Widget（UI, @RoutePage 注解）
  ↓
ViewModel（signals 状态，GetIt 工厂注入）
  ↓
Repository（统一 CRUD，with RepositoryMixin）
  ↓
Entity / Filter Entity（纯 Dart 数据类：fromJson / toJson / copyWith）
  ↓
Database → Laconic → MySQL
  ├─ acore_world（游戏世界数据，库名可配置）
  └─ foxy（应用元数据 / DBC 镜像表 / 迁移记录）
```

### 核心设计决策

- **一张表一个 Repository**，命名与表语义对应（`CreatureTemplateRepository`、`QuestTemplateRepository` 等）
- **Repository CRUD 命名严格统一**（详见 `docs/repository_crud_template.md`）：`getBrief*` / `get*s` / `count*` / `get*` / `create*` / `store*` / `update*` / `destroy*` / `copy*` / `save*`。**禁止** `search` / `query` 等别名
- **列表页与 Entity Picker 共用** `getBrief*`（精简列 + 分页）和 `count*`。`get{Entities}` **仅**用于 DBC 导出等需要全量全字段的批处理
- **ViewModel 注册为工厂**（`registerFactory`），每次页面打开获取新实例；**Repository 注册为懒汉单例**（`registerLazySingleton`）
- **跨库查询 DBC** 时使用全限定名：`foxy.dbc_spell`、`foxy.dbc_faction` 等
- **本地化**：世界库的 `*_locale` 分表（如 `creature_template_locale`）默认检测 `zhCN`，通过 `FoxyViewModel` 信号全局控制

---

## 项目结构

```
lib/
├── main.dart                         # 入口：窗口初始化 → DI → runApp(FoxyApp())
├── di.dart                           # GetIt 统一注册（Repository + ViewModel）
├── constant/                         # 枚举、Flags、条件类型等常量
│   ├── condition_source_type.dart
│   ├── condition_type.dart
│   ├── condition_value_config.dart
│   ├── creature_enums.dart
│   ├── creature_flags.dart
│   ├── game_object_constants.dart
│   ├── gossip_menu_option_constants.dart
│   ├── item_constants.dart / item_enums.dart / item_flags.dart / item_quality.dart
│   ├── smart_script_constants.dart
│   └── spell_enums.dart / spell_flags.dart
├── database/
│   ├── database.dart                 # 单例：connect(MysqlConfig) / laconic 访问器
│   ├── migration_runner.dart         # Migration 抽象类 + MigrationRunner
│   └── migration/                    # 带时间戳的迁移文件
│       ├── migration_202604260000.dart
│       ├── migration_202604260001.dart
│       ├── migration_202604270000.dart
│       ├── migration_202604280000.dart
│       └── migration_202605010000.dart
├── entity/                           # 数据实体 + Filter + Brief 实体
│   ├── creature_template_entity.dart # 包含 BriefCreatureTemplateEntity + CreatureTemplateEntity
│   ├── creature_template_filter_entity.dart
│   ├── creature_template_locale_entity.dart
│   ├── item_template_entity.dart / _filter / _locale
│   ├── quest_template_entity.dart / _filter / _locale / _addon
│   ├── smart_script_entity.dart
│   ├── spell_entity.dart / _filter
│   ├── activity_log_entity.dart
│   ├── feature_entity.dart
│   └── ...（共 90+ 实体文件）
├── page/                             # 按业务域划分的 Page + ViewModel
│   ├── bootstrap/                    # 数据库连接引导页
│   ├── dashboard/                    # 工作台首页（常用模块、活动趋势、版本信息）
│   ├── scaffold/                     # 主壳：侧边栏、面包屑、DBC 导入对话框
│   ├── foxy_app/                     # FoxyApp Widget + FoxyViewModel（locale 开关）
│   ├── creature_template/            # 生物详情页 + 12 个关联表 Tab
│   ├── item/                         # 物品模板 + 附魔/掉落 Tab
│   ├── quest/                        # 任务模板 + Addon/奖励/起止点 Tab
│   ├── game_object/                  # 游戏对象模板
│   ├── gossip_menu/                  # 对话菜单 + NPC 文本
│   ├── smart_script/                 # SmartAI 脚本
│   ├── spell/                        # 法术（含 6 个关联 Tab：区域/加成/自定义属性/分组/链接/等级/掉落）
│   ├── condition/                    # 条件
│   ├── player_create_info/           # 出生信息
│   ├── setting/                      # DBC 导入 / 导出管理
│   ├── more/                         # 「更多」入口（可钉到侧边栏/收藏）
│   ├── reference_loot_template/      # 关联掉落
│   ├── page_text/                    # 页面文本（含 locale）
│   ├── area_table/                   # 区域
│   ├── emote_text/                   # 表情文本
│   ├── quest_faction_reward/         # 任务声望
│   ├── quest_sort/                   # 任务排序
│   ├── quest_info/                   # 任务信息
│   ├── item_extended_cost/           # 扩展价格
│   ├── scaling_stat_distribution/    # 属性缩放分布
│   ├── scaling_stat_value/           # 缩放属性值
│   ├── spell_item_enchantment/       # 法术附魔
│   ├── gem_property/                 # 宝石属性
│   ├── glyph_property/               # 雕文属性
│   ├── talent/                       # 天赋
│   ├── currency_type/                # 货币
│   ├── item_set/                     # 套装
│   └── achievement/                  # 成就
├── repository/                       # 数据访问层（每个文件对应一张表）
│   ├── repository_mixin.dart         # 所有 Repository 的 mixin：提供 laconic 和 kPageSize
│   ├── creature_template_repository.dart
│   ├── item_template_repository.dart
│   ├── quest_template_repository.dart
│   ├── smart_script_repository.dart
│   ├── spell_repository.dart
│   ├── loot_template_repository.dart # 通用掉落模板（creature/gameobject/item 共用）
│   └── ...（共 80+ Repository 文件）
├── router/
│   ├── router.dart                   # FoxyRouter（@AutoRouterConfig）：路由树定义
│   ├── router.gr.dart                # build_runner 自动生成的路由代码
│   ├── router_facade.dart            # RouterFacade：面包屑 + 导航 + 路径 signals
│   ├── router_menu.dart              # RouterMenu 枚举（菜单图标、中文标签、路由映射）
│   └── router_node.dart              # RouterNode 数据类（路径节点）
├── util/
│   ├── dbc_sync_util.dart            # DBC 导入/导出（含 Isolate 后台处理）
│   ├── dbc_export_registry.dart      # DBC 导出表名与列映射
│   ├── dialog_util.dart              # 全局对话框：confirm / error / success / loading
│   ├── event_bus.dart                # 发布/订阅事件总线
│   ├── format_util.dart              # 格式化工具
│   ├── item_helpers.dart             # 物品相关辅助函数
│   ├── logger_util.dart              # Logger 封装
│   ├── shared_preferences_util.dart  # SharedPreferences 封装
│   └── window_initializer.dart       # 窗口管理器初始化
├── widget/                           # 通用 UI 组件
│   ├── context_menu.dart             # 右键菜单
│   ├── foxy_card.dart                # 卡片组件
│   ├── foxy_entity_picker.dart       # 实体选择器（弹窗搜索/选择）
│   ├── foxy_entity_picker_delegates.dart
│   ├── foxy_feature_card.dart        # 功能卡片（首页/更多页）
│   ├── foxy_flag_picker.dart         # 位标记选择器
│   ├── foxy_form_item.dart           # 表单字段封装
│   ├── foxy_form_section.dart        # 表单分区
│   ├── foxy_game_asset_icon.dart     # 游戏资源图标显示
│   ├── foxy_header.dart              # 页面标题头
│   ├── foxy_locale_crud_dialog.dart  # 多语言（locale）CRUD 对话框
│   ├── foxy_locale_picker.dart       # 语言选择器
│   ├── foxy_locale_picker_delegates.dart
│   ├── foxy_number_input.dart        # 数字输入框
│   ├── foxy_pagination.dart          # 分页组件
│   ├── foxy_shad_select.dart         # 选择下拉框
│   ├── foxy_shad_table.dart          # 虚拟化数据表格
│   ├── foxy_tab.dart                 # Tab 容器
│   ├── lazy_indexed_stack.dart       # 懒加载 IndexedStack
│   └── window_button.dart            # 窗口控制按钮（最小化/最大化/关闭）
└── event/
    └── activity_logged_event.dart    # 活动日志事件

docs/
├── database_acore_world_schema.md    # acore_world 库表结构参考（622KB）
├── database_foxy_schema.md           # foxy 库表结构参考（120KB）
└── repository_crud_template.md       # Repository CRUD 约定模板（强制规范）

asset/image/                          # 图片与图标资源
config.yaml                           # 本地数据库连接配置（.gitignore，不入库）
```

---

## 关键文件角色

| 文件 | 角色 | 何时修改 |
|------|------|----------|
| `lib/main.dart` | 应用入口 | 很少改动——仅初始化顺序调整 |
| `lib/di.dart` | 依赖注入注册中心 | 新增 Repository / ViewModel 时 |
| `lib/router/router.dart` | 路由树定义（`@AutoRouterConfig`） | 新增页面路由时；改后需运行 build_runner |
| `lib/router/router_menu.dart` | 侧边栏 + 更多页菜单定义 | 新增顶级菜单入口时 |
| `lib/router/router_facade.dart` | 导航门面 + 面包屑状态 | 修改导航行为/路径逻辑时 |
| `lib/database/database.dart` | MySQL 连接单例 | 很少改动——连接/关闭逻辑 |
| `lib/database/migration_runner.dart` | 迁移框架 | 新增 Migration 类注册时 |
| `lib/repository/repository_mixin.dart` | Repository 基类 mixin | 很少改动——laconic 访问 + kPageSize |
| `lib/util/dialog_util.dart` | 全局对话框工具 | 修改对话框行为时 |
| `lib/util/dbc_sync_util.dart` | DBC 导入/导出引擎 | 新增 DBC 表或修改导入流程时 |
| `lib/page/scaffold/scaffold_page.dart` | 主外壳（侧边栏+面包屑+窗口） | 修改主布局/窗口行为时 |
| `lib/page/foxy_app/foxy_app.dart` | Material App 根组件 | 修改主题/全局配置时 |
| `config.yaml` | 数据库连接配置 | 运行时自动写入，**不入库** |

---

## 核心模式与约定

### 1. Repository CRUD 模式（强制遵循 `docs/repository_crud_template.md`）

每个 Repository：
```dart
class FooRepository with RepositoryMixin {
  static const _table = 'foo_table';

  // 公开方法顺序（严格）：
  Future<List<BriefFooEntity>> getBriefFoos({int page = 1, FooFilterEntity? filter}) async { ... }
  Future<List<FooEntity>> getFoos() async { ... }                          // 仅导出用
  Future<int> countFoos({FooFilterEntity? filter}) async { ... }
  Future<FooEntity?> getFoo(int id) async { ... }
  Future<FooEntity> createFoo() async { ... }                              // 内存占位，不落库
  Future<int> storeFoo(FooEntity entity) async { ... }                     // 新增
  Future<void> updateFoo(FooEntity entity) async { ... }
  Future<void> destroyFoo(int id) async { ... }                            // 不用 delete
  Future<void> copyFoo(int id) async { ... }
  Future<void> saveFoo(FooEntity entity) async { ... }                    // upsert
  // 分表 locale（仅世界库分表）：
  Future<List<FooLocaleEntity>> getFooLocales(int id) async { ... }
  Future<void> saveFooLocales(int id, List<FooLocaleEntity> locales) async { ... }

  // 私有方法在所有公开方法之后：
  Future<int> _getNextEntry() async { ... }
  QueryBuilder _applyFilter(QueryBuilder builder, FooFilterEntity? filter) { ... }
  void _handleReservedWords(Map<String, dynamic> json) { ... }
}
```

关键细节：
- `kPageSize = 50`（来自 `RepositoryMixin`）
- `getBrief*` LEFT JOIN locale 表以显示本地化名称
- `_applyFilter` 接受 `QueryBuilder`，链式追加 where 条件
- 文本模糊搜索：`comparator: 'like'`，值为 `'%$keyword%'`
- MySQL 保留字（如 `rank`）需在 `_handleReservedWords` 中加反引号
- 跨库 DBC 表名用全名：`'foxy.dbc_spell'`

### 2. Entity 模式

每个数据表通常有 3 个实体类：
```dart
// 1. 简要实体（列表页 + Entity Picker）
class BriefFooEntity { entry, name, localeName, ... }
// 2. 完整实体（详情/编辑页）
class FooEntity { 全部字段, fromJson, toJson, copyWith }
// 3. 筛选实体（列表页筛选表单）
class FooFilterEntity { 所有筛选字段为 String 类型 }
```

驼峰字段名（Dart 侧）↔ 数据库列名（`toJson`/`fromJson` 映射）。数值默认值通常为 `0`，字符串为 `''`。

### 3. ViewModel 模式

```dart
class FooListViewModel {
  // TextEditingController 用于筛选输入
  final entryController = TextEditingController();
  final nameController = TextEditingController();

  // signals 响应式状态
  final page = signal(1);
  final items = signal(<BriefFooEntity>[]);
  final total = signal(0);

  // 从 GetIt 获取 Repository（不是构造函数注入）
  final _repository = GetIt.instance.get<FooRepository>();

  Future<void> initSignals() async { /* 初次加载 */ }
  Future<void> search() async { page.value = 1; await _refresh(); }
  Future<void> reset() async { /* 清空筛选 → _refresh */ }
  void navigateToDetail({int? id, String? name}) { /* 通过 RouterFacade 导航 */ }

  void dispose() { /* 释放 Controllers */ }
}
```

注册规则：
- 需要持久状态的 ViewModel（如 `ScaffoldViewModel`、`FoxyViewModel`）→ **`registerSingleton`**
- 每次打开都需新实例的页面 ViewModel（大多数）→ **`registerFactory`**

### 4. 路由与导航模式

- 路由树在 `router.dart` 中通过 `@AutoRouterConfig` 定义，`build_runner` 生成 `router.gr.dart`
- **新增页面路由后必须运行**：`dart run build_runner build --delete-conflicting-outputs`
- 页面用 `@RoutePage()` 注解（`auto_route`）
- 导航**不直接使用** `AutoRouter.of(context).push()`，而是通过 `RouterFacade`：
  - **列表→详情**：`routerFacade.navigateToDetail(...)` — 自动构建面包屑路径并 push
  - **侧边栏菜单**：`routerFacade.navigateToMenu(menu)` — navigate 到顶级路由
  - **面包屑回退**：`routerFacade.navigateToBreadcrumb(index)`
  - **返回上一页**：`routerFacade.goBack()`
  - **面包屑显示**：`Watch((_) => routerFacade.path.value)` 渲染 `List<RouterNode>`
- `RouterNode` 包含 `menu`（顶层菜单枚举）、`parentMenu`（详情页归属的父菜单，用于侧边栏高亮）、`label`（显示文字）、`route`（路由对象）
- `RouterFacade.activeMenu` 从路径末端反向查找第一个有 `parentMenu`/`menu` 的节点来高亮侧边栏

### 5. 数据库与迁移

- **连接流程**：`BootstrapPage` 收集 MySQL 凭据 → `Database.instance.connect(config)` → `MigrationRunner.run()` → 检测 locale 表 → 进入主界面
- **迁移**：`MigrationRunner` 确保 `foxy` 库和 `foxy.migrations` 表存在后，按顺序执行 `List<Migration>`。已执行过的迁移（`migrations` 表有记录）自动跳过
- 新增迁移：创建 `lib/database/migration/migration_YYYYMMDDNNNN.dart`，实现 `Migration` 接口，在 `MigrationRunner.run()` 列表中注册
- `config.yaml` 存储连接信息（含密码），在 `.gitignore` 中排除

### 6. DBC 导入/导出

- **导入**：启动后若 `foxy.dbc_*` 表缺失或为空则提示。在后台 Isolate 中使用 `warcrafty` 解析 `.dbc` 文件并写入 MySQL
- **导出**：设置页支持将库内 DBC 表导出为 `.dbc` 文件
- DBC 表名清单：`requiredDbcTableNames` 常量（`dbc_sync_util.dart`）
- 进度通过信号（`dbcProgress` / `dbcProgressLabel` / `dbcProgressDetail`）实时展示

### 7. UI 约定

- **组件库**：`shadcn_ui`（导入 `package:shadcn_ui/shadcn_ui.dart`）
- **图标**：`LucideIcons.xxx`（来自 `lucide_icons_flutter`）
- **Toast**：`ShadSonner.of(context).show(ShadToast(...))`
- **对话框**：简单确认/错误/Toast 用 `DialogUtil.instance`（`confirm` / `error` / `success` / `loading` / `alert`）；自定义内容对话框用 `showFoxyDialog`（见 `lib/util/dialog_util.dart`）。**禁止**直接调用 `showShadDialog`（其默认 `opaque: true` 会让下层页面不绘制）
- **数据表格**：`FoxyShadTable`（虚拟化），配合 `FoxyPagination` 分页
- **Tab 容器**：`FoxyTab`（`tabs` + `contents` 列表）
- **平台字体**：Windows 使用 `'Microsoft YaHei UI'`，其他平台 null
- **窗口**：无边框桌面窗口，自定义标题栏（`WindowButton`）+ 拖拽（`windowManager.startDragging()`）

---

## 常用命令

```bash
# 安装依赖
flutter pub get

# 代码生成（修改 router/ 或 @RoutePage 页面后必须执行）
dart run build_runner build --delete-conflicting-outputs

# 运行（Windows 桌面）
flutter run -d windows

# 静态分析
flutter analyze

# 测试
flutter test
```

---

## 新增业务模块检查清单

按顺序执行以下步骤：

1. **`entity/`** — 新建或追加 `Brief{Name}Entity`、`{Name}Entity`、`{Name}FilterEntity`
2. **`repository/`** — 按 `docs/repository_crud_template.md` 模板实现 CRUD（`with RepositoryMixin`，方法命名/顺序严格一致）
3. **`page/<module>/`** — 创建 `{name}_list_page.dart` + `{name}_list_view_model.dart`；如需详情页，创建 `{name}_detail_page.dart` + `{name}_detail_view_model.dart`
4. **`router/router.dart`** — 在 `routes` 中添加 `AutoRoute(page: ...)` 条目
5. **`router/router_menu.dart`** — 如果是侧边栏/更多页可见菜单，在 `RouterMenu` 枚举中添加条目（含中文 label、LucideIcons、route）
6. **运行 build_runner** — `dart run build_runner build --delete-conflicting-outputs`
7. **`di.dart`** — 注册 Repository（`registerLazySingleton`）和 ViewModel（`registerFactory`）
8. **迁移（可选）** — 若需在 `foxy.features` 中添加入口记录，创建迁移文件并在 `MigrationRunner` 中注册

---

## 注意事项与陷阱

- **`build_runner`**：修改任何 `@RoutePage()` 页面或 `router.dart` 后，必须重新生成。否则 `router.gr.dart` 中的路由类不存在会导致编译失败
- **`config.yaml` 不入库**：`.gitignore` 已排除。不要提交其中的数据库密码
- **跨库查询 DBC**：在 Laconic 查询中使用全限定名 `foxy.dbc_*`（两个库在同一 MySQL 连接上）
- **`rank` 是 MySQL 保留字**：在 Repository 的 `toJson`/query 中需加反引号 `` `rank` ``（参见 `creature_template_repository.dart` 的 `_handleReservedWords`）
- **ViewModel 生命周期**：`dispose()` 中释放 `TextEditingController`；Page 的 `dispose()` 中调用 `viewModel.dispose()`
- **默认 locale**：locale join 固定使用 `'zhCN'`
- **避免 `delete` 关键词**：删除操作用 `destroy`，因为 `delete` 在某些上下文中是保留字
- **`get{s}()` vs `getBrief*`**：全量方法仅在导出场景使用。列表页和 Picker 必须走 `getBrief*` + `count*`
- **测试**：已有 DBC 导出/定义/locale、工具函数等测试；普通业务 Repository / ViewModel 覆盖仍偏少。PR 会经 CI 跑 `flutter analyze` 与 `flutter test`
- **拼写检查配置**：`codebook.toml` 包含项目专有词汇（Azeroth、DBC、NPC 等），避免被拼写检查误报
