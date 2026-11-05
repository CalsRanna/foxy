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
- **桌面体验**:无边框窗口、窗口尺寸记忆、右侧键菜单、面包屑导航、快捷键(退出/设置/一键导出)。应用内任意页面按 `⌘⇧E`(macOS)或 `Ctrl+Shift+E`(Windows/Linux)可打开一键导出 DBC + MPQ 对话框。

## 技术栈

- **Flutter Desktop**(Windows 为主,macOS / Linux 亦构建)
- **Dart 3.13+** / Flutter 3.47.x stable
- **laconic + laconic_mysql**:查询构建器与 MySQL 驱动
- **signals / signals_flutter**:响应式状态管理
- **shadcn_ui + lucide_icons_flutter**:界面组件
- **auto_route**:声明式路由;**get_it**:依赖注入
- **build_runner + source_gen**:自研代码生成器
- **warcrafty**:DBC/MPQ/BLP 解析

## 仓库结构

本仓库是 Dart pub workspace monorepo,包含七个包:

```
foxy/
├── packages/
│   ├── foxy/                 # Flutter 应用(唯一可运行包)
│   │   ├── lib/              # 应用源码(见下方架构)
│   │   ├── test/             # 按被测层与跨模块行为分类
│   │   ├── tool/             # 发布工具与更新器
│   │   └── windows|linux|macos/  # 平台工程
│   ├── foxy_annotation/      # 代码生成注解定义(Entity/Repository/ViewModel)
│   ├── foxy_game_definition/ # 纯 Dart 的游戏枚举、标志位与参数定义
│   ├── foxy_game_file/       # 纯 Dart 的 DBC 读写、MPQ 读取与打包、图标提取
│   ├── foxy_generator/       # source_gen 代码生成器(读注解,产出 .g.dart)
│   ├── foxy_lint/            # 项目专属 analyzer 插件(9 条 lint 规则)
│   └── foxy_widget/          # Flutter 共用组件、游戏图标显示及其测试
├── doc/codegen/              # 代码生成系统文档
└── pubspec.yaml              # workspace 根
```

## 架构概览

核心设计:**注解声明 + 代码生成**。手写代码只通过 `@Foxy*` 注解声明"表是什么",机械样板(列表行 DTO、完整实体、仓库 CRUD、表单控制器、ViewModel 信号)由三个 build_runner builder 生成到 `.g.dart` part 文件,手写类通过 `with` 混入生成的 mixin。

```
Page (SignalBuilder 订阅) ──► ViewModel (signals + 表单控制器) ──► UseCase / Repository ──► MySQL
                                                        └──► EventBus ──► ActivityLogListener ──► foxy.activity_log
```

- **Entity**:`@FoxyBriefEntity` / `@FoxyFullEntity` 声明表结构,物理列名只在此出现一次。
- **Repository**:`@FoxyRepository` / `@FoxyFilter` 生成分页查询、过滤、CRUD 与 `linkKey` 子表查询层。
- **ViewModel**:`@FoxyListViewModel` / `@FoxyDetailViewModel` 等生成列表/表单状态与控制器。
- **UseCase**:跨表事务逻辑(对话菜单、locale 同步等)手写,注入 `DatabaseTransaction`。

应用源码按以下职责放置:

```text
packages/foxy/lib/
├── constant/                # 应用的 DBC 表映射与多语言字段注册
├── entity/                  # 表实体、列表 DTO 与键类型
├── model/                   # 跨层数据模型:DBC、本地化、选择器协议、工作进度
├── exception/               # 业务异常与错误文案映射
├── repository/              # 数据读写、查询偏好、DBC 导出仓储注册表
├── use_case/<module>/       # 跨表、活动日志及导入导出业务流程
├── infrastructure/         # 数据库、文件、配置、平台服务
│   ├── database/migration/ # 数据库迁移,与连接、事务、迁移 runner 放在同一层
│   ├── dbc/                # DBC 数据库同步与导入导出 worker
│   ├── mpq/                # 数据库导出到 MPQ 的编排与 worker
│   └── logging/            # 技术日志输出
├── event/                  # 事件定义与事件总线
├── view_model/             # 页面状态、输入校验与分页状态
│   ├── form/               # 字段控制器、数字解析与显示格式
│   └── workflow/           # 手写工作流 ViewModel、状态、导出项与结果文案
├── page/<module>/          # 页面与模块专用组件
│   ├── dashboard/component/ # 仪表盘专用卡片与内容
│   ├── scaffold/           # 主外壳、首次引导与目录/DBC 提醒
│   └── setting/            # 设置页面、导入导出弹窗及其表格组件
├── widget/                 # 依赖业务、应用状态或平台服务的跨页面组件
│   ├── form/               # 依赖字段控制器的输入组件
│   ├── table/              # 应用页面的 badge 折叠布局计算
│   ├── picker/             # 通用选择器
│   │   ├── delegate/       # 业务仓储到选择器的适配
│   │   └── locale/         # 本地化选择器与编辑器
│   ├── dialog/             # 共用弹窗外壳与反馈
│   ├── directory/          # 设置页与首次引导共用的目录配置组件
│   ├── update/             # 设置页与仪表盘共用的更新弹窗
│   └── window|feature/      # 窗口按钮与模块卡片
├── theme/                  # 显示配色
├── router/                 # 路由与导航
├── di.dart                 # 依赖装配
├── foxy_app.dart           # 应用主题与路由外壳
└── main.dart               # 应用入口
```

生成式 Entity、Repository、ViewModel 的文件路径由生成器推导,继续保留在各自层的根目录。页面专用组件随实际使用模块放置;跨页面组件按职责归入 `widget/`;共享数据协议归 `model/`。基础设施不依赖业务仓储或页面层,活动日志记录策略在 `use_case/activity_log/` 中装配。新增文件的具体规则见 `CONVENTIONS.md`。

布局、表格、分页、表单布局、上下文菜单、错误提示和游戏图标显示位于 `packages/foxy_widget/lib/src/`,应用统一通过 `package:foxy_widget/foxy_widget.dart` 使用。该包依赖 Flutter、`shadcn_ui`、`path` 和 `foxy_game_file`,不引用 `foxy` 的实体、仓储、路由或应用状态;应用页面的 badge 折叠布局计算留在应用包。`FoxyBlpIconProvider`、`FoxyGameAssetIcon` 和 `FoxyIconText` 是公开显示接口;`FoxyBlpDecoder` 及解码结果、异常类型是包内实现,不从公共入口导出。

游戏枚举、标志位、数值范围,以及 Condition、SmartScript、GameObject 的参数定义位于纯 Dart 包 `packages/foxy_game_definition/`,通过 `package:foxy_game_definition/foxy_game_definition.dart` 使用。`FlagItem` 和 `IntegerFieldSpec` 随定义放在该包,不依赖 Flutter 或运行时第三方库。主应用负责组件渲染和引用对象查询;DBC 表映射 `DbcDefinitions`、多语言字段注册 `DbcLocaleFields` 及本地化模型留在应用包。

DBC 文件读取、写入、头校验、复制替换,以及 MPQ 读取、打包、图标提取和路径规则位于纯 Dart 包 `packages/foxy_game_file/`,通过 `package:foxy_game_file/foxy_game_file.dart` 使用。依赖方向为 `foxy → foxy_widget → foxy_game_file`,主应用也可直接使用文件包。`DbcFileReader` 返回字段值与原文件行索引,`DbcFileWriter` 接收 schema 与记录,`MpqFilePacker` 打包已有 DBC 文件。数据库查询、SQL 拼接、暂存表切换、表映射、配置和任务编排留在 `foxy`。文件包不依赖 Flutter 或数据库;提取的 BLP 原始文件由 `foxy_widget` 解码显示。

## 快速开始

### 环境要求

- Flutter 3.47.x stable(Dart SDK ^3.13.0)
- macOS 端构建需 macOS 12.0+(Flutter 3.47 与 file_selector_macos 0.9.5+2 起要求)与 Xcode,原生插件统一使用 Swift Package Manager,无需安装 CocoaPods
- MySQL 5.7+ / 8.x(建议 utf8mb4;应用会自建 `foxy` 元数据库)

### Docker 准备本地数据库与 DBC

没有安装 AzerothCore 服务端时,可在仓库根目录通过一个 Compose 文件准备 Foxy 所需的数据:

```bash
docker compose up -d
docker compose logs -f db-import client-data
```

需要 Docker Engine / Docker Desktop(包含 Compose)。`database` 启动 MySQL 8.0,`db-import` 等数据库健康后导入官方 AzerothCore 数据,`client-data` 下载官方 v20.0 数据包并仅解压 DBC 到 `data/azerothcore/dbc`。无需克隆或编译 AzerothCore。首次会下载约 1.2 GB 的数据压缩包及 Docker 镜像,需要联网;两个初始化容器成功退出(`Exited (0)`)是正常状态,MySQL 会持续运行。

Foxy 仍作为本机桌面应用运行,连接参数填写:

| 配置 | 默认值 |
| --- | --- |
| 主机 | `127.0.0.1` |
| 端口 | `63306` |
| 数据库 | `acore_world` |
| 用户名 | `root` |
| 密码 | `foxy_local_dev` |

首次引导没有游戏客户端时选择“跳过图标提取”,“服务端目录”选择本机的 `<仓库目录>/data/azerothcore`,然后完成 DBC 导入。该目录不需要服务端程序;Foxy 会自动创建 `foxy` 元数据库。DBC 文件位于本机目录,不能填写容器内的 `/data` 路径。

MySQL 数据保存在命名卷,DBC 保存在已被 Git 忽略的 `data/` 目录。再次启动会保留已有 DBC 文件,不会覆盖 Foxy 导出的修改。日常停止使用 `docker compose stop`,重新启动使用 `docker compose up -d`;`docker compose down` 保留数据,而 `docker compose down -v` 会删除数据库卷。

可在第一次启动前通过环境变量 `FOXY_MYSQL_PORT`、`FOXY_MYSQL_PASSWORD` 修改端口和密码;数据库卷初始化后修改变量不会更改现有 MySQL 密码。默认只绑定本机回环地址。AzerothCore 官方镜像目前仅提供 x86_64 版本,Compose 已指定 `linux/amd64`,ARM 电脑需要 Docker 的 x86_64 仿真支持。

上游参考:[AzerothCore Docker 配置](https://github.com/azerothcore/acore-docker)、[客户端数据 v20.0](https://github.com/wowgaming/client-data/releases/tag/v20.0)。

### 运行

```bash
cd packages/foxy
flutter pub get
dart run build_runner build   # 重新生成 .g.dart(耗时数分钟)
flutter analyze
flutter test
flutter run -d windows
```

> 注:根目录为 workspace,应用的 Flutter 命令请在 `packages/foxy` 下执行;组件包在 `packages/foxy_widget` 执行 `flutter test`,游戏定义包和文件包分别在 `packages/foxy_game_definition`、`packages/foxy_game_file` 执行 `dart test`。代码生成器与 lint 包的纯 Dart 测试分别用 `cd packages/foxy_generator && dart test`、`cd packages/foxy_lint && dart test`。

macOS 使用 `flutter run -d macos` 或 `flutter build macos --release`,Flutter 会自动生成并解析 Swift Package Manager 插件依赖。使用 Xcode 时打开 `packages/foxy/macos/Runner.xcworkspace`。新增原生插件时需确认其 macOS 实现支持 Swift Package Manager。

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

应用测试按被测职责和跨模块行为分类,生成器与 lint 测试保留在各自包内:

- **game_data 测试**(`test/game_data/`):实体、仓储和 DBC 表映射对游戏定义的使用,纯内存运行。
- **database_editing 测试**(`test/database_editing/`):复合主键值语义、编辑流程、查询构建行为,纯内存运行。
- **identity 测试**(`test/identity/`):身份/状态保持语义(活动日志 ID、locale 草稿、路由面包屑)。
- **分层测试**(`test/constant/`、`test/model/`、`test/infrastructure/`、`test/repository/`、`test/use_case/`、`test/view_model/`、`test/page/`、`test/widget/`):目录与被测代码对应,覆盖常量、更新服务、DBC 数据库同步与 MPQ 导出编排、表单控制器、业务流程及界面交互。
- **依赖边界测试**(`test/architecture/`):检查基础设施、数据模型、仓储、业务流程和界面状态的依赖方向,避免文件再次进入错误的层。
- **生成产物行为测试**(`test/codegen/`):真实生成代码的实体序列化、主键状态与列表刷新行为。
- **集成测试**(`test/integration/`,标签 `integration`):对真实 MySQL 运行应用自身的启动链路(建库、全部迁移、utf8mb4 自愈、features 种子中文回读)与仓储读写(生成器的 store/update/destroy、异常映射、手写列表方法,含 locale JOIN、like 转义、联表分页、locale 批量事务回滚、creature_template 清单的精简夹具、DBC 导入的暂存表→行数/重复 ID 校验→原子改名链路,以及导出→导入往返;夹具表建在专用 `foxy_it_world` 库)。默认跳过(见 `dart_test.yaml`);本地先起一次性实例(`docker run -d --rm -p 3307:3306 -e MYSQL_ROOT_PASSWORD=foxy mysql:8.0`),再 `flutter test --tags integration --run-skipped -j 1`(DBC 用例还需 `FOXY_TEST_MYSQL_ALLOW_DBC_WRITE=1`,它会替换 `foxy.dbc_*` 表);CI 由 `ci.yml` 的 `database-integration` job 在 MySQL 8 容器上运行。
- **生成器测试**(`packages/foxy_generator/test/`):`dart test` 纯 Dart 运行。
- **lint 测试**(`packages/foxy_lint/test/`):analyzer 官方测试框架。
- **组件测试**(`packages/foxy_widget/test/`):在该包目录运行 `flutter test`,覆盖表单布局、动态 Tab、表格滚动保持、BLP 像素解码、图片缓存和显示。BLP/PNG 样本随测试保存在该包中。
- **游戏文件测试**(`packages/foxy_game_file/test/`):在该包目录运行 `dart test`,覆盖 DBC 读取、写入与往返、头校验、文件替换、MPQ 打包读取与图标提取。数据库同步、任务取消与工作流测试仍留在 `foxy`。
- **游戏定义测试**(`packages/foxy_game_definition/test/`):在该包目录运行 `dart test`,覆盖枚举、标志位、动态参数含义和标签展开,验证与 AzerothCore 服务端取值的一致性。

## 构建与发布

发布流水线(`.github/workflows/release.yml`)由推送 `v*` tag 触发:

1. 手动 bump `packages/foxy/pubspec.yaml` 的 `version`,并在 `CHANGELOG.md` 补 `## vX.Y.Z` 段(流水线读取该段作为更新说明);
2. 打 tag 并推送:`git tag vX.Y.Z && git push origin vX.Y.Z`;
3. 单 job 依次执行:`flutter build windows --release` → 编译更新器 → 打包 zip → 生成 `latest.yaml`(含 SHA-256,保留最近 3 条) → 发布 GitHub Release。

应用与通用组件包的 analyze,以及应用、组件、生成器和 lint 四包测试不在这条流水线里,由 `.github/workflows/ci.yml` 在 push 与 PR 时运行,环境为 Windows,与发布构建保持一致。发布出问题时,删除该 tag 再重新推送即可重跑;同一 tag 重复推送会自动取消旧 run。

更新入口固定为 `releases/latest/download/latest.yaml`,应用启动时自动检查(24 小时内不重复),也可在设置页手动检查。

## 文档

- [CONVENTIONS.md](CONVENTIONS.md) — 项目硬性约定(命名、代码生成铁律、lint、错误处理、UI、数据库、测试)
- [doc/codegen/README.md](doc/codegen/README.md) — 代码生成系统架构
- [doc/codegen/usage.md](doc/codegen/usage.md) — 模块开发指南
- [doc/codegen/generators.md](doc/codegen/generators.md) — 生成器实现详解
- [doc/codegen/extending.md](doc/codegen/extending.md) — 扩展生成器
- [doc/module-workflow.md](doc/module-workflow.md) — 新增完整模块机械执行清单(逐步、可验证)

## 许可

[MIT](LICENSE) © 2026 Cals Ranna
