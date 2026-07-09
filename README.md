# Foxy

**AzerothCore 数据库可视化管理工具** — 用桌面端图形界面管理生物、物品、任务、法术等 World of Warcraft 服务端游戏数据。

> 基于 Flutter 重构，目标是做最好用的魔兽世界（AzerothCore）数据编辑器。

---

## 功能特性

### 核心数据管理

| 模块 | 说明 |
|------|------|
| **生物 (Creature)** | 模板、补充数据、抗性、技能、装备、击杀声望、商人/训练师、掉落（击杀/偷窃/剥皮） |
| **物品 (Item)** | 模板、附魔、分解/勘探/研磨掉落等 |
| **任务 (Quest)** | 模板、Addon、接取/交还、奖励文本、生物/物体起止点 |
| **游戏对象 (GameObject)** | 模板、Addon、任务物品、掉落 |
| **对话 (Gossip)** | 菜单、选项、NPC 文本及本地化 |
| **内建脚本 (SmartAI)** | `smart_scripts` 列表与详情编辑 |
| **法术 (Spell)** | 法术本体及相关：区域、加成、自定义属性、分组、链接、等级、掉落等 |
| **条件 (Conditions)** | 条件类型与动态取值配置 |
| **出生信息** | 角色创建数据、物品、动作、自定义法术 |

### 扩展与 DBC 数据

支持更多模块（通过「更多」入口访问，可钉到侧边栏 / 收藏到工作台）：

- 关联掉落、页面文本、区域、表情文本
- 任务声望 / 排序 / 信息
- 扩展价格、属性缩放分布与缩放属性值
- 法术附魔、宝石属性、雕文属性
- 天赋、货币、套装、成就

### 其它能力

- **DBC 导入 / 导出**：从客户端 DBC 目录导入到 MySQL（`foxy.dbc_*`），或将库内数据导出为 `.dbc` 文件
- **多语言 (Locale)**：检测世界库 `*_locale` 表后可开关本地化显示（如 zhCN）
- **工作台**：常用模块、最近活动趋势、核心/数据库/软件版本信息
- **功能收藏与钉选**：侧边栏与首页可自定义常用入口
- **无边框桌面窗口**：窗口尺寸记忆、自定义标题栏

---

## 技术栈

| 类别 | 选型 |
|------|------|
| 框架 | [Flutter](https://flutter.dev) / Dart 3.9+ |
| UI | [shadcn_ui](https://pub.dev/packages/shadcn_ui)、Lucide Icons |
| 状态 | [signals](https://pub.dev/packages/signals) / signals_flutter |
| 依赖注入 | [get_it](https://pub.dev/packages/get_it) |
| 路由 | [auto_route](https://pub.dev/packages/auto_route) |
| 数据库 | MySQL（[laconic](https://pub.dev/packages/laconic) + laconic_mysql） |
| DBC | [warcrafty](https://pub.dev/packages/warcrafty) |
| 桌面窗口 | window_manager |
| 配置 | YAML（`config.yaml`） |

**目标平台**：优先 Windows 桌面；工程同时包含 Linux / macOS 等平台脚手架。

**服务端目标**：[AzerothCore](https://www.azerothcore.org/) 的 `acore_world`（及兼容结构的世界库）。

---

## 架构概览

采用 **Page + ViewModel + Repository + Entity** 分层：

```
┌─────────────────────────────────────────────┐
│  Page / Widget（UI，auto_route 路由页面）     │
├─────────────────────────────────────────────┤
│  ViewModel（signals 状态，GetIt 注入）        │
├─────────────────────────────────────────────┤
│  Repository（统一 CRUD，RepositoryMixin）     │
├─────────────────────────────────────────────┤
│  Entity / Filter Entity                     │
├─────────────────────────────────────────────┤
│  Database（Laconic → MySQL）                 │
│    · acore_world：游戏世界数据                │
│    · foxy：应用元数据 + DBC 镜像表            │
└─────────────────────────────────────────────┘
```

### 关键约定

- **一张表一个 Repository**，公开 API 统一为：  
  `getBrief*` / `get*s` / `count*` / `get*` / `create*` / `store*` / `update*` / `destroy*` / `copy*` / `save*`
- 列表页与实体选择器（Entity Picker）共用 **Brief 实体 + 分页**；全量 `get{Entities}` 主要用于 DBC 导出等批处理
- 连接成功后自动运行 **MigrationRunner**，创建/升级 `foxy` 库（features、migrations、DBC 相关表等）

更细的 Repository 约定见 [`docs/repository_crud_template.md`](docs/repository_crud_template.md)。

---

## 环境要求

- [Flutter SDK](https://docs.flutter.dev/get-started/install)（与 `pubspec.yaml` 中 `sdk: ^3.9.2` 匹配）
- MySQL 5.7+ / 8.x（可访问 AzerothCore 世界库）
- 已部署的 **AzerothCore**（或等价）`acore_world` 数据库
- （可选）客户端 **DBC** 目录，用于首次导入成就、法术、区域等客户端表数据

---

## 快速开始

### 1. 克隆与依赖

```bash
git clone https://github.com/CalsRanna/foxy.git
cd foxy
flutter pub get
```

### 2. 代码生成（路由等）

修改 `lib/router/` 或带 `@RoutePage` 的页面后，需要重新生成：

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. 运行

```bash
# Windows 桌面（推荐）
flutter run -d windows

# 或其它已配置的桌面目标
flutter run -d linux
flutter run -d macos
```

### 4. 连接数据库

启动后进入 **引导页**，填写 MySQL 连接信息并连接：

| 项 | 示例 |
|----|------|
| 地址 | `127.0.0.1` |
| 端口 | `3306` |
| 数据库 | `acore_world` |
| 用户名 / 密码 | 你的 MySQL 账号 |

连接成功后会：

1. 写入工作目录下的 `config.yaml`（该文件已在 `.gitignore` 中，勿提交密钥）
2. 确保存在 `foxy` 库并执行迁移
3. 检测 locale 表并进入主界面

### 5. 导入 DBC（推荐）

进入主界面后，若所需 `foxy.dbc_*` 表缺失或为空，会提示配置 **DBC 目录** 并导入。也可在 `config.yaml` 中预先配置：

```yaml
host: 127.0.0.1
port: "3306"
database: acore_world
username: your_user
password: your_password
dbc_path: D:\path\to\AzerothCore\data\dbc
```

导入在后台 Isolate 中执行，进度通过对话框展示。设置页支持将当前库内 DBC 数据 **导出** 为 `.dbc` 文件。

---

## 项目结构

```
lib/
├── main.dart                 # 入口：窗口初始化、DI、runApp
├── di.dart                   # GetIt 注册 Repository / ViewModel
├── constant/                 # 枚举、Flags、条件类型等常量
├── database/                 # 连接封装、Migration 与 Runner
├── entity/                   # 数据实体与 Filter 实体
├── page/                     # 按业务域划分的页面与 ViewModel
│   ├── bootstrap/            # 启动连接页
│   ├── dashboard/            # 工作台
│   ├── scaffold/             # 主壳：侧边栏、DBC 导入
│   ├── creature_template/    # 生物（多 Tab 关联表）
│   ├── item/ / quest/ / …    # 其它业务模块
│   └── setting/              # 基本设置、数据库设置、DBC 导出
├── repository/               # 数据访问层
├── router/                   # auto_route 配置与菜单
├── util/                     # DBC 同步、日志、对话框、事件总线等
└── widget/                   # 通用组件（表格、分页、表单、Picker…）

docs/
├── database_acore_world_schema.md   # 世界库表结构参考
├── database_foxy_schema.md          # foxy 库表结构参考
└── repository_crud_template.md      # Repository CRUD 约定

asset/                        # 图片与图标资源
config.yaml                   # 本地连接配置（不入库）
```

---

## 开发说明

### 新增一个业务模块（简要）

1. 在 `entity/` 增加实体与 Filter（含 Brief 实体若需列表/选择器）
2. 在 `repository/` 按模板实现 CRUD（见 `docs/repository_crud_template.md`）
3. 在 `page/<module>/` 实现 List / Detail 页面与 ViewModel
4. 注册路由（`router.dart` + `build_runner`）与菜单（`router_menu.dart`）
5. 在 `di.dart` 注册 Repository 与 ViewModel
6. 如需侧边栏/更多页展示，通过 `foxy.features` 迁移或数据维护功能入口

### 常用命令

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d windows
flutter analyze
flutter test
```

### 数据库说明

| 库 | 用途 |
|----|------|
| **acore_world**（可配置） | AzerothCore 世界数据：生物/物品/任务模板、SmartAI、掉落等 |
| **foxy**（应用自动创建） | 功能清单 `features`、迁移记录 `migrations`、DBC 镜像表 `dbc_*`、活动日志等 |

跨库查询 DBC 时使用全名，例如 `foxy.dbc_spell`。

---

## 截图与愿景

应用内介绍原文：

> 希望新的 Foxy 能继续实现最初的愿景，**做最好的魔兽世界编辑器**。

旧版因模拟器迭代而落后，本仓库为 **Flutter 桌面重构版**，在保持可视化编辑体验的同时，用更精简的技术栈提升维护效率与执行性能。

---

## 许可证

[MIT License](LICENSE) © 2026 Cals Ranna

---

## 相关链接

- 仓库：https://github.com/CalsRanna/foxy
- AzerothCore：https://www.azerothcore.org/
- 表结构与开发约定：见 [`docs/`](docs/) 目录
