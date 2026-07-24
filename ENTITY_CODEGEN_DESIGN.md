# Foxy Entity 与 Repository Filter 代码生成方案

## 1. 目标与边界

Foxy 的代码生成分成两个独立边界：

- Entity 生成器描述数据库行本身，并生成 Full Entity 的通用行为、Brief
  投影和复合 Key。
- Repository Filter 生成器描述某个 Repository 支持的查询输入，并生成
  Filter 数据对象。

两者不能互相推导。表中存在某列，不代表该列可以被筛选；查询支持某个
条件，也不代表它是 Full Entity 的持久化字段。

生成器只消除稳定、重复的数据对象代码。SQL、join、locale fallback、
分页、排序和 `_applyFilter()` 仍由 Repository 手写，因为这些行为表达的
是查询语义，而不是数据对象结构。

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

Repository 仍负责如何把 Key 翻译成 `where` 条件，但不拥有 Key 的结构。

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

## 5. Repository Filter 生成

### 5.1 注解 API

Repository Filter 注解定义在
`lib/infrastructure/codegen/repository_annotations.dart`：

```dart
enum FoxyFilterFieldType {
  boolean,
  decimal,
  integer,
  text,
}

final class FoxyRepositoryFilterField {
  final String name;
  final FoxyFilterFieldType type;
  final Object defaultValue;
}

final class FoxyRepositoryFilter {
  final String name;
  final List<FoxyRepositoryFilterField> fields;
}
```

Repository 示例：

```dart
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';

part 'item_template_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'ItemTemplateFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'entry',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
    FoxyRepositoryFilterField(
      name: 'minLevel',
      type: FoxyFilterFieldType.integer,
      defaultValue: 0,
    ),
  ],
)
class ItemTemplateRepository with RepositoryMixin {
  // SQL 和 _applyFilter() 手写。
}
```

### 5.2 生成结果

生成类位于同一 Repository library 的
`<name>_repository.g.dart`：

```dart
final class ItemTemplateFilter {
  final String entry;
  final int minLevel;

  const ItemTemplateFilter({
    this.entry = '',
    this.minLevel = 0,
  });

  factory ItemTemplateFilter.fromJson(Map<String, dynamic> json) { ... }

  ItemTemplateFilter copyWith({
    String? entry,
    int? minLevel,
  }) { ... }

  Map<String, dynamic> toJson() { ... }
}
```

Filter 是不可变查询数据对象。它生成 `fromJson`、`copyWith` 和 `toJson`，
但不生成 SQL。

当前 76 个 Repository 专属 Filter 已全部迁移到这条路径。

### 5.3 字段与默认值

| 注解类型 | Dart 类型 | JSON 读取 |
| --- | --- | --- |
| `boolean` | `bool` | `bool` |
| `decimal` | `double` | `num.toDouble()` |
| `integer` | `int` | `num.toInt()` |
| `text` | `String` | `toString()` |

默认值必须是可求值的编译期常量，并与字段类型匹配。`decimal` 可以使用
整数或 double 字面量，生成结果统一为 double。

字段名必须是 lowerCamelCase。遇到 Dart 保留字时只允许追加一个下划线，
例如 `class_`；这代表确定的查询字段名，不是数据库字段兼容 alias。

### 5.4 共享 Filter

一个 Filter 如果确实被多个 Repository 共同拥有，就不能生成在任意一个
Repository 的 private library part 中，否则其他 Repository 会反向依赖
错误的 owner。

当前唯一例外是：

```text
lib/repository/loot_template_filter.dart
└── LootTemplateFilter
```

它由 9 个 Loot Repository 共享，因此是独立的手写查询模型。它仍不属于
Entity，也不带 `Entity` 后缀。

未来只有在多个 Repository 的查询契约真正相同且共同演进时才允许新增
共享 Filter；仅仅字段碰巧相同不足以共享。

## 6. Builder 拓扑

`build.yaml` 只配置两条生成路径：

```text
lib/entity/**_entity.dart
  @FoxyFullEntity
    -> FoxyEntityGenerator
    -> source_gen shared part
    -> *_entity.g.dart

lib/repository/**_repository.dart
  @FoxyRepositoryFilter
    -> FoxyRepositoryFilterGenerator
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

Repository Filter 生成器拒绝：

- 注解 owner 不是以 `Repository` 结尾的 class；
- Repository class 与文件名不匹配；
- 缺少对应 `part '<name>_repository.g.dart';`；
- Filter 名不以 `Filter` 结尾，或仍带 `Entity` 后缀；
- 空字段列表、重复字段名或非法字段名；
- 无法识别的类型或不兼容默认值。

诊断必须指出具体 owner/字段和修复方式，避免生成半正确代码。

## 8. 测试与验收

生成器测试覆盖：

- 标准输出结构与行为；
- 注解顺序不影响 Entity 输出；
- 标量、nullable、bool 和复合 Key 映射；
- Repository Filter 的全部字段类型；
- 重复/非法名称和默认值类型错误。

仓库契约测试覆盖：

- 标准 Full Entity 只剩三个明确手写例外；
- 生成型 Full Entity 不依赖抽象 getter 或 lint ignore；
- 76 个 Repository 专属 Filter 都有对应注解和生成 part；
- 不存在 `*_filter_entity.dart`、`.filter.g.dart` 或旧 Builder；
- `LootTemplateFilter` 是唯一明确的共享 Filter。

每次修改生成规则后执行：

```bash
dart format <changed dart files>
dart run build_runner build --delete-conflicting-outputs
dart test test/infrastructure/codegen -j 1
flutter analyze
flutter test
git diff --check
```

验收的最终结构是：物理行身份由 Entity/Key 表达，列表投影由 Brief
表达，查询输入由 Repository Filter 表达，SQL 查询行为继续由
Repository 显式实现。
