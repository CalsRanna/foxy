# Foxy 全项目主键可编辑方案

## 1. 背景

Foxy 的定位是 AzerothCore / World of Warcraft 3.3.5a 数据库的可视化编辑器。当前项目普遍把主键当作不可变身份：详情页将主键字段设为只读，Repository 更新时从 `toJson()` 中移除主键列，再使用实体当前的主键定位记录。

这种策略对 `conditions` 等由业务字段组成联合主键的表尤其不合适：条件来源、条件类型和条件参数都属于联合主键，锁定主键后，用户实际上无法修改条件本身。

本方案将全项目统一为以下模型：

> Key 是打开记录时的强类型定位快照，不是不可编辑字段。编辑已有记录时，使用原始 Key 定位旧行，使用当前表单的完整数据更新该行。

## 2. 产品边界

### 2.1 Foxy 负责的内容

- 允许用户编辑当前记录的所有数据库字段，包括单列主键和联合主键。
- 使用打开详情或选中 Brief 行时保存的原始强类型 Key 定位旧记录。
- 校验当前模块已经定义的字段格式、值域和单表约束。
- 将当前实体的完整字段写回当前表。
- 正确处理目标主键冲突、旧记录不存在和数据库写入失败。
- 主键修改成功后，更新当前详情页持有的 `persistedKey` signal、依赖该键的页面状态和面包屑标签。

### 2.2 Foxy 不负责的内容

- 不扫描其他表对当前主键的引用。
- 不自动级联更新其他表。
- 不因为其他表可能存在引用而禁止修改或删除。
- 不为 AzerothCore 官方表增加代理主键、自增 ID 或外键。
- 不尝试从字段名称推断跨表关系。
- 不保留遗留的跨表外键存在性校验和反向引用删除保护；改造相关模块时应删除这些 Repository 查询及其合同测试。

Foxy 假定用户理解直接修改数据库字段可能产生的影响。必要时可以显示非阻断式说明，但不得以潜在跨表影响为由锁定字段或拒绝保存。

## 3. 核心概念

### 3.1 强类型主键

每个可编辑实体使用专用的强类型 `FooKey` 值对象表达完整行定位条件。通常它就是完整物理主键；单列主键和联合主键采用同一种模型，不使用 `Map<String, dynamic>` 在页面、路由、ViewModel 或 Repository 公共 API 之间传递主键。

例如 `conditions` 使用：

```dart
@immutable
final class ConditionKey {
  final int sourceTypeOrReferenceId;
  final int sourceGroup;
  final int sourceEntry;
  final int sourceId;
  final int elseGroup;
  final int conditionTypeOrReference;
  final int conditionTarget;
  final int conditionValue1;
  final int conditionValue2;
  final int conditionValue3;

  const ConditionKey({
    required this.sourceTypeOrReferenceId,
    required this.sourceGroup,
    required this.sourceEntry,
    required this.sourceId,
    required this.elseGroup,
    required this.conditionTypeOrReference,
    required this.conditionTarget,
    required this.conditionValue1,
    required this.conditionValue2,
    required this.conditionValue3,
  });

  factory ConditionKey.fromEntity(ConditionEntity value) {
    return ConditionKey(
      sourceTypeOrReferenceId: value.sourceTypeOrReferenceId,
      sourceGroup: value.sourceGroup,
      sourceEntry: value.sourceEntry,
      sourceId: value.sourceId,
      elseGroup: value.elseGroup,
      conditionTypeOrReference: value.conditionTypeOrReference,
      conditionTarget: value.conditionTarget,
      conditionValue1: value.conditionValue1,
      conditionValue2: value.conditionValue2,
      conditionValue3: value.conditionValue3,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ConditionKey &&
            sourceTypeOrReferenceId == other.sourceTypeOrReferenceId &&
            sourceGroup == other.sourceGroup &&
            sourceEntry == other.sourceEntry &&
            sourceId == other.sourceId &&
            elseGroup == other.elseGroup &&
            conditionTypeOrReference == other.conditionTypeOrReference &&
            conditionTarget == other.conditionTarget &&
            conditionValue1 == other.conditionValue1 &&
            conditionValue2 == other.conditionValue2 &&
            conditionValue3 == other.conditionValue3;
  }

  @override
  int get hashCode => Object.hash(
    sourceTypeOrReferenceId,
    sourceGroup,
    sourceEntry,
    sourceId,
    elseGroup,
    conditionTypeOrReference,
    conditionTarget,
    conditionValue1,
    conditionValue2,
    conditionValue3,
  );
}
```

单列主键也使用领域专用类型，例如：

```dart
@immutable
final class AchievementKey {
  final int id;

  const AchievementKey(this.id);

  factory AchievementKey.fromEntity(AchievementEntity value) {
    return AchievementKey(value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AchievementKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
```

`FooKey` 必须是纯数据值对象，字段类型与物理行定位列一致，提供从对应完整实体创建新键的 `fromEntity` 工厂，并实现适用于路由参数比较的值相等和 `hashCode`。不得使用内部持有 `Map<String, dynamic>` 的通用 `PrimaryKey` 包装类伪装类型安全。

行定位列按以下顺序确定：

1. 表存在 `PRIMARY KEY` 时，使用全部物理主键列。
2. 表没有主键但存在所有列均为 `NOT NULL` 的物理 `UNIQUE` 约束时，使用该唯一约束的全部列。`spell_linked_spell` 使用 `UNIQUE (spell_trigger, spell_effect, type)`。
3. 表既没有主键也没有唯一约束时，不允许从字段名猜测一个“主键”。必须为该表显式设计经过审查的强类型旧行定位器。

当前 `playercreateinfo_cast_spell` 属于第三种情况。它使用包含全部物理列的 `PlayerCreateInfoCastSpellKey`：`raceMask`、`classMask`、`spell` 和保持数据库真实可空性的 `String? note`。其 Full Entity、Brief Entity、Key、Controller 与 `toJson()` 都必须区分数据库 `NULL` 和空字符串 `''`；UI 必须允许用户明确保留或选择这两种值，不能在加载或收集 candidate 时静默互相转换。更新和删除使用完整旧行快照作为 `WHERE`，并追加 `LIMIT 1`。`note` 使用 MySQL null-safe equality 处理 `NULL`，并使用 binary 文本比较，避免表的大小写不敏感 collation 命中一个可见内容不同的行。即使数据库存在完全相同字节内容的重复行，也只修改或删除其中一行；这些完全相同行在可观察数据上没有区别。其 Brief Entity 必须包含全部四列。该例外不改变 AzerothCore 表结构，也不能推广成基于 Map、反射或字段名推断的通用后备方案。

当前 Laconic 2.3.0 的 QueryBuilder 在编译 `UPDATE` / `DELETE` 时不携带 builder 的 `limit`。实施无键表方案时，升级后的 Laconic 必须提供带写入结果的 `UPDATE ... LIMIT 1` / `DELETE ... LIMIT 1` 能力；若 QueryBuilder 仍不支持，Repository 使用参数化、可返回写入结果的原始 SQL API。禁止把 Key 值插值进 SQL 字符串。

### 3.2 原始键

`originalKey` 是打开已有记录时捕获的 `FooKey` 快照。它可以来自物理主键、物理唯一键或显式全行定位器，只用于定位数据库中的旧行，不参与构造用户最终要保存的数据。

### 3.3 候选实体

`candidate` 是从当前表单收集并完成验证后的完整实体。它的 `toJson()` 表示用户期望写入当前表的最终数据，其中包括修改后的行定位列。

Foxy 假定 `candidate` 始终可控且可获取，从它构造的 Key 就是成功写入后的新定位条件。Repository 不在保存过程中隐式改变候选键；需要自动分配的键必须在展示表单前由 `createFoo()` 完成预分配，预分配结果只是可编辑的表单默认值。因此保存方法无须返回一次可以从 `candidate` 确定的 Key。

对于可编辑业务实体的 `AUTO_INCREMENT` 主键，预分配是强制要求。`createFoo()` 必须在表单打开前提供显式非零键值；新建保存时不得把 `0`、`NULL` 或其他会触发 MySQL 隐式分配的值交给数据库。用户可以修改预分配值，但保存前的单表字段验证必须拒绝会导致数据库另行生成主键的候选值。

### 3.4 不变量

- 新建操作没有原始键，执行 `INSERT`。
- 编辑操作必须持有强类型原始 Key，执行以其全部定位字段为 `WHERE` 条件的 `UPDATE`。
- 不得使用候选实体的新主键定位旧行。
- 不得仅因为某列属于主键而从更新载荷中移除它。
- `storeFoo(candidate)` 必须原样插入 `candidate.toJson()`，不得在保存阶段分配、替换、规范化或修正候选主键。
- 可编辑业务实体不得通过 `insertAndGetId()` 或插入后的返回值修正候选主键；ActivityLog 等没有可编辑详情候选实体的内部追加表不受此限制。
- 更新成功后，原始键必须替换为通过 `FooKey.fromEntity(candidate)` 得到的新键。
- 独立详情页的后续保存、删除、复制和刷新使用 `persistedKey` signal 中的最新强类型键；内嵌子表行使用自己的 `editingKey` 保存选中 Brief 行的原始定位器。父详情的子 Tab 切换继续监听父级 `persistedKey`。

## 4. Repository 设计

### 4.1 创建与更新必须显式区分

不要通过“候选主键是否已经存在”推断当前操作是创建还是更新。操作类型应由详情页是否具有原始键决定：

```dart
if (persistedKey.value == null) {
  await repository.storeFoo(candidate);
} else {
  await repository.updateFoo(persistedKey.value!, candidate);
}
```

创建时如果目标主键已经存在，由数据库唯一约束拒绝插入。

`storeFoo` 和 `updateFoo` 均返回 `Future<void>`。ViewModel 从自己持有的 `candidate` 计算新键，Repository 不返回重复信息。现有 `storeFoo` 中“ID 不合法时再次调用 `nextMaxPlusOne()`”以及返回最终 ID 的逻辑必须移除；依赖返回 ID 的调用方改为使用 `FooKey.fromEntity(candidate)`。

如果物理主键包含 `AUTO_INCREMENT` 列，`createFoo()` 必须在进入表单前预分配显式非零值。`storeFoo()` 必须拒绝仍会触发数据库隐式分配的候选键，不能插入后通过 `lastInsertId`、`insertAndGetId()` 或 Repository 返回值改变页面认知。复制流程同样先分配新键并构造完整复制候选实体，再调用 `storeFoo()`。

### 4.2 统一更新语义

单列主键、联合主键、物理唯一键和显式无键表定位器使用相同的“原始定位器 + 完整 candidate”语义：

```dart
Future<void> updateFoo(
  FooKey originalKey,
  FooEntity candidate,
) async {
  final result = await _whereKey(
    laconic.table(_table),
    originalKey,
  ).update(candidate.toJson());

  if (result.matchedRows == 0) {
    throw StateError('原记录不存在，可能已被其他操作修改或删除');
  }
}
```

`updateFoo()` 对外仍返回 `Future<void>`。Laconic 的更新结果只在 Repository 内部用于判定旧行是否存在，不作为新 Key 来源。`matchedRows == 1 && changedRows == 0` 表示行存在但值未变化，仍然成功；不能把 `changedRows == 0` 当成记录不存在。

具体 Repository 仍应显式列出物理行定位列，并从具体 `FooKey` 的类型化字段构造查询，不通过字段名称、Map 或反射猜测。需要转义的保留字继续按现有方式转义。例如：

```dart
QueryBuilder _whereKey(QueryBuilder builder, ConditionKey key) {
  return builder
      .where('SourceTypeOrReferenceId', key.sourceTypeOrReferenceId)
      .where('SourceGroup', key.sourceGroup)
      .where('SourceEntry', key.sourceEntry)
      .where('SourceId', key.sourceId)
      .where('ElseGroup', key.elseGroup)
      .where('ConditionTypeOrReference', key.conditionTypeOrReference)
      .where('ConditionTarget', key.conditionTarget)
      .where('ConditionValue1', key.conditionValue1)
      .where('ConditionValue2', key.conditionValue2)
      .where('ConditionValue3', key.conditionValue3);
}
```

### 4.3 移除不可变主键处理

逐个审计并移除仅用于禁止主键更新的代码，例如：

```dart
json.remove('ID');
json.remove('entry');
json.remove('CreatureID');
```

当前 AzerothCore world 基表和 Foxy migration 中没有发现 `GENERATED ALWAYS AS (...)` 生成列。`AUTO_INCREMENT` 和数据库默认值仍允许显式写入，不构成从候选载荷删除字段的理由；SQL 保留字应通过正确引用列名处理，也不构成删除字段的理由。完整详情实体的 `toJson()` 只能包含当前物理表列，而这些列必须作为完整候选载荷写入。

初步扫描显示，目前有约 62 个 Repository 在更新载荷中调用 `json.remove(...)`。实施时必须逐个核对，不能进行无审查的全局替换。

### 4.4 主键冲突

新增操作可以在写入前查询候选键是否已存在，以提供清晰提示，但这只是用户体验优化，不能代替数据库约束：

```dart
if (originalKey == null &&
    await repository.existsFoo(FooKey.fromEntity(candidate))) {
  throw StateError('主键已存在，无法新建');
}
```

编辑操作不执行候选主键冲突预检，无论 Dart 中的 `newKey` 是否等于 `originalKey`。原因有两点：

- Dart 字符串相等语义可能与 MySQL collation 的大小写、重音或尾随空格比较语义不同，预检可能把当前行误判成冲突。
- 预检与实际 `UPDATE` 之间始终存在并发窗口。

更新时直接执行以 `originalKey` 定位的单条 `UPDATE`，捕获数据库的重复主键/唯一键异常并转换为中文错误，例如：

```text
修改后的主键已存在，无法保存。
```

数据库约束是更新冲突的唯一最终判定。单条 `UPDATE` 失败时旧记录保持不变，不使用“先删除、再插入”模拟主键修改。没有物理唯一约束的显式无键表定位器不执行主键冲突预检。

### 4.5 旧记录不存在

使用原始 Key 更新不到目标记录时，应提示：

```text
原记录不存在，可能已被其他操作修改或删除。
```

采用 Laconic 新版本提供的更新结果 API，检查 `matchedRows`：

- `matchedRows == 0`：抛出上述错误，不更新 `persistedKey`，也不写成功活动日志。
- `matchedRows == 1 && changedRows == 0`：原记录存在，只是数据没有变化，按成功处理。
- 不使用普通预读，也不为此增加 `SELECT ... FOR UPDATE`。

删除采用相同原则：Repository 检查 Laconic 删除结果的 `deletedRows`。`deletedRows == 0` 时报告原记录不存在，只有实际删除成功后才记录活动日志。具体结果类型和属性名以升级后的 Laconic API 为准，但“匹配行数”和“实际变化行数”必须保持上述语义区别。

### 4.6 事务边界

普通主键修改是一条当前表 `UPDATE`，不需要通过删除和插入扩大事务范围。每个 Repository 写方法只允许修改自己的一个物理表。

如果某个页面让用户同时明确编辑了基础实体和 locale 等多个 candidate，ViewModel 可以协调各自 Repository 调用，并可使用现有事务把这些明确提交的写入组成一次保存。父记录主键变化本身不得触发 Repository 自动创建、更新、删除或迁移 locale/子记录；这类行为属于被禁止的跨表级联。

## 5. Entity 与强类型 Key

- 每个可通过详情页编辑的实体应有对应的 `FooKey` 类型。
- 单列主键也必须使用领域专用 `FooKey`，不能退化为无领域信息的动态 Map。
- 每个通过列表、实体选择器、可编辑子表列表或详情导航暴露的可编辑模块，都必须提供独立的 `BriefFooEntity`。当前没有 Brief Entity 的模块必须在改造时补建，不能继续用完整 `FooEntity` 充当列表行。
- Brief Entity 只包含列表/选择器实际需要展示的列，以及 `FooKey` 对应的全部行定位列。即使某个定位列不渲染，也必须由 Brief 查询读取并保存在 Brief Entity 中；显式全行定位器的 Brief 必须包含全部物理列。
- Brief Entity 必须提供类型化 `FooKey get key`，精确覆盖完整行定位条件。查看详情、复制和删除统一传递 `brief.key`。
- 完整实体不提供 `key` getter；`FooKey.fromEntity(fullEntity)` 是从保存候选实体得到新键的唯一公共转换入口。
- `FooKey` 必须精确包含选定物理主键、物理唯一键或经审查的显式全行定位器的全部列，字段类型和可空性与数据库存储兼容。
- 除显式无键表全行定位器外，`FooKey` 不包含非键列。所有 Key 都不依赖 Repository、Laconic 或数据库连接。
- Repository 的 `_whereKey` 负责把类型化字段映射为数据库列名；`FooKey` 本身不构造查询。
- 联合主键必须保持显式字段，不用列表、索引循环或反射隐藏物理结构。
- `toJson()` 继续包含完整物理字段，并保持现有列顺序约束。
- 不得使用 `Map<String, dynamic>` 表示或传递主键。该限制只针对主键建模与主键参数传递，不限制 Entity 序列化、Laconic 数据边界及项目中其他与主键无关的合理 Map 用法。

可以统一方法命名和保存流程，但不应为了抽象而破坏项目现有的显式实体与 Repository 风格。

Repository 的 Brief 合同必须统一为：

```dart
Future<List<BriefFooEntity>> getBriefFoos(...);
```

不得出现方法名为 `getBrief*`，返回类型却是完整 `FooEntity` 的情况。Brief 查询只显式选择展示列和全部行定位列；显式全行定位器按例外要求选择全部物理列。完整实体读取保留给详情编辑、DBC 导出和批处理。

## 6. ViewModel 设计

详情 ViewModel 应以 signal 保存数据库中当前已持久化的强类型键：

```dart
final persistedKey = signal<FooKey?>(null);
```

`persistedKey` 同时承担原始行定位和页面运行期状态通知职责，不再维护一份重复的 `_originalKey`。表单 Controller 中正在编辑但尚未保存的候选主键不会提前写入 `persistedKey`。

初始化规则：

- 新建：`persistedKey.value = null`。
- 编辑：路由传入的完整 `FooKey` 只作为首次初始化参数，并赋给 `persistedKey.value` 后加载记录。

保存规则：

```dart
final candidate = _collectFromControllers();
validateFooFields(candidate);
final newKey = FooKey.fromEntity(candidate);
final originalKey = persistedKey.value;

final isCreate = originalKey == null;
if (isCreate) {
  await repository.storeFoo(candidate);
} else {
  await repository.updateFoo(originalKey, candidate);
}

persistedKey.value = newKey;
```

可以在写入前从可控的 `candidate` 构造 `newKey`，但必须在数据库写入成功后才能将它赋给 `persistedKey.value`。如果写入失败，signal 继续保留旧键，以便用户修正后重试。Repository 不需要返回 `newKey`。

### 6.1 内嵌子表使用 editingKey

内嵌在父详情 Tab 中的行编辑器没有独立详情路由，不能套用父级 `persistedKey` 作为子行身份。它必须单独保存当前选中 Brief 行的原始定位器：

```dart
final editingKey = signal<FooKey?>(null);
```

规则如下：

- 点击“新建”时将 `editingKey.value` 设为 `null`，然后展示 `createFoo()` 返回的候选默认值。
- 选中已有 Brief 行时，先把 `brief.key` 赋给 `editingKey.value`，再按该键加载完整实体并初始化 Controller。
- 保存时，`editingKey.value == null` 执行 `storeFoo(candidate)`；否则执行 `updateFoo(editingKey.value!, candidate)`。
- 不得用 `FooKey.fromEntity(candidate)` 定位正在编辑的旧子行。
- 保存成功后重新加载当前子表列表并清空选择及 `editingKey`。这样即使候选键中的父过滤列发生变化、记录移出当前 Tab 的查询范围，也不会留下指向旧行的选择状态。
- 删除和复制直接使用当前选中 `brief.key`；父详情主键变化只负责切换子表查询范围，不改写已有子行。

### 6.2 ActivityLog 不保存业务主键

`ActivityLog` 自身的自增 `id` 继续作为日志记录的主键。被操作业务记录的主键不属于活动日志的身份，因此活动日志不保存以下内容：

- `entityId` / `entity_id`；
- 完整 `FooKey`；
- 从联合主键中挑选的代表性整数；
- 为日志目的生成的主键字符串稳定编码；
- 旧键和新键的结构化副本。

每个调用方只提供适合展示的业务对象标签，例如“Condition 17 / 12345”。标签用于帮助用户理解日志，不用于重新查询、导航或关联业务记录。

现有 `foxy.activity_log.entity_id` 应通过新增迁移删除，不得修改已经应用的旧迁移。`ActivityLogEntity`、Repository、查询和所有调用方同步移除 `entityId`。如继续使用现有 `entity_name` 列，可直接将它作为可读标签承载列，不要求为了本次改造重命名。

活动日志仍然是业务写入成功后的 best-effort 附加行为；日志写入失败不得把已经成功的业务保存变成失败。

## 7. UI 规则

### 7.1 主键不再是只读理由

详情页不得因为以下条件锁定输入：

```dart
readOnly: isExisting
enabled: !isExisting
```

如果这些条件唯一表达的是“已有记录的主键不可修改”，应当移除。

### 7.2 编辑字段与展示数据的边界

完整详情实体 `FooEntity.toJson()` 中的每个物理列都属于 `candidate`，必须在详情表单中提供可编辑控件。以下情况都不能作为永久只读理由：

- 字段属于主键；
- 字段是 `AUTO_INCREMENT`；
- 字段具有数据库默认值；
- Repository 通常会为字段预分配默认值；
- 模块沿用了旧的只读惯例或笼统的“语义限制”。

Brief Entity 的查询别名、`displayText` 等计算 getter，以及列表、Picker、面包屑使用的组合标签属于展示数据。它们不属于完整详情 `candidate`，不应伪装成详情页中的只读字段，也不参与 `INSERT` 或 `UPDATE`。

仅当当前类型或模式明确不使用某个物理字段时，才允许按已有动态规则临时禁用该控件。类型或模式切换后该字段重新适用时，控件必须恢复可编辑。动态禁用不能退化为“已有记录不可修改”或永久只读。

### 7.3 新建默认主键

Repository 的 `MAX + 1` 或其他预分配逻辑只提供默认值。只要数据库字段允许显式写入，用户就可以修改该默认主键。

对于 `AUTO_INCREMENT` 主键，这个默认值必须在表单打开前完成预分配并且非零。新建表单可以继续编辑该值，但保存验证必须拒绝 `0`、`NULL` 等会要求数据库隐式生成新键的值，以保证数据库最终键始终等于 `FooKey.fromEntity(candidate)`。

### 7.4 非阻断式说明

可以在主键字段附近或应用帮助中统一说明：

```text
修改主键只更新当前记录，Foxy 不会同步修改其他表中的引用。
```

该说明不得变成确认弹窗、引用扫描或保存阻断。

## 8. 动态字段与类型切换

主键可编辑不代表所有字段在所有状态下都有效。例如 `conditions` 的引用条件不使用 `ConditionTarget` 和参数字段，某些来源类型不使用 `SourceGroup` 或 `SourceId`。

这类字段继续按业务语义启用或禁用。类型切换导致旧值不再适用时，应采用项目统一策略：

- 明确清空不再使用的字段，并让 UI 立即反映新状态；或
- 保留草稿值，但在保存前要求用户处理无效字段。

不得因为处理动态字段困难而重新锁定条件类型或其他主键列。任何自动清空行为都应可见，避免静默修改用户数据。

## 9. 路由、面包屑与多 Tab

详情路由中的 `FooKey?` 只负责页面首次初始化。页面存活期间，路由参数不再作为当前记录身份的事实来源；保存成功后的最新身份由详情 ViewModel 的 `persistedKey` signal 管理。

页面标题、是否为新建状态、保存按钮行为以及依赖父记录已落库的子 Tab 都使用 `Watch` 监听 `persistedKey`：

```dart
final key = viewModel.persistedKey.value;
final isNew = key == null;
```

新建首次保存或已有记录修改主键后，只更新 `persistedKey.value`，不替换、重建当前 AutoRoute。子 ViewModel 必须监听或接收同一 `persistedKey`，在 signal 变化后改用新键加载；不得继续读取页面构造函数中的初始路由 Key。

面包屑显示名称变化使用现有 `RouterFacade.updateCurrentLabel()` 更新 `path` signal，不替换路由。

`RouterFacade.replaceCurrentDetail` 应删除。`RouterNode.id` 当前也只保存、不参与查找、比较、去重或导航，应从 `RouterNode` 以及 `RouterFacade.navigateToDetail` 参数中删除。不为 `FooKey` 增加字符串稳定编码，也不依赖默认 `toString()` 构造路由身份。

本项目是桌面内部导航，不依赖 URL 深链或进程重启后的路由状态恢复。AutoRoute 栈保留首次初始化参数是可接受的；若未来新增路由恢复能力，应单独设计持久化状态，而不是在每次保存后销毁并重建详情页。

详情路由声明从松散标量或 Map 改为 `FooKey?` 后，必须运行 `dart run build_runner build --delete-conflicting-outputs` 重新生成并提交 `router.gr.dart`。运行期 signal 更新不需要重新生成或替换路由。

## 10. 删除、复制、刷新与列表返回

- 保存主键变更后，删除操作必须使用新键。
- 复制操作必须以新键读取当前记录。
- 当前详情运行期间的重新加载必须使用 `persistedKey.value`，不能重新读取初始路由参数。
- 返回列表后，列表通过正常刷新展示新主键，不在内存中猜测替换行。
- 如果模块缓存了实体 ID、父记录 ID 或过滤条件，应监听 `persistedKey` 并在保存成功后同步切换。

## 11. 不同数据类型采用同一策略

本方案不按“根实体、关系表、DBC 表”区分主键是否可编辑。以下数据都使用相同原则：

- AzerothCore world 表。
- `foxy.dbc_*` 镜像表。
- 单列主键。
- 联合主键。
- locale 表。
- 父子详情中的子表记录。

差异只体现在每张表的物理行定位方式、字段验证和已有单表写入规则，不体现在是否允许修改定位列。

## 12. 实施步骤

### 阶段一：建立合同

1. 更新 `AGENTS.md` 中“主键只读”和“更新移除主键”的旧约定。
2. 建立强类型 `FooKey` 约定，并将 `persistedKey` signal、Brief Entity 的 `key` getter、`FooKey.fromEntity` 和 Repository 更新签名确定为统一命名。
3. 增加共享合同测试，禁止因为已有记录而锁定主键。
4. 增加共享合同测试，禁止更新方法无条件移除物理主键。
5. 增加共享合同测试，禁止 `storeFoo` 在保存阶段分配或改写候选主键，并要求创建和更新方法返回 `Future<void>`；可编辑 `AUTO_INCREMENT` 主键必须在 `createFoo()` 中预分配显式非零值，保存时拒绝隐式分配哨兵值。
6. 将“不检查跨表引用、不保护反向删除、不执行级联”写入架构合同；现有跨表保护按模块改造进度逐步移除。
7. 增加共享合同测试，要求每个列表/选择器/可编辑子表/详情导航模块具有独立 Brief Entity，且 `getBrief*` 不得返回完整 Entity。
8. 升级到提供更新/删除结果的 Laconic 版本，建立 `matchedRows`、`changedRows` 和 `deletedRows` 语义合同；同时确认 QueryBuilder 或参数化原始写入 API 支持无键表所需的 `UPDATE/DELETE ... LIMIT 1`。Repository 公共保存方法仍返回 `Future<void>`。

### 阶段二：以 conditions 验证完整链路

1. 解锁 10 个联合主键字段，同时保留动态字段语义限制。
2. Repository 使用原始 10 列主键定位，写入全部 15 列。
3. 保存成功后更新 `persistedKey.value`，由页面和子 Tab 响应 signal 切换状态。
4. 保留路由中的初始 `ConditionKey?` 作为首次加载参数，不替换当前路由。
5. 覆盖主键冲突、连续两次保存、旧记录不存在和新建后改键场景。

### 阶段三：联合主键与子表

优先改造当前明确锁定联合主键或在更新时移除多个键列的模块，例如：

- `player_create_info`
- loot template 系列
- `npc_vendor`
- `gossip_menu_option`
- locale 表
- creature/game object/quest 的关系子表
- SmartAI

每个模块单独核对物理行定位器、路由参数和父子 Tab 状态。`spell_linked_spell` 使用物理唯一键；`playercreateinfo_cast_spell` 使用完整可空旧行快照和 `LIMIT 1`，并为内嵌编辑状态增加 `editingKey`。

### 阶段四：单列主键模块

逐个改造 `ID`、`entry` 等单列主键模块：

- 解锁详情字段。
- 保留创建时的默认 ID 分配。
- 更新 Repository 签名。
- 保存后更新 `persistedKey` signal，不替换路由。
- 调整删除和复制使用的新 ID；活动日志只记录可读标签，不传递业务 ID。

### 阶段五：全项目审计

1. 搜索所有 `json.remove(...)`，确认没有仅为主键不可变而保留的删除逻辑。
2. 搜索所有 `readOnly: true`、`pkReadOnly`、`enabled: !isNew`，删除绑定 `candidate.toJson()` 物理列的永久只读状态；仅保留由明确类型或模式控制的临时动态禁用。
3. 搜索所有通过实体当前主键执行更新的 Repository。
4. 搜索所有新建/更新二合一的 `save*` 方法，确认不会用候选新键错误推断操作类型。
5. 核对所有独立详情页在主键改变后监听自身 `persistedKey`，所有父级子 Tab 监听父详情 `persistedKey`，所有内嵌行编辑器另存选中 Brief 行的 `editingKey`，不使用 candidate 新键定位旧行。
6. 核对每张可编辑表的物理主键或物理唯一键均使用全部列定位；无两者的表必须有显式强类型全行定位方案，不得猜测键列。
7. 搜索所有返回 ID、使用 `insertAndGetId()` 的可编辑业务 `store*` 以及保存阶段调用的 `nextMaxPlusOne()`，改为在 `create*` 或复制候选构造阶段预分配可编辑的显式键并原样插入 `candidate`；逐个核对 `AUTO_INCREMENT` 新建流程不会提交触发隐式分配的零值。
8. 搜索所有跨表存在性校验、反向引用计数、删除保护和级联写入，移除相应 Repository 行为及旧合同测试。
9. 搜索所有返回完整 Entity 的 `getBrief*` 以及直接用完整 Entity 承载列表行的模块，为其补建独立 Brief Entity，并把查询字段收窄为展示列加完整行定位列；显式全行定位器按例外保留全部物理列。
10. 删除未被消费的 `RouterNode.id` 和 `RouterFacade.replaceCurrentDetail`，同步移除 RouterFacade 详情导航方法中的 `id` 参数和所有调用方；不要用字符串编码或路由替换代替运行期 `persistedKey` signal。
11. 为 `foxy.activity_log` 新增迁移以删除业务 `entity_id`，同步移除 `ActivityLogEntity.entityId` 及所有构造参数；确认每个调用方改为提供可读标签。
12. 所有 `update*` 改用 Laconic 结果中的匹配行数判断旧行不存在，所有 `destroy*` 检查实际删除行数；删除旧的普通预读后备方案。
13. 审计同时保存基础表、locale 和子表的流程：每个 Repository 写方法只修改一个物理表，ViewModel 只协调用户明确提交的多个 candidate，不因父键变化自动级联。

## 13. 测试要求

每个改造模块至少覆盖：

- Brief Entity 精确包含完整行定位列并能构造正确的 `FooKey`；显式全行定位器覆盖全部物理列及真实可空性。
- `FooKey` 的值相等覆盖全部行定位字段；相等对象具有相同 `hashCode`，任一定位字段不同都会判定为不相等。
- `getBrief*` 返回独立 Brief Entity，通常不加载完整 Entity 或完整表字段；显式全行定位器是唯一例外，但返回类型仍必须是专用 Brief Entity。
- 查看详情、复制和删除通过 `brief.key` 传递完整行定位器。
- `FooKey.fromEntity(candidate)` 能从完整候选实体构造相同的新键。
- 完整详情实体 `toJson()` 的每个物理列都有可编辑控件；`AUTO_INCREMENT`、数据库默认值和预分配默认值不会使控件永久只读。
- 可编辑 `AUTO_INCREMENT` 主键在表单打开前得到显式非零默认值；新建保存拒绝会触发数据库隐式分配的候选值，Repository 不通过插入返回 ID 修正 candidate。
- 复制流程在插入前构造带显式新键的完整 candidate，保存方法不会另行分配或返回不同的键。
- Brief 查询别名和计算展示 getter 不进入完整详情候选实体，也不会被实现为详情页只读输入框。
- 已有记录的主键字段可编辑。
- 不修改主键时正常保存。
- 单列或联合主键的一列发生变化时，用旧键定位并写入新键。
- 联合主键多列同时变化时正确保存。
- 修改后连续第二次保存使用新键定位。
- 新主键与现有记录冲突时旧记录不丢失。
- 新增操作可以预检候选主键，且不需要排除当前记录。
- 编辑操作无论主键是否变化都不执行候选键冲突预检，数据库唯一约束错误被转换为明确中文提示。
- `matchedRows == 0` 时给出原始记录不存在错误；`matchedRows == 1 && changedRows == 0` 仍然成功。
- `deletedRows == 0` 时删除报告原记录不存在且不写成功日志。
- 字符串键在 Dart 相等语义与 MySQL collation 不一致时不会被更新预检误判。
- `playercreateinfo_cast_spell` 的 Entity、Brief、Key、Controller 和 `toJson()` 保留 `note` 的 `NULL`/空字符串区别；写入使用完整旧行条件、null-safe/binary 文本比较和 `LIMIT 1`，完全重复行存在时一次更新或删除最多影响一行，所有值通过参数绑定传递。
- 内嵌子表选中已有行后通过 `editingKey == brief.key` 定位，修改候选键不会改变当前保存使用的旧行条件；保存刷新后清空选择。
- 新建记录可以修改预分配主键并保存。
- 保存成功后 `persistedKey`、面包屑和子 Tab 使用新键，当前详情路由不被替换或重建。
- 新建首次保存和已有记录修改主键后，`persistedKey` signal 触发页面状态及子 Tab 切换；普通字段保存不会重建页面。
- `RouterNode` 不再保存冗余字符串 `id`，详情路由直接携带强类型 `FooKey`。
- 保存失败后仍保留旧键，可以修正并重试。
- 当前已有的字段格式、物理范围、同一记录交叉字段、当前表唯一性验证和动态禁用规则不回退；遗留跨表引用验证不保留。
- 活动日志只用自身 `id` 标识日志行；业务写入日志时只提供可读标签，不保存单列或联合业务主键。

Repository 测试应验证生成查询的核心语义：

```text
WHERE 使用 originalKey / editingKey 的全部类型化定位字段
SET 使用 candidate.toJson() 的完整字段
普通表 UPDATE 的 matchedRows 决定旧行是否存在
无键表 UPDATE / DELETE 附加 LIMIT 1
```

## 14. 验收标准

全项目完成后应满足：

- 不存在仅因为字段属于主键而设置的只读控件。
- 不存在绑定完整详情候选物理列的永久只读控件；字段只可在当前类型或模式明确不适用时临时禁用。
- Brief/list/Picker 的派生展示值与完整详情候选实体分离，不作为只读数据库字段处理。
- 不存在仅为了保持主键不可变而从更新载荷移除的字段。
- 所有编辑操作都能区分原始行定位 Key 和候选实体产生的新 Key。
- 每个列表、选择器、可编辑子表和详情导航流程都使用独立 Brief Entity；不存在 Full Entity 冒充 Brief Entity 的实现。
- 每个 Brief Entity 都包含全部行定位列并提供强类型 `key` getter；显式全行定位器包含全部物理列。
- 每个 `FooKey` 都基于全部行定位字段实现 `==` 和 `hashCode`，并保持定位字段的真实类型与可空性。
- 有主键的表使用全部物理主键列；无主键但有非空唯一约束的表使用全部唯一键列；`playercreateinfo_cast_spell` 使用完整旧行快照和 `LIMIT 1`。
- 独立详情页使用 `persistedKey`，内嵌子表行使用独立 `editingKey`，二者都不会用 candidate 新键定位旧行。
- 不存在 `RouterNode.id` 或仅为路由身份而添加的 `FooKey` 字符串稳定编码。
- 不存在 `RouterFacade.replaceCurrentDetail`；详情页运行期身份切换由 `persistedKey` signal 完成。
- 所有主键修改都只更新当前表，不触发跨表扫描或级联。
- 每个 Repository 写方法只修改一个物理表；多 candidate 保存只能由 ViewModel 明确协调，不因父键变化产生隐式 locale/子表写入。
- 所有创建操作都原样写入 ViewModel 收集的候选实体，Repository 不在保存阶段重新分配或改变主键。
- 所有可编辑 `AUTO_INCREMENT` 新建与复制流程都在写入前持有显式非零键，不依赖数据库隐式分配或插入返回 ID；内部无详情候选实体的追加日志表除外。
- 不存在 Foxy 自行执行的跨表外键存在性校验、反向引用删除保护或级联写入。
- 主键冲突不会导致旧记录丢失。
- 更新不执行候选键冲突预检；Laconic 匹配行数正确区分“旧行不存在”和“行存在但值未变化”，删除零行不会记录成功日志。
- 主键修改后可以在同一详情页继续保存、删除、复制和刷新。
- `foxy.activity_log` 不存在业务 `entity_id`；活动日志只保留日志自身的 `id` 和可读目标标签，不承担业务记录定位或导航职责。
- `flutter analyze` 和相关测试通过，完整测试结果不引入超出已知基线的新失败。

## 15. 最终原则

```text
原始 Key = 旧行定位条件（物理主键、物理唯一键或显式全行快照）
当前实体 = 当前表最终写入内容
Repository = 只负责当前表
跨表引用影响 = 用户负责
```

该原则适用于 Foxy 管理的全部数据库表。
