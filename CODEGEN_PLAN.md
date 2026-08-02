# 代码生成演进计划:Repository 查询层全量生成

> 状态:已实施(2026-08-01)
> 创建日期:2026-08-01
> 关联文档:[`AGENTS.md`](AGENTS.md)(当前架构约束)、[`README.md`](README.md)(代码生成概览)

## 实施结果摘要

- Step 1 完成:9 个聚合 Brief 实体与 `getBriefLootTemplateEntries`/`countLootTemplates` 已删除,6 个 picker 委托改用行级 `getBrief*Rows`/`count*Rows`(`idOf` 取 `t.entry`);reference 方法名规范化为 `getBriefReferenceLootTemplates`/`countReferenceLootTemplates`/`copyReferenceLootTemplate`(`Future<ReferenceLootTemplateKey>`);condition 的 `copyCondition` 改为返回 `Future<ConditionKey>`;契约测试同步更新。
- Step 2 完成:`@FoxyFilter` 增加可选 `column:`;`_applyFilter` 列名按「filter 名 → 同名实体字段 → 该字段列名」推断,无法推断且未声明 `column` 时构建期报错;`repository_emitter` 新增 `create`/`copy`/`getBrief*`/`count*`/`get*`/`_applyFilter` 生成(查询层仅对存在 `lib/view_model/<base>_list_view_model.dart` 的仓库生成);`repository_reader` 删除「同签名手写 CRUD 禁止」;`list_reader` 删除文本正则签名匹配,改为约定名(`getBrief<Base>s`/`count<Base>s`/`copy<Base>`,辅音 + y 结尾按 y → ies 复数化)。
- Step 3 完成:16 个纯仓库删除手写查询层改用生成版;10 个 join/like/上限校验仓库保留手写 `@override`(area_table 的 `create`/`copy` 保留 AreaBit 预分配;currency_type 的 locale 过滤改名为 `_applyLocaleFilter` 避免签名冲突;reference 的 `_applyRowFilter` 改名为 `_applyFilter` 以覆盖生成版);12 个无法推断的 filter 补了 `column:`;`dart run build_runner build --delete-conflicting-outputs` 全量重新生成,`flutter analyze` 无告警。
- Step 4 完成:`repository_generator_vm` 新增查询层生成/复数化/`column` 推断错误断言,删除「手写标准 CRUD 拒绝」;`list_generator_vm` 删除 reference 特例测试,改为约定名断言;`dart test test/infrastructure/codegen`(38 个)与 `flutter test`(375 个)全绿。
- 与计划的主要偏差:纯仓库的 `getXxxs` 统一带 key orderBy(导出层自行按 ID 排序,无行为影响);`_table` 常量在 4 个完全迁移的仓库标记 `ignore: unused_field`(mixin 无法访问类静态成员,生成代码内联表名字面量)。

## Context

当前代码生成器只覆盖"纯样板":Entity 值语义、标准 CRUD(`get`/`store`/`update`/`destroy`)、Filter 值对象、List/Detail ViewModel 样板。而**查询层(`getBrief*`/`count*`/`copy*`/`create*`/`_applyFilter`)全部手写**——76 个仓库有手写 `_applyFilter`,是代码库最大的手写量,且高度模式化。

目标架构(已确认):**生成器全量生成,手写壳用 `@override` 顶掉生成版**(Dart 语言机制:类成员优先于 mixin 成员;晚绑定保证覆盖自动传播到所有生成调用方)。生成器不再检测/跳过手写方法。覆盖传播示例:生成 `copyXxx` 调用 `createXxx()`,若壳 override 了 `createXxx`(如 achievement 的 ID 上限校验),生成 copy 自动用上校验版。

范围决策(已确认):
1. **去聚合修复全部 9 个 loot 仓库**(聚合 Brief 是设计冗余,只被 picker 使用)
2. **locale join 参数化分两步走**:本期做机制 + 纯仓库迁移,locale join 仓库保留手写 override
3. **Detail/编辑器 VM 骨架生成排到下一期**

## 现状关键事实(已探明)

- 26 个主表仓库(有 `@FoxyListViewModel`)方法命名完全统一:`getBrief<BaseName>s` / `count<BaseName>s`(复数=简单加 s)、`copy<BaseName>` / `create<BaseName>`(单数)、`get<BaseName>s()`(全量,DBC export 用)
- 复合 key 主表(condition/smart_script/gossip_menu)**都有手写 copy**,所以 copy 总是生成
- `_applyFilter` 中 text filter:96 处精确匹配、6 处 LIKE;filter 名 ≠ 实体字段名的占多数(如 `filter('name')` → 列 `AreaName_lang_zhCN`)
- 聚合 Brief(`Brief*LootTemplateEntryEntity`)9 个,只被 `foxy_entity_picker_delegates.dart` 的 9 个 picker 委托使用(显示"模板 ID + 掉落项数")
- reference_loot_template 的列表方法名 `getBriefLootTemplateRows` 与约定名不符,`list_reader` 用文本正则签名匹配兼容它——去聚合 + 规范化后正则可删

## Step 1: 去聚合修复(9 个 loot 仓库)

前置步骤,消除"签名不匹配"这一 override 覆盖不了的场景。

**删除**(9 个仓库 + 9 个实体文件):
- `lib/entity/brief_{creature,disenchant,game_object,item,milling,pickpocketing,prospecting,reference,skinning}_loot_template_entry_entity.dart`
- 各仓库的 `getBriefLootTemplateEntries`(分组聚合查询)与 `countLootTemplates`(GROUP BY Entry 的 count,注意与 `countLootTemplateRows` 区分,后者保留)

**picker 改造**(`lib/widget/foxy_entity_picker_delegates.dart` 9 处):改用行级 `getBriefLootTemplateRows` / `countLootTemplateRows`,显示列从"模板 ID + 掉落项数"改为行级字段(模板 ID + 物品名/Reference),`idOf` 保持取 `t.entry`(Reference 字段语义不变)。

**reference 方法名规范化**(对齐约定名,内容保留——其行级查询带 item join,需手写 override):
- `getBriefLootTemplateRows` → `getBriefReferenceLootTemplates`(list VM 调用约定名)
- `countLootTemplateRows` → `countReferenceLootTemplates`
- `copyLootTemplate` → `copyReferenceLootTemplate`,返回类型统一为 `Future<ReferenceLootTemplateKey>`(现在返回 void,与生成版签名冲突)
- `getBriefLootTemplates(int entry)` / `countLootTemplatesForEntry(int entry)`(detail 子表用,带父键参数)保留原名,与生成版签名不同不冲突
- condition 的 `copyCondition` 返回 void 同理改为 `Future<ConditionKey>`

**契约测试**:检查 `reference_loot_template_contract_test.dart` 等是否断言聚合 Brief,同步更新。

## Step 2: Repository 生成器扩展(查询层全量生成)

### 注解扩展(`repository_annotations.dart`)

`@FoxyFilter.text/integer/decimal/boolean` 加可选 `column:` 参数(物理列名)。推断规则:**filter 名 → 同名实体字段(dart 名)→ 该字段的 `@FoxyFullField` 列名**;无同名实体字段 → 构建期错误,要求显式 `column`。`integer/decimal/boolean` 的匹配语义同理(等值匹配)。

### 生成成员(`repository_emitter.dart` 新增,遵循现有成员排序)

以 `XxxRepository` / `XxxEntity` 为例,`mixin _XxxRepositoryMixin on RepositoryMixin` 新增:

```dart
// create:key 字段 nextMaxPlusOne(多 key 全部预分配)
Future<XxxEntity> createXxx() =>
    XxxEntity(entry: await nextMaxPlusOne(_table, 'entry'));

// copy:调 get + create(override 自动传播)+ copyWith + store,返回新 key
Future<int> copyXxx(int key) async {
  final source = await getXxx(key);
  if (source == null) throw StateError('原记录不存在，可能已被其他操作修改或删除');
  final blank = await createXxx();
  final copied = source.copyWith(entry: blank.entry);
  await storeXxx(copied);
  return copied.entry;
}

// 全量列表(DBC export 用)
Future<List<XxxEntity>> getXxxs() async { /* orderBy key + get + map fromJson */ }

// 列表:brie 投影列(@FoxyBriefField 标记的物理列)+ orderBy key + _applyFilter + 分页
Future<List<BriefXxxEntity>> getBriefXxxs({int page = 1, XxxFilter? filter}) async { ... }

// 统计
Future<int> countXxxs({XxxFilter? filter}) async =>
    _applyFilter(laconic.table(_table), filter).count();

// 默认 filter 匹配:filter 字段 → column,text 精确匹配
QueryBuilder _applyFilter(QueryBuilder builder, XxxFilter? filter) { ... }
```

复合 key 时 `create` 预分配全部 key 字段,`copy` 返回 `XxxKey`。

### 生成器逻辑修改

- **删除** `repository_reader.dart` 中"同签名手写 CRUD 禁止"的 `_fail` 逻辑——全量生成后壳里同名方法一律是合法 `@override`,签名不匹配由编译器报错
- 删除 `list_reader.dart` 的文本正则签名匹配(`_readMethods`/`_balancedParams`/`_MethodCandidate` 等),list VM 生成器直接调用约定名;元素校验保留(repository 必须有 `@FoxyRepository` 等)
- `list_generator_test.dart` 中"方法名与 base name 不匹配时按签名匹配(reference 特例)"测试删除

## Step 3: 仓库迁移

**纯仓库**(无 join / 无 like / 无 whereAny / filter 可推断或已加 column):删除手写 `getBrief*` / `count*` / `copy*` / `create*` / `_applyFilter` / `getXxxs`,改用生成版。代表:`area_table`(name filter 加 `column: 'AreaName_lang_zhCN'`)、`currency_type`、`item_set`、`talent`、`gem_property`、`glyph_property`、`item_extended_cost`、`quest_faction_reward`、`quest_info`、`quest_sort`、`scaling_stat_distribution`、`scaling_stat_value`、`spell_item_enchantment`、`player_create_info`、`emote_text`、`currency_category` 等约 16 个,逐个对比后迁移。

**保留手写 override**(join / like / 上限校验等特殊逻辑):`achievement`(create 上限校验 + title like)、`creature_template`(locale join + whereAny)、`item_template`、`game_object_template`、`quest_template`、`gossip_menu`、`spell`、`smart_script`、`page_text`、`npc_text` 等约 10 个——手写方法原样保留,自动成为 override;filter 注解如不可推断则加 `column`。

迁移后 `dart run build_runner build --delete-conflicting-outputs` 全量重新生成,对比生成 diff 确认无行为变化(纯仓库应只剩 `_table` 常量 + locale helper)。

## Step 4: 测试更新

- `test/infrastructure/codegen/repository_generator_vm.dart`:新增 `create`/`copy`/`getBrief`/`count`/`_applyFilter`/`getXxxs` 生成断言(对照现有手写输出文本);删除"手写标准 CRUD 拒绝"断言;新增 `@FoxyFilter` 无同名实体字段时要求 `column` 的构建错误断言
- `test/infrastructure/codegen/list_generator_vm.dart`:删除 reference 特例测试,改为约定名断言
- `test/infrastructure/codegen/generator_test_support.dart`:sample 源码加 `@FoxyFilter` column 用例
- 相关 contract 测试(`reference_loot_template_contract_test.dart` 等)按 Step 1 更新
- 现有手写输出即"黄金样本":迁移前后用 `git diff` 对比生成 `.g.dart` 与手写删除内容

## 验证

```bash
dart test test/infrastructure/codegen        # 生成器套件
flutter analyze                               # custom_lint + 编译
flutter test                                  # 全量(含契约测试)
dart run build_runner build --delete-conflicting-outputs  # 重新生成并审查 diff
```

重点验证:
1. 纯仓库迁移后行为与手写版逐方法一致(对比删除的源码与生成输出)
2. override 仓库编译通过(类成员优先于 mixin 的覆盖生效)
3. reference 去聚合后列表页 / detail 子表 / picker 全部正常
4. `flutter test` 中 loot 相关契约测试通过

## 明确排除(下一期)

- **locale join DSL 参数化**(~20 个 join 仓库的 `_applyFilter` 参数化,含 whereAny / 多表 join)
- **子表父键形态**(`getBriefXxxs(parentKey, {page})` 等约 50 个子表仓库查询层,需 `@FoxyRepository` 父键参数)
- **Detail/编辑器 VM 的 persist/initSignals 骨架生成**(复用本期覆盖机制)
- **DI 注册生成**(`lib/di.dart`)
- **locale helper 生成**(`getXxxLocales`/`saveXxxLocales` 委托)

## 风险与边界

- **返回类型统一**:condition/reference 的 `copy*` 现在返回 `void`,生成版返回 `Future<Key>`——迁移时改手写返回类型(list VM 不关心返回值,无调用方影响)
- **`getNextMenuId` / `getNextItemId` 等公开辅助**保留手写,不与生成成员冲突
- **生成 `_applyFilter` 只覆盖"filter 名可映射"的字段**:不可映射的仓库要么加 `column` 要么保留手写 override 整个 `_applyFilter`——迁移时逐个决定,宁留 override 不强行生成
- **子表仓库(无 list VM)本期完全不生成查询层**,避免父键形态未定义时误生成

## 下一期实施结果摘要(2026-08-01)

- **子表父键查询层(Phase B)**:`@FoxyRepository` 增加 `parentKey:`(字段名列表,5 个 player_create_info 仓库用双父键);声明后生成父键形态 `count*`/`getBrief*`/`create*`/`copy*`(create 预分配非父 key 字段,where 带父键)。31 个子表仓库迁移;9 个 loot 仓库方法名规范化(`getBriefLootTemplates` → `getBriefCreatureLootTemplates` 等)并同步更新 8 个 collection editor 调用点。语义差异(带 join 的 getBrief、loot 不预分配 Item、skill 的位掩码过滤)保留手写 `@override`。
- **Detail VM 骨架(Phase C1)**:`@FoxyDetailViewModel` 增加可选 `repository:`;声明后生成信号/initSignals/persist/dispose/_logActivity 钩子。18 个标注 detail VM 迁移(7 个不规则 VM 保持手写);gossip_menu 的 NPC 文本预占、smart_script 的监听器、creature_template/gossip_menu 的 persist 校验保留为 `@override`。
- **Collection editor 骨架(Phase C2)**:新注解 `@FoxyCollectionEditorViewModel(entity:, repository:)`(复用 FormEmitter 的 controller 样板),生成全套编辑器骨架(信号/token/copy/create/destroy/edit/paginate/persist/setParentKey/_refresh)。26 个单父键 editor 迁移;6 个保持手写(5 个 player_create_info 双父键用复合父类型 + item_enchantment_template 自定义父类型 + page_text_locale 手写查询层 + gossip_menu_option 用 use case 的 persist 为 @override)。
- **locale helper 生成(Phase E)**:仓库混入 `DbcLocaleRepositoryMixin` 且声明 `dbcLocaleTableName` 时,生成 mixin `on` 子句扩宽为 `RepositoryMixin, DbcLocaleRepositoryMixin` 并生成 `get*Locales`/`save*Locales` 委托。21 个生成仓库迁移;3 个纯手写仓库(item_bag_family/item_limit_category/totem_category)保留手写。
- 验证:`dart test test/infrastructure/codegen` 43 个、`flutter analyze` 无告警、`flutter test` 375 个全绿。

## 关联词汇重命名 + Linked Detail 生成器(2026-08-02)

- **词汇改名**:`parentKey`/`setParentKey` → `linkKey`/`setLinkKey`(信号、注解参数、`@FoxyRepository(linkKey:)`、`ParentNotLoadedException` → `LinkNotLoadedException`,消息"父记录尚未加载" → "关联记录尚未加载");`CollectionEditorViewModel` → `LinkedListViewModel`、`SingleEditorViewModel` → `LinkedDetailViewModel`(类名+文件名全量改名,含 `ItemEnchantmentTemplateParentKey` → `ItemEnchantmentTemplateLinkKey`)。29 个仓库、32 个 linked list VM、8 个 linked detail VM、页面调用点、di.dart、契约测试全部同步。
- **Linked Detail 生成器(Phase C3)**:新注解 `@FoxyLinkedDetailViewModel(entity:, repository:, ...)` 生成一对一关联表单骨架(linkKey/editingKey/entity 信号、`_refreshToken`/`_linkToken`、destroy/dispose/initSignals/setLinkKey/persist、`_refresh` get-or-create),controller 复用 FormEmitter。要求实体恰好一个物理 Key(关联键即主键),复合键报错保持手写。8 个单行编辑器迁移;`npc_text` 保持纯手写(use cases + locale 仓库)且是唯一例外。
- 验证:`dart test test/infrastructure/codegen` 45 个、`flutter analyze` 无告警、`flutter test` 375 个全绿。
