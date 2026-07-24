# Foxy Entity 代码生成方案

## 1. 目标

本方案以 `lib/entity/` 中的 Full Entity 作为持久化数据结构的唯一事实源，
减少 Full Entity、Key 和 Brief Entity 的模板代码，并把查询 Filter 从
Entity 元数据中逐步迁移到 Repository 查询契约。

每个生成型 Entity 只暴露一个手写 Dart library：
`xxx_entity.dart`。Full Mixin、标准复合 Key 和标准 Brief Entity 全部作为
同一个 library 的 part 写入 `xxx_entity.g.dart`。业务代码不得直接 import
生成文件，也不再为生成型 Brief/Key 保留转发壳文件。

手写代码继续保留：

- Entity 类；
- 不可变 `final` 字段；
- `const` 构造函数；
- `@FoxyFullEntity`、`@FoxyFullField` 以及按需使用的 Brief/Filter 注解；
- 一行 `fromJson` factory 委托；
- Entity 特有的业务方法。

Entity 生成器负责生成：

- `_XXXEntityMixin`；
- `static fromJson()`；
- `copyWith()`；
- `toJson()`；
- `operator ==`；
- `hashCode`；
- `toString()`；
- 标准复合 Key；
- 标准 Brief Entity。

所有产物必须读取同一个 Full Entity 源文件，不得复制物理列名、默认值或主键
定义。标量 Key 继续直接使用 `int` 或 `String`，不额外生成类型。

## 2. 非目标

第一版不处理以下内容：

- 不生成字段或构造函数；
- 不修改已有类声明；
- 不生成 Repository、SQL 或 `_applyFilter()`；
- 不从数据库实时反向读取 Schema；
- 不为集合字段提供深度相等；
- 不允许一个字段读取多个数据库列名；
- 不为 nullable `copyWith` 提供“显式设置为 null”的 sentinel；
- 不自动处理 `DateTime`、enum、`Map`、`List` 或自定义值对象；
- 不让任何 Builder 读取另一个 Builder 的生成文件；
- 不把 Repository Filter 输出到 Entity 的 `*.g.dart`。

遇到暂不支持的类型或结构时，生成器必须在构建期报错，不得静默跳过或生成
弱类型代码。

## 3. 总体结构

本方案最终选择：**单 package + `lib/infrastructure/codegen/`**。

`codegen` 是合适的目录名。它描述的是构建期代码生成能力，而不是某一种 Entity
产物；后续加入 Repository 等生成器时仍然适用。放在 `infrastructure` 下表示它
属于 Foxy 自身的工程基础设施，不属于 Entity 的业务模型。该目录虽然位于 `lib`
下，但不会因为位置在 `lib` 下就自动进入 Flutter 产物；Dart/Flutter 只会沿实际
import 图编译可达代码。

注解和生成器都放在 Foxy 主 package 的 build-time infrastructure 中，不创建
额外本地 package：

```text
lib/infrastructure/codegen/
├── builder.dart
├── entity_annotations.dart
└── src/
    ├── entity_emitter.dart
    ├── entity_generator.dart
    ├── entity_model.dart
    ├── entity_reader.dart
    ├── filter_entity_generator.dart
    └── entity_validator.dart

test/infrastructure/codegen/
├── brief_entity_generator_test.dart
├── filter_entity_generator_test.dart
├── full_entity_generator_test.dart
└── key_generator_test.dart

build.yaml
```

这里的“不同 Dart library”**不是**“不同 Dart package”。在 Dart 中，一个可被
`import` 的 `.dart` 文件通常就是一个 library；同一个 package 可以包含很多
library。这里实际只要求保留两个互不导出的入口：

```text
package:foxy/infrastructure/codegen/entity_annotations.dart  # 运行时代码可见
package:foxy/infrastructure/codegen/builder.dart              # 仅 build_runner 可见
```

具体边界如下：

- Entity 只允许 import
  `package:foxy/infrastructure/codegen/entity_annotations.dart`；
- `entity_annotations.dart` 只能依赖 `dart:core` 和 `meta`；
- `builder.dart` 与 `src/*_generator.dart` 才能 import `analyzer`、`build` 和
  `source_gen`；
- `lib/main.dart`、DI 和任何运行时代码不得 import `builder.dart` 或 generator；
- 不从 `entity_annotations.dart` export builder/generator library。
- 不使用 `part` 将 annotation 与 builder/generator 合并成同一个 library。

根 `pubspec.yaml` 增加或显式声明：

```yaml
dependencies:
  meta: ^1.18.0

dev_dependencies:
  analyzer: ^7.6.0
  build: ^3.1.0
  source_gen: ^3.1.0
```

另外通过 `flutter pub add --dev build_test test` 添加生成器测试依赖，让 pub
解析与当前 `build 3.x`、Dart 3.9.2 兼容的版本。上面的版本展示当前项目已经
解析出的主版本关系；实施时提交更新后的 `pubspec.lock`。

Foxy 是 `publish_to: none` 的应用项目，生成器不会被其他 package 消费，因此
单独拆 annotation/generator package 带来的发布隔离没有实际收益。只要严格
保持 Dart library import 边界，generator 的 dev dependencies 就不会进入
Flutter 运行时代码的依赖路径。

只有满足以下任一条件时，才改为两个 package：

- 注解和生成器需要被多个应用共同使用；
- 生成器准备独立发布或独立版本演进；
- Foxy 改造成多 package workspace，并且其他 package 也需要使用这些注解。

届时再拆成运行时依赖 `foxy_entity_annotations` 和开发依赖
`foxy_entity_generator`。当前阶段提前拆分会增加两个 `pubspec.yaml`、路径依赖、
版本配对和分别测试的成本，却不会改善实际运行时产物。

## 4. 注解 API

注解 library 使用 `package:meta/meta_meta.dart` 限制注解目标。所有注解构造函数
必须是 `const`。

### 4.1 FoxyFullEntity

```dart
import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class FoxyFullEntity {
  final String table;

  const FoxyFullEntity({
    required this.table,
  });
}
```

`table` 使用完整物理表名：

```dart
@FoxyFullEntity(table: 'creature_template')
```

DBC 表使用完整限定名：

```dart
@FoxyFullEntity(table: 'foxy.dbc_glyph_properties')
```

第一阶段生成 Entity 层代码时不会使用 `table` 生成 SQL，但会校验其非空。后续
Repository 生成器可以直接复用该元数据。

### 4.2 FoxyFullField

```dart
@Target({TargetKind.field})
class FoxyFullField {
  final String name;
  final bool key;

  const FoxyFullField(
    this.name, {
    this.key = false,
  });
}
```

示例：

```dart
@FoxyFullField(
  'ID',
  key: true,
)
final int id;
```

约束：

- `name` 是唯一、精确且区分大小写的物理数据库列名；
- 不提供 alias；
- `key` 表示字段属于物理主键；
- 复合主键顺序使用字段在 Entity 中的声明顺序；
- Full 字段的反序列化回退值不在注解中重复配置，统一读取未命名构造函数中
  对应参数的默认值。

### 4.3 FoxyBriefEntity 和 FoxyBriefField

这两个注解在第一阶段启用：

```dart
@Target({TargetKind.classType})
class FoxyBriefEntity {
  const FoxyBriefEntity();
}

@Target({TargetKind.field})
class FoxyBriefField {
  const FoxyBriefField();
}
```

`@FoxyBriefEntity` 标记该 Full Entity 可以派生标准 Brief Entity；
`@FoxyBriefField` 选择进入 Brief 的 Full 字段。

标准 Brief 生成约束：

- Brief 字段必须全部来自 Full Entity；
- Brief 必须包含完整物理身份；
- Brief 的 `fromJson` 继续使用对应 `FoxyFullField.name` 物理列名；
- Brief 构造默认值复用 Full Entity 对应构造参数的默认值；
- 标量身份的 `key` getter 返回 `int` 或 `String`；
- 复合身份的 `key` getter 返回生成的 `XXXKey`；
- Brief 生成 `final` 字段、`const` 构造函数、`fromJson` 和 `key`；
- Brief 不生成 `copyWith` 或 `toJson`，避免暴露写模型 API；
- join、locale fallback 或计算展示字段存在时，不添加
  `@FoxyBriefEntity`，继续手写 Brief。

### 4.4 Repository Filter

Filter 不是数据库行，也不是 Entity 的精简投影。它表达某个 Repository
公开了哪些查询条件，因此最终归属于 Repository library。

目标注解放在 Repository class 上，而不是 Full Entity 或 Full 字段上：

```dart
part 'gem_property_repository.g.dart';

@FoxyRepositoryFilter(
  name: 'GemPropertyFilter',
  fields: [
    FoxyRepositoryFilterField(
      name: 'id',
      type: FoxyFilterFieldType.text,
      defaultValue: '',
    ),
  ],
)
class GemPropertyRepository with RepositoryMixin {
  // _applyFilter 仍然手写。
}
```

目标产物 `GemPropertyFilter` 是
`gem_property_repository.g.dart` 的一部分。ViewModel 已经依赖具体
Repository，因此只需 import `gem_property_repository.dart`，不需要 import
Entity Filter 文件或任何 `.g.dart`。

Repository Filter 注解至少声明：

- Filter 类型名；
- Dart 字段名；
- Dart 字段类型；
- 构造默认值。

Filter 字段类型不能从 Full 字段类型推断。例如 Full 的 `int id` 常对应
Filter 的 `String id`，以保留文本框原始输入。类型映射继续使用：

```text
boolean -> bool
decimal -> double
integer -> int
text    -> String
```

Filter 生成 `final` 字段、`const` 构造函数、`fromJson`、`copyWith` 和
`toJson`。JSON key 使用 Filter 的 Dart 字段名。

第一版 Repository Filter 生成器不生成 SQL。`_applyFilter()` 继续由
Repository 手写，因为实际查询可能包含：

- 精确、模糊和范围比较；
- locale fallback；
- join 后的展示字段；
- 多列组合条件；
- 同一字段在不同查询方法中的不同语义。

只有当这些语义形成稳定且足够小的公共模型后，才考虑增加 comparator 等元数据；
不能为了生成 SQL 把任意查询表达式塞进注解字符串。

通常一个列表 Repository 对应一个 Filter，可直接使用 class 注解。若一个
Repository 暴露多组独立查询，则注解必须显式命名每个 Filter，不能根据方法名
猜测。像 `LootTemplateFilter` 这样被多个 Repository 共享的查询条件不归属于
任意一个具体 Repository，应保留在独立的共享查询模型文件中。

当前代码中的 `@FoxyFilterEntity`、`@FoxyFilterField` 和
`*.filter.g.dart` 是迁移期兼容实现。迁移 Repository Filter 时应按模块逐个
替换；在全部调用方迁移完成前，不同时生成两个同名 Filter。

### 4.5 Key

Key 不使用独立注解。Entity Generator 只读取 `FoxyFullField.key`：

- 没有 key 字段：不生成 Key，并由 Full Entity Validator 给出诊断；
- 单个 `int` 或 `String` key：直接使用标量，不生成 `XXXKey` 类；
- 多个 key 字段：按照 Full 字段声明顺序生成不可变 `XXXKey`；
- 生成的复合 Key 包含 `final` 字段、`const` 构造函数、`fromEntity`、
  `operator ==`、`hashCode` 和 `toString`；
- 特殊身份无法由物理 key 字段表达时继续手写专用 Key，不使用隐藏白名单。

Key 属于 Entity，而不是 Repository，原因是它表达“这一行是谁”，会跨越
Repository、ViewModel、路由和 Brief Entity 使用。Repository 只负责如何使用
旧 Key 定位更新或删除目标，不拥有身份定义。

只有查询游标、临时 locator、替代搜索键等不代表持久化行身份的“key”才属于
Repository 查询模型，不使用本节的 Entity Key 生成规则。

## 5. Entity 编写形式

每个输入 Dart 文件只能声明一个 `@FoxyFullEntity` class。生成器不支持也不尝试
聚合一个文件中的多个 Full Entity；检测到第二个时直接构建失败。文件名必须与
该 Full Entity 对应，例如 `CreatureTemplateEntity` 放在
`creature_template_entity.dart`。

```dart
import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_template_entity.g.dart';

@FoxyFullEntity(table: 'creature_template')
class CreatureTemplateEntity with _CreatureTemplateEntityMixin {
  @FoxyFullField(
    'entry',
    key: true,
  )
  final int entry;

  @FoxyFullField('name')
  final String name;

  const CreatureTemplateEntity({
    this.entry = 0,
    this.name = '',
  });

  factory CreatureTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureTemplateEntityMixin.fromJson(json);
}
```

命名规则：

- 输入文件：`creature_template_entity.dart`
- 生成文件：`creature_template_entity.g.dart`
- 生成 Mixin：`_CreatureTemplateEntityMixin`
- 生成 Brief：`BriefCreatureTemplateEntity`（启用时）
- 生成复合 Key：`CreatureTemplateKey`（多列身份时）
- Mixin 只使用下划线前缀，不使用 `$`
- Mixin 中的静态方法名为 `fromJson`，不使用下划线前缀

Mixin 是 library-private 类型。虽然 `fromJson` 自身不是私有名称，外部
library 仍不能通过 `_CreatureTemplateEntityMixin` 调用它。

Entity 保留现有 factory API：

```dart
CreatureTemplateEntity.fromJson(json)
```

不改成 companion、顶层函数或公开静态解析器。

Full、Brief 和 Key 属于同一个 Dart library。调用方统一 import 手写入口：

```dart
import 'package:foxy/entity/creature_template_entity.dart';
```

禁止以下形式：

```dart
import 'package:foxy/entity/brief_creature_template_entity.dart';
import 'package:foxy/entity/creature_template_entity.key.g.dart';
import 'package:foxy/entity/creature_template_entity.brief.g.dart';
```

生成型 Entity 不保留 `brief_xxx_entity.dart` 或 `xxx_key.dart` 转发壳。
仍然存在的独立 Brief/Key 文件只代表尚不能从 Full Entity 元数据生成的手写模型。

当前已继续迁移 `BroadcastText`、`Condition`、`ItemExtendedCost`、
`ScalingStatDistribution`、`SmartScript` 和 `SpellFocusObject` 的标准 Brief。
这些 Brief 的字段全部来自 Full Entity；原有展示 getter 以同库 extension 保留。
剩余独立 Brief 包含 JOIN/聚合字段、兼容别名，或其 Full Entity 本身仍采用非对称
手写映射。剩余独立 Key 中，普通物理复合 Key 依赖这些手写 Full Entity；
`WaypointDataKey` 和 `ItemEnchantmentTemplateParentKey` 则不是物理行主键。

### 5.1 注解排序

同一个声明上的多个注解没有执行顺序。项目统一按照注解类型名的字母顺序排列，
排序时忽略开头的 `@`。

后续同时启用 Brief 和 Filter 时，class 注解统一使用
`Foxy + 角色 + Entity` 命名，并按字母顺序排列：

```dart
@FoxyBriefEntity()
@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_glyph_properties')
class GlyphPropertyEntity with _GlyphPropertyEntityMixin {
  // ...
}
```

字段注解统一使用 `Foxy + 角色 + Field` 命名，并按字母顺序排列：

```dart
@FoxyBriefField()
@FoxyFilterField(
  defaultValue: '',
  type: FoxyFilterFieldType.text,
)
@FoxyFullField(
  'ID',
  key: true,
)
final int id;
```

Key 不使用独立注解，由 `FoxyFullField(key: true)` 表达。

该顺序只作为源码风格约定，任何 Reader、Validator 或 Generator 都不得依赖
注解声明顺序。注解内部的命名参数继续遵循 Dart formatter 和就近代码的可读性，
不纳入本排序规则。

## 6. 生成结果

上一节的 Entity 生成：

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creature_template_entity.dart';

mixin _CreatureTemplateEntityMixin {
  static CreatureTemplateEntity fromJson(Map<String, dynamic> json) {
    return CreatureTemplateEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  CreatureTemplateEntity copyWith({
    int? entry,
    String? name,
  }) {
    final self = this as CreatureTemplateEntity;
    return CreatureTemplateEntity(
      entry: entry ?? self.entry,
      name: name ?? self.name,
    );
  }

  Map<String, dynamic> toJson() {
    final self = this as CreatureTemplateEntity;
    return {
      'entry': self.entry,
      'name': self.name,
    };
  }

  @override
  bool operator ==(Object other) {
    final self = this as CreatureTemplateEntity;
    return identical(self, other) ||
        other is CreatureTemplateEntity &&
            self.runtimeType == other.runtimeType &&
            self.entry == other.entry &&
            self.name == other.name;
  }

  @override
  int get hashCode {
    final self = this as CreatureTemplateEntity;
    return Object.hashAll([
      self.runtimeType,
      self.entry,
      self.name,
    ]);
  }

  @override
  String toString() {
    final self = this as CreatureTemplateEntity;
    return 'CreatureTemplateEntity('
        'entry: ${self.entry}, '
        'name: ${self.name}'
        ')';
  }
}
```

所有生成内容按照字段在源文件中的声明顺序输出。该顺序同时用于：

- `fromJson` 构造参数；
- `copyWith` 参数；
- `toJson` Map；
- `operator ==`；
- `hashCode`；
- `toString`。

这保证 DBC 物理字段不会因为字母排序或 Map 遍历发生顺序变化。

### 6.1 Companion 命名

给定 `GlyphPropertyEntity`：

```text
Full Mixin -> _GlyphPropertyEntityMixin
Brief      -> BriefGlyphPropertyEntity
Filter     -> GlyphPropertyFilterEntity
Key        -> GlyphPropertyKey
```

Key 名称从 Full class 名移除结尾的 `Entity` 后追加 `Key`。标量 key 不生成
`GlyphPropertyKey`。

### 6.2 复合 Key 示例

`GossipMenuEntity` 的 `menuId/textId` 都标记 `key: true` 时生成：

```dart
final class GossipMenuKey {
  final int menuId;
  final int textId;

  const GossipMenuKey({
    required this.menuId,
    required this.textId,
  });

  factory GossipMenuKey.fromEntity(GossipMenuEntity entity) {
    return GossipMenuKey(
      menuId: entity.menuId,
      textId: entity.textId,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is GossipMenuKey &&
            menuId == other.menuId &&
            textId == other.textId;
  }

  @override
  int get hashCode => Object.hashAll([menuId, textId]);

  @override
  String toString() {
    return 'GossipMenuKey(menuId: $menuId, textId: $textId)';
  }
}
```

### 6.3 Brief 示例

```dart
class BriefGlyphPropertyEntity {
  final int id;
  final int spellId;

  const BriefGlyphPropertyEntity({
    this.id = 0,
    this.spellId = 0,
  });

  factory BriefGlyphPropertyEntity.fromJson(Map<String, dynamic> json) {
    return BriefGlyphPropertyEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      spellId: (json['SpellID'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
```

Brief 不生成 `copyWith/toJson`。复合身份 Brief 与复合 Key 位于同一个
Entity library，其 `key` getter 直接返回完整复合 Key，不产生 import 或额外
生成文件。

### 6.4 迁移期 Filter 示例

```dart
class GlyphPropertyFilterEntity {
  final String id;

  const GlyphPropertyFilterEntity({
    this.id = '',
  });

  factory GlyphPropertyFilterEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return GlyphPropertyFilterEntity(
      id: json['id']?.toString() ?? '',
    );
  }

  GlyphPropertyFilterEntity copyWith({
    String? id,
  }) {
    return GlyphPropertyFilterEntity(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}
```

Filter 使用 Dart 字段名作为 JSON key，不使用 `FoxyFullField.name`。这是当前
Entity Filter 兼容产物；迁移完成后，同样的类型由 Repository 注解生成到
`xxx_repository.g.dart`，并移除 `Entity` 后缀。

## 7. 类型映射规则

第一版支持以下 Dart 类型及其 nullable 形式：

| Dart 类型 | `fromJson` | `toJson` |
| --- | --- | --- |
| `int` | `(value as num?)?.toInt()` | 原值 |
| `double` | `(value as num?)?.toDouble()` | 原值 |
| `String` | `value?.toString()` | 原值 |
| `bool` | 数据库 `0/1` 转为布尔值 | 布尔值转为 `0/1` |

### 7.1 int

```dart
@FoxyFullField('ID')
final int id;

const Entity({
  this.id = 0,
});
```

生成：

```dart
id: (json['ID'] as num?)?.toInt() ?? 0,
```

### 7.2 double

```dart
@FoxyFullField('Chance')
final double chance;

const Entity({
  this.chance = 100.0,
});
```

生成：

```dart
chance: (json['Chance'] as num?)?.toDouble() ?? 100.0,
```

`double` 构造参数默认值推荐显式写 `100.0` 而不是 `100`。生成器可以接受整数
常量，并在生成代码时规范为 double literal。

### 7.3 String

```dart
@FoxyFullField('Name')
final String name;

const Entity({
  this.name = '',
});
```

生成：

```dart
name: json['Name']?.toString() ?? '',
```

### 7.4 bool

第一版约定所有数据库布尔字段使用 `0/1`：

```dart
@FoxyFullField('QuestRequired')
final bool questRequired;

const Entity({
  this.questRequired = false,
});
```

生成逻辑必须区分“数据库值不存在”和 `false`：

```dart
questRequired: json['QuestRequired'] == null
    ? false
    : (json['QuestRequired'] as num).toInt() == 1,
```

`toJson`：

```dart
'QuestRequired': questRequired ? 1 : 0,
```

对于 `bool?`：

```dart
'Enabled': enabled == null ? null : (enabled! ? 1 : 0),
```

### 7.5 nullable

nullable 字段允许：

```dart
@FoxyFullField('Description')
final String? description;

const Entity({
  this.description,
});
```

可选 nullable 参数没有显式默认值时，Dart 默认值为 `null`，生成器同样将
`null` 作为反序列化回退值。

第一版 `copyWith` 仍生成：

```dart
Entity copyWith({
  String? description,
}) {
  return Entity(
    description: description ?? this.description,
  );
}
```

因此暂时不能通过以下调用把已有非空值改为 `null`：

```dart
entity.copyWith(description: null);
```

这是第一版明确接受的限制。后续若确实需要，再单独引入 sentinel 方案。

## 8. 默认值规则

Full Entity 的未命名 generative constructor 是默认值的唯一事实来源：

```dart
@FoxyFullField('LootMode')
final int lootMode;

const Entity({
  this.lootMode = 1,
});
```

生成器通过 analyzer 读取 `this.lootMode = 1` 的常量值并生成：

```dart
lootMode: (json['LootMode'] as num?)?.toInt() ?? 1,
```

这个规则同时用于 Full Mixin 和标准 Brief；Filter 使用
`FoxyFilterField.defaultValue`，不属于本节规则。

校验规则：

- 每个 Full 字段必须对应未命名构造函数中的同名 named initializing formal，
  即 `this.fieldName`；
- 非 nullable 参数必须提供显式的编译期常量默认值；
- nullable 参数可以省略默认值，此时规范化为 `null`；
- nullable 参数也可以提供与其非空类型兼容的常量默认值；
- `int` 字段要求整数默认值；
- `double` 字段接受 `int` 或 `double` 数值默认值；
- `String` 字段要求字符串默认值；
- `bool` 字段要求布尔默认值；
- 第一版不支持 required 构造参数；这类 Entity 暂时继续手写；
- 第一版只把 `int`、`double`、`String`、`bool` 和 `null` 常量写入生成代码；
- 如果构造参数默认值引用 `static const`，Reader 必须读取其计算后的常量值，
  Emitter 再输出规范化 literal，不复制原始表达式文本。

以下字段初始化器不是构造参数默认值，不允许用于生成型 Entity：

```dart
@FoxyFullField('LootMode')
final int lootMode = 1;
```

它会让 `final` 字段在声明处完成赋值，无法再通过 `this.lootMode` 接收不同实例值。

`ActivityLogEntity`、`FeatureEntity` 等包含 required 参数、enum 或
`DateTime` 的特殊 Entity 暂时保持手写。

## 9. 相等、hashCode 和 toString

### 9.1 operator ==

生成值相等判断：

```dart
@override
bool operator ==(Object other) {
  return identical(this, other) ||
      other is EntityName &&
          runtimeType == other.runtimeType &&
          field1 == other.field1 &&
          field2 == other.field2;
}
```

包含 `runtimeType` 是为了避免 Entity 将来出现子类时产生不对称相等关系。

### 9.2 hashCode

统一使用：

```dart
Object.hashAll([
  runtimeType,
  field1,
  field2,
]);
```

不使用 `Object.hash(...)`，因为大型 DBC Entity 很容易超过它适合表达的
参数数量。

### 9.3 toString

统一格式：

```text
EntityName(field1: value1, field2: value2)
```

字段顺序与声明顺序一致。

第一版只支持标量字段，因此 `==` 使用字段自身的 `==` 即可。将来若支持
`List` 或 `Map`，必须先明确深度相等和对应 hash 规则，不能只生成引用相等。

## 10. Builder 配置

`lib/infrastructure/codegen/builder.dart`：

```dart
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/entity_generator.dart';
import 'src/filter_entity_generator.dart';

Builder foxyEntityBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [const FoxyEntityGenerator()],
    'foxy_entity',
  );
}

Builder foxyFilterEntityBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const FoxyFilterEntityGenerator(),
    generatedExtension: '.filter.g.dart',
  );
}
```

根目录 `build.yaml` 的 Builder 定义：

```yaml
builders:
  foxy_entity:
    import: "package:foxy/infrastructure/codegen/builder.dart"
    builder_factories: ["foxyEntityBuilder"]
    build_extensions:
      ".dart": [".foxy_entity.g.part"]
    auto_apply: root_package
    build_to: cache
    applies_builders: ["source_gen:combining_builder"]

  foxy_filter_entity:
    import: "package:foxy/infrastructure/codegen/builder.dart"
    builder_factories: ["foxyFilterEntityBuilder"]
    build_extensions:
      ".dart": [".filter.g.dart"]
    auto_apply: root_package
    build_to: source
```

同一个根 `build.yaml` 增加 target 配置，限制扫描范围：

```yaml
targets:
  $default:
    builders:
      foxy:foxy_entity:
        generate_for:
          - lib/entity/**_entity.dart
      foxy:foxy_filter_entity:
        generate_for:
          - lib/entity/**_entity.dart
```

Entity Builder 只接受包含唯一 `@FoxyFullEntity` class 的输入文件，一次读取并
校验完整模型，然后按照固定顺序输出：

1. Full Mixin；
2. 标准复合 Key（多列身份时）；
3. 标准 Brief Entity（启用时）。

三个产物之间直接引用同一个 library 中的类型，不生成 import。标量 Key 不产生
额外声明。迁移期 Filter Builder 仍根据 `@FoxyFilterEntity` 单独生成
`.filter.g.dart`；它不进入 Entity shared part。

运行：

```bash
dart run build_runner build --delete-conflicting-outputs
```

开发期间可以运行：

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### 10.1 Builder 拓扑

一个 Full Entity 是唯一输入和唯一公开 library：

```text
Full Entity annotations
        │
        ▼
FoxyEntityGenerator
        │
        ├── Full Mixin
        ├── composite Key（可选）
        └── Brief Entity（可选）
        │
        ▼
SharedPartBuilder + combining_builder
        │
        ▼
xxx_entity.g.dart

迁移期 @FoxyFilterEntity ──> Filter LibraryBuilder ──> *.filter.g.dart
```

规则：

- Entity Generator 只读取一次 Full Entity 并构建一个
  `EntityGenerationModel`；
- Full、Brief 和 Key 由同一个 Emitter 基于同一模型输出；
- Builder 不依赖注解声明顺序；
- Builder 之间不建立“先生成、再读取生成文件”的执行链；
- Entity 使用 `SharedPartBuilder`；
- 迁移期 Filter 使用独立 `LibraryBuilder`；
- `.foxy_entity.g.part` 只存在于 build cache，最终由
  `source_gen:combining_builder` 写入 tracked `*.g.dart`。

产物：

```text
glyph_property_entity.dart
glyph_property_entity.g.dart
glyph_property_entity.filter.g.dart

player_create_info_entity.dart
player_create_info_entity.g.dart
```

不产生 `*.brief.g.dart` 或 `*.key.g.dart`，也不保留对应转发壳。Filter 的
兼容 export 文件会在 Repository Filter 迁移时一并移除。

### 10.2 Library 与 import 规则

物理生成文件不是公共模块边界。业务代码只根据类型归属 import 手写入口：

- Full、Brief、持久化 Key → `xxx_entity.dart`；
- Repository 专属 Filter → `xxx_repository.dart`；
- 共享 Filter → 独立共享查询模型文件；
- 手写特殊 Key → 对应手写 Key 文件。

同一个调用文件同时使用 Full、Brief 和生成 Key 时仍然只有一个 Entity import。
这避免把 Builder extension、生成器拆分方式和执行顺序泄漏给业务层。

## 11. 生成器内部模型

生成器不要直接在 analyzer Element 上拼接字符串。先读取为内部不可变模型：

```dart
final class EntityGenerationModel {
  final String className;
  final bool generateBrief;
  final bool generateFilter;
  final String mixinName;
  final String table;
  final List<EntityFieldModel> fields;

  const EntityGenerationModel({
    required this.className,
    required this.generateBrief,
    required this.generateFilter,
    required this.mixinName,
    required this.table,
    required this.fields,
  });
}

final class EntityFieldModel {
  final String dartName;
  final String dartType;
  final String columnName;
  final Object? constructorDefaultValue;
  final FilterFieldGenerationModel? filter;
  final bool includeInBrief;
  final bool nullable;
  final bool key;

  const EntityFieldModel({
    required this.dartName,
    required this.dartType,
    required this.columnName,
    required this.constructorDefaultValue,
    required this.filter,
    required this.includeInBrief,
    required this.nullable,
    required this.key,
  });
}

final class FilterFieldGenerationModel {
  final Object? defaultValue;
  final FoxyFilterFieldType type;

  const FilterFieldGenerationModel({
    required this.defaultValue,
    required this.type,
  });
}
```

处理流程：

```text
GeneratorForAnnotation<FoxyFullEntity>
        │
        ▼
读取 ClassElement、未命名构造函数和 FoxyFullField
        │
        ▼
构建 EntityGenerationModel
        │
        ▼
集中执行全部校验
        │
        ▼
EntityEmitter 输出 Dart 源码
        │
        ▼
SharedPartBuilder 合并为 *.g.dart
```

Reader、Validator 和 Emitter 必须分离。Entity Generator 一次读取模型后统一
输出 Full、Brief 和 Key；迁移期 Filter Generator 以及后续 Repository
Generator 复用相应元数据，而不是重新解释源码文本。

## 12. 构建期诊断

以下情况必须抛出 `InvalidGenerationSourceError`，并关联到具体 class 或 field：

1. `@FoxyFullEntity` 没有标注在 class 上；
2. `table` 为空；
3. Entity 没有未命名 generative constructor；
4. Entity 存在非 `final` 实例字段；
5. 非静态实例字段缺少 `@FoxyFullField`；
6. `FoxyFullField.name` 为空；
7. 同一个 Entity 中物理列名重复；
8. 同一个字段出现多个 `@FoxyFullField`；
9. 字段没有对应的命名构造参数；
10. 对应参数不是 `this.fieldName` 形式的 initializing formal；
11. 构造参数类型与字段类型不一致；
12. 构造参数是第一版不支持的 required 参数；
13. 非 nullable 构造参数没有显式默认值；
14. 构造参数默认值与字段类型不兼容；
15. 字段类型不在第一版支持列表中；
16. Entity 已手写 `copyWith`、`toJson`、`operator ==`、`hashCode` 或
    `toString`，与生成成员冲突；
17. Entity 没有应用约定名称的 `_XXXEntityMixin`；
18. Entity 没有声明正确的 `part 'xxx_entity.g.dart'`；
19. Entity 没有保留约定签名的 `fromJson` factory；
20. key 字段不是持久化字段；
21. 没有任何 key 字段；
22. 同一种 class 或 field 注解重复出现；
23. 存在 `FoxyBriefField`，但 class 没有 `FoxyBriefEntity`；
24. 存在 `FoxyFilterField`，但 class 没有 `FoxyFilterEntity`；
25. 标准 Brief 没有包含全部 key 字段；
26. `FoxyFilterField.defaultValue` 与其 Filter 类型不兼容；
27. Brief、Filter 或 Key 需要无法从 Full Entity 元数据得到的字段；
28. Reader 或 Generator 尝试根据注解声明顺序决定行为；
29. 一个输入文件包含多个 `@FoxyFullEntity` class；
30. Entity class 名与输入文件名不符合约定。

诊断消息应包含修复方式，例如：

```text
GlyphPropertyEntity.id 的构造参数默认值类型不匹配：
字段类型为 int，但 this.id = '' 的默认值是 String。
```

生成器不能因为单个字段无法识别而只生成剩余字段。

## 13. 生成文件策略

生成的 `*.g.dart`：

- 带 `GENERATED CODE - DO NOT MODIFY BY HAND` 头；
- 不允许手工编辑；
- 与对应 Entity 源文件一起提交；
- FullEntityMixin、标准复合 Key 和标准 Brief 位于同一个 Entity `*.g.dart`；
- Filter 在迁移期继续使用独立 `*.filter.g.dart`；
- `.foxy_entity.g.part` 只存在于 build cache，不提交；
- 不提交或保留 `*.brief.g.dart`、`*.key.g.dart`；
- 重复执行生成器必须产生零 diff。

提交生成文件可以让代码审查直接看到物理字段映射变化，也避免全新 checkout
在未执行 build_runner 时因为缺少 part 而无法分析。

后续若引入 CI，应增加生成漂移检查：

```bash
dart run build_runner build --delete-conflicting-outputs
git diff --exit-code
```

### 13.1 源码 contract tests

仓库中部分 contract tests 使用 `File(...).readAsStringSync()` 检查具体源码文本。
方法移入 `*.g.dart` 后，只读取主文件会产生错误结论。

迁移规则：

1. 能改成行为测试的契约优先改成行为测试；
2. 必须检查源码形状时，提供统一 test helper，读取主 library 及其全部本地
   `part`；
3. 检查生成型 Full、Brief 或 Key 时从 Entity 主文件开始读取，不直接依赖
   Builder 的临时 extension；
4. 对 Brief 的禁止 API 断言必须截取 Brief class 自身，不能因为同 library 的
   Full Mixin 合法包含 `copyWith/toJson` 而误报；
5. 不把“一行 export 文件不包含某方法”当作真实架构契约；
6. 不在每个 contract test 中重复实现 part/export 解析。

Repository 源码 contract tests 在 Repository 仍为手写期间不受本阶段影响。

## 14. 测试方案

### 14.1 生成器单元测试

使用 `build_test` 验证输入源码与生成源码。

正常场景：

- `int`、`double`、`String`、`bool`；
- nullable 类型；
- 从构造参数读取零值、非零值、空字符串和非空默认值；
- nullable 参数省略默认值时规范化为 `null`；
- 通过 `static const` 间接声明的默认值；
- 单列和复合 key 元数据读取；
- 一个文件只包含一个 annotated Full Entity；
- 大型 Entity；
- 字段顺序；
- 全部生成方法。

异常场景：

- 缺少字段注解；
- 重复物理列名；
- 构造参数默认值类型错误；
- non-nullable 参数没有默认值；
- required 构造参数；
- 对应参数不是 initializing formal；
- 非 final 字段；
- 缺少命名构造参数；
- 不支持的类型；
- 手写方法与生成方法冲突；
- 一个文件包含多个 annotated Full Entity；
- class 名与文件名不匹配。

### 14.2 Companion Generator 测试

Key：

- 标量 key 不产生 Key 类；
- 复合 key 的字段、顺序、相等和 hash；
- `fromEntity` 使用完整身份；
- 缺少 key 和特殊 key 退出路径。

Brief：

- 只包含被标记字段；
- 必须包含完整身份；
- 标量和复合 `key` getter；
- 不生成 `copyWith/toJson`；
- join、locale 和计算字段拒绝自动生成。

Filter：

- Full 字段类型与 Filter 字段类型可以不同；
- Filter 默认值类型校验；
- 生成 `fromJson/copyWith/toJson`；
- 不生成 SQL comparator 或 Repository 查询代码。

Builder：

- Entity Builder 的一个输出同时包含 Full、复合 Key 和 Brief；
- 标量 Key 不产生额外类型；
- Entity Builder 不产生 import、`*.brief.g.dart` 或 `*.key.g.dart`；
- 迁移期 Filter Builder 与 Entity Builder 的 output extension 不冲突；
- 调整注解排列顺序产生零代码 diff。

### 14.3 生成结果行为测试

每个试点 Entity 至少验证：

```dart
test('fromJson/toJson 保留完整物理字段', () {
  final entity = Entity.fromJson(row);
  expect(entity.toJson(), row);
});

test('copyWith 保留未修改字段', () {
  final changed = entity.copyWith(field: newValue);
  expect(changed.otherField, entity.otherField);
});

test('值相等与 hashCode 一致', () {
  final left = Entity.fromJson(row);
  final right = Entity.fromJson(row);
  expect(left, right);
  expect(left.hashCode, right.hashCode);
});

test('toString 包含类名和全部字段', () {
  expect(entity.toString(), contains('Entity('));
});
```

DBC Entity 继续运行现有：

- DBC 字段覆盖测试；
- `fromJson/toJson` round-trip；
- export field 顺序和取值测试。

### 14.4 项目验证

每次试点迁移后执行：

```bash
dart format <changed handwritten dart files>
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test <closest focused tests>
flutter test
```

只格式化手写变更和生成器源码，不对整个仓库做无关格式化。

## 15. 落地与迁移顺序

### 15.1 Entity library 合并

1. 将 Full、Brief、Key Generator 合并成一个 `FoxyEntityGenerator`；
2. 使用一个 `SharedPartBuilder` 输出 `.foxy_entity.g.part`；
3. 重新生成全部 `xxx_entity.g.dart`；
4. 将生成型 Brief/Key 的调用方 import 改为所属 `xxx_entity.dart`；
5. 删除 `*.brief.g.dart`、`*.key.g.dart` 以及只做 export 的兼容壳；
6. 保留真正手写的 Brief 和特殊 Key；
7. 更新源码 contract helper，使其沿 `part` 读取完整 library；
8. 运行生成器测试、全局 Entity 契约、`flutter analyze` 和完整测试。

### 15.2 Repository Filter 迁移

Repository Filter 后续按模块迁移：

1. 增加 Repository annotation library 和 `FoxyRepositoryFilterGenerator`；
2. 为目标 Repository 添加 `part 'xxx_repository.g.dart'`；
3. 在 Repository class 注解中声明 Filter 类型和字段；
4. 生成 Filter DTO，但保留手写 `_applyFilter()`；
5. ViewModel 改为只 import Repository；
6. 删除该模块旧的 Entity Filter 注解、生成文件和转发壳；
7. 共享 Filter 迁到独立查询模型，不绑定某个 Repository；
8. 每个模块迁移后验证 count/list 使用同一 Filter 语义。

迁移必须逐模块完成，不能在同一个 library 中同时存在新旧同名 Filter。

## 16. 后续扩展边界

以下能力按实际需求再设计：

- 自定义字段 converter；
- nullable `copyWith` sentinel；
- 集合深度相等；
- Repository Filter comparator；
- 根据 `table` 和 `key` 生成标准 Repository 基础代码。

Entity 能力必须建立在同一个 `EntityGenerationModel` 上。Repository Filter
可以拥有独立查询模型，但不得复制 Entity 的物理列名、构造默认值或主键定义。

## 17. 验收标准

Entity 代码生成必须满足：

1. 生成 Mixin 只使用下划线前缀，不使用 `$`；
2. Mixin 静态方法名为 `fromJson`；
3. 生成 `fromJson/copyWith/toJson/==/hashCode/toString`；
4. 标量 key 不生成类型，复合 key 生成完整不可变 Key；
5. 标准 Brief 包含完整身份且不暴露 `copyWith/toJson`；
6. Full、Brief 和复合 Key 位于同一个 `xxx_entity.g.dart`；
7. Entity Generator 一次读取同一个 Full Entity 源文件；
8. 每个输入文件只允许一个 `@FoxyFullEntity`；
9. 物理列名精确且区分大小写；
10. 未命名构造函数参数默认值决定 Full 和 Brief 的反序列化回退值；
11. 默认值与字段类型的兼容性在构建期校验；
12. `FoxyFullField` 不再声明 `defaultValue`，只描述物理列名和 key；
13. DBC 字段顺序不变；
14. 缺失行、Repository 身份和持久化契约不受影响；
15. 试点 Entity 的现有行为测试全部通过；
16. `flutter analyze` 通过；
17. 重复生成零 diff；
18. 调整注解顺序产生零代码 diff；
19. 生成文件不需要也不允许人工修改；
20. 业务代码不 import `.g.dart`；
21. 生成型 Brief/Key 不保留独立转发壳；
22. Repository Filter 不进入 Entity 的 `.g.dart`。
