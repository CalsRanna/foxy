# 新增完整模块:机械执行清单

本文回答一个问题:**新增一个完整模块(不是一张表)时,要做完哪些事、按什么顺序做、每步怎么验证。**

面向执行者(人类或 AI 编码助手)。规则:

- **按顺序执行,每步完成并验证后再进入下一步**;某步失败,先修好这一步,不要往下跳。
- **不要自行发挥**。每一步都先打开"样板文件"照抄模式:简单模块看 `quest_sort`,复杂主模块看 `creature_template`,DBC+子表模块看 `skill_line`。多个先例冲突时,以**最近、规模最大、覆盖最全**的为准(见根目录 `AGENTS.md` 的工作原则)。
- 每步标注了 `✅ 验证`:没有通过验证,任务就没有完成。
- 假设:你已能运行 `cd packages/foxy && flutter pub get`,且 `packages/foxy` 下已安装依赖。**所有命令都在 `packages/foxy` 下执行**(monorepo 根是 workspace)。

---

## 步骤 0:判定形态与命名(动笔前,10 分钟)

### 0.1 判定模块形态

| 形态 | 特征 | 里程碑判定 | 样板 |
| --- | --- | --- | --- |
| **A. 主表 + 详情(无子表)** | 一张主表,列表 → 详情单表单 | 最常见的模块 | `quest_sort`(简单)、`currency_type`(带枚举) |
| **B. 主表 + 详情 + 子表 Tab** | 主表详情页含 1..N 个子表 tab(linkKey) | 大模块 | `creature_template`(12 tab)、`skill_line`(1 子表) |
| **C. 仅子表(无独立页面)** | 只作为其他模块的 tab 存在,无列表页 | 补全表 | `creature_loot_template` |
| **D. 一对一子表(Linked Detail)** | 父表详情内嵌一个单行表单 | 补全表 | `creature_template_addon` |
| **E. 复合主键模块** | 主键是两个及以上字段,无法用单 key 表达 | 手写形态,不生成 | `condition`、`player_create_info`(按 `(race, class)`) |
| **F. DBC 宽表模块** | 表是 `foxy.dbc_*`(16 语言 `*_lang_*` 字段) | DBC 表 | `quest_sort`(DBC 本体)、`skill_line`(DBC+子表) |

判定要点:

- 一张表能不能"独立列表展示"是形态 A/B 与 C/D 的分界线:能被用户按主键浏览就做 A/B,只能挂在父级下就做 C/D。
- 形态 F 不是独立维度,它叠加在 A/B 上(如 `skill_line` = B+F):决定 detail VM 要手写、要加 DBC 注册(见步骤 10)。
- 子表是"复合键"(如 `game_event_battleground` 的 `(eventEntry, bg_map_id)`)?优先考虑是否能用 linkKey 表达(linkKey 支持单键;多键需要手写 link 查询,参考 `player_create_info_*` 的写法,它们保持了"主表+多个子 View"的结构,子集合查询手写)。
- **拿不准时,选择"最近、最大、最全"的模块群做样板,并在任务描述里写明"以 X 为样板"。**

### 0.2 命名登记表(先填这张表,全程用它命名)

| 项 | 规则 | 例子(假想的 `game_event` 模块) |
| --- | --- | --- |
| 模块目录(`lib/page/`) | 小写蛇形 | `page/game_event/` |
| Entity 类名/文件 | `XxxEntity` / `xxx_entity.dart` | `GameEventEntity` / `game_event_entity.dart` |
| Repository 类名/文件 | `XxxRepository` / `xxx_repository.dart` | `GameEventRepository` / `game_event_repository.dart` |
| List VM 类名/文件 | `XxxListViewModel` / `xxx_list_view_model.dart` | `GameEventListViewModel` |
| Detail VM 类名/文件 | `XxxDetailViewModel` / `xxx_detail_view_model.dart` | `GameEventDetailViewModel` |
| Linked List VM 类名/文件 | `XxxLinkedListViewModel`(子表) | `GameEventCreatureLinkedListViewModel` |
| Linked Detail VM 类名/文件 | `XxxLinkedDetailViewModel`(1:1) | — |
| Route 类名 | `<Xxx>ListRoute` / `<Xxx>DetailRoute` | `GameEventListRoute` / `GameEventDetailRoute` |
| RouterMenu 枚举值 | 驼峰,label 中文"…列表" | `gameEvent(label: '世界事件列表', icon: LucideIcons.calendarDays)` |
| features 种子的 `name` | 中文模块名(2-4 字) | `'世界事件'` |
| features 种子的 `router_menu` | RouterMenu 枚举值字符串 | `'gameEvent'` |
| 表名(`@FoxyFullEntity(table:)`) | 物理表名;DBC 表加 `foxy.` 前缀 | `'game_event'` 或 `'foxy.dbc_xxx'` |

命名冲突检查:类名在整个 `lib/` 下唯一;`RouterMenu` 枚举值唯一;features 表 `name` 唯一。

---

## 步骤 1:实体层(每张表一个文件)

位置:`packages/foxy/lib/entity/`。样板:`lib/entity/quest_sort_entity.dart`(DBC 宽表)、`lib/entity/currency_type_entity.dart`(普通表)、`lib/entity/skill_line_ability_entity.dart`(子表 + linkKey)。

写一个 `XxxEntity`:

```dart
import 'package:foxy_annotation/entity_annotations.dart';

part 'xxx_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity()                      // 表名推导自类名;例外显式 table:
class XxxEntity with _XxxEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('id', key: true)      // 物理列名只在这里出现一次
  final int id;

  @FoxyFullField('name1')
  final String name1;

  // ... 其余字段

  const XxxEntity({
    this.id = 0,
    this.name1 = '',
    // 每个字段一个默认值(与服务端表定义一致)
  });

  factory XxxEntity.fromJson(Map<String, dynamic> json) =>
      _XxxEntityMixin.fromJson(json);
}
```

规则与坑:

1. **`@FoxyBriefEntity()` 必须显式声明**(列表行 DTO、picker、子表 tab 都靠它;它不被推导)。
2. **`@FoxyBriefField()`(字段级,无参)标记进 Brief 的字段** —— 通常 1-3 个(编号 + 显示名)。若 Brief 需要 JOIN 别名字段(如 `displayName` 来自 locale JOIN),用**类级** `@FoxyBriefField.text('name')` 形式声明投影(见 `creature_template_entity.dart` 的类级注解),这时仓库必须手写 count/getBrief(见步骤 2.4)。
3. **`key: true` 至少一个**;复合主键用多个 `key: true`(生成 `XxxKey` 类),复合键模块走形态 E。
4. **DBC 宽表的 16 语言字段**:每个语言一个字段 `nameLangEnUS…nameLangUnk3` + `nameLangFlags`,物理列名 `Name_lang_enUS`……(`quest_sort_entity.dart` 是完整样板)。16 语言常量名顺序见 `lib/constant/dbc_locale_fields.dart` 的 `DbcLocaleFields`(语言名以它为准)。
5. **手写代码保留三件套**,生成时校验,删了会报构建期错误:
   - `with _XxxEntityMixin`
   - `part 'xxx_entity.g.dart';`
   - `factory XxxEntity.fromJson(...) => _XxxEntityMixin.fromJson(json);`
6. 字段类型只允许标量(`int`/`double`/`String`/`bool`/nullable);`bool` 的 DB 语义是 tinyint(生成代码处理 1/0,但**实体字段仍声明为 `bool`**)。
7. 子表实体照写,只是会被 linkKey 仓库消费(不含 special 注解,与主表同构)。

✅ **验证**:运行 `dart run build_runner build --delete-conflicting-outputs`(全部生成一次,慢,几分钟),检查 `xxx_entity.g.dart` 已生成且 `analyze` 无该文件错误。**不要手改 .g.dart**。

---

## 步骤 2:仓库层(每张表一个文件)

位置:`packages/foxy/lib/repository/`。样板:`lib/repository/quest_sort_repository.dart`、`lib/repository/creature_loot_template_repository.dart`(linkKey)。

```dart
import 'package:foxy_annotation/repository_annotations.dart';
import 'package:foxy/repository/repository_mixin.dart';

part 'xxx_repository.g.dart';

@FoxyRepository()                      // linkKey: ['parentId'] 时是子表形态
@FoxyFilter.text('id')
@FoxyFilter.text('name', column: 'Name_lang_zhCN')  // 物理列默认推导;别名列显式
class XxxRepository
    with RepositoryMixin, _XxxRepositoryMixin {}
```

规则与坑:

1. **filter 字段**:`@FoxyFilter.text/integer/decimal/boolean(name, {column, defaultValue})`。`column` 默认推导 = 名 → 实体字段 → 其 `@FoxyFullField` 列。**别名列(JOIN 列,如 `it.name`)必须显式 `column:`**,此时生成器强制你手写 `countXxxs`/`getBriefXxxs`(带 JOIN,见 `currency_type_repository.dart`)。
2. **手写查询条件的场景**:filter 语义复杂(如 DBC 表的 `WHERE SortName_lang_zhCN LIKE`),覆写 `_applyFilter(builder, filter)`(`quest_sort_repository.dart` 样板;涉及 `ParseUtil.escapeLike` 转义)。
3. **DBC 宽表**:混入 `DbcLocaleRepositoryMixin` 并 `@override String get dbcLocaleTableName => _table;` —— 生成器检测到后产出 `getXxxLocales` / `saveXxxLocales` 委托(16 语言读写)。
4. **`_table` 由生成 part 提供**(`const _table`),不要手写(构建期拒绝)。
5. **copy/create 的默认行**:生成器产出 `createXxx`(默认值行)和 `copyXxx`。需要"下一个自增 ID"时覆写,用 `nextMaxPlusOne(_table, 'ID')` + **越界抛 `IdExhaustedException`**(`quest_sort_repository._getNextId` 样板;参考 `BriefXxx` ID 上限,如 quest sort ≤32768)。
6. **子表(linkKey)**:`@FoxyRepository(linkKey: ['entry'])`。生成的子集合方法带关联键位置参数;`@FoxyLinkedListViewModel` 按「同关联键下最大+1」分配自增。多关联键(复合)走手写(参考 `player_create_info_*` 仓库)。
7. **写入前钩子**:`_beforeStore` / `_beforeUpdate` / `_beforeDestroy` 空实现,需要时覆写。

✅ **验证**:`dart run build_runner build --delete-conflicting-outputs` 后 `xxx_repository.g.dart` 生成;`flutter analyze` 无错误。别名列场景检查生成器是否要求手写方法(构建期报错提示时按提示补)。

---

## 步骤 3:ViewModel 层

位置:`packages/foxy/lib/view_model/`。List/Detail/LinkedList 三个注解分别对应页面。

### 3.1 List ViewModel(形态 A/B 都需要)

样板:`lib/view_model/quest_sort_list_view_model.dart`(18 行):

```dart
@FoxyListViewModel()
class XxxListViewModel
    with
        FieldControllerMixin,
        QueryVersionMixin,
        _XxxListViewModelMixin {}
```

`@FoxyListViewModel` 生成:filter 控制器(从 `@FoxyFilter` 读)、`items/page/total/loading/submitting/errorMessage` 信号、`copy/destroy/paginate/reset/search`。**实体没有名称字段时,覆写 `_logActivity`** 给活动日志一个可读名(默认名称链 `name` → `*NameLangZhCN` → `titleLangZhCN` → `title` → `logTitle` → `comment`,链上全无时只有 key)。

### 3.2 Detail ViewModel(形态 A/B 都需要)

**决策:生成 or 手写?**

| 条件 | 做法 |
| --- | --- |
| 普通 world 表(无 16 语言字段) | **生成**:`@FoxyDetailViewModel(...)` + `with FieldControllerMixin, _XxxDetailViewModelMixin`(样板 `lib/view_model/currency_type_detail_view_model.dart`) |
| DBC 宽表(步骤 1.4 的 16 语言) | **手写**(样板 `lib/view_model/quest_sort_detail_view_model.dart`、`skill_line_detail_view_model.dart`):`class XxxDetailViewModel with FieldControllerMixin {}`,无注解无 part —— 因为 locale 应用/收集逻辑(16 语言)无法由生成器表达 |

生成形态的注解参数(全部可选,按需声明):

```dart
@FoxyDetailViewModel(
  selects: {'type'},             // int/String 字段 → SelectFieldController
  flags: {'flags'},              // int 位标志 → FlagFieldController
  groups: {'stat'},              // int 动态组 → IntFieldControllerGroup
  exclude: {'field'},            // 不进表单的字段
)
```

规则:实体字段类型 → 控制器类型(`int`→`Int`、`double`→`Double`、`String`→`String`、`String?`→`NullableString`、`bool`→`SelectFieldController<int>`);`selects/flags/groups` 相互排斥、一个字段只能属于一个;fallback 类型必须匹配字段类型。手写形态下,`@FoxyInventoryHost` 不存在这个场景 —— 全手写 controller 注册:见 `quest_sort_detail_view_model.dart` 的 `registerController(...)`。

手写 Detail VM 必须实现的 6 件事(照抄 `quest_sort_detail_view_model.dart`):
`entity/persistedKey/loading/submitting/errorMessage` 信号 + `dispose()`;`initSignals({key})`(null 时调 `createXxx` 取默认行;有 key 时 `getXxx`,null 抛 `RecordNotFoundException`);`persist()`(first→`storeXxx` 并用返回值刷新 `persistedKey`;existing→`updateXxx`;成功 `_logActivity`);`_applyCandidate` / `_collectCandidate`;locale 应用方法(有 locale 时)。

### 3.3 Linked List / Linked Detail VM(形态 B/D)

- 子表列表:样板 `lib/view_model/skill_line_ability_linked_list_view_model.dart`:

```dart
@FoxyLinkedListViewModel(selects: {'acquireMethod'})
class XxxLinkedListViewModel
    with FieldControllerMixin, _XxxLinkedListViewModelMixin {}
```

- 一对一:样板 `lib/view_model/creature_template_addon_linked_detail_view_model.dart`(生成,要求实体恰好一个物理 key)。

✅ **验证**:build_runner 生成 `.g.dart`;`flutter analyze` 无错误。手写形态没有生成物,验证靠 analyze + 页面联调。

---

## 步骤 4:页面层

位置:`packages/foxy/lib/page/<module>/`。**一个模块 = 一个目录**:

| 文件 | 作用 | 样板 |
| --- | --- | --- |
| `xxx_list_page.dart` | 路由页:标题 + 筛选 + 表格 + 分页 | `quest_sort_list_page.dart`(207 行内) |
| `xxx_detail_page.dart` | 路由页:标题 + `FoxyTab`(主表单 + 各子表 tab) | `skill_line_detail_page.dart` |
| `xxx_view.dart` | 主表单视图(详情页第一个 tab 的内容) | `skill_line_view.dart` |
| `xxx_<sub>_view.dart` | 每个子表 tab 一个视图(形态 B) | `skill_line_ability_view.dart`(linked list)、`creature_loot_template_view.dart` |

### 4.1 List page 要点(照抄样板)

- `@RoutePage() class XxxListPage extends StatefulWidget`;`initState` 调 `viewModel.initSignals()`;`dispose` 调 `viewModel.dispose()`。
- 结构:`FoxyHeader('X列表')` → 筛选 `ShadCard`(每个 `@FoxyFilter` 一个 `FoxyStringInput` + 查询/重置) → `FoxyDataTable<BriefXxxEntity>`。
- 表格列:`FoxyTableColumn.fixed(label, width, cell)` / `.flex`;长内容列注意 `min_table_column_width` lint 规则(列宽给足)。
- 交互三件套(照抄 `skill_line_list_page.dart` 171-210 行):
  - 双击行 → `_navigateToDetail(key:)`;
  - 右键 `ContextMenu` → 编辑/复制/删除;
  - 复制/删除前 `DialogUtil.instance.confirm(...)`,成功后 `DialogUtil.instance.success(...)`,失败 `DialogUtil.instance.error('失败类型：${FoxyExceptions.message(error)}')` —— **错误一律阻塞模态,禁止 toast**(UI 一致性约定)。
- 导航:`GetIt.instance.get<RouterFacade>().navigateToDetail(route: XxxDetailRoute(key: key), parentMenu: RouterMenu.xxx)`。

### 4.2 Detail page 要点

```dart
@RoutePage()
class XxxDetailPage extends StatefulWidget {
  final int? xxxKey;   // 参数名 <模块>Key
  ...
}
```

- `initState` → `viewModel.initSignals(key: widget.xxxKey)`,异常包 `DialogUtil.instance.error('加载失败：…')`。
- 结构:`ListView` + `FoxyHeader('X详情')` + `Watch((_) { ... FoxyTab(...) })`。
- 带子表:`tabs: [Text('基本信息'), ...]`,`contents: [XxxView(viewModel:), XxxSubView(key: ValueKey('sub-$id'), parentId: id)]`,`disabledIndexes: key == null ? {1,...} : {}`(未保存时禁用子表 tab,先存主表)。
- **新代码统一用 `didUpdateWidget` 里 `viewModel.setLinkKey(...)`**(比依赖 ValueKey 重建精确),同时保留 ValueKey 作为兜底。

### 4.3 表单视图要点

- 每个字段一个 `FoxyFormItem(label:, child:)`;按 4 列栅格 `Row(spacing: 8, children: [Expanded(...) x4])`;分组用 `FoxyFormSection`。
- 控件映射(不要用裸 Material 控件,注意 `no_readonly_in_view` 等 lint):

| 实体类型 | 控件 |
| --- | --- |
| int / double | `FoxyNumberInput<T>` |
| String | `FoxyStringInput` |
| String? | `FoxyNullableStringInput` |
| bool / 枚举 int | `FoxyShadSelect<T>`(placeholder 传字符串) |
| 位标志 int | `FoxyFlagPicker` |
| 外键引用 | `FoxyEntityPicker(delegate:)` |
| 16 语言 locale | `FoxyLocalePicker`(见 4.4) |
| 只读 | `FoxyInputReadonly` |

- placeholder **一律英文列名**;`Row/Column` 间距用 `spacing:` 参数,`SizedBox` 只做固定尺寸(AGENTS.md UI 约定)。
- 保存/取消:`Watch` 包 `ShadButton(enabled: !viewModel.submitting.value, onPressed: _persist)`;`_persist` 成功 `DialogUtil.success('X数据已保存')`、失败 `DialogUtil.error('保存失败：…')`;取消 → `RouterFacade.goBack()`。

### 4.4 FoxyLocalePicker(DBC 宽表)

样板 `skill_line_view.dart` 62-105 行:`Watch((_) { FoxyLocalePicker(entry: persistedKey, controller: zhCN 字段, title: 'X本地化', placeholder: 'Name_lang_zhCN', delegate: FoxyLocalePickerDelegates.xxx, onSaved: viewModel.applyNameLocales) })`。`entry` 来自 `persistedKey`,未保存时(entry == null)locale 编辑不可用。

### 4.5 子表视图(linked list tab)

样板 `skill_line_ability_view.dart`:
`initSignals(linkKey: parentId)`;`didUpdateWidget` 里 `setLinkKey`;列表 `FoxyDataTable<BriefXxxEntity>` + 新增按钮;编辑用 `FoxyFormDialog`(不要裸 ShadDialog);行编辑表单照抄样板(字段与 4.3 控件映射一致);成功 `DialogUtil.success` / 失败 `DialogUtil.error`。

✅ **验证**:`flutter analyze` 通过;运行 `flutter run -d <device>` 手动冒烟(见步骤 15)。

---

## 步骤 5:生成器构建(一次性)

```bash
cd packages/foxy
dart run build_runner build --delete-conflicting-outputs
```

这一次生成:全部新增 `.g.dart`(entity/repository/view_model)+ **`router.gr.dart`**(auto_route 重生成)。不需要改 `build.yaml`(`generate_for` 通配已覆盖 `lib/entity/**_entity.dart` 等)。

改动注解后必须重跑;`flutter analyze` 会把 `InvalidGenerationSourceError` 钉到出错元素(修复文案见 `doc/codegen/usage.md` 常见错误表)。

✅ **验证**:命令退出码 0;`git status` 中 `.g.dart` 均已生成;`flutter analyze` 无错误。

---

## 步骤 6:DI 注册

文件:`packages/foxy/lib/di.dart`。

三处修改(全部显式注册,无自动扫描;照 skill-line 提交的 di.dart 段落):

1. **import 区**(按字母序):新增 `repository/xxx_repository.dart`、`view_model/xxx_*_view_model.dart` 的 import。
2. **`_registerViewModels`(registerFactory)**:每个 VM 一行:
   `_instance.registerFactory(() => XxxListViewModel());`
   `_instance.registerFactory(() => XxxDetailViewModel());`
   `_instance.registerFactory(() => XxxLinkedListViewModel());`(子表有才加)
3. **`_registerRepositories`(registerLazySingleton)**:每个仓库一行:
   `_instance.registerLazySingleton(() => XxxRepository());`
4. **UseCase(仅跨表事务才需要,见步骤 12)**:`_registerUseCases()` 里 `registerFactory(() => XxxUseCase(...))`。

✅ **验证**:`flutter analyze` 通过(GetIt 编译期不校验,靠冒烟)。漏注册会在运行时 `GetIt` 抛 `TypeNotRegisteredError`。

---

## 步骤 7:路由与菜单

### 7.1 router.dart

文件:`lib/router/router.dart`,按模块注释分组添加两个 AutoRoute:

```dart
/// Game Event
AutoRoute(page: GameEventListRoute.page),
AutoRoute(page: GameEventDetailRoute.page),
```

### 7.2 router_menu.dart

文件:`lib/router/router_menu.dart`,两处修改:

1. **enum 值**:`gameEvent(label: '世界事件列表', icon: LucideIcons.calendarDays)` —— **enum 顺序 = 侧边栏顺序**,插到语义相近的位置(参照现有排序)。label 格式 "X列表"(它同时是侧边栏与面包屑文本)。
2. **`route` getter 的 switch**:补一行 `RouterMenu.gameEvent => const GameEventListRoute(),`。

注意 `RouterMenu` 是**非叶子模块(有独立列表页)**才需要;纯子表模块(C/D 形态)不注册菜单,只注册路由(供 detail page 跳转/子表导航用 —— 子表通常没有独立 route,不用加)。

### 7.3 重新生成路由

`dart run build_runner build --delete-conflicting-outputs`(router.gr.dart 由 auto_route 生成,它就是步骤 5 那次一并生成的;若 7.1/7.2 是在步骤 5 之后改的,重跑一次)。

✅ **验证**:`router.gr.dart` 包含 `GameEventListRoute`;`RouterMenu.gameEvent.route` 可用;`flutter analyze` 无错误。

---

## 步骤 8:特性迁移(features 种子)

### 8.1 新建迁移文件

`lib/database/migration/migration_YYYYMMDDHHMM.dart`,时间戳**严格大于**现有最大。确认方式:`ls lib/database/migration/ | sort | tail -1`(当前最大 `migration_202608090002.dart`);也用它确认迁移总数(当前 10)。样板 `migration_202608090000.dart`(features 种子,即下面的示例):

```dart
import 'package:foxy/database/migration_runner.dart';
import 'package:laconic/laconic.dart';

class Migration202609030000 implements Migration {
  @override
  String get name => 'migration_202609030000';

  @override
  Future<void> migrate(Laconic laconic) async {
    await laconic.table('foxy.features').insert([
      {
        'name': '世界事件',
        'description': '管理节日与限时世界事件，配置事件时间、关联刷怪、物体与任务。',
        'icon': 'calendarDays',
        'router_menu': 'gameEvent',
        'category': 'database',        // 'database' 或 'dbc'(DBC 相关表用 'dbc')
        'is_pinned': 0,
        'is_favorite': 0,
        'sort_order': 28,              // 取现有最大 sort_order +1(当前 27,一批内递增)
      },
    ]);
  }
}
```

要点:

- `router_menu` 的值必须与 RouterMenu 枚举名**完全一致**(字符串),feature card 点击它导航。
- `icon` 是 icon map 的 key(见 8.3),**不能凭空造**。
- `sort_order`:取当前最大 +1;一批多个模块依次递增。
- 迁移是应用级功能**,必须插入**,否则模块进不了 dashboard/更多页/侧边栏(侧边栏主菜单由 RouterMenu 驱动,但 dashboard 卡片、更多页、搜索由 features 驱动)。

### 8.2 注册迁移

- `lib/database/migration_runner.dart`:import + `migrations` 列表末尾追加实例(按时间序)。
- `packages/foxy/test/migration_runner_test.dart`:**迁移总数断言必须更新**(`hasLength(<总数>)`,当前 10;共 3 处),`containsAll` 列表加新迁移名。

### 8.3 图标注册(仅当使用新 icon)

`lib/widget/foxy_feature_card.dart` 的 `_kFeatureIconMap` 加一行 `'calendarDays': LucideIcons.calendarDays`。**优先复用 map 中已有 icon**(list/bookOpen/mapPin/…),用新 icon 才加 map。map 缺失时降级为 `circleAlert`,不崩但显示错误图标 —— 所以 8.1 与 8.3 必须一起做。

✅ **验证**:`flutter test test/migration_runner_test.dart` 通过;`flutter analyze` 通过。

---

## 步骤 9:游戏数据常量与 game_data 测试(仅当模块引入游戏语义)

`lib/constant/` 存放游戏语义常量(标志位、枚举值、DBC schema、默认值)。**新增有游戏语义的常量时**:

1. 新建 `lib/constant/xxx_constants.dart`(样板 `skill_line_constants.dart` — 3.3.5a 的 AcquireMethod 枚举)。
2. 新建 `packages/foxy/test/game_data/xxx_game_data_test.dart`,**常量取值与 AzerothCore 3.3.5 服务端一致**(样板 `quest_sort_game_data_test.dart`、`talent_game_data_test.dart` —— 引用 `DbcDefinitions` / `DbcLocaleFields` 或常量类,断言字段名/schema/枚举值)。

判定:模块的 flag/enum 在页面或仓库中被解释(如 `SkillLineConstants.skillAcquireMethodOptions` 用于 ShadSelect)就必须进 constant + 测试;若字段只是**原样透传**(`int` 显示/编辑,不做语义解释),不需要。

✅ **验证**:`flutter test test/game_data/` 全绿。

---

## 步骤 10:DBC 表额外步骤(仅形态 F)

模块表是 `foxy.dbc_*` 时,除以上全部外还需:

1. `lib/constant/dbc_definitions.dart`:`DbcDefinitions` 注册表(文件名 `Xxx.dbc`、schema 格式串、字段清单)。**schema 必须与 warcrafty 的 DBC 结构一致**,否则导入导出报错。样板:同文件 `quest_sort` 条目(`format: 'nssss…'` 与字段数一一对应)。
2. `lib/constant/dbc_locale_fields.dart`:16 语言字段注册(`DbcLocaleFields.xxxName.tableName` / `.columnPrefix` / `.flagsColumn`)。样板:同文件 `questSortSortName`。
3. `lib/infrastructure/dbc/dbc_export_registry.dart`:导出注册(表名 → 导出任务,样板见 skill-line 提交 +35 行)。
4. 相关测试同步更新:
   - `packages/foxy/test/dbc_entity_export_fields_test.dart`(新增表的导出字段断言)
   - `packages/foxy/test/dbc_locale_field_codec_test.dart`(locale 编解码握手)
   - `packages/foxy/test/dbc_definitions_test.dart` 若有
5. 实体/repository 形态:实体 `@FoxyFullEntity(table: 'foxy.dbc_xxx')`;repository 混入 `DbcLocaleRepositoryMixin`(步骤 2.3);detail VM 手写(步骤 3.2);页面用 `FoxyLocalePicker`(步骤 4.4)。
6. `foxy.features` 种子的 `category: 'dbc'`。

✅ **验证**:三个 DBC 测试文件全绿;`flutter analyze` 通过。

---

## 步骤 11:picker 委托(仅当本模块被其他模块引用)

### 11.1 实体 picker 委托

若其他模块的表单要**选本模块的记录**,在 `lib/widget/foxy_entity_picker_delegates.dart` 加 static delegate(样板:skill-line 提交的 `skillLineCategory`,含 title/errorLabel/filters/columns/idOf/fetch/count)。然后**更新引用页面**(如 skill-line 把 `npc_trainer_view.dart` 中硬编码的文本改成了 picker)。

### 11.2 locale picker 委托

本模块有 16 语言字段且要在其他页面编辑时,在 `lib/widget/foxy_locale_picker_delegates.dart` 加 `_dbc(...)` 委托(样板 skill-line 提交:每个语言字段一个 delegate,引用仓库的 `getXxxLocales`/`saveXxxLocales`)。

✅ **验证**:`flutter analyze`;引用的页面冒烟选择成功。

---

## 步骤 12:跨表 UseCase(仅当需要)

单表 CRUD 不需要。跨表事务(如"创建 gossip 同时建 option"、"保存物品同步 Item.dbc")才建 UseCase:

1. `lib/use_case/xxx_use_case.dart`(注入 `DatabaseTransaction`,`AGENTS.md` 说 UseCase 手写、事务合并 zone marker)。
2. `di.dart` `_registerUseCases()` 注册 `registerFactory`。
3. 页面/VM 里经 GetIt 取用。

✅ **验证**:`flutter analyze`;行为测试(use case 有 `test/use_case/*_test.dart` 先例时照抄)。

---

## 步骤 13:测试

### 必须更新的既有测试

| 文件 | 改什么 |
| --- | --- |
| `test/migration_runner_test.dart` | 迁移总数(3 处断言)+ `containsAll` |
| (DBC 表)`test/dbc_entity_export_fields_test.dart` | 导出字段断言 |
| (DBC 表)`test/dbc_locale_field_codec_test.dart` | locale 字段断言 |

### 新增测试的判定

| 场景 | 新增 |
| --- | --- |
| 有游戏语义常量(步骤 9) | `test/game_data/xxx_game_data_test.dart` |
| 复合键/特殊编辑语义(键值语义、编辑流程、查询构建) | `test/database_editing/xxx_database_editing_test.dart`(纯内存,不连库) |
| DBC 表 | 步骤 10 的三个测试 |
| 无以上特殊点 | **不强制**;但改动生成器/注解时必须加生成器套件测试(`packages/foxy_generator/test/`,见 `doc/codegen/extending.md`) |

✅ **验证**:

```bash
cd packages/foxy && flutter analyze && flutter test
cd packages/foxy_generator && dart test    # 只动了注解/生成器时才需要
```

---

## 步骤 14:文档与统计数字更新(最容易遗漏)

**模块数量变化后,以下数字全部要求同步更新** —— 先 grep 再改,别凭记忆:

### README.md

| 位置 | 内容 |
| --- | --- |
| 第 5 行 | 功能描述 "…等 **130 余张**数据表的图形化编辑能力" → 更新为实际数 |
| 第 9 行 | "*120+* 张 world 表" → 更新 |
| 第 38 行 | "**91 个测试文件**" → 更新 |
| 第 103 行 | "共 **110 个** Dart 测试文件" → 更新 |
| 第 11 行 | DBC 表数 "约 50 张表"(仅 DBC 表新增时) |
| 文档索引 | `doc/` 列表加本清单链接(如有) |

### AGENTS.md

统计命令(在 `packages/foxy` 下执行,实测值备查):

```bash
ls lib/entity/*_entity.g.dart | wc -l          # 130
ls lib/repository/*_repository.g.dart | wc -l  # 129
ls lib/view_model/*_view_model.g.dart | wc -l  # 85
grep -c "AutoRoute(" lib/router/router.dart    # 59
grep -cE "^  [a-zA-Z]+\\(" lib/router/router_menu.dart  # 30 (enum 成员)
grep -c "registerFactory(" lib/di.dart         # 111
grep -c "registerLazySingleton(" lib/di.dart   # 143
grep -c "registerSingleton(" lib/di.dart       # 10
ls lib/entity/*_entity.dart | wc -l            # 135 (含手写)
ls lib/database/migration/*.dart | wc -l       # 10
ls lib/constant/*.dart | wc -l                 # 34
ls lib/widget/*.dart | wc -l                   # 30
```

| 位置 | 内容 |
| --- | --- |
| `Repository Layout` 表 | 包版本号/描述(rare) |
| 「On disk:」行 | entity/repository/view_model 三个 `.g.dart` 计数(当前按上表) |
| 「Wiring a New Module」 | di.dart 注册计数(总数 + 三个分计数,当前 111/143/10) |
| 同行 | router 数(当前 59)、`RouterMenu` 数(当前 30) |
| 实体文件行 | "~135 `*_entity.dart` files (130 generated)" |
| Migrations 行 | "(total)"(当前 10) |
| constant 行 | "34 files" |
| widget 行 | "30 files" |
| foxy_lint 规则数 | 只在 rules 增减时改(加模块不改) |

### CHANGELOG.md + 版本

- 模块合入时在 CHANGELOG 相应未发布段补一条(发布流水线读最新段做 release notes);版本 bump 在发布流程做,平时不动 `pubspec.yaml` 的 version。

✅ **验证**:`grep -n` 数字已更新;README/AGENTS 无过期计数。

---

## 步骤 15:最终验收

```bash
cd packages/foxy
dart run build_runner build --delete-conflicting-outputs   # 幂等,应无新输出
flutter analyze
flutter test
flutter run -d windows   # 或 macos
```

手动冒烟清单(每项都要过):

- [ ] 侧边栏/dashboard/更多页出现新模块入口,图标正确,点击进入列表
- [ ] 列表:加载、筛选(每个 filter)、分页、双击开详情、右键菜单复制/删除(复制成功后 DB 出现新行;删除有确认)
- [ ] 详情(新建):主表单字段默认值正确;保存后 `persistedKey` 生效、子表 tab 解锁
- [ ] 详情(编辑):值回填、修改保存生效;取消不落库
- [ ] 子表(若有):新增/编辑/删除/复制;关联键自动填充
- [ ] locale 字段(若有):地球按钮编辑 16 语言,保存后 zhCN 列表列更新
- [ ] 活动日志表可见本模块操作(名称可读,不是裸 key)
- [ ] 老库升级(已有 foxy 元数据):迁移跑通且不丢数据;新库(bootstrap 向导):迁移全量跑通
- [ ] 刷新/退出重开:配置与状态不丢

提交(与仓库规范一致,comment 英文):

```bash
git add -A
git commit -m "feat(game-event): add game event management module"
```

---

## 附录 A:本清单与现有文档的分工

- `AGENTS.md`:全局约定(代码生成系统、lint 规则、UI 一致性)与"Wiring a New Module"速览 —— **本文是它的展开执行版**。
- `doc/codegen/usage.md`:5 种模块形态的注解用法、推导规则、覆写点、常见构建期错误表 —— 写代码时逐条对照。
- `doc/codegen/README.md` / `generators.md` / `extending.md`:生成器内部实现与扩展 —— 改生成器时读;加普通模块不读。

## 附录 B:易漏点速查(排查"还以为做完了")

1. `migration_runner_test.dart` 的数量断言(步骤 8.2)—— 改迁移必改测试,否则 CI 红。
2. `router.gr.dart` 没重生成 —— 路由加了但导航崩(运行时)或编译错。
3. `foxy_feature_card.dart` 图标 map 漏加 —— dashboard 卡片显示 `circleAlert` 占位图标。
4. README / AGENTS.md 的计数没更新 —— 两者都有"生成文件数量/路由数量/注册数量/迁移数量",diff 时先 `grep -n` 数字。
5. 实体 fromJson 委托 / with mixin / part 三件套 —— 缺一个,构建期报错提示到元素(修复表见 usage.md)。
6. 新实体忘记 `@FoxyBriefEntity()` —— 生成器报 `must declare @FoxyBriefEntity`。
7. `_logActivity` 名称链无命中 —— 复制/删除日志只有裸 key;给实体加名称字段或覆写 `_logActivity`。
8. DBC 模块忘了 `dbc_export_registry.dart` —— 导出列表漏表,用户导出的补丁不更新。
9. 子表没有 `didUpdateWidget` 的 `setLinkKey` —— 父页 key 变化后子表查询旧 key,数据错乱。
10. 新模块页面右上角按钮/字段 placeholder 用了中文而非英文列名 —— 违反 UI 约定(lint 只拦得住一部分)。
11. 复合键模块硬套生成 —— 工程量大;优先改造成 linkKey 子表,实在无法改造才走形态 E(手写,参考 `condition`)。
