# Foxy Entity、Repository 与 Filter 代码生成方案

## 1. 目标与边界

Foxy 的代码生成分成三个独立职责：

- Entity 生成器描述数据库行本身，并生成 Full Entity 的通用行为、Brief
  投影和复合 Key。
- Repository 生成器消费 Full Entity 的表名与物理 Key 元数据，生成标准
  公有行 CRUD 和查询定位代码。
- Filter 生成器描述某个 Repository 支持的查询输入，并生成 Filter
  数据对象。

三个职责不能随意互相推导。表中存在某列，不代表该列可以被筛选；查询
支持某个条件，也不代表它是 Full Entity 的持久化字段。

生成器只消除稳定、重复的数据对象和物理行持久化代码。Brief SQL、join、
locale fallback、分页、排序和 `_applyFilter()` 仍由 Repository 手写，
因为这些行为表达的是查询语义，而不是数据对象结构。

## 2. 为什么 Filter 不属于 Entity

Full Entity 是物理行的写模型，字段与数据库列一一对应。Filter 是一次
Repository 查询的输入模型，可能包含：

- 文本化的 ID 搜索；
- 只影响 join 的名称条件；
- UI 状态或范围边界；
- 多张表共同参与后才有意义的条件。

因此 Filter 的 owner 是 Repository。Entity 源文件中不允许再出现
`@FoxyFilterEntity`、`@FoxyFilterField` 或独立的
`*_filter_entity.dart`。

Filter 类型统一以 `Filter` 结尾，不带 `Entity` 后缀。

## 3. 为什么 Key 仍属于 Entity

Key 表示一行数据的完整物理身份。它由 Full Entity 上标记为 `key: true`
的字段决定，并被读取、更新、删除和 Brief Entity 的 `key` 共同使用。
这是行模型的固有属性，不是某个 Repository 查询策略。

- 单字段 Key 直接使用该字段的标量类型。
- 复合或特殊物理身份生成不可变的 `<Name>Key` 值对象。
- 复合 Key 生成值相等、`hashCode` 和 `toString`。

`@FoxyRepository(EntityType)` 负责把 Key 翻译成 `where` 条件，但
Repository 不重复声明 Key 的结构或物理列。

## 4. Entity 生成

### 4.1 注解

Entity 注解定义在
`lib/infrastructure/codegen/entity_annotations.dart`：

```dart
@FoxyBriefEntity()
@FoxyBriefField.text('displayName')
@FoxyFullEntity(table: 'foxy.dbc_example')
class ExampleEntity with _ExampleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Name')
  final String name;

  const ExampleEntity({
    this.id = 0,
    this.name = '',
  });

  factory ExampleEntity.fromJson(Map<String, dynamic> json) =>
      _ExampleEntityMixin.fromJson(json);
}
```

`@FoxyFullField` 的名称必须精确匹配物理 SQL/DBC 列名和大小写。

字段上的无参数 `@FoxyBriefField()` 表示把一个物理字段放入 Brief。
class 上的具名构造函数表示额外的查询投影：

```dart
@FoxyBriefField.text('displayName')
@FoxyBriefField.integer('childCount')
```

这种投影只进入 Brief，不进入 Full Entity，因此可以表达 join alias 而
不会污染持久化模型。Repository 的 `SELECT` 必须使用同名 alias。

### 4.2 生成结果

每个生成型 Entity 只有一个跟随源文件的 `*.g.dart`。其中可以同时包含：

- `_ExampleEntityMixin`
- `BriefExampleEntity`
- `ExampleKey`（仅复合 Key）

Full Mixin 不生成抽象 getter。实例方法内部使用：

```dart
final self = this as ExampleEntity;
```

因此源 Entity 不需要
`// ignore_for_file: annotate_overrides`，也不需要为了 Mixin 重复声明
getter。

Mixin 负责生成：

- `fromJson`
- `copyWith`
- `toJson`
- 值相等、`hashCode`、`toString`

Brief 只生成构造、`fromJson` 和 `key`，不生成写模型 API，例如
`toJson` 或 `copyWith`。

### 4.3 手写边界

目前只有以下 Full Entity 明确保留手写：

- `ActivityLogEntity`
- `FeatureEntity`
- `VersionEntity`

它们涉及 DateTime、枚举转换、无持久化行身份等当前生成器边界。新增标准
标量表 Entity 默认必须走生成器，不得随意扩充手写白名单。

## 5. Repository 与 Filter 生成

### 5.1 注解 API

Repository 注解定义在
`lib/infrastructure/codegen/repository_annotations.dart`：

```dart
enum FoxyFilterType {
  boolean,
  decimal,
  integer,
  text,
}

final class FoxyFilter {
  final Object defaultValue;
  final String name;
  final FoxyFilterType type;

  const FoxyFilter.text(
    this.name, {
    String this.defaultValue = '',
  }) : type = FoxyFilterType.text;

  const FoxyFilter.integer(
    this.name, {
    int this.defaultValue = 0,
  }) : type = FoxyFilterType.integer;

  // decimal / boolean 同理。
}

final class FoxyRepository {
  final Type entity;

  const FoxyRepository(this.entity);
}
```

Repository 示例：

```dart
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'item_template_repository.g.dart';

@FoxyRepository(ItemTemplateEntity)
@FoxyFilter.text('entry')
@FoxyFilter.text('name')
@FoxyFilter.integer('classId', defaultValue: -1)
class ItemTemplateRepository
    with RepositoryMixin, _ItemTemplateRepositoryMixin {
  // Brief SQL、Filter SQL 和带额外校验的方法手写。
}
```

`@FoxyRepository` 和 `@FoxyFilter` 相互独立：

- 标准持久化 Repository 同时使用两者。
- 只读或聚合查询 Repository 可以只使用 `@FoxyFilter`。
- 没有筛选条件的持久化 Repository 可以只使用 `@FoxyRepository`。

`FoxyFilter` 可以重复标注 class。Filter 名由 Repository class 推导：
`ItemTemplateRepository` 固定生成 `ItemTemplateFilter`，不再声明名称。

### 5.2 Repository 生成结果

`@FoxyRepository(ItemTemplateEntity)` 从 Entity 上读取：

- `@FoxyFullEntity.table`
- 全部 `@FoxyFullField(key: true)`
- Key 字段的 Dart 类型、属性名、物理列名和声明顺序

如果 Repository 没有声明对应操作，则在同一个 Repository part 中直接
生成公有的 `get<Name>`、`store<Name>`、`update<Name>` 和
`destroy<Name>`。调用方直接使用这些方法，不需要手写一层转发。

生成 Mixin 约束在 `RepositoryMixin` 上，因此可以直接使用 `laconic`：

```dart
mixin _ItemTemplateRepositoryMixin on RepositoryMixin {
  Future<void> destroyItemTemplate(int key) async {
    final deletedRows = await _whereKey(
      laconic.table('item_template'),
      key,
    ).delete();
    if (deletedRows == 0) {
      throw StateError('原记录不存在，可能已被其他操作修改或删除');
    }
  }

  Future<ItemTemplateEntity?> getItemTemplate(int key) async {
    final results = await _whereKey(
      laconic.table('item_template'),
      key,
    ).limit(1).get();
    if (results.isEmpty) return null;
    return ItemTemplateEntity.fromJson(results.first.toMap());
  }

  Future<void> updateItemTemplate(
    int originalKey,
    ItemTemplateEntity template,
  ) async {
    // 按 originalKey 更新完整 candidate，并检查 matchedRows。
  }

  QueryBuilder _whereKey(QueryBuilder builder, int key) {
    return builder.where('entry', key);
  }
}
```

复合 Key 按 Entity 声明顺序逐列生成：

```dart
mixin _PlayerCreateInfoRepositoryMixin on RepositoryMixin {
  QueryBuilder _whereKey(
    QueryBuilder builder,
    PlayerCreateInfoKey key,
  ) {
    var query = builder;
    query = query.where('race', key.race);
    query = query.where('class', key.class_);
    return query;
  }
}
```

生成器按操作签名识别现有方法：

- 缺少对应操作时，按 Entity base name 生成标准公有方法；
- 已存在同类 `get/store/update/destroy` 方法时，仅跳过该操作；
- 因此带额外字段校验、唯一性检查、特殊错误语义或历史 API 名称的方法
  可以继续手写，而其他操作仍然生成；
- 手写方法不是对生成私有方法的薄包装，而是完整的特殊实现。

当前 81 个持久化 Repository 全部使用生成 `_whereKey`，其中生成 68 个
`get`、68 个 `destroy`、65 个 `update` 和 4 个无额外校验的 `store`。
保留的手写方法确实含有额外校验或特殊命名。9 个 Loot Repository、
`AchievementCriteriaRepository`、`ItemRandomPropertiesRepository`、
`ItemVisualsRepository` 和 `SoundProviderPreferencesRepository` 保留既有
公有方法名，生成器不会额外暴露另一套 API。

`HolidayRepository`、`ItemLimitCategoryRepository`、
`TotemCategoryRepository` 和 `WaypointDataRepository` 是只读或聚合
查询边界，只生成 Filter，不混入持久化 Mixin。

### 5.3 Filter 生成结果

生成类位于同一 Repository library 的
`<name>_repository.g.dart`：

```dart
final class ItemTemplateFilter {
  final String entry;
  final int classId;

  const ItemTemplateFilter({
    this.entry = '',
    this.classId = -1,
  });

  factory ItemTemplateFilter.fromJson(Map<String, dynamic> json) { ... }

  ItemTemplateFilter copyWith({
    String? entry,
    int? classId,
  }) { ... }

  Map<String, dynamic> toJson() { ... }
}
```

Filter 是不可变查询数据对象。它生成 `fromJson`、`copyWith` 和 `toJson`，
但不生成 SQL。

当前 85 个 Repository 专属 Filter 已全部迁移到这条路径。

### 5.4 字段与默认值

| 注解类型 | Dart 类型 | JSON 读取 |
| --- | --- | --- |
| `boolean` | `bool` | `bool` |
| `decimal` | `double` | `num.toDouble()` |
| `integer` | `int` | `num.toInt()` |
| `text` | `String` | `toString()` |

默认值由具名构造函数提供并受到 Dart 静态类型检查。常用默认值无需书写：

- `FoxyFilter.text` → `''`
- `FoxyFilter.integer` → `0`
- `FoxyFilter.decimal` → `0.0`
- `FoxyFilter.boolean` → `false`

字段名必须是 lowerCamelCase。遇到 Dart 保留字时只允许追加一个下划线，
例如 `class_`；这代表确定的查询字段名，不是数据库字段兼容 alias。

### 5.5 Filter 不跨 Repository 共享

每个 Filter 都是其 Repository 的查询契约。即使多个 Repository 当前拥有
完全相同的字段，也必须分别声明和生成类型，不能通过共享 Filter 把这些
查询 API 耦合起来。

9 个 Loot Repository 因此分别拥有：

- `CreatureLootTemplateFilter`
- `DisenchantLootTemplateFilter`
- `GameObjectLootTemplateFilter`
- `ItemLootTemplateFilter`
- `MillingLootTemplateFilter`
- `PickpocketingLootTemplateFilter`
- `ProspectingLootTemplateFilter`
- `ReferenceLootTemplateFilter`
- `SkinningLootTemplateFilter`

字段形状相同只是当前实现事实，不构成共享 owner。以后某一种 Loot 查询
增加条件时，只修改对应 Repository 的注解和 SQL。

## 6. Builder 拓扑

`build.yaml` 只配置两条生成路径：

```text
lib/entity/**_entity.dart
  @FoxyFullEntity
    -> FoxyEntityGenerator
    -> source_gen shared part
    -> *_entity.g.dart

lib/repository/**_repository.dart
  @FoxyRepository(EntityType) + 可重复 @FoxyFilter.*
    -> FoxyRepositoryGenerator + FoxyFilterGenerator
    -> source_gen shared part
    -> *_repository.g.dart
```

两者都使用 `SharedPartBuilder` 和 `source_gen:combining_builder`。旧的
`LibraryBuilder`、`.filter.g.dart` 和 `foxy_filter_entity` Builder 已删除。

生成命令：

```bash
dart run build_runner build --delete-conflicting-outputs
```

生成文件纳入版本控制，调用方只 import Entity 或 Repository 的主 library，
不直接 import `.g.dart`。

## 7. 构建期诊断

Entity 生成器拒绝：

- 文件名、class 名或 Mixin 形状不符合约定；
- 缺少或重复 `@FoxyFullField`；
- 重复物理列名；
- 缺少完整 Key；
- Brief 缺少完整物理身份；
- Brief 投影与 Full 字段重名；
- 不支持的字段类型或不兼容默认值。

Repository 生成器拒绝：

- `@FoxyRepository` owner 不是以 `Repository` 结尾的 class；
- Entity 与 Repository base name 不一致；
- Entity 没有唯一 `@FoxyFullEntity` 或没有物理 Key；
- Repository 没有混入约定的生成 Mixin；
- Repository class 与文件名不匹配；
- 缺少对应 `part '<name>_repository.g.dart';`；

Filter 生成器拒绝：

- `@FoxyFilter` owner 不是以 `Repository` 结尾的 class；
- 重复或非法字段名；
- 无法识别的具名构造类型。

诊断必须指出具体 owner/字段和修复方式，避免生成半正确代码。

## 8. 测试与验收

生成器测试覆盖：

- 标准输出结构与行为；
- 注解顺序不影响 Entity 输出；
- 标量、nullable、bool 和复合 Key 映射；
- FoxyFilter 的全部字段类型、默认值和注解顺序；
- 重复/非法 Filter 字段；
- 缺失的标准公有 Repository CRUD 生成；
- 已存在特殊 Repository 方法时按操作跳过；
- 标量与复合 Repository Key 定位；
- Repository 与 Entity 命名不一致。

仓库契约测试覆盖：

- 标准 Full Entity 只剩三个明确手写例外；
- 生成型 Full Entity 不依赖抽象 getter 或 lint ignore；
- 85 个 Repository 专属 Filter 都有对应注解和生成 part；
- 81 个标准持久化 Repository 不再手写 `_whereKey`；
- 标准 Repository 公有 CRUD 位于生成 Mixin，特殊实现仍在主文件；
- 不存在 `*_filter_entity.dart`、`.filter.g.dart` 或旧 Builder；
- 不存在跨 Repository 共享的 `LootTemplateFilter`。

每次修改生成规则后执行：

```bash
dart format <changed dart files>
dart run build_runner build --delete-conflicting-outputs
dart test test/infrastructure/codegen -j 1
flutter analyze
flutter test
git diff --check
```

验收的最终结构是：物理行身份由 Entity/Key 表达，Repository Mixin
消费该身份生成标准公有行 CRUD 和物理定位，列表投影由 Brief 表达，
查询输入由 Filter 表达，特殊校验与其余 SQL 查询行为继续由 Repository
显式实现。
