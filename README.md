# Foxy

AzerothCore(WoW 3.3.5 模拟器)world 数据库的可视化管理工具。

Foxy 面向自建魔兽世界服务器(如 AzerothCore)的管理员与开发者,提供生物、物品、任务、法术、游戏对象、对话、SmartAI 脚本、掉落、本地化等 130 余张数据表的图形化编辑能力,同时支持 DBC 数据同步与客户端游戏图标提取,让原本依赖 SQL 与工具链的运维工作变得直观高效。

## 功能特性

- **数据表管理**:生物、物品、任务、法术、游戏对象、对话菜单、SmartAI、掉落模板、条件、天赋、宝石/雕文属性等 120+ 张 world 表,覆盖列表查询、分页筛选、详情表单、子表 Tab、复制/删除、复合主键等完整编辑链路。
- **中文本地化**:通过 locale 表 JOIN 展示简体中文名称(如生物名、物品名),可编辑 `*_locale` 表与 DBC 宽表的 16 语言字段。
- **DBC 同步**:导入/导出客户端 DBC 文件(约 50 张表,基于 warcrafty 解析),后台 isolate 执行,支持进度显示、取消与完整性校验(行数、重复 ID、列结构兼容)。
- **图标提取**:从客户端 MPQ 归档提取游戏图标(BLP 解码,支持 DXT1/3/5),本地缓存并支持内存 LRU 复用,界面直接展示图标。
- **活动日志**:所有创建/更新/删除/复制操作统一记录到 `foxy.activity_log`,工作台可查看最近动态。
- **自动更新**:启动时检查新版本,支持 SHA-256 校验下载、断点取消、重启后自动替换(便携 zip 分发,无安装器)。
- **新手向导**:首次运行三步引导——连接数据库 → DBC 同步 → 图标提取。
- **桌面体验**:无边框窗口、窗口尺寸记忆、右侧键菜单、面包屑导航、快捷键(退出/设置)。

## 技术栈

- **Flutter Desktop**(Windows 为主,macOS / Linux 亦构建)
- **Dart 3.9.2+** / Flutter 3.44.x stable
- **laconic + laconic_mysql**:查询构建器与 MySQL 驱动
- **signals / signals_flutter**:响应式状态管理
- **shadcn_ui + lucide_icons_flutter**:界面组件
- **auto_route**:声明式路由;**get_it**:依赖注入
- **build_runner + source_gen**:自研代码生成器
- **warcrafty**:DBC/MPQ/BLP 解析

## 仓库结构

本仓库是 Dart pub workspace monorepo,包含四个包:

```
foxy/
├── packages/
│   ├── foxy/                 # Flutter 应用(唯一可运行包)
│   │   ├── lib/              # 应用源码(见下方架构)
│   │   ├── test/             # 91 个测试文件
│   │   ├── tool/             # 发布工具与更新器
│   │   └── windows|linux|macos/  # 平台工程
│   ├── foxy_annotation/      # 代码生成注解定义(Entity/Repository/ViewModel)
│   ├── foxy_generator/       # source_gen 代码生成器(读注解,产出 .g.dart)
│   └── foxy_lint/            # 项目专属 analyzer 插件(9 条 lint 规则)
├── doc/codegen/              # 代码生成系统文档
└── pubspec.yaml              # workspace 根
```

## 架构概览

核心设计:**注解声明 + 代码生成**。手写代码只通过 `@Foxy*` 注解声明"表是什么",机械样板(列表行 DTO、完整实体、仓库 CRUD、表单控制器、ViewModel 信号)由三个 build_runner builder 生成到 `.g.dart` part 文件,手写类通过 `with` 混入生成的 mixin。

```
Page (Watch 订阅) ──► ViewModel (signals + 表单控制器) ──► UseCase / Repository ──► MySQL
                                                        └──► EventBus ──► ActivityLogListener ──► foxy.activity_log
```

- **Entity**:`@FoxyBriefEntity` / `@FoxyFullEntity` 声明表结构,物理列名只在此出现一次。
- **Repository**:`@FoxyRepository` / `@FoxyFilter` 生成分页查询、过滤、CRUD 与 `linkKey` 子表查询层。
- **ViewModel**:`@FoxyListViewModel` / `@FoxyDetailViewModel` 等生成列表/表单状态与控制器。
- **UseCase**:跨表事务逻辑(对话菜单、locale 同步等)手写,注入 `DatabaseTransaction`。

## 快速开始

### 环境要求

- Flutter 3.44.x stable(Dart SDK ^3.9.2)
- MySQL 5.7+ / 8.x(建议 utf8mb4;应用会自建 `foxy` 元数据库)

### 运行

```bash
cd packages/foxy
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # 重新生成 .g.dart(耗时数分钟)
flutter analyze
flutter test
flutter run -d windows
```

> 注:根目录为 workspace,所有 Flutter 命令请在 `packages/foxy` 下执行;代码生成器与 lint 包的纯 Dart 测试分别用 `cd packages/foxy_generator && dart test`、`cd packages/foxy_lint && dart test`。

### 配置

运行时工作目录下的 `config.yaml`(gitignored)保存数据库连接与客户端路径:

```yaml
host: 127.0.0.1
port: 3306
database: acore_world
username: acore
password: acore
use_ssl: false
locale_enabled: true
dbc_path: D:/Simulators/Client
client_dir: D:/Simulators/Client
icons_extracted: true
```

缺少 `config.yaml` 时应用会进入引导向导,向导完成即自动生成该文件。

## 测试

共 110 个 Dart 测试文件:

- **game_data 测试**(`test/game_data/`):枚举/标志常量与 AzerothCore 服务端取值一致性,纯内存运行。
- **database_editing 测试**(`test/database_editing/`):复合主键值语义、编辑流程、查询构建行为,纯内存运行。
- **identity 测试**(`test/identity/`):身份/状态保持语义(活动日志 ID、locale 草稿、路由面包屑)。
- **基础设施测试**:更新服务、DBC 编解码、BLP/MPQ、表单控制器、use case、widget 行为。
- **DB 集成测试**(`test/dbc_mysql_integration_test.dart`):需 `FOXY_TEST_MYSQL=1` 且 `FOXY_TEST_MYSQL_FOXY_SCHEMA` 指向隔离 schema 才运行,否则自动跳过。
- **生成器测试**(`packages/foxy_generator/test/`):`dart test` 纯 Dart 运行。
- **lint 测试**(`packages/foxy_lint/test/`):analyzer 官方测试框架。

## 构建与发布

发布流水线(`.github/workflows/release.yml`)默认由推送 `v*` tag 触发,也可在 Actions 页面手动触发(填 release tag 重跑):

1. 手动 bump `packages/foxy/pubspec.yaml` 的 `version`,并在 `CHANGELOG.md` 补 `## vX.Y.Z` 段(流水线读取该段作为更新说明);
2. 打 tag 并推送:`git tag vX.Y.Z && git push origin vX.Y.Z`;
3. 单 job CI 依次执行:analyze + 三包测试 gate → `flutter build windows --release` → 编译更新器 → 打包 zip → 生成 `latest.yaml`(含 SHA-256,保留最近 3 条) → 发布 GitHub Release。同一 tag 重复推送会自动取消旧 run。

更新入口固定为 `releases/latest/download/latest.yaml`,应用启动时自动检查(24 小时内不重复),也可在设置页手动检查。

## 文档

- [doc/codegen/README.md](doc/codegen/README.md) — 代码生成系统架构
- [doc/codegen/usage.md](doc/codegen/usage.md) — 模块开发指南
- [doc/codegen/generators.md](doc/codegen/generators.md) — 生成器实现详解
- [doc/codegen/extending.md](doc/codegen/extending.md) — 扩展生成器

## 许可

[MIT](LICENSE) © 2026 Cals Ranna
