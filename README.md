<p align="center">
  <img src="asset/image/icon_256.png" alt="Foxy" width="96">
</p>

# Foxy

**AzerothCore 数据库可视化管理工具** —— 基于 Flutter 的桌面应用,用于管理魔兽世界 3.3.5 模拟器(AzerothCore)的 `world` 数据库,覆盖生物、物品、任务、法术、游戏对象、对话、内建脚本(SmartAI)等核心内容。

Foxy 面向内容制作场景,把「列表检索 → 详情编辑 → 关联子表维护」做成完整闭环,并内置 DBC 数据同步与客户端游戏图标提取能力,让游戏数据的制作更简单高效。

## 功能特性

- **全流程内容编辑**
  - 列表页:按 entry/名称等字段筛选、分页、右键复制/删除,双击进入详情
  - 详情页:主表字段表单 + 关联子表 Tab 行编辑(如生物的 12 个 Tab:模板补充、击杀声望、抗性、技能、装备模板、任务物品、商人、训练师、击杀/偷窃/剥皮掉落)
  - 新增时自动分配自增 ID,支持整行复制生成新记录
- **覆盖 130+ 张 AzerothCore 核心表**,统一为「列表 + 详情 + 关联子表」三种页面形态,包括:
  - 生物 (`creature_template`)、物品 (`item_template`)、任务 (`quest_template`)、游戏对象 (`game_object_template`)、法术 (`spell`)、对话 (`gossip_menu` / `npc_text`)、内建脚本 (`smart_script`)
  - 掉落体系:击杀/偷窃/剥皮/采矿/草药/分解/研磨/选矿/参照掉落
  - 辅助数据:条件 (`conditions`)、页面文本、区域、表情文本、任务声望/排序/信息、扩展价格、属性缩放、法术附魔、宝石/雕文、天赋、货币、套装、成就、出生信息等
- **DBC 双向同步**:从魔兽客户端 `DBC` 目录导入到 `foxy.dbc_*` 表(不污染 AzerothCore 标准库),或从数据库导出回 DBC 文件;基于 isolate 的工作线程,带阶段进度与随时取消
- **游戏图标**:直接从客户端 `locale` 包 MPQ 中提取 `Interface\Icons` 图标(BLP 解码),供物品/法术等选择器内嵌展示
- **中文本地化支持**:连接时检测 locale 表(如 `creature_template_locale`)是否存在,存在则对生物、物品、游戏对象、对话、页面文本等模块自动 JOIN `zhCN` 列显示中文名;DBC 宽表本地化字段支持 16 种语言的整列编辑
- **操作留痕**:所有新增/修改/删除自动写入活动日志,在工作台展示最近动态
- **功能导航**:`features` 表驱动侧边栏固定与首页收藏,「更多」页按分类浏览全部模块

## 技术栈

| 领域 | 选型 |
| --- | --- |
| 跨平台框架 | Flutter (SDK ^3.9.2),桌面端 Windows / macOS / Linux |
| 数据库 | MySQL,经 `laconic` 查询构建器 + `laconic_mysql` 驱动 |
| UI | `shadcn_ui` + `lucide_icons_flutter`(中文界面,Windows 下使用 Microsoft YaHei UI) |
| 状态管理 | `signals` / `signals_flutter`(响应式信号) |
| 依赖注入 | `get_it`(全量显式注册,不使用服务定位魔法) |
| 路由 | `auto_route` + 自研 `RouterFacade`(面包屑路径、菜单高亮) |
| 代码生成 | `build_runner` + `source_gen` + `analyzer`,自研三层 Builder |
| 静态检查 | `custom_lint` + 8 条自研规则(见 `analysis_options.yaml`) |
| DBC 解析 | `warcrafty`(DBC 二进制 schema 定义) |
| 其它 | `window_manager`(无边框窗口)、`shared_preferences`、`file_selector`、`yaml_edit`(config.yaml)、`logger`、`package_info_plus` |

## 架构设计

```
Page (列表/详情/子表 Tab)
   │  Watch(signals)
   ▼
ViewModel (List / Detail / LinkedDetail / LinkedList —— 注解驱动,代码生成)
   │
   ▼
UseCase (跨表事务操作,如对话+文本+日志组合写入)
   │
   ▼
Repository (单表边界,含关联键子表查询层 —— 代码生成)
   │
   ▼
Entity (Brief 列表行 / Full 完整记录 —— 代码生成)
   │
   ▼
laconic query builder ──► MySQL (AzerothCore world 库 + foxy 元库)
```

核心思路是**「注解声明 + 代码生成 + 显式覆盖」**:

- **Entity 层**:用 `@FoxyBriefEntity` / `@FoxyFullEntity` 声明列表行与全量记录字段(附列名与主键标记),生成 `fromJson` / `copyWith` / 字段元数据
- **Repository 层**:`@FoxyRepository(entity)` + `@FoxyFilter` 声明筛选字段,生成 `getBrief*` / `count*` / `get*` / `create*` / `copy` / `destroy` 查询层;`linkKey` 声明关联键后自动生成「按关联键查子集合」的形态(如生物详情页的掉落 Tab);locale 开关与列表筛选(含 zhCN JOIN)也由生成器承接
- **ViewModel 层**:`@FoxyDetailViewModel` 按字段类型推断生成 `IntFieldController` / `DoubleFieldController` / `StringFieldController` / `SelectFieldController` / `FlagFieldController` / `NullableStringFieldController` / `IntFieldControllerGroup` 等表单控制器与 `collect` / `apply` / `initSignals` / `persist` 骨架;`@FoxyListViewModel` 生成筛选控制器、分页、查询版本号(竞态 token)与操作钩子

生成代码默认行为无法覆盖时,在业务类中显式覆写即可(如 `creature_template` 的 locale JOIN 与复制逻辑)。

> 完整的代码生成系统文档见 [`doc/codegen/`](doc/codegen/README.md)(使用指南 / 生成器实现 / 扩展指南)。

### 工程约束(custom_lint 强制)

| 规则 | 含义 |
| --- | --- |
| `entity_scalar_only` | Entity 只允许标量字段 |
| `repository_no_save` | Repository 不暴露直接 save,统一走生成的行为骨架 |
| `no_collection_loops` | 禁止手写集合循环,统一用集合方法 |
| `entity_no_flutter_import` | Entity 层禁止依赖 Flutter |
| `viewmodel_no_router_facade` | ViewModel 不触达路由 |
| `no_flex_in_view` | 视图层禁止使用 `Flex` 布局,统一走 Row/Column 的 `spacing` |
| `no_readonly_in_view` | 视图层禁止直接实例化只读输入控件 |
| `no_chinese_throw` | 异常内禁止中文文案 |

### 异常体系

业务异常收敛为 `sealed FoxyException` 语义类型(记录不存在、主键重复、忙碌互斥、校验失败等),面向用户的**中文文案统一经 `foxyErrorMessage(error)` 映射**,UI 展示错误只有这一个入口;诊断信息一律英文,只进日志。

### 元数据与引导

- 首次启动进入 Bootstrap 页填写 MySQL 连接 → 连接后自动执行 `MigrationRunner`(建 `foxy` 元库、`features` / `migrations` / `activity_log` 等表,按序应用 6 个迁移)→ 加载功能清单 → 进入工作台
- 未配置 DBC 目录 / 客户端目录 / 未提取图标时,弹出不可跳过的三步设置引导

## 快速开始

### 环境要求

- Flutter stable(≥ 3.9)+ Dart(≥ 3.9)
- 一个可用的 AzerothCore `world` 数据库(MySQL 5.7+/8.x)
- 魔兽 3.3.5 客户端文件与 `DBC` 目录,用于图标提取与 DBC 同步

### 安装与运行

```bash
# 1. 拉取依赖
flutter pub get

# 2. 生成代码(Entity / Repository / ViewModel 三层 .g.dart)
dart run build_runner build --delete-conflicting-outputs

# 3. 运行(以 Windows 为例)
flutter run -d windows
```

首次启动按界面引导填写数据库连接即可;连接信息会写入 `config.yaml`。

### 配置

运行目录下的 `config.yaml` 保存连接与路径配置(也可在「设置」中修改):

```yaml
host: 127.0.0.1        # MySQL 主机
port: "3306"           # MySQL 端口
database: acore_world  # AzerothCore world 库名
username: foxy
password: foxy
dbc_path: D:\Simulators\AzerothCore\core\data\dbc   # 客户端 DBC 目录
client_dir: D:\Simulators\AzerothCore\client        # 客户端根目录(图标提取)
icons_extracted: true                                # 图标是否已提取
```

### 测试

```bash
flutter test
```

测试覆盖 88 个文件:各模块「契约测试」(生成代码与注解声明的一致性)、真实 MySQL 上的「数据库编辑契约测试」、DBC 编解码/导入导出、图标提取(BLP/MPQ)、表单控件与页面行为等。需要真实数据库的集成测试(如 `dbc_mysql_integration_test.dart`)会在未配置环境时自动跳过。

## 目录结构

```
lib/
├── main.dart                  # 入口:窗口初始化 → DI → 应用
├── di.dart                    # get_it 全量显式注册
├── router/                    # auto_route 路由 + RouterFacade(面包屑/菜单)
├── page/                      # 页面层(每个模块一个目录:列表页/详情页/子表视图)
├── view_model/                # ViewModel(注解声明 + .g.dart 生成)
├── use_case/                  # 跨表用例(事务、DBC 导入导出、图标提取等)
├── repository/                # 单表仓库(注解声明 + .g.dart 生成查询层)
├── entity/                    # 数据实体(Brief/Full + .g.dart 生成)
├── constant/                  # 游戏语义常量与枚举(flags、类型、DBC 定义、本地化字段等)
├── database/                  # 连接管理 + 迁移 runner
├── infrastructure/
│   ├── codegen/               # 自研代码生成器(注解 + reader/model/emitter/generator)
│   ├── database/              # 事务封装、MySQL 错误归一
│   ├── dbc/                   # DBC 导入( isolate worker)/导出/本地化字段编解码
│   ├── game_asset/            # MPQ 读取、BLP 解码、图标提取与缓存
│   ├── errors/                # sealed FoxyException + foxyErrorMessage 映射
│   ├── config/                # config.yaml 读写
│   ├── logging/               # 活动日志服务
│   ├── preferences/           # SharedPreferences 封装、locale 查询偏好
│   └── window/                # 无边框窗口初始化
├── event/                     # 事件总线
├── widget/                    # 通用组件(虚拟化表格、选择器、表单、对话框等)
└── lint/                      # custom_lint 规则实现
doc/
└── codegen/                   # 代码生成系统文档(总览 / 使用 / 实现 / 扩展)
```

### 代码生成注解速查

| 注解 | 目标 | 作用 |
| --- | --- | --- |
| `@FoxyBriefEntity` / `@FoxyBriefField` | 实体 | 列表行实体与字段(可带默认值) |
| `@FoxyFullEntity(table)` / `@FoxyFullField(name, key)` | 实体 | 全量记录实体,`key: true` 标记主键 |
| `@FoxyRepository(entity, linkKey)` | 仓库 | 查询层生成;`linkKey` 声明关联键后支持子表形态 |
| `@FoxyFilter` | 仓库 | 列表筛选字段声明(单事实来源) |
| `@FoxyListViewModel(entity, repository)` | ViewModel | 列表控制器/分页/竞态/操作钩子 |
| `@FoxyDetailViewModel(entity, selects/flags/groups/nullable/exclude/repository)` | ViewModel | 表单控制器推断 + 例外声明 + 行为骨架 |
| `@FoxyLinkedListViewModel` / `@FoxyLinkedDetailViewModel` | ViewModel | 详情页子表 Tab 的列表/详情生成 |

## 许可

[MIT](LICENSE) © 2026 Cals Ranna

---

> 本项目与暴雪娱乐 / AzerothCore 项目无关。数据库内容版权归各自所有者。
