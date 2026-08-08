# 使用指南:如何用生成器开发一个模块

本文面向**业务开发者**——你不需要懂生成器内部实现,只需按本页的 5 种形态声明注解,再覆写默认行为。

## 注解速查

**推导链**:标灰的参数都可以省略——省略时由生成器从类名/类型推导(见「推导规则」表);显式声明永远优先,且与推导不一致时构建期报错。

| 注解 | 标注位置 | 作用 |
| --- | --- | --- |
| `@FoxyBriefEntity()` | Entity class | 声明「表格行展示模型」(`BriefXxxEntity`),list page 表格 / picker 选择列表 / 子表 tab 表格共用。**必须显式声明,不推导**——消费方含生成器看不见的手写代码 |
| `@FoxyBriefField` | Entity class / 字段 | class 上:声明 Brief 投影字段(带类型与默认值);字段上:无参形式标记该物理字段进 Brief |
| `@FoxyFullEntity(~~table~~)` | Entity class | 声明全量实体;`table:` 省略时推导为 `snake_case(类名去 Entity)`(`CreatureLootTemplateEntity` → `creature_loot_template`)。DBC 表(`foxy.dbc_*`)、复数表名(`conditions`)、拼写差异表(`trainer_spell`)显式声明 |
| `@FoxyFullField(name, key)` | Entity 字段 | 声明物理列名;`key: true` 标记主键(列名推导为阶段 2) |
| `@FoxyRepository(~~entity~~, linkKey)` | Repository class | `entity:` 省略时推导为 `类名去 Repository + Entity`;`linkKey` 声明关联键后生成子表形态(不可推导,必须显式) |
| `@FoxyFilter` | Repository class | 声明列表筛选字段(单事实来源) |
| `@FoxyListViewModel(~~entity, repository~~)` | List ViewModel | entity/repository 都从类名推导(`XxxListViewModel` → `XxxEntity` / `XxxRepository`) |
| `@FoxyDetailViewModel(~~entity, repository~~, selects/flags/groups/exclude, skeleton)` | Detail ViewModel | entity 推导;repository 省略时同名仓库存在即生成行为骨架,`skeleton: false` 关闭 |
| `@FoxyLinkedListViewModel(~~entity, repository~~, ...)` | 子表列表 ViewModel | entity/repository 推导;生成关联键子集列表 + 行编辑骨架 |
| `@FoxyLinkedDetailViewModel(~~entity, repository~~, ...)` | 一对一子表 ViewModel | entity/repository 推导;生成 get-or-create 单行编辑器骨架 |

### 推导规则

| 事实 | 约定(默认) | 配置(例外) |
| --- | --- | --- |
| 表名 | `snake_case(类名去 Entity)` | `@FoxyFullEntity(table: 'xxx')` |
| 仓库绑定的实体 | 类名去 `Repository` + `Entity` | `@FoxyRepository(XxxEntity)` |
| VM 绑定的实体/仓库 | 类名去 VM 后缀 + `Entity`/`Repository` | `entity:` / `repository:` |
| 表单行为骨架 | 同名 `XxxRepository` 存在即启用 | `skeleton: false` |
| nullable 字段控制器 | `String?` 类型即声明 | —(无需任何声明) |
| select fallback | 实体构造器同名参数默认值 | `selects: {'type': 0}`(Map 显式) |

## 5 种模块形态

```
主表 List（列表页）
  └─ Detail（详情页，表单 + 多 Tab）
        ├─ Linked List Tab（子表行编辑，如生物的掉落）
        └─ Linked Detail Tab（一对一子表表单，如模板补充）
子表 Repository（linkKey 形态，无独立列表页）
```

### 形态 1:主表 List + Detail(生物、物品、任务……)

需要 4 个文件。以 `CreatureTemplate` 为例:

**`entity/creature_template_entity.dart`**
```dart
@FoxyBriefEntity()
@FoxyFullEntity()              // table 推导为 'creature_template'
class CreatureTemplateEntity with _CreatureTemplateEntityMixin {
  @FoxyBriefField()                // 字段级：进 Brief 列表行
  @FoxyFullField('entry', key: true)  // 物理列名 + 主键
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('name')
  final String name;

  @FoxyFullField('minlevel')
  final int minLevel;

  // ... 其余字段
  const CreatureTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.minLevel = 1,
    // ...
  });

  factory CreatureTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureTemplateEntityMixin.fromJson(json);
}
```

**`repository/creature_template_repository.dart`**
```dart
@FoxyRepository()             // entity 推导为 CreatureTemplateEntity
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
class CreatureTemplateRepository
    with RepositoryMixin, _CreatureTemplateRepositoryMixin {
  static const _table = 'creature_template';
}
```

**`view_model/creature_template_list_view_model.dart`**
```dart
@FoxyListViewModel()          // entity/repository 都从类名推导
class CreatureTemplateListViewModel
    with FieldControllerMixin, QueryVersionMixin, _CreatureTemplateListViewModelMixin {
  // 覆写点：记录复制/删除活动日志
  @override
  void _logActivity(ActivityActionType action, int key) { ... }
}
```

**`view_model/creature_template_detail_view_model.dart`**
```dart
@FoxyDetailViewModel(
  selects: {'type', 'faction'},             // Set：fallback 从构造器默认值推导
  flags: {'unitFlags', 'typeFlags'},        // 例外：FlagFieldController
  // repository 省略：同名仓库存在，行为骨架自动启用
)
class CreatureTemplateDetailViewModel
    with FieldControllerMixin, _CreatureTemplateDetailViewModelMixin {
  // 覆写点：加载实体后的语义钩子、提交后的活动日志
}
```

### 形态 2:子表 Repository(linkKey)

详情页的每个 Tab 对应一个子表仓库,`linkKey` 声明后生成「按关联键查子集合」的查询层:

```dart
@FoxyRepository(linkKey: ['entry'])   // entity 推导；linkKey 必须显式
@FoxyFilter.text('item')
class CreatureLootTemplateRepository
    with RepositoryMixin, _CreatureLootTemplateRepositoryMixin {
  static const _table = 'creature_loot_template';
}
```

生成方法形态(单关联键):

```dart
Future<List<BriefCreatureLootTemplateEntity>> getBriefCreatureLootTemplates(
  int entry, {int page = 1})            // 关联键是第一个位置参数
Future<int> countCreatureLootTemplates(int entry)
Future<CreatureLootTemplateEntity> createCreatureLootTemplate(int entry)
```

子表新增时,关联键自动填入,自增 ID 按「同关联键下最大 +1」分配(`nextMaxPlusOne(..., where: {...})`)。

### 形态 3:Linked List Tab(子表行编辑)

```dart
@FoxyLinkedListViewModel(
  selects: {'item'},                       // Set：fallback 从构造器默认值推导
)
class CreatureLootTemplateLinkedListViewModel
    with FieldControllerMixin, _CreatureLootTemplateLinkedListViewModelMixin {}
```

生成全套:关联键信号、分页、竞态 token、`copy/create/destroy/edit/persist/setLinkKey/_refresh`。

### 形态 4:Linked Detail Tab(一对一子表表单)

```dart
@FoxyLinkedDetailViewModel()
class CreatureTemplateAddonLinkedDetailViewModel
    with FieldControllerMixin, _CreatureTemplateAddonLinkedDetailViewModelMixin {}
```

要求实体**恰好一个物理 Key(关联键即主键)**;`_refresh` 用 get-or-create(无记录时用 `create*` 预建默认行)。

### 形态 5:复合键子表(手写,不走生成)

`player_create_info` 系列按 `(race, class)` 双关联键,`@FoxyLinkedListViewModel` 只支持单关联键——这类保持手写 Linked List。

## 字段类型 → 控制器 推断规则

| Entity 字段类型 | 生成控制器 | 备注 |
| --- | --- | --- |
| `int` | `IntFieldController` | |
| `double` | `DoubleFieldController` | |
| `String` | `StringFieldController` | |
| `bool` | `SelectFieldController<int>(fallback: 0)` | `collect() == 1` 转换;toJson 时 `1/0` |
| `String?` | `NullableStringFieldController` | 类型即声明,无需任何注解 |
| 例外:int | `SelectFieldController<int>(fallback)` | `selects: {'字段'}`(Set,fallback 取构造器默认值)或 `selects: {'字段': fallback}`(Map 显式覆盖) |
| 例外:String | `SelectFieldController<String>(fallback)` | 同上 |
| 例外:int(位标志) | `FlagFieldController` | 加 `flags: {...}` |
| 例外:int(动态组) | `IntFieldControllerGroup` | 加 `groups: {...}` |
| 不进表单 | — | 加 `exclude: {...}` |

约束(构建期校验,拼错即报错):

- `bool` 没有专用 controller,一律走 Select(见 `pickpocketing_loot_template_linked_list_view_model.dart` 的既有做法);
- `selects` fallback 类型必须与字段类型一致(int/String);Set 形态推导失败(构造器默认值不是 int/String 常量)时改用 Map 显式;
- `groups` 只支持 `int`;`flags` 只支持 `int`;
- 一个字段只能属于一个例外集合(selects/flags/groups/exclude 互斥)。

## 覆写模式

生成代码是 mixin,手写类可以:

- **`@override` 生成方法**:如 `CurrencyTypeRepository` 覆写 `countCurrencyTypes`(加物品 join),`getBriefCurrencyTypes`(选中文名);生成器不阻止,编译器保证签名一致;
- **覆写空实现钩子**:
  - `Repository._beforeStore` / `_beforeUpdate` / `_beforeDestroy`(写前校验或补充字段);
  - `Form._afterApplyCandidate`(加载实体后的联动,如编辑规格刷新);
  - `Form._logActivity` / `List._logActivity`(活动日志,entityName 各页不同);
  - `List._refresh` 内部整体可覆写(不常见);
- **在手写类里声明 `static const _table`**:生成器校验它必须与 `@FoxyFullEntity.table` 一致,不一致构建期报错;
- **给 Repository 混入 `DbcLocaleRepositoryMixin` 并声明 `dbcLocaleTableName`**:生成器检测到后生成 `get*Locales` / `save*Locales` 委托;
- **保持手写方法不进生成范围**:Repository 里没被 `@FoxyRepository` 覆盖的私有方法照常可用(如 `CurrencyTypeRepository._applyLocaleFilter` / `_getNextId`)。

## 常见错误与修复

所有构建期错误都带 `修复方式:`(todo 文案),下面是几个典型:

| 错误 | 原因 | 修复 |
| --- | --- | --- |
| `XxxEntity 必须应用约定 Mixin _XxxEntityMixin` | 手写类没混入生成的 mixin | `with _XxxEntityMixin` |
| `XxxEntity 缺少正确的 part 'xxx_entity.g.dart'` | 没声明生成 part | 加 `part 'xxx_entity.g.dart';` |
| `XxxEntity 必须保留约定签名的 fromJson factory 委托` | factory 签名不符 | 委托到 `_XxxEntityMixin.fromJson(json)` |
| `XxxEntity 没有物理主键字段` | 没有 `@FoxyFullField(key: true)` | 至少一个 key 字段 |
| `XxxRepository 必须混入 _XxxRepositoryMixin` | 没混入 | `with RepositoryMixin, _XxxRepositoryMixin` |
| `XxxRepository._table 与 XxxEntity 的物理表不一致` | `_table` 与表名不符 | 对齐 |
| `Xxx 缺少 part 'xxx.g.dart'` | 缺 part | 补上 |
| `Xxx 必须混入 FieldControllerMixin` / `...Mixin` | List VM 缺基座 | 加 `FieldControllerMixin, QueryVersionMixin` |
| `... 已手写 copyWith ... 与生成成员冲突` | 手写了生成成员 | 删手写,保留 Entity 特有业务方法 |
| `XxxEntity 必须声明 @FoxyBriefEntity` | 查询层生成 `getBrief*` 返回 `BriefXxxEntity` | 给 Entity 加 `@FoxyBriefEntity()`(表格行展示模型声明) |
| `... 推导出文件 xxx.dart，但文件不存在` / `找不到 class` | 推导的仓库/实体未迁移或类名不符 | 创建并迁移同名类,或在注解显式声明 |
| `... 无法推导 entity 类名` | VM 类名无约定后缀 | 用 `XxxListViewModel` 等规范命名 |
| `... 的构造默认值不是可求值的常量` | `selects` Set 形态推导 fallback 失败 | 改用 Map 显式:`selects: {'字段': fallback}` |
| `... 不能同时声明 repository 与 skeleton: false` | 两个互斥参数同时传 | 只保留一个 |
| `... 缺少对应列 ... 无法推断物理列` | `@FoxyFilter` 名与实体字段不一致 | 显式 `column:` 或改名 |
| `... 只能使用无参数的 @FoxyBriefField()` | 字段级误用带参形式 | 类级具名构造函数是投影别名,字段级只能无参 |
| `... 必须且只能声明一个 @FoxyFullEntity` | 同文件多个 Full Entity | 拆到独立文件 |
