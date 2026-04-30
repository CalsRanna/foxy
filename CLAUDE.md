# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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
- **Brief 实体** (如 `BriefCreatureTemplateEntity`): 列表页用的精简版实体, 通过 LEFT JOIN locale 表获取本地化字段
- **Filter 实体** (如 `CreatureTemplateFilterEntity`): 封装列表筛选条件
- **Repository**: 通过 `RepositoryMixin` 混入获得 `laconic` 实例和 `kPageSize = 50` 常量

### 数据库层

- `config.yaml`: MySQL 连接配置 (`host`, `port`, `database`, `username`, `password`)
- `lib/database/migration_runner.dart`: 按顺序执行 migration, 通过 `foxy.migrations` 表跟踪已执行的迁移
- `repository/repository_mixin.dart`: 从 `FoxyViewModel` 获取 `Laconic` 实例, 所有 Repository 混入此 mixin

### 路由

- `lib/router/router.dart`: `@AutoRouterConfig` 注解的根路由配置, 生成 `router.gr.dart`
- `lib/router/router_menu.dart`: 侧边栏菜单枚举, 每个菜单项对应路由
- `lib/router/router_facade.dart`: 封装面包屑导航逻辑 (path signal, navigateToDetail, goBack, navigateToBreadcrumb)
- `lib/router/router_node.dart`: 面包屑中的单个节点

### 依赖注入 (lib/di.dart)

`DI.ensureInitialized()` 在 `main()` 中调用, 集中注册所有 ViewModel:
- `registerSingleton`: `RouterFacade`, `FoxyViewModel`, `DbcImportViewModel`
- `registerLazySingleton`: 列表页 ViewModel (保持分页状态)
- `registerFactory`: 详情页 ViewModel (每次创建新实例)
