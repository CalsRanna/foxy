# Foxy 代码生成系统

Foxy 用 **「注解声明 + 代码生成 + 显式覆写」** 支撑 130 张数据库表的 CRUD 层:手写层只声明「是什么」(注解),机械样板由生成器产出(Entity 值语义、Repository 查询层、ViewModel 表单控制器与行为骨架),生成默认覆盖不了的场景在业务类里显式 `@override`。

本文档面向**想理解、扩展或维护生成器本身**的开发者,而不是使用生成器的业务开发者。业务侧使用方式见 [使用指南](usage.md)。

## 文档目录

| 文档 | 内容 |
| --- | --- |
| [README.md](README.md) | 本文:整体架构、设计原则、数据流、流水线 |
| [usage.md](usage.md) | 业务侧使用指南:注解速查、5 种形态、覆写模式、常见问题 |
| [generators.md](generators.md) | 每个生成器的 reader/model/emitter 逐层详解、关键校验、生成产物 |
| [extending.md](extending.md) | 扩展指南:如何改现有生成器、如何新增生成器、调试技巧、测试 |

## 一句话总结

```
手写注解 ──reader──▶ 模型 ──emitter──▶ 生成源码 ──part──▶ 编译进手写类
```

## 目录布局

```
lib/infrastructure/codegen/
├── entity_annotations.dart      # Entity 层注解(@FoxyBriefEntity / @FoxyFullEntity / ...)
├── form_annotations.dart        # Form 层注解(@FoxyDetailViewModel / @FoxyLinkedListViewModel / ...)
├── list_annotations.dart        # 列表层注解(@FoxyListViewModel)
├── repository_annotations.dart  # 仓库层注解(@FoxyRepository / @FoxyFilter)
├── builder.dart                 # build_runner Builder 入口(SharedPartBuilder)
└── src/
    ├── entity_reader.dart       # 读取注解 + 校验 → EntityGenerationModel
    ├── entity_model.dart        # Entity 生成模型
    ├── entity_validator.dart    # Entity 模型级校验
    ├── entity_emitter.dart      # Entity 生成器
    ├── repository_reader.dart   # 读取注解 + 校验 → RepositoryGenerationModel
    ├── repository_model.dart    # Repository 生成模型
    ├── repository_emitter.dart  # Repository 生成器
    ├── repository_filter_*.dart # Filter 类(reader/model/emitter/generator)
    ├── form_reader.dart         # 读取注解 + 校验 → FormGenerationModel
    ├── form_model.dart          # Form 生成模型
    ├── form_emitter.dart        # Form 生成器
    ├── list_*.dart              # List ViewModel(reader/model/emitter/generator)
    ├── linked_list_*.dart       # Linked List ViewModel(reader/model/emitter/generator)
    ├── linked_detail_*.dart     # Linked Detail ViewModel(reader/model/emitter/generator)
    ├── *_generator.dart         # source_gen Generator 子类(注解 → 生成)
    ├── naming.dart              # toSnakeCase / pluralize 命名工具
    └── dart_literal.dart        # 常量 → Dart 字面量工具
```

## 核心架构

### 三组 Builder,一条流水线

`builder.dart` 用 `SharedPartBuilder` 注册 3 组 Builder,每组对应一个生成「part」文件(`.g.dart`),由 `build.yaml` 限定输入范围:

| Builder | 生成器(按名排序) | 输入范围 | 输出 |
| --- | --- | --- | --- |
| `foxy_entity` | `FoxyEntityGenerator` | `lib/entity/**_entity.dart` | `*.g.dart`(Brief/Key/Full mixin) |
| `foxy_repository` | `FoxyFilterGenerator`, `FoxyRepositoryGenerator` | `lib/repository/**_repository.dart` | `*.g.dart`(Filter 类 + Repository mixin) |
| `foxy_view_model` | `FoxyLinkedDetailViewModelGenerator`, `FoxyLinkedListViewModelGenerator`, `FoxyListViewModelGenerator`, `FoxyViewModelGenerator` | `lib/view_model/**_view_model.dart` | `*.g.dart`(ViewModel mixin) |

要点:

- **生成器按类名排序**写入同一个 part,以满足 Dart 顶层成员按名称排序的格式约定(`FoxyLinkedDetail...` < `FoxyLinkedList...` < `FoxyList...` < `FoxyViewModel`)。
- **Repository 生成器拆两个**:`FoxyFilterGenerator` 生成公开 `Filter` 类(顶层,在前),`FoxyRepositoryGenerator` 生成私有 mixin(在后)——同样是「Sort Members」约定。
- 所有生成器 `writeDescriptions: false`,不给生成文件加 banner。

### 注解 → 生成器 → part 的完整数据流

以 `CurrencyTypeRepository` 为例:

```
手写 repository/currency_type_repository.dart:
  @FoxyRepository(CurrencyTypeEntity)
  @FoxyFilter.text('id')
  class CurrencyTypeRepository with RepositoryMixin, _CurrencyTypeRepositoryMixin {...}
                │
                │  FoxyRepositoryGenerator.generateForAnnotatedElement()
                ▼
        RepositoryReader.read() ──▶ RepositoryGenerationModel
                │
                ▼
        RepositoryEmitter.emit() ──▶ "mixin _CurrencyTypeRepositoryMixin on RepositoryMixin {...}"
                │
                ▼
        repository/currency_type_repository.g.dart (part of 父库)
                │
                ▼
        编译进手写类（with 列表里的 mixin）
```

生成产物见 [generators.md](generators.md)。

### 为什么用「mixin」而不是「extends」

生成的代码都是 `mixin _XxxMixin on ...`,手写类通过 `with` 混入。原因:

- 手写类可声明 `static const _table`、可 `@override` 生成方法(如 `CurrencyTypeRepository` 覆写 `countCurrencyTypes`),mixin 的覆写语义是天然的「显式覆盖」钩子;
- 一个 part 文件只含一个 mixin + 一个公开类(Filter),`on` 子句(`on RepositoryMixin`)保证生成代码能调用基座成员;
- Entity 的 `Full mixin` 同理,手写 `class XxxEntity with _XxxEntityMixin` 通过 mixin 拿到 `fromJson`/`copyWith`/`==`/`hashCode`/`toString`。

## 设计原则

1. **单一事实来源(Single Source of Truth)**
   - 物理列名只在 `@FoxyFullField('列名')` 声明一次;Repository/Filter/List 的列名要么从 Entity 推断,要么显式声明,绝不重复手写;
   - 筛选字段只在 Repository 的 `@FoxyFilter` 声明;List ViewModel 的筛选控制器由生成器从 `@FoxyFilter` 读取(不在 List 注解里重复);
   - Entity 的 key 字段是唯一 key 来源,Repository/Form/List 都从它推断 key 类型与名字。

2. **约定优于配置(Convention over Configuration)**
   - 命名约定:类名 ↔ 文件名(snake_case)、`XxxEntity` ↔ `XxxRepository` ↔ `XxxFilter` ↔ `BriefXxxEntity`、方法名 `getBriefXxxs`/`countXxxs`/`copyXxx`/`destroyXxx`;
   - 位置约定:每个生成文件必须位于 `lib/<层>/<snake_case>.dart`,生成器会校验;
   - 结构约定:每个手写类必须混入生成的私有 mixin、声明 `part 'xxx.g.dart'`、Entity 还要有约定签名的 `factory fromJson` 委托。

3. **失败要早、信息要准**
   - 校验分两层:`Reader` 里做「结构校验」(注解用法、命名、文件位置、mixin 是否混入),`EntityValidator` 做「模型校验」(表名非空、列名唯一、Brief 覆盖 key 等);
   - 所有 `_fail` 都抛 `InvalidGenerationSourceError`,带 `message + todo`(修复方式),`flutter analyze` / `build_runner` 会把错误钉到出错元素;
   - 生成代码的「运行时不变式」也尽量前移:例如 store 前校验主键 > 0、update 未命中 0 行抛 `RecordNotFoundException`,把数据库静默失败变成显式业务异常。

4. **生成代码贴近手写风格**
   - 成员顺序遵循 Dart「Sort Members」规则(字段按序 → 构造 → hashCode → == → toString 等),生成文件与手写文件混排不违和;
   - 表名/列名统一写成 `'`反引号列名`'`,避免 MySQL 保留字(`index`、`rank`)逐个登记;
   - `dart_literal.dart` 统一处理常量 → 字面量(含 double 补 `.0`、字符串转义 `$`)。

5. **生成器之间无直接依赖,通过命名约定握手**
   - Repository 生成器不 import Entity 生成器:它只依赖 Entity 的**注解与模型**(`@FoxyFullField` 的列名、key 标记),以及手写 Repository 源码文本里的 `_table` / `DbcLocaleRepositoryMixin` 出现与否;
   - List/Form 生成器也不 import Repository 生成器:它们直接读 Repository 的 `@FoxyFilter` / Entity 的 `@FoxyFullField`,靠命名约定(方法名、Filter 类名)与 Repository 生成器握手;
   - 所以**新增一个生成器时,只要遵守同样的「读注解 + 命名约定」约定,就能独立加入**,见 [extending.md](extending.md)。

## 关键约定与基础设施

生成代码依赖的手写基础设施:

- `RepositoryMixin`(`lib/repository/repository_mixin.dart`):提供 `laconic` 访问、`localeEnabled`、`kPageSize`、`nextMaxPlusOne`、`prepareWriteJson` 等;
- `FieldControllerMixin`(`lib/widget/form/field_controller.dart`):提供 `registerController` / `disposeControllers`,生成代码在 `on FieldControllerMixin` 下可直接声明 controller;
- `QueryVersionMixin`(`lib/widget/query_version_mixin.dart`):List ViewModel 的分页浏览基线(`queryVersion` / `markQueryVersion` / `normalizePageAfterDelete`);
- `DbcLocaleRepositoryMixin`(`lib/repository/dbc_locale_repository_mixin.dart`):DBC 宽表本地化字段的加载/保存,Repository 生成器检测到它出现时生成 `get*Locales` / `save*Locales` 委托;
- `FoxyException` 家族(`lib/infrastructure/errors/foxy_exceptions.dart`):生成代码抛的业务异常(`RecordNotFoundException` / `DuplicateKeyException` / `InvalidPrimaryKeyException` / `BusyException` / `LinkNotLoadedException` / `IdExhaustedException`);
- `MysqlErrorUtil.isDuplicateEntry`(`lib/infrastructure/database/mysql_error_util.dart`):把 MySQL duplicate entry 翻译成 `DuplicateKeyException`。

## 跑起来

```bash
# 重新生成全部 .g.dart(新增/修改注解后)
dart run build_runner build --delete-conflicting-outputs

# 生成后校验(可选,能查出部分手写端与生成端不一致)
dart run build_runner build --delete-conflicting-outputs && flutter analyze
```

生成的文件都带 `// GENERATED CODE - DO NOT MODIFY BY HAND`,不要手改。
