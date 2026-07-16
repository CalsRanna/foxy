# Foxy

**AzerothCore 数据库可视化管理工具**

Foxy 是一款基于 Flutter 开发的桌面应用，用于可视化管理 AzerothCore / World of Warcraft 3.3.5a 的游戏数据。它提供生物、物品、任务、法术、对话、SmartAI 等数据的查询与编辑能力，并支持客户端 DBC 数据的导入和导出。

> 当前以 **Windows 桌面端**为主要目标，同时保留 macOS 与 Linux 工程。

## 功能概览

### 世界数据库管理

- **生物**：模板、Addon、抗性、技能、装备、任务物品、击杀声望、商人、训练师及掉落数据
- **物品**：物品模板、附魔模板、普通掉落、分解、勘探和研磨掉落
- **任务**：任务模板、Addon、奖励文本、需求文本、生物与游戏对象起止点
- **游戏对象**：模板、Addon、任务物品及掉落数据
- **对话系统**：Gossip 菜单、菜单选项、NPC 文本与本地化内容
- **SmartAI**：`smart_scripts` 列表、筛选和详情编辑
- **条件系统**：AzerothCore `conditions` 数据与动态字段配置
- **角色出生信息**：出生位置、物品、技能、动作与自定义法术

### DBC 与扩展数据

- 区域、表情、任务分类和任务信息
- 法术、法术区域、法术加成、自定义属性、分组、链接和等级
- 法术附魔、宝石属性、雕文属性
- 扩展价格、属性缩放分布与属性缩放值
- 天赋、货币、套装和成就
- DBC 目录批量导入
- 数据库镜像表批量导出为 `.dbc` 文件
- 固定 16 语言字段的 DBC 本地化编辑

### 桌面体验

- 列表筛选、分页和实体选择器
- 详情页分区与多 Tab 关联数据编辑
- 常用功能收藏、侧边栏固定与活动记录
- 自定义无边框窗口和窗口尺寸记忆
- 世界数据库 `*_locale` 表检测与本地化显示开关

## 技术栈

| 类别 | 技术 |
| --- | --- |
| 应用框架 | Flutter / Dart 3.9+ |
| UI | `shadcn_ui`、Material、Lucide Icons |
| 状态管理 | `signals` / `signals_flutter` |
| 依赖注入 | `get_it` |
| 路由 | `auto_route` + `build_runner` |
| 数据库 | MySQL、`laconic`、`laconic_mysql` |
| DBC | `warcrafty` |
| 配置 | YAML |
| 桌面窗口 | `window_manager` |

## 数据库模型

Foxy 通过同一个 MySQL 连接访问两个 Schema：

| Schema | 用途 |
| --- | --- |
| 用户配置的世界库，通常为 `acore_world` | AzerothCore 生物、物品、任务等服务端数据 |
| 固定的 `foxy` | 应用迁移、功能清单、活动记录和 `dbc_*` 镜像表 |

首次成功连接后，应用会自动创建 `foxy` Schema、初始化迁移表并按顺序执行尚未应用的迁移。

## 环境要求

开始前请准备：

- Flutter SDK，所带 Dart SDK 需满足 `pubspec.yaml` 中的 `sdk: ^3.9.2`
- 可访问的 MySQL 服务
- 已部署的 AzerothCore 3.3.5a 世界数据库或兼容表结构
- 可选：客户端 DBC 目录，用于初始化或更新 DBC 镜像数据
- Windows 构建需要 Flutter Windows 桌面开发环境及 Visual Studio C++ 工具链

检查 Flutter 环境：

```bash
flutter doctor
```

## 快速开始

### 1. 获取代码

```bash
git clone https://github.com/CalsRanna/foxy.git
cd foxy
```

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 运行应用

Windows：

```bash
flutter run -d windows
```

macOS：

```bash
flutter run -d macos
```

Linux：

```bash
flutter run -d linux
```

### 4. 连接 AzerothCore 数据库

应用启动后会显示数据库连接引导页，请填写：

- 主机地址
- MySQL 端口
- 世界数据库名称，例如 `acore_world`
- 用户名
- 密码

连接成功后，Foxy 会依次：

1. 连接世界数据库；
2. 检测可用的 `*_locale` 表；
3. 创建或升级 `foxy` 辅助 Schema；
4. 加载功能清单；
5. 保存本地连接配置；
6. 进入主界面。

连接信息保存在项目运行目录下的 `config.yaml`。该文件已被 Git 忽略，请勿将数据库密码提交到版本库。

配置示例：

```yaml
host: 127.0.0.1
port: "3306"
database: acore_world
username: your_username
password: your_password
dbc_path: D:\AzerothCore\data\dbc
locale_enabled: true
```

通常无需手动创建该文件，应用会在连接和设置过程中自动更新配置。

## DBC 导入与导出

### 导入

进入主界面后，如果必要的 `foxy.dbc_*` 表不存在、为空或结构不兼容，应用会提示选择 DBC 目录并执行同步。

DBC 导入在后台 Isolate 中运行，界面会显示当前阶段、文件和记录进度。请使用与 AzerothCore 3.3.5a 数据结构匹配的 DBC 文件。

### 导出

在设置页中可以：

1. 选择输出目录；
2. 勾选需要导出的 DBC 表；
3. 查看记录数量与不可导出原因；
4. 将数据库内容写出为对应 `.dbc` 文件。

导出会校验字段完整性、数据类型和数值范围；校验失败时不会用无效文件覆盖已有目标文件。

## 发布构建

### Windows

```bash
flutter build windows --release
```

Windows 构建脚本会将 `asset/icon/` 中的游戏图标复制到可执行文件旁的 `data/icon/` 目录。发布时应保留 Flutter 生成的完整 bundle 目录，不能只复制 `foxy.exe`。

### macOS

```bash
flutter build macos --release
```

### Linux

```bash
flutter build linux --release
```

Windows 是当前主要支持平台；在 macOS 或 Linux 发布前，请针对文件选择、窗口行为和外部游戏图标进行平台验收。

## 开发命令

```bash
# 静态分析
flutter analyze

# 运行全部测试
flutter test

# 运行单个测试文件
flutter test test/area_table_contract_test.dart

# 格式化修改过的文件
dart format lib/path/to/file.dart test/path/to/test.dart

# 重新生成 auto_route 路由
# 修改 lib/router/router.dart 或 @RoutePage 页面后必须执行
dart run build_runner build --delete-conflicting-outputs
```

`lib/router/router.gr.dart` 是生成后提交到版本库的文件，不应手工修改。

部分测试会直接读取源码并检查实体字段、UI 结构、Repository 约定和 DBC 注册关系。请从项目根目录执行测试。

MySQL 集成测试只应连接隔离 Schema。相关测试通过以下环境变量显式启用：

```text
FOXY_TEST_MYSQL=1
FOXY_TEST_MYSQL_FOXY_SCHEMA=<不能为 foxy 的隔离 Schema>
```

不要使用生产数据库、真实世界库或默认 `foxy` Schema 执行破坏性测试。

## 项目结构

```text
lib/
├── main.dart                 # 应用入口
├── di.dart                   # GetIt 依赖注册
├── constant/                # AzerothCore / DBC 常量、枚举和 Schema 定义
├── database/                # 数据库连接与 foxy Schema 迁移
├── entity/                  # 完整、简要、筛选及本地化实体
├── event/                   # 事件总线与活动事件
├── infrastructure/
│   ├── config/              # config.yaml 读写
│   ├── dbc/                 # DBC 导入、导出、Worker 和本地化编解码
│   ├── logging/             # 日志
│   ├── preferences/         # 窗口偏好
│   ├── util/                # 格式化与解析工具
│   └── window/              # 桌面窗口初始化
├── page/                    # 按业务模块组织的 Page、View 和 ViewModel
├── repository/              # Laconic 数据访问层
├── router/                  # auto_route 配置、菜单和导航门面
└── widget/                  # 表单、表格、Picker、Dialog 等共享组件

test/                        # 单元、Widget、源码契约和集成测试
asset/image/                 # Flutter Asset 图片
asset/icon/                  # 游戏图标，由 Windows 构建脚本复制到 data/icon
windows/ macos/ linux/       # 桌面平台工程
```

整体采用 Page / ViewModel / Repository / Entity 分层：

```text
Page / Widget
      ↓
ViewModel（Signals + 表单控制器）
      ↓
Repository（Laconic 查询与引用完整性）
      ↓
Entity / Filter / Brief Entity
      ↓
MySQL：世界数据库 + foxy 辅助数据库
```

## 参与开发

提交修改前建议至少执行：

```bash
flutter analyze
flutter test
git diff --check
```

开发新业务模块时通常需要同步修改：

1. Entity、Brief Entity 与 Filter Entity；
2. 字段验证规则；
3. Repository；
4. 列表页、详情页和 ViewModel；
5. `lib/di.dart` 依赖注册；
6. 路由与菜单；
7. Entity Picker Delegate；
8. DBC Definition、Locale 与导出注册；
9. 对应契约测试。

面向 AI 编程助手的详细架构和约定见 [`AGENTS.md`](AGENTS.md)。

## 安全提示

- 修改或删除数据库数据前请先备份。
- 不要提交 `config.yaml`、数据库密码或其它凭据。
- 不要在生产数据库上执行测试或实验性迁移。
- DBC 导入与导出应使用版本匹配的数据文件，并在批量操作前保留备份。

## License

本项目基于 [MIT License](LICENSE) 开源。

Copyright © 2026 Cals Ranna
