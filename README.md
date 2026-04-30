# Foxy

基于 Flutter 的 AzerothCore 数据库可视化管理工具。通过跨平台桌面应用，提供对魔兽世界服务端全部核心游戏数据的编辑管理能力。连接 MySQL 数据库，支持直接读写 creature_template、item_template、quest_template 等 AzerothCore 核心表，并提供 DBC 文件导入、数据本地化编辑、操作日志追踪等高级功能。

## 功能模块

### 生物模板 (creature_template)
编辑生物属性、阵营、战斗数值、移动速度、掉落、标识位等全部字段。关联子表通过标签页管理：
- 模板补充 (creature_template_addon)、击杀声望 (creature_onkill_reputation)
- 抗性 (creature_template_resistance)、技能 (creature_template_spell)
- 装备模板 (creature_equip_template)、任务物品 (creature_quest_item)
- 商人 (npc_vendor)、训练师 (npc_trainer)
- 击杀掉落 (creature_loot_template)、偷窃掉落 (pickpocketing_loot_template)、剥皮掉落 (skinning_loot_template)

### 物品模板 (item_template)
编辑物品基础属性。关联子表：
- 附魔模板 (item_enchantment_template)、物品掉落 (item_loot_template)
- 分解掉落 (disenchant_loot_template)、选矿掉落 (prospecting_loot_template)
- 研磨掉落 (milling_loot_template)

### 任务模板 (quest_template)
编辑任务定义。关联子表：
- 模板补充 (quest_template_addon)、提交物品 (quest_request_items)、发放奖励 (quest_offer_reward)
- 开始生物 (creature_queststarter)、结束生物 (creature_questender)
- 开始物体 (gameobject_queststarter)、结束物体 (gameobject_questender)

### 游戏对象模板 (gameobject_template)
编辑游戏对象定义及掉落、任务物品子表。

### 法术 (spell)
法术基础属性编辑。关联子表：
- 附魔 (spell_item_enchantment)、范围 (spell_range)、时长 (spell_duration)
- 效果加成 (spell_bonus_data)、自定义属性 (spell_custom_attr)、区域 (spell_area)
- 分组 (spell_group)、关联法术 (spell_linked_spell)、等级 (spell_rank)
- 掉落 (spell_loot_template)

### 对话菜单 (gossip_menu)
编辑 NPC 对话菜单，关联对话选项 (gossip_menu_option) 和 NPC 文本 (npc_text)。

### 智能脚本 (smart_scripts)
管理 AI 行为脚本的事件、条件、动作定义。

### 其他模块
| 模块 | 说明 |
|------|------|
| 关联掉落 | reference_loot_template 统一管理 |
| 页面文本 | page_text 及多语言本地化 |
| 条件 | condition 表，用于各类条件判断 |
| 出生信息 | player_create_info，管理角色创建数据 |
| 区域 | area_table 区域定义 |
| 表情文本 | emote_text 表情动画文本 |
| 任务声望 | quest_faction_reward 任务阵营声望奖励 |
| 任务排序 | quest_sort 任务排序配置 |
| 任务信息 | quest_info 任务难度提示信息 |
| 扩展价格 | item_extended_cost 物品扩展消耗 |
| 属性缩放分布 | scaling_stat_distribution |
| 法术附魔 | spell_item_enchantment |
| 宝石属性 | gem_properties (DBC 数据) |
| 雕文属性 | glyph_properties (DBC 数据) |

### 系统功能
- **工作台首页**: 显示服务器版本信息、数据库版本、操作趋势统计、常用模块快捷入口
- **侧边栏定制**: 在"更多"页面中可将任意模块固定到侧边栏或收藏到首页
- **面包屑导航**: 多级路径导航，支持点击任意层级跳转
- **DBC 导入**: 自动从客户端 DBC 文件导入 46 个数据表（阵营、技能、图标、载具等）以增强数据展示
- **操作日志**: 记录增删改操作历史，首页展示趋势图
- **多语言支持**: 支持 locale 本地化表编辑（简体中文等）
- **设置**: 基本设置 + 数据库连接配置

## 技术栈

| 类别 | 技术 |
|------|------|
| 框架 | Flutter (macOS / Windows / Linux) |
| Dart SDK | ^3.9.2 |
| 状态管理 | signals (^6.0.2) + signals_flutter |
| 依赖注入 | get_it (^9.0.5) |
| 路由 | auto_route (^10.2.0) |
| 数据库驱动 | mysql_client (^0.0.27) |
| 查询构建器 | laconic (^2.2.0) + laconic_mysql (^1.2.0) |
| UI 组件库 | shadcn_ui (^0.43.0) |
| 图标库 | lucide_icons_flutter (^3.1.6) |
| 桌面窗口 | window_manager (^0.5.1) |
| DBC 解析 | warcrafty (^1.0.1) |
| 配置管理 | yaml (^3.1.3) + yaml_edit (^2.2.2) |
| 并发控制 | pool (^1.5.2) |
| 文件选择 | file_selector (^1.1.0) |
| 本地存储 | shared_preferences (^2.3.5) |
| 应用信息 | package_info_plus (^9.0.0) |

## 环境要求

- Flutter SDK ^3.9.2
- MySQL 数据库（AzerothCore 结构，包含 acore_world 数据库）
- DBC 文件目录（可选，用于数据增强功能）

## 快速开始

```bash
# 1. 安装依赖
flutter pub get

# 2. 生成 auto_route 路由代码（首次运行或修改路由后必做）
dart run build_runner build

# 3. 在项目根目录创建 config.yaml（参见下方配置说明）

# 4. 运行
flutter run
```

## 配置文件

在项目根目录创建 `config.yaml`：

```yaml
host: 127.0.0.1          # MySQL 主机地址
port: "3306"              # MySQL 端口
database: acore_world     # AzerothCore world 数据库名
username: acore           # 数据库用户名
password: acore           # 数据库密码
dbc_path: /path/to/dbc    # (可选) DBC 文件目录路径
```

首次启动时，应用会显示引导页面，可在此界面填写连接信息。配置会自动保存到 `config.yaml`。

`dbc_path` 指向客户端 DBC 文件所在目录（如 `D:\Simulators\AzerothCore\code\env\dist\dbc`），配置后应用启动时会将 46 个 DBC 数据文件导入到 `foxy.dbc_*` 表中，用于下拉选择器等数据增强展示。

## 项目结构

```
lib/
├── entity/                          # 数据实体，对应 MySQL 表结构
│   ├── *_entity.dart                #   完整实体（fromJson / toJson）
│   ├── *_filter_entity.dart         #   列表筛选条件实体
│   └── *_locale_entity.dart         #   本地化表实体
├── repository/                      # 数据访问层（Repository 模式）
│   ├── repository_mixin.dart        #   混入提供 laconic 实例和 kPageSize 常量
│   ├── *_repository.dart            #   各模块数据库操作（CRUD + 分页查询）
│   └── setting_repository.dart      #   设置相关查询
├── page/                            # 页面模块（MVVM，Page + ViewModel 同目录）
│   ├── bootstrap/                   #   数据库连接引导页（配置填写 + 版本检测）
│   │   ├── bootstrap_page.dart
│   │   ├── bootstrap_view_model.dart
│   │   ├── bootstrap_simulator_form.dart
│   │   └── bootstrap_window_header.dart
│   ├── scaffold/                    #   主窗架（侧边栏 + 面包屑 + 窗口管理 + DBC 导入）
│   │   ├── scaffold_page.dart
│   │   ├── scaffold_view_model.dart
│   │   └── dbc_import_view_model.dart
│   ├── dashboard/                   #   工作台首页
│   │   ├── dashboard_page.dart
│   │   ├── dashboard_view_model.dart
│   │   └── component/               #   首页子组件（欢迎、版本、趋势、常用模块、简介）
│   ├── foxy_app/                    #   应用入口组件
│   │   ├── foxy_app.dart            #   ShadApp.router 配置
│   │   └── foxy_view_model.dart     #   全局状态（laconic 实例、locale 设置）
│   ├── creature_template/           #   生物模板（详情页 12 个子 Tab）
│   │   ├── creature_template_list_page.dart
│   │   ├── creature_template_list_view_model.dart
│   │   ├── creature_template_detail_page.dart
│   │   ├── creature_template_detail_view_model.dart
│   │   ├── creature_template_view.dart     #   主属性表单
│   │   ├── creature_template_addon_view.dart
│   │   ├── creature_equip_template_view.dart
│   │   ├── creature_loot_template_view.dart
│   │   ├── ...                              #   其他子 Tab 视图
│   │   └── *_selector.dart                  #   关联数据选择器组件
│   ├── item/                         #   物品模板（同理）
│   ├── item_template/               #   物品模板（详情页 6 个子 Tab）
│   ├── quest/                       #   任务模板（详情页 8 个子 Tab）
│   ├── game_object/                 #   游戏对象模板
│   ├── spell/                       #   法术
│   ├── gossip_menu/                 #   对话菜单
│   ├── smart_script/                #   智能脚本
│   ├── setting/                     #   设置页（基本设置 / 数据库设置子路由）
│   ├── more/                        #   更多模块页（网格展示 + 搜索 + 固定/收藏）
│   ├── reference_loot_template/     #   关联掉落
│   ├── page_text/                   #   页面文本
│   ├── condition/                   #   条件
│   ├── player_create_info/          #   出生信息
│   ├── area_table/                  #   区域
│   ├── emote_text/                  #   表情文本
│   ├── quest_faction_reward/        #   任务声望
│   ├── quest_sort/                  #   任务排序
│   ├── quest_info/                  #   任务信息
│   ├── item_extended_cost/          #   扩展价格
│   ├── scaling_stat_distribution/   #   属性缩放分布
│   ├── spell_item_enchantment/      #   法术附魔
│   ├── gem_property/                #   宝石属性
│   └── glyph_property/              #   雕文属性
├── view_model/                      # 全局 ViewModel
│   └── feature_view_model.dart      #   功能模块管理（固定/收藏/列表）
├── widget/                          # 可复用 UI 组件
│   ├── foxy_shad_table.dart         #   表格组件（支持双击编辑、右键菜单、固定表头）
│   ├── header.dart                  #   页面标题组件
│   ├── pagination.dart              #   分页组件（每页 50 条）
│   ├── form_item.dart               #   表单行组件（label + input）
│   ├── flag_picker.dart             #   位标识选择器（多选位标志）
│   ├── foxy_shad_select.dart        #   下拉选择器扩展
│   ├── context_menu.dart            #   右键菜单
│   ├── card.dart                    #   卡片组件
│   ├── tab.dart                     #   标签页容器（基于 expandable_page_view）
│   └── window_button.dart           #   自定义窗口按钮
├── router/                          # 路由系统
│   ├── router.dart                  #   @AutoRouterConfig 根配置
│   ├── router_menu.dart             #   侧边栏菜单枚举（RouterMenu, 含图标和标签）
│   ├── router_facade.dart           #   路由门面（面包屑 path signal + 导航方法）
│   ├── router_node.dart             #   面包屑节点数据类
│   └── router.gr.dart               #   auto_route 生成的路由代码（build_runner 生成）
├── database/                        # 数据库迁移
│   ├── migration_runner.dart        #   迁移执行器（按时间戳顺序执行）
│   └── migration/                   #   迁移脚本（创建 foxy 自用表）
├── constant/                        # 常量定义
│   ├── creature_flags.dart          #   生物 flags 位标识选项（npcflag, unit_flags 等）
│   └── gossip_menu_option_constants.dart
├── util/                            # 工具类
│   ├── dialog_util.dart             #   对话框工具（loading / confirm / success / error）
│   ├── logger_util.dart             #   日志工具（基于 logger 包）
│   ├── window_initializer.dart      #   窗口初始化（尺寸记忆、透明背景、无系统标题栏）
│   ├── shared_preferences_util.dart #   本地存储工具
│   └── item_helpers.dart            #   物品辅助函数
└── di.dart                          # GetIt 依赖注入注册中心（所有 ViewModel 集中注册）
```

## 开发命令

```bash
flutter run                          # 开发运行（默认 macOS）
flutter run -d windows               # Windows 平台运行
flutter analyze                      # 静态分析（基于 flutter_lints）
flutter test                         # 运行测试
flutter build macos                  # 构建 macOS 应用
flutter build windows                # 构建 Windows 应用
flutter clean                        # 清理构建产物
dart run build_runner build          # 生成 auto_route 路由代码
dart run build_runner build --delete-conflicting-outputs  # 强制重新生成（覆盖冲突）
```

## 架构

### 分层架构

```
UI (Page + Widget)
    ↓ Watch(signal) / navigate
ViewModel (signals 状态 + 业务逻辑)
    ↓ Repository
Repository (laconic 查询构建)
    ↓ mysql_client
MySQL (AzerothCore)
```

### MVVM 模式

每个功能模块由 **Page** 和 **ViewModel** 组成，同目录内聚：

- **Page** (`StatefulWidget`): 负责 UI 布局，通过 `GetIt.instance.get<T>()` 获取 ViewModel，使用 `Watch((_) => ...)` 订阅 signal 变化自动重建。
- **ViewModel**: 包含所有业务逻辑。通过 `signal()` / `listSignal()` 管理响应式状态。处理表单数据、列表分页、CRUD 操作、操作日志记录。

列表页 ViewModel 通过 `registerLazySingleton` 注册（保持分页状态），详情页 ViewModel 通过 `registerFactory` 注册（每次创建新实例）。

### Entity / Repository 模式

- **Entity**: 纯数据类，每个类通过 `fromJson(Map<String, dynamic>)` 工厂构造函数从数据库行构建，提供 `toJson()` 序列化回去。字段名保持与 MySQL 列名一致（snake_case）。
- **Brief 实体** (如 `BriefCreatureTemplateEntity`): 列表页精简版，JOIN locale 表获取本地化字段，`displayName` / `displaySubName` getter 优先展示本地化值。
- **Filter 实体** (如 `CreatureTemplateFilterEntity`): 封装列表筛选参数。
- **Repository**: 通过 `RepositoryMixin` 混入获得 `laconic` (Laconic 查询构建器) 和 `kPageSize = 50`。所有查询通过 laconic 的链式 API（`.select()`, `.where()`, `.leftJoin()`, `.limit()`, `.offset()`）构建。

### 依赖注入 (DI)

全部依赖在 `lib/di.dart` 的 `DI.ensureInitialized()` 中注册，`main()` 启动时调用：

```
main() → WindowInitializer.ensureInitialized() → DI.ensureInitialized() → runApp(FoxyApp())
```

注册层次：
- **Singleton**: `RouterFacade`, `FoxyViewModel`, `DbcImportViewModel`（全局唯一）
- **LazySingleton**: 列表页 ViewModel（首次访问时创建，保持分页状态）
- **Factory**: 详情页 ViewModel、子 Tab ViewModel（每次获取新建实例）

### 路由系统

`lib/router/router.dart` 是 `@AutoRouterConfig` 注解的根配置。路由结构：

```
/ → BootstrapPage (初始页)
  └─ ScaffoldRoute (主窗架，内部嵌套 AutoRouter)
       ├─ DashboardRoute (首页)
       ├─ CreatureTemplateListRoute (列表页)
       ├─ CreatureTemplateDetailRoute (详情页，可选参数 entry/name)
       ├─ ItemTemplateListRoute / ItemTemplateDetailRoute
       └─ ... (其他模块同模式)
```

`RouterFacade` 维护面包屑导航状态 (`signal<List<RouterNode>>`)，提供 `navigateToMenu`、`navigateToDetail`、`goBack`、`navigateToBreadcrumb` 等方法。侧边栏菜单定义在 `RouterMenu` 枚举中，每个枚举值关联页面路由、Lucide 图标和中文标签。

### 数据库层

应用连接后自动运行 `MigrationRunner`，在目标数据库中创建 `foxy` 数据库和 `foxy.migrations` 追踪表。迁移按时间戳顺序执行，已执行的迁移会被跳过。

DBC 导入在独立 `Isolate` 中运行，使用 `warcrafty` 包解析 DBC 文件，通过 laconic 写入 `foxy.dbc_*` 表。6 个并发连接池 + 每批 200 行批量插入。导入完成后记录 `dbc_import_timing.log` 耗时统计。
