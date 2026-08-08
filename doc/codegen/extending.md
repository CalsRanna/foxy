# 扩展生成器:修改与新增

本文面向**维护生成器本身的开发者**。改生成器 = 改「生成代码的契约」,影响面是所有已生成/将生成的模块,所以每一步都有对应的验证手段。

## 1. 修改现有生成器的标准流程

以「给 List ViewModel 增加一个功能」为例:

1. **只改一处模型**:在 `list_model.dart` 的 `ListGenerationModel` 加字段(如 `bool enableXxx`),Reader 负责填,Emitter 负责用。模型是所有层共享的契约。
2. **Reader 读注解 / 源码**:在 `list_reader.dart` 里从注解或源码文本提取新信息,填进模型。
3. **Emitter 产出代码**:在 `list_emitter.dart` 用 `StringBuffer` 拼新方法/字段,保持「Sort Members」成员顺序。
4. **校验**:如果新能力有前提条件,在 Reader 里 `_fail`(带修复文案);模型级不变量放 `EntityValidator`(目前只有 Entity 层有独立 validator)。
5. **回归**:跑 `dart run build_runner build --delete-conflicting-outputs` 全量重生成,再 `flutter test`。

### 需要同步维护的地方

| 改了 | 必须同步 |
| --- | --- |
| 注解类(字段/签名) | 所有使用该注解的手写文件(生成器会以校验/报错方式提示) |
| 生成代码形状(方法名/签名) | 手写端 `@override` 生成方法的类(如覆写 `countXxxs`)——签名不匹配由编译器报错 |
| 生成代码引用的基础设施 | `FieldControllerMixin` / `QueryVersionMixin` / `RepositoryMixin` 等基座 |
| 生成代码抛的异常 | `FoxyException` 家族 + `foxyErrorMessage` 映射 |
| 生成代码用的常量 | `kPageSize` 等 |

## 2. 新增一个生成器

以「新增 `@FoxyCalendarViewModel`」为例,四步:

### a. 注解类(如 `form_annotations.dart` 或新建文件)

```dart
@Target({TargetKind.classType})
class FoxyCalendarViewModel {
  final Type entity;
  final Type repository;
  const FoxyCalendarViewModel({required this.entity, required this.repository});
}
```

### b. 四层文件(`src/calendar_*.dart`)

```dart
// calendar_model.dart
final class CalendarGenerationModel {
  final String className;   // ...
  const CalendarGenerationModel({...});
}

// calendar_reader.dart
final class CalendarReader {
  const CalendarReader();
  Future<CalendarGenerationModel> read(
    Element element, ConstantReader annotation, BuildStep buildStep) async {
    // 1. 结构校验(类名/文件位置/part/mixin 顺序)  —— 可复制 ListReader 的模式
    // 2. 读注解(entity/repository)               —— 用 TypeChecker + ConstantReader
    // 3. 复用 FormReader 拿 controller 样板       —— 若字段类型推断同构
    // 4. 填模型
  }
}

// calendar_emitter.dart
final class CalendarEmitter {
  const CalendarEmitter();
  String emit(CalendarGenerationModel model) {
    // StringBuffer 拼 mixin;成员按「Sort Members」
  }
}

// calendar_generator.dart
final class FoxyCalendarViewModelGenerator
    extends GeneratorForAnnotation<FoxyCalendarViewModel> {
  final CalendarReader reader;
  final CalendarEmitter emitter;
  const FoxyCalendarViewModelGenerator({
    this.reader = const CalendarReader(),
    this.emitter = const CalendarEmitter(),
  }) : super(inPackage: 'foxy_annotation');
  @override
  TypeChecker get typeChecker => const TypeChecker.fromUrl(
    'package:foxy_annotation/form_annotations.dart#'
    'FoxyCalendarViewModel',
  );
  @override
  Future<String> generateForAnnotatedElement(
    Element element, ConstantReader annotation, BuildStep buildStep) async {
    final model = await reader.read(element, annotation, buildStep);
    return emitter.emit(model);
  }
}
```

### c. 注册进 Builder(`builder.dart` + `build.yaml`)

```dart
Builder foxyViewModelBuilder(BuilderOptions options) {
  return SharedPartBuilder(
    [
      const FoxyCalendarViewModelGenerator(),  // 按类名排序插入
      const FoxyLinkedDetailViewModelGenerator(),
      // ...
    ],
    'foxy_view_model',
    writeDescriptions: false,
  );
}
```

`build.yaml` 不用改(复用 `foxy_view_model` 的 `generate_for` 范围);若新生成器输出不同后缀或不同输入范围,才需新增 Builder 条目。

### d. 测试与契约测试

- 至少一个手写样例文件 + 断言生成代码形状的测试(参考 `test/` 下现有生成器测试);
- 注解声明 ↔ 生成代码的一致性由 `packages/foxy_generator/test/` 的生成器单测承担,新增生成器时把新声明纳入。

## 3. 复用模式(重要)

现有代码里最值得复用的两处:

- **`FormReader` 是 controller 样板的事实来源**:Linked List / Linked Detail 都 `const FormReader().read(...)` 再叠加自己的语义。新增「字段表单类」生成器时,应复用 FormReader 而不是复制粘贴。
- **`readFilterField` 是 Filter 字段的事实来源**:Filter 生成器与 Repository 生成器共用同一个函数,保证字段定义一致。新增消费 Filter 的生成器(List 已经这么做了)时,应从 `@FoxyFilter` 注解读,而不是自己解析。

新增生成器的三条纪律:

1. 输出必须是**同一个 part**(追加到现有 `SharedPartBuilder` 的生成器列表),并遵守「Sort Members」排序;
2. 生成代码依赖的手写基座(mixin/异常/工具)必须已存在或同步补齐;
3. 生成器之间**不直接 import 对方**,只通过注解 + 命名约定握手(见 README 设计原则 5)。

## 4. 调试技巧

### 生成代码在哪、怎么看

- `build_to: cache`,产物缓存在 `.dart_tool/build/generated/foxy/lib/...`;生成内容合并进 `.dart_tool/build/.../<part>.g.dart`(combining builder 汇总)。
- 直接读手写文件旁的 `*.g.dart`(已落盘,如 `repository/currency_type_repository.g.dart`)——这是最终编译进手写类的代码。
- `--delete-conflicting-outputs` 先清后建,排查「改了注解但生成没变」时先用它。

### 常见「生成没生效」排查

| 现象 | 原因与对策 |
| --- | --- |
| 改了注解,`flutter analyze` 不报 | 没重跑 `dart run build_runner build` |
| 改了生成器代码,产物不变 | `build_runner` 缓存;`dart run build_runner build --delete-conflicting-outputs` |
| 生成文件报「找不到符号」 | 手写端缺少对应 `part` / 没混入 mixin / 基座没 import(见 `field_controller.dart` 顶部注释的 import 作用域说明) |
| 生成文件与手写文件互相冲突 | `--delete-conflicting-outputs` 清掉陈旧产物再建 |

### 调试错误信息

所有 `_fail` 都抛 `InvalidGenerationSourceError(message, element, todo)`,`build_runner` 输出会把错误钉到出错元素并附修复文案。若想定位具体生成器的报错路径,在 reader 里临时加 `print` 或断点(生成器运行在 `build_runner` 进程里)。

## 5. 测试与回归

- 跑全部测试:`flutter test`(含游戏数据对照、生成代码行为、数据库集成测试,未配置环境自动跳过);
- 关键回归点:
  - `test/game_data/*_game_data_test.dart`(项目内游戏数据定义与 AzerothCore 3.3.5 的一致性);
  - `test/database_editing/*_database_editing_test.dart`(真实 MySQL 上的编辑行为,覆盖 store/update/destroy 的异常翻译);
  - `packages/foxy_generator/test/`(生成器单测,注解声明 ↔ 生成代码一致性);
  - 直接调用生成方法的手写覆写(`@override`)是否仍编译。
- 生成器自身没有独立单元测试,验证方式 = 全量重生成 + 全量测试。

## 6. 已知边界与历史取舍

以下取舍是刻意的,扩展前先确认你是否要打破:

1. **生成代码不 import 依赖自身**:part 文件是 `part of 父库`,生成代码里的 `FoxyException` / `foxyErrorMessage` / `RecordNotFoundException` 靠父文件(混入 `FieldControllerMixin` 的类)的 import 作用域解析(见 `field_controller.dart` 顶部注释)。新增生成代码引用的符号时,确保它在父文件 import 链上,或在基座里 `export`。
2. **`selects` / `flags` / `groups` / `nullable` / `exclude` 互斥**:一个字段只能属于一个例外集合(FormReader 校验)。这是刻意约束,防止同一个字段被两种控制器语义解释。
3. **`@FoxyLinkedListViewModel` 只支持单关联键**:复合关联键(如 `player_create_info` 按 `(race, class)`)保持手写。扩展成支持复合键需要动 Reader(linkKey 读取)+ Emitter(`_linkParams` / `_linkWheres`)+ 命名约定,收益是消掉一批手写文件,代价是生成复杂度上升——按需取舍。
4. **`@FoxyListViewModel` 只支持 `@FoxyFilter.text`**:筛选类型目前只有文本;扩展为支持 integer/decimal/boolean 需要同步改 `ListReader._readFilterFields`(目前显式拒绝非 text)与 `ListEmitter`(controller 类型推断),以及 `_applyFilter` 的「与默认值不等才生效」语义。
5. **Repository 不得手写 `_table`**:表名单一来源在 Entity 注解,生成 part 产出 `const _table`;手写类再声明同名成员会被构建期拒绝(`Remove static const _table`)。表名只从 `@FoxyFullEntity.table`(或类名推导)来。
6. **Entity 的 `fromJson` factory 必须是指定委托形式**:由 AST 校验,`=> _XxxEntityMixin.fromJson(json)` 或等价块体 `{ return _XxxEntityMixin.fromJson(json); }` 之外的形式(如加中间转换)会报错。
7. **结构校验基于语法级 AST**(`source_shape.dart` 的 `parseString` 助手):mixin 混入与顺序、part 声明、成员声明、factory 委托都是 AST 检查,对格式不敏感(跨行、引号、块体均可),与 `.g.dart` 是否已生成无关。跨文件「注解存在性」探测(如 List ViewModel 是否存在)仍是文本检查。

## 7. 扩展路线图(按收益排序)

| 扩展 | 收益 | 成本 |
| --- | --- | --- |
| 支持 `@FoxyFilter.integer` 等非 text 筛选 | 更多列表页筛选项 | 改 ListReader + ListEmitter + 命名约定 |
| 支持复合 linkKey 的 Linked List | 消掉 player_create_info 系列手写 | Reader/Emitter/命名约定 三处联动 |
| 生成器自身加单元测试 | 回归保障 | 中(需要 build_test 设施) |
| 生成代码文档化输出(如 JSON schema) | 非 Dart 消费方 | 低(新 emitter) |
