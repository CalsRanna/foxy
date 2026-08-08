# 生成器实现详解

本文逐个生成器拆解 **reader / model / emitter / generator** 四层。按生成链路上游到下游排列:Entity → Repository(+Filter)→ Form → List → Linked List → Linked Detail。

约定:每层文件都位于 `packages/foxy_generator/lib/src/`;`*_generator.dart` 是 source_gen 入口,`*_reader.dart` 读注解做校验产出模型,`*_model.dart` 是纯数据结构,`*_emitter.dart` 拼字符串产代码。所有 `_fail` 抛 `InvalidGenerationSourceError`(带 `todo` 修复文案)。

---

## 0. 共享基础设施

### `dart_literal.dart` — 常量 → Dart 字面量

Entity / Repository / Filter 三个 emitter 都要把常量值写回 Dart 源码,统一在这里转义:

- `dartLiteral(value, {asType})`:`asType == 'double'` 时整数补成 `1.0`(避免 `double` 字段默认值退化成 `int`);`double` 纯整数形式补小数点;其余原样。
- `dartStringLiteral(value)`:单引号字符串,转义 `\`、`'`、`$`(防字符串插值)、`\n\r\t`。

表名/列名一律经 `dartStringLiteral`,列名再包一层反引号(见 Repository)。

### `naming.dart` — 命名工具

- `toSnakeCase`:`AchievementEntity` → `achievement_entity`;连续大写按缩写切分(`NPCVendorRepository` → `npc_vendor_repository`)。
- `pluralize`:`GemProperty` → `GemProperties`(辅音 + y → ies,避免 `GemPropertys`);与手写仓库的 `getBrief*/count*` 命名对齐。

### `convention.dart` — 约定推导(Convention over Configuration)

所有「从类名推导」的规则集中于此,reader 只在注解省略参数时回退到推导值,显式参数永远优先:

- `tableNameOf`:`CreatureLootTemplateEntity` → `creature_loot_template`(类名恰为 `Entity` 返回空,调用方报错);
- `entityClassNameOfRepository` / `repositoryClassNameOfEntity`:一对一命名互推;
- `baseNameOfViewModel` / `entityClassNameOfViewModel` / `repositoryClassNameOfViewModel`:按最长后缀剥离(`LinkedDetailViewModel` > `LinkedListViewModel` > `DetailViewModel` > `ListViewModel`——`XxxLinkedDetailViewModel` 以 `DetailViewModel` 结尾,必须先剥长后缀)。

### `entity_resolver.dart` — 推导类名的解析

推导出的类名没有注解 `typeValue` 可用,需要按约定路径(`lib/<层>/<snake_case(类名)>.dart`)解析出真实 `ClassElement`:

- `resolveClass(buildStep, errorElement, className, directory, context)`:canRead 文件 → `resolver.libraryFor` → 按类名取 ClassElement;失败抛 `InvalidGenerationSourceError`(带修复文案)。
- `resolveFullEntity(...)`:在 `resolveClass` 之上校验 `@FoxyFullEntity` 唯一,并读物理表名(`table:` 省略时回退 `tableNameOf` 推导)。

---

## 1. Entity 生成器(`FoxyEntityGenerator`)

入口 [entity_generator.dart],基类 `GeneratorForAnnotation<FoxyFullEntity>`,`typeChecker` 指向 `FoxyFullEntity`。一个 `@FoxyFullEntity` 类产出一个 part。

### Reader([entity_reader.dart])→ `EntityGenerationModel`

读取流程与校验:

1. **结构校验**(`_validateSourceShape`):手写源码必须匹配
   - `class XxxEntity with _XxxEntityMixin`(正则,含边界);
   - `part 'xxx_entity.g.dart';`;
   - 约定签名的 `factory XxxEntity.fromJson(Map<String, dynamic> json) => _XxxEntityMixin.fromJson(json);`(多行正则)。
2. **唯一性校验**(`_validateUniqueFullEntity`):每个库(文件)必须且只能一个 `@FoxyFullEntity` class。
3. **成员冲突校验**(`_validateNoGeneratedMemberConflicts`):手写类不允许存在 `copyWith` / `toJson` / `toString` / `==` / `hashCode`(生成成员);必须声明唯一的 `fromJson` factory。
4. **构造校验**:必须有无名 generative 构造;每个非静态字段必须对应同名 named initializing formal(`this.x = ...`);`required` 参数不支持;字段必须 `final`、不能有字段初始化器(默认值移到构造参数)。
4. **表名推导**:`@FoxyFullEntity(table:)` 省略时按 `convention.tableNameOf(className)` 推导(显式声明优先);推导为空(类名恰为 `Entity`)报错。
5. **字段读取**(`_readField`):从 `@FoxyFullField(name, key:)` 取物理列名与 key 标记;从构造参数 `computeConstantValue()` 取编译期常量默认值;类型仅支持 `int`/`double`/`String`/`bool` 及 nullable 形式;`nullable` 由类型 `?` 推断,默认值可为 null。
6. **Brief 读取**:字段级 `@FoxyBriefField()`(无参)标记物理字段进 Brief;类级 `@FoxyBriefField.text/integer/decimal/boolean('name')` 声明投影别名(非物理列,由 Repository 查询提供,如 locale 的 `localeName`)。

产出模型:

```
EntityGenerationModel
├── className / mixinName / inputFileName / table
├── generateBrief            # 是否声明 @FoxyBriefEntity
├── fields                   # Full 字段(含 includeInBrief / nullable / key / columnName)
├── briefProjectionFields    # 类级投影别名
├── baseName / briefClassName / keyClassName / keyFields
└── briefFields = 物理Brief字段 + 投影别名
```

### Validator([entity_validator.dart])

模型级校验(Reader 已做的除外):

- `table` 非空;类名以 `Entity` 结尾;
- 至少一个 `key: true` 字段;
- 物理列名在 Entity 内唯一(区分大小写);
- 投影别名必须是合法 lowerCamelCase,且不与 Full 字段/其他投影重名;
- **声明了 `@FoxyBriefEntity` 时,所有 key 字段必须标注 `@FoxyBriefField`**(否则 Brief 行无法还原完整物理身份);未声明时,任何 Brief 标注都报错(防止误标)。

### Emitter([entity_emitter.dart])→ `emitEntityPart`

按「Sort Members」顺序拼接三个区块:

1. **`BriefXxxEntity`**(`emitBrief`,若 `generateBrief`):final 类,字段保持原序 → 无名构造(带默认值)→ `fromJson` → `hashCode` → `key` getter(单 key 返回标量;复合 key 返回 `XxxKey`)→ `==` → `toString`。
2. **`XxxKey`**(`emitKey`,若 key 字段 > 1):复合主键值对象,`fromEntity` factory。
3. **`_XxxEntityMixin`**(`emitFullMixin`):mixin 成员顺序 = hashCode → `==` → `copyWith` → `toJson` → `toString` → 静态 `fromJson`。

`fromJson` 类型转换(`_fullFromJson`):`int`/`double` 经 `num?.toInt/toDouble` + 默认值兜底;`String` 经 `toString()`;`bool` 特殊——`json[x] == null ? 默认值 : (json[x] as num).toInt() == 1`(兼容 MySQL tinyint 的 0/1)。`toJson`(`_fullToJson`):`bool` 写 `1/0`(nullable 时 `null` 原样)。

`copyWith` 参数类型:非 nullable 字段 → `T?`,`field ?? self.field`;nullable 字段 → 原类型。

关键点:所有成员都 `final self = this as XxxEntity;`——mixin 被 `with` 混入,`this` 是手写类的运行时类型,`as` 保证类型安全。

---

## 2. Filter 生成器(`FoxyFilterGenerator`)

入口 [repository_filter_generator.dart],基类 `Generator`(非注解级,全库扫描 `@FoxyFilter` 标注的 class)。

### Reader([repository_filter_reader.dart])→ `RepositoryFilterGenerationModel`

- 只能标注以 `Repository` 结尾的 class;文件位置必须 `lib/repository/<snake_case>.dart`;必须有 `part 'xxx.g.dart';`。
- 每个 `@FoxyFilter` 注解读 `name` / `type`(enum index→`FoxyFilterType`)/ `defaultValue`(类型强匹配)/ `column`(可省略,省略时由 Repository 生成器从 Entity 推断)。
- 字段名必须匹配 `^[a-z][A-Za-z0-9]*_?$`(lowerCamelCase;Dart 保留字允许追加单个 `_`,如 `class_`)。

`readFilterField` 是**独立函数**,Filter 生成器与 Repository 生成器共用,保证两边读到一致的字段定义。

### Emitter([repository_filter_emitter.dart])→ `XxxFilter` 类

final 类:字段(原序)→ 无名构造(带默认值)→ `fromJson` → `copyWith` → `toJson`。字段类型由 `FoxyFilterType` 映射:`boolean→bool`、`decimal→double`、`integer→int`、`text→String`。

---

## 3. Repository 生成器(`FoxyRepositoryGenerator`)

入口 [repository_generator.dart],基类 `GeneratorForAnnotation<FoxyRepository>`。**这是最复杂的生成器**,产出两类仓库:

- **主表仓库**(有 List ViewModel):完整查询层 + `_applyFilter`。
- **子表仓库**(声明 `linkKey`):关联键子集查询层(无 `_applyFilter`、无全量列表)。

两者由 `queryLayerEnabled = listViewModelPresent || declaredLinkKeys.isNotEmpty` 决定是否生成查询层;`listViewModelPresent` 通过 `buildStep.canRead` 探测 `lib/view_model/<base>_list_view_model.dart` 是否存在。

### Reader([repository_reader.dart])→ `RepositoryGenerationModel`

读取流程与校验:

1. **结构校验**:类名以 `Repository` 结尾;文件位置正确;`part` 声明;必须混入 `_XxxRepositoryMixin`(正则检查 with 列表);`static const _table` 必须与实体的物理表名一致。
2. **绑定实体**:`@FoxyRepository(entity:)` 显式传入时校验命名一对一(安全网);省略时按 `convention.entityClassNameOfRepository` 推导,再经 `resolveFullEntity` 解析出 ClassElement 并读表名。
3. **Key 推断**:扫描实体 `@FoxyFullField(key: true)` 字段;**nullable 的 key 直接报错**(SQL `列 = NULL` 恒不成立,`_whereKey` 会静默匹配 0 行误报「原记录不存在」)。
4. **Brief 投影列**:字段级 `@FoxyBriefField()` 的物理列收集到 `briefProjectionColumns`(查询 select 用)。
5. **linkKey 校验**:每个声明的 `linkKey:` 必须是实体 key 字段(dart 名);声明了查询层但没有 `@FoxyBriefEntity` / 没有投影列时报错——查询层生成的 `getBrief*`/`count*` 返回 `BriefXxxEntity`,Brief 是「表格行展示模型」声明,与 linkKey 正交但查询层必须依赖它在场。
6. **Filter 读取**(`_readFilterFields`):`column` 未声明时从 Entity 同名字段推断物理列;推断失败时——主表仓库(有 List VM)报错,子表仓库(无 List VM,不生成 `_applyFilter`)允许(Filter 类仍生成,仅作查询输入对象)。
7. **locale helpers**:源码同时出现 `DbcLocaleRepositoryMixin` 与 `dbcLocaleTableName` 时启用(`localeHelpersEnabled`),生成 `get*Locales` / `save*Locales` 委托;`on` 子句相应扩宽到 `DbcLocaleRepositoryMixin`。

### Emitter([repository_emitter.dart])→ `_XxxRepositoryMixin on RepositoryMixin`

成员按「Sort Members」:公开方法按名(copy → count → create → destroy → getBrief → get → getXxxs → getXxxLocales → saveXxxLocales → store → update),私有方法按名(_applyFilter → _before* → _whereKey)。

| 方法 | 形态 | 说明 |
| --- | --- | --- |
| `copyXxx(key)` | 主/子表 | `get` → 不存在抛 `RecordNotFoundException` → `create`(子表带关联键)→ `copyWith`(key 换成新分配)→ `store`;返回新 key |
| `countXxxs(...)` | 主表:`({filter})` | `_applyFilter(laconic.table(t), filter).count()` |
| | 子表:`(linkKey)` | `laconic.table(t).where('`entry`', entry).count()`(无 filter) |
| `createXxx()` | 主表 | 全 key 字段 `nextMaxPlusOne(table, '`ID`')` |
| | 子表:`(linkKey)` | 关联键直接填参,非关联 key 字段 `nextMaxPlusOne(..., where: {...})`(同关联键下最大+1) |
| `destroyXxx(key)` | 主/子表 | `_beforeDestroy` → `_whereKey(...).delete()` → 0 行抛 `RecordNotFoundException` |
| `getXxx(key)` | 主/子表 | `_whereKey(...).limit(1).get()` → null 或 `fromJson` |
| `getBriefXxxs(...)` | 主表:`({page, filter})` | select 投影列 → `_applyFilter` → orderBy key → limit/offset |
| | 子表:`(linkKey, {page})` | select 投影列 → where 关联键 → orderBy → limit/offset |
| `getXxxs()` | 仅主表 | 全量列表(`orderBy key`),供 DBC export 等消费方 |
| `get*Locales` / `save*Locales` | 仅 locale helpers | 委托 `loadDbcLocaleField` / `storeDbcLocaleField` |
| `storeXxx(entity)` | 主/子表 | 单 int key 且 `<= 0` 抛 `InvalidPrimaryKeyException` → `_beforeStore` → `prepareWriteJson(toJson())` → insert,duplicate 翻译 `DuplicateKeyException` |
| `updateXxx(originalKey, entity)` | 主/子表 | `_beforeUpdate` → update,duplicate 翻译;**「未命中 0 行」判断在 try 之外**(否则会被 duplicate 分支重新检查)→ 抛 `RecordNotFoundException` |
| `_applyFilter` | 仅主表 | 对每个 filter 字段:`bool/decimal/integer` 与默认值不等才生效;`text` 非空才生效;`builder.where('`col`', value)` |
| `_beforeStore` / `_beforeUpdate` / `_beforeDestroy` | 恒生成 | 空实现覆写钩子 |
| `_whereKey` | 恒生成 | 单 key:`.where('`col`', key)`;复合 key:链式 `.where(...)` |

几个细节:

- **列名反引号**:`_column` 把物理列名包反引号再写 Dart 字符串(`'`rank`'`),laconic 不转义标识符,反引号统一规避 MySQL 保留字(`index`、`rank`),无需白名单。
- **`_table` 内联**:mixin 无法按裸名访问宿主类的 `static const _table`,所以 `_table(model)` 直接内联字面量;`_table` 声明本身仍由 Reader 校验一致。
- **子表 `copy` 关联键**:`copyXxx` 时 `create(linkKey)` 用 `source.linkKey`,保证复制仍落在同一关联键下。

---

## 4. Form 生成器(`FoxyViewModelGenerator`)

入口 [form_generator.dart],基类 `GeneratorForAnnotation<FoxyDetailViewModel>`。

### Reader([form_reader.dart])→ `FormGenerationModel`

- 只能标注 `XxxViewModel`;文件位置正确;`part`;必须混入 `_XxxViewModelMixin`,且 `FieldControllerMixin` 必须在 `with` 列表里**位于** `_XxxViewModelMixin` **之前**(mixin 解析顺序,否则生成的 `registerController` 调用无法解析)。
- **绑定实体**:`entity:` 显式传入时校验;省略时按 `convention.entityClassNameOfViewModel` 推导(最长后缀剥离,所以 `@FoxyDetailViewModel` 标在手写 `*LinkedListViewModel` 类上也能正确解析),再经 `resolveFullEntity` 解析。
- 实体必须有 unnamed generative 构造;从构造参数(仅 named initializing formal)读字段,顺序 = 构造参数顺序。
- **例外集合读取 + 互斥校验**:`selects`(Map 显式 fallback **或** Set 推导 fallback,见下)/ `flags` / `groups` / `exclude`(Set);`nullable` 已删除——`String?` 类型本身就是声明;一个字段只能属于一个集合;所有例外字段名必须真实存在于实体(拼错即报错)。
- **类型推断**(`_readField`):`groups` 只支持 `int`;`String?` 自动走 `NullableStringFieldController`(无需声明);`selects` Set 形态的 fallback 从实体构造器同名参数常量默认值推导(`_deriveSelectFallback`,取不到报错提示改用 Map);`flags` 只支持 `int`;其余必须 ∈ {int, double, String, bool}。
- **Key 推断**(`_readEntityKeyField`):从 `@FoxyFullField(key: true)`;单 key 返回 (类型, 名),复合 key 返回 (`XxxKey`, null)——后者不能用于 Linked Detail。
- **repository 推导 + 骨架开关**:`repository:` 显式传入时 `skeletonEnabled = true`;省略时探测同名 `lib/repository/<base>_repository.dart` 是否存在且含 `@FoxyRepository`(约定:存在即启用行为骨架);`skeleton: false` 显式关闭(与 `repository:` 互斥,构建期校验)——只读/特殊持久化表单的出口。

### Emitter([form_emitter.dart])→ `_XxxViewModelMixin on FieldControllerMixin`

字段区(skeleton 开启时):`_repository`(GetIt)→ `entity` / `persistedKey` / `loading` / `submitting` / `errorMessage` 信号 → 各字段 controller。

controller 声明(`_controllerDeclaration`):

| kind | 生成 |
| --- | --- |
| plain int | `late final xController = registerController(IntFieldController());` |
| plain double | `... DoubleFieldController());` |
| plain String | `... StringFieldController());` |
| plain bool | `... SelectFieldController<int>(fallback: 0));`(多行) |
| select | `... SelectFieldController<int/String>(fallback: ...));`(多行) |
| flag | `... FlagFieldController());` |
| group | `... IntFieldControllerGroup());` |
| nullable | `... NullableStringFieldController());` |

controller 名 = 字段名去尾部 `_`(`class_` → `class`,Dart 保留字转义)。

方法区(skeleton 开启时,按「Sort Members」):

- `dispose()` → `disposeControllers()`;
- `initSignals({key})`:无 key → `createXxx()` 预建空白行 + `_applyCandidate`;有 key → `getXxx(key)`,null 抛 `RecordNotFoundException`;错误写 `errorMessage` + `LoggerUtil.e` + rethrow;finally `loading=false`;
- `persist()`:`submitting` 防重入(`BusyException`)→ `_collectCandidate` → 按 `persistedKey` 区分 store/update → 写回 `persistedKey`(单 key 用 `candidate.key`,复合用 `XxxKey.fromEntity`)→ `_logActivity(action, candidate)` → 错误 `foxyErrorMessage` + rethrow;
- `_afterApplyCandidate(entity)` 空钩子;`_applyCandidate(entity)` 逐 controller `init`(bool 转 1/0)+ 末尾调 `_afterApplyCandidate`;`_collectCandidate()` 逐 controller `collect`(bool `== 1` 还原);
- `_logActivity(action, entity)` 空实现覆写钩子。

---

## 5. List 生成器(`FoxyListViewModelGenerator`)

入口 [list_generator.dart],基类 `GeneratorForAnnotation<FoxyListViewModel>`。

### Reader([list_reader.dart])→ `ListGenerationModel`

- 只能标注 `XxxListViewModel`;文件位置;`part`;必须混入 `_XxxListViewModelMixin`,且 `FieldControllerMixin` 与 `QueryVersionMixin` 都必须位于它**之前**。
- **绑定实体/仓库**:`entity:` / `repository:` 省略时都从类名推导;推导出的仓库经 `resolveClass` 解析并校验 `@FoxyRepository` 唯一(显式传入时保留一对一命名安全网)。
- **筛选字段**:从仓库 `@FoxyFilter` 读取(不在 List 注解里重复,单一事实来源);**只支持 `@FoxyFilter.text`**(其它类型构建期报错)。
- Key 类型:单 key → 字段类型;复合 key → `XxxKey`。
- 方法名按命名约定直接取:`getBrief<Base>s` / `count<Base>s` / `copy<Base>` / `destroy<Base>`(手写 `@override` 顶掉生成版,签名不匹配由编译器报错)。

### Emitter([list_emitter.dart])→ `_XxxListViewModelMixin on FieldControllerMixin, QueryVersionMixin`

字段:`_repository` → `items`(Brief 列表信号)→ `page`(`@override`,QueryVersionMixin 的抽象 `page` getter 由它满足)→ `total` → `loading` / `submitting` / `errorMessage` → 每个 text 筛选字段一个 `StringFieldController` → `_refreshToken`。

方法(copy → destroy → dispose → initSignals → paginate → reset → search → _collectFilter → _logActivity → _refresh):

- `copy(key)` / `destroy(key)`:`submitting` 防重入 → 调仓库 → `_logActivity` → (destroy 额外 `normalizePageAfterDelete`)→ `_refresh`;错误写 `errorMessage` + rethrow。
- `initSignals()` → `_refresh()`;`paginate(page)` / `reset()` / `search()` 都会 `markQueryVersion()`(表格回顶)。
- `_collectFilter()` 逐 controller `collect` 构 `XxxFilter`。
- `_refresh()`:竞态 token(`++_refreshToken`)→ `getBriefXxxs` 与 `countXxxs` **并行**(`.wait`)→ token 不匹配直接丢弃;`items` / `total` 写入;`loading` 由 token 守卫;错误 `foxyErrorMessage`(token 不匹配则静默)。

---

## 6. Linked List 生成器(`FoxyLinkedListViewModelGenerator`)

入口 [linked_list_generator.dart],基类 `GeneratorForAnnotation<FoxyLinkedListViewModel>`。

### Reader([linked_list_reader.dart])→ `LinkedListGenerationModel`

- **复用 `FormReader`**(controller 样板与 Detail 完全同构),再叠加链接语义;`repository:` 省略时从类名推导,经 `resolveClass` 解析并校验 `@FoxyRepository`;
- 仓库必须 `@FoxyRepository` 且**恰好一个 `linkKey`**(复合关联键如 player_create_info 系列保持手写,构建期明确报错);
- `linkKey` 字段必须在实体上且类型为 `int`。

### Emitter([linked_list_emitter.dart])→ `_XxxLinkedListViewModelMixin on FieldControllerMixin`

字段:`_repository` → `linkKey`(int? 信号)→ `items` → `editingKey` / `selectedKey` → `page` / `total` / `loading` / `submitting` / `errorMessage` → 各字段 controller(复用 `FormEmitter` 的 controller 样板,`skeletonEnabled: false` 关掉行为骨架,`substring` 取 mixin 主体)。

方法(全部带**双竞态守卫**:`_refreshToken` + `_interactionToken`,且每次操作前快照 `linkKey`,结束后校验 `linkKey.value != link` 则丢弃结果——防止 Tab 切换后旧数据回写):

- `copy(key)` / `create()` / `destroy(key)` / `edit(key)` / `persist()`:先 `submitting` 防重入 + `linkKey.value` 非空校验(`LinkNotLoadedException`),操作后 token 守卫 + linkKey 校验,再 `_refresh`;
- `dispose()` / `initSignals({linkKey})` → `setLinkKey(linkKey)`;
- `paginate(page)`:递增 `_interactionToken`,更新 page,`_refresh`;
- `setLinkKey(linkKey)`:递增 `_interactionToken`;linkKey 变化时 page 重置为 1;清空编辑/选中;`_applyCandidate(Entity(linkField: link))`(表单字段预填关联键);`_refresh`;
- `_refresh()`:`countXxxs(link)` → 计算 `lastPage = max(1, (count / kPageSize).ceil())` → `nextPage = min(page, lastPage)` → `getBriefXxxs(link, page: nextPage)` → token 守卫写 `page`/`items`/`total`,清空编辑/选中。

---

## 7. Linked Detail 生成器(`FoxyLinkedDetailViewModelGenerator`)

入口 [linked_detail_generator.dart],基类 `GeneratorForAnnotation<FoxyLinkedDetailViewModel>`。

### Reader([linked_detail_reader.dart])→ `LinkedDetailGenerationModel`

- 复用 `FormReader`;`repository:` 省略时从类名推导,经 `resolveClass` 解析并校验 `@FoxyRepository`,推导不到报错(Linked Detail 没有"仅 controller"形态);
- 实体必须**恰好一个物理 Key**(复合键报错,保持手写)。

### Emitter([linked_detail_emitter.dart])→ `_XxxLinkedDetailViewModelMixin on FieldControllerMixin`

字段:`_repository` → `linkKey` / `editingKey` / `entity`(状态信号)→ `loading` / `submitting` / `errorMessage` → controller 样板(复用 `FormEmitter`)。

方法(destroy → dispose → initSignals → persist → setLinkKey → _refresh):

- `destroy()`:`editingKey` 为 null 直接 return(尚未创建);快照 `linkToken` + `linkKey`,操作后双守卫,再 `_refresh`;
- `initSignals({linkKey})` → `setLinkKey(linkKey)`;
- `persist()`:`linkKey` 非空校验;`_collectCandidate`;按 `editingKey` 区分 store/update;守卫后写 `entity` / `editingKey`(用 `candidate.singleKeyFieldName`)→ `_refresh`;
- `setLinkKey(linkKey)`:已加载同 key 直接 return;**get-or-create 语义**在 `_refresh`:`getXxx(link)` → null 时 `createXxx(link)` 预建默认行 → `_applyCandidate`(编辑键:已有记录为 link,新预建为 null);
- `_refresh()`:token 守卫;linkKey 为 null 清空实体;错误 `foxyErrorMessage` + `LoggerUtil.e` + rethrow。

---

## 8. Builder 与 `build.yaml` 的接线

- `build.yaml`:`generate_for` 限定三个 Builder 的输入范围(`lib/entity/**_entity.dart` 等),三个 Builder 的 `build_extensions` 都映射到同名 `.g.dart`(`build_to: cache` + `applies_builders: source_gen:combining_builder`,由 combining builder 汇总)。
- `builder.dart`:SharedPartBuilder 的 part 名(第二个参数)是 `foxy_entity` / `foxy_repository` / `foxy_view_model`;生成器列表按名排序(见顶部表)。
- **为什么 Filter 生成器排在 Repository 前**:part 顶层遵循「Sort Members」,公开 class(Filter)在前、私有 mixin(Repository)在后。

## 9. 各生成器产物速查(以 `CurrencyType` 为例)

| 源文件 | 生成产物 |
| --- | --- |
| `entity/currency_type_entity.dart` | `BriefCurrencyTypeEntity` + `_CurrencyTypeEntityMixin`(copyWith/toJson/fromJson/==/hashCode/toString) |
| `repository/currency_type_repository.dart` | `CurrencyTypeFilter`(公开)+ `_CurrencyTypeRepositoryMixin`(copy/count/create/destroy/get/getBrief/getXxxs/store/update/_applyFilter/_whereKey/_before*) |
| `view_model/currency_type_list_view_model.dart` | `_CurrencyTypeListViewModelMixin`(copy/destroy/initSignals/paginate/reset/search/_collectFilter/_refresh) |
| `view_model/currency_type_detail_view_model.dart` | `_CurrencyTypeDetailViewModelMixin`(controller 样板 + initSignals/persist/dispose/_logActivity/_applyCandidate/_collectCandidate) |

> `getXxxs`(全量列表)只为主表仓库生成(子表无 DBC export 等全量消费方);`get*Locales`/`save*Locales` 只在仓库混入 `DbcLocaleRepositoryMixin` 时生成。
