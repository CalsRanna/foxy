# AGENTS.md

This file provides guidance to coding agent when working with code in this repository.

## 项目概述

Foxy 是一个 Flutter 桌面应用，用于可视化管理 AzerothCore（魔兽世界服务端）的 MySQL 数据库。支持生物、物品、任务、法术、对话等游戏数据的 CRUD 操作。

## 技术栈

- **Flutter 桌面端** (macOS/Windows/Linux), SDK ^3.9.2
- **状态管理**: signals + signals_flutter (响应式 signal 原语)
- **依赖注入**: get_it (全局 Service Locator)
- **路由**: auto_route (代码生成路由)
- **数据库**: MySQL, 通过 mysql_client 连接, laconic 自定义查询构建器
- **UI 组件**: shadcn_ui
- **窗口管理**: window_manager (桌面端)

## 常用命令

```bash
flutter run                        # 开发运行
flutter analyze                    # 静态分析
flutter test                       # 运行测试
flutter build macos                # 构建 macOS 应用

# 修改 auto_route 路由配置后需要重新生成代码
dart run build_runner build
dart run build_runner build --delete-conflicting-outputs   # 强制重新生成
```

## 架构

```
lib/
├── entity/          # 数据实体 (fromJson/toJson, 纯数据类)
├── repository/      # 数据访问层, 通过 RepositoryMixin 获取 laconic 实例
├── page/            # 页面 + ViewModel (MVVM, 同目录内聚)
├── widget/          # 可复用 UI 组件 (FoxyShadTable, FoxyHeader, form_item 等)
├── router/          # auto_route 路由配置 + RouterFacade (面包屑导航)
├── database/        # 数据库迁移系统 (MigrationRunner)
├── constant/        # 静态常量 (flags, enums)
├── util/            # 工具类 (DialogUtil, WindowInitializer, logger 等)
└── di.dart          # GetIt 依赖注册中心
```

### MVVM 模式

每个功能模块在 `lib/page/<module>/` 下组织：
- `*_list_page.dart` + `*_list_view_model.dart` — 列表页, ViewModel 用 `registerLazySingleton` 注册
- `*_detail_page.dart` + `*_detail_view_model.dart` — 详情/编辑页, ViewModel 用 `registerFactory` 注册
- `*_view.dart` + `*_view_model.dart` — 详情页内的子 Tab 视图

ViewModel 通过 `GetIt.instance.get<T>()` 获取, 使用 signals 的 `signal()` 管理响应式状态。Widget 层用 `Watch((_) => ...)` 订阅 signal 变化。

### 实体与 Repository

- **Entity**: 纯数据类, 字段对应 MySQL 列名 (snake_case), 包含 `fromJson(Map)` 工厂构造函数和 `toJson()` 方法
- **Brief 实体** (如 `BriefCreatureTemplateEntity`): 列表页与 Entity Picker **共用**的精简版实体；**Brief ≡ 分页列表列集**，Picker 列 ⊆ Brief
- **Filter 实体** (如 `CreatureTemplateFilterEntity`): 列表与 Picker 共用的筛选条件
- **Repository**: 通过 `RepositoryMixin` 混入, 从 `Database.instance.laconic` 获取 Laconic 实例, 统一 `kPageSize = 50` 分页。**一表一 Repository**（`static const _table`，无主从分类）。完整 CRUD 契约见 [`docs/repository_crud_template.md`](docs/repository_crud_template.md)。方法命名约定:
  - 分页精简列表: `getBrief{Entities}({int page = 1, FilterEntity? filter})` — **仅**列表页 / Picker；可 `leftJoin` 关联展示列
  - 全量完整列表: `get{Entities}()` — **全列全行、无 page/filter**；供 DBC 导出等批处理，**禁止**给 UI 列表用
  - 计数: `count{Entities}({FilterEntity? filter})` — 与 `getBrief*` 共用 filter / join
  - 单条: `get{Entity}(...)` → `Future<{Entity}Entity?>` — 用 `.limit(1).get()` 空→null（勿用 laconic `first()`，会抛）；复合主键**多参数**，禁止 `Map`
  - 内存占位: `create{Entity}()` — 不落库
  - 插入: `store{Entity}(semanticName)` — 参数用语义名；自动主键返回 `Future<int>`
  - 更新: `update{Entity}(...)`
  - 删除: `destroy{Entity}(...)` — 不用 `delete*`
  - 复制: `copy{Entity}(...)` → `Future<void>`
  - Upsert: `save{Entity}(...)` — 主键 0→store；否则 get 后 update 或按给定主键 insert
  - 分表 locale（过渡）: `get{Entity}Locales` / `save{Entity}Locales`；DBC 同表多语言列无 Locale Repository
  - LIKE: 始终 `comparator: 'like'`，值为 `'%$kw%'`
  - 公开方法顺序: getBrief → get*s → count → get → create → store → update → destroy → copy → save → locales → 其它公开辅助
  - 私有方法顺序: `_getNextId` / `_getNextEntry` → `_applyFilter` → 其它

### 数据库层

- `config.yaml`: MySQL 连接配置 (`host`, `port`, `database`, `username`, `password`, 可选 `dbc_path`、`locale_enabled`)
- `lib/database/database.dart`: `Database` 单例 (`Database.instance`), 封装 `Laconic` 实例, 提供 `connect(MysqlConfig)` / `close()` / `laconic` getter
- `lib/database/migration_runner.dart`: `MigrationRunner` 按时间戳顺序执行 migration, 通过 `foxy.migrations` 表跟踪已执行迁移; 迁移创建 `foxy.features`、`foxy.activity_log` 等自用表并写入模块种子数据
- `lib/database/migration/`: 迁移脚本 (命名 `migration_<YYYYMMDDHHMM>.dart`), 新增迁移需在 `MigrationRunner.run()` 的列表中按顺序注册
- `repository/repository_mixin.dart`: `RepositoryMixin` 通过 `Database.instance.laconic` 获取 Laconic 实例并定义 `kPageSize = 50`, 所有 Repository 混入此 mixin
- `util/dbc_sync_util.dart`: `DbcSyncUtil` 封装 DBC 文件导入 (worker isolate 内执行), 写入 30 个 `foxy.dbc_*` 表, 由 `ScaffoldViewModel` 消费进度流

### 路由

- `lib/router/router.dart`: `@AutoRouterConfig` 注解的根路由配置, 生成 `router.gr.dart`
- `lib/router/router_menu.dart`: 侧边栏菜单枚举, 每个菜单项对应路由
- `lib/router/router_facade.dart`: 封装面包屑导航逻辑 (path signal, navigateToDetail, goBack, navigateToBreadcrumb)
- `lib/router/router_node.dart`: 面包屑中的单个节点

### 依赖注入 (lib/di.dart)

`DI.ensureInitialized()` 在 `main()` 中调用, 集中注册所有 ViewModel:
- `registerSingleton`: `RouterFacade`, `FoxyViewModel`, `ScaffoldViewModel` (ScaffoldViewModel 聚合功能模块清单与 DBC 导入状态)
- `registerLazySingleton`: 列表页 ViewModel + 各 Repository (保持分页状态)
- `registerFactory`: 详情页 ViewModel + 子 Tab ViewModel (每次创建新实例)
