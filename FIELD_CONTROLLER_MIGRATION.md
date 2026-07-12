# Foxy 输入组件与 FieldController 迁移指南

> 本文是全项目输入架构迁移的约束文档。后续修改 ViewModel、表单页面或通用输入组件时，应先阅读本文，并以本文描述的“最终目标架构”为准。过渡 API 只用于分阶段迁移，不代表允许长期保留两套设计。

## 1. 迁移目标

项目中的表单字段不再由 Page 直接传递 Flutter/ShadCN 的原始 Controller：

- 禁止 Page 直接依赖 `TextEditingController`。
- 禁止 Page 直接依赖 `ShadSelectController<T>`。
- Page 只把 Foxy 的类型化 `XXXFieldController` 传给输入组件。
- ViewModel 负责 FieldController 的创建、初始化、收集和释放。
- Widget 只借用 FieldController，不得释放它。
- 字段类型、格式化规则和解析规则只在 Controller 类型中声明一次。

最终数据流：

```text
Entity
  ⇅ init / collect
XXXFieldController
  ⇅ 内部持有原始 Controller
Foxy 输入组件
  ⇅
ShadInput / ShadSelect
```

Page 不应越过 `XXXFieldController` 直接访问内部原始 Controller。

## 2. 设计边界

### 2.1 FieldController 负责什么

`lib/util/field_controller.dart` 中的 Controller 只负责：

- 持有底层 `TextEditingController` 或 `ShadSelectController<T>`；
- 使用实体值初始化控件；
- 从控件收集强类型值；
- 字符串与字段类型之间的格式化和解析；
- 释放底层 Controller。

### 2.2 FieldController 不负责什么

以下信息属于 Widget/Page 展示层，禁止加入 FieldController：

- `label`；
- `placeholder`；
- `errorLabel`；
- `readOnly` / `enabled`；
- 宽度、高度和布局；
- 下拉选项、Picker Delegate；
- 颜色、图标或其他视觉配置。

解析错误可以描述“不是有效整数/数字”，但 FieldController 不保存用于 UI 展示的字段名称。如果以后需要更丰富的错误展示，应设计独立的校验/错误模型，不得把展示元数据重新塞回 Controller。

### 2.3 生命周期所有权

FieldController 由 ViewModel 通过 `FieldControllerMixin.registerController` 创建并自动注册，由 `disposeControllers()` 统一释放：

```dart
class MyViewModel with FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final rankController = registerController(SelectFieldController<int>(fallback: 0));

  void dispose() => disposeControllers();
}
```

特殊生命周期（动态增删 Controller）不适用 mixin，需自行管理 dispose。
输入 Widget 不得在自身 `dispose()` 中释放传入的 FieldController。

## 3. Controller 类型体系

| 字段语义 | Controller | 底层 Controller | 说明 |
|---|---|---|---|
| 字符串 | `StringFieldController` | `TextEditingController` | 原样读写字符串 |
| 整数 | `IntFieldController` | `TextEditingController` | 空串为 `0`，非法值抛 `FormatException` |
| 浮点数 | `DoubleFieldController` | `TextEditingController` | 空串为 `0.0`，非法值抛 `FormatException` |
| 位标记 | `FlagFieldController` | `TextEditingController` | 负责十进制与十六进制组合文本的格式化/解析 |
| 下拉选择 | `SelectFieldController<T>` | `ShadSelectController<T>` | 未选择时返回显式 `fallback` |

数值 Controller 额外继承：

```dart
NumberFieldController<T extends num>
```

`FoxyNumberInput<T>` 必须接收 `NumberFieldController<T>`，不能接收宽泛的 `TextBackedFieldController<T>`。原因是 `FlagFieldController` 同样以 `int` 为底层值，但它不能作为普通整数输入框使用。

### 命名规则

Controller 类统一使用 `XXXFieldController`：

```dart
IntFieldController
DoubleFieldController
StringFieldController
FlagFieldController
SelectFieldController<T>
```

实例变量统一以 `Controller` 结尾：

```dart
final entryController = IntFieldController();
final nameController = StringFieldController();
final rankController = SelectFieldController<int>(fallback: 0);
```

禁止：

```dart
final entryField = IntFieldController();       // 实例名错误
final nameFieldController = StringFieldController(); // 冗余命名
final nameController = TextFieldController();  // 不存在此 Foxy 类型
```

字符串类型必须使用 `StringFieldController`，避免与 Flutter 的 `TextField` / `TextEditingController` 混淆。

## 4. 输入组件最终契约

最终状态下，各输入组件只接受下列类型：

| 输入组件 | Controller 参数类型 |
|---|---|
| `FoxyStringInput` | `StringFieldController` |
| `FoxyNumberInput<T>` | `NumberFieldController<T>` |
| `FoxyShadSelect<T>` | `SelectFieldController<T>` |
| `FoxyFlagPicker` | `FlagFieldController` |
| `FoxyEntityPicker<T>` | `IntFieldController` |
| `FoxyLocalePicker` 的主输入框 | `StringFieldController` |

输入组件内部可以通过 `controller.controller` 访问底层 Flutter/Shad 的原始 Controller，但 Page 不可以。

统一调用形式：

```dart
FoxyNumberInput<int>(
  controller: viewModel.minLevelController,
  placeholder: 'minlevel',
)
```

```dart
FoxyShadSelect<int>(
  controller: viewModel.rankController,
  options: kRankOptions,
  placeholder: const Text('rank'),
)
```

参数名一律为 `controller`，类型为对应的 `XXXFieldController`。禁止再提供原始 `TextEditingController` / `ShadSelectController` 入口。

## 5. FoxyFormItem 的职责

`FoxyFormItem` 只负责：

- 左侧标签；
- 输入组件的横向布局；
- 为输入组件提供 `Expanded`。

它不得隐式创建 `ShadInput`，也不负责 `placeholder`、`readOnly` 或输入值。只保留 `label` 与必填 `child`。

正确写法：

```dart
FoxyFormItem(
  label: '名称',
  child: FoxyStringInput(
    controller: viewModel.nameController,
    placeholder: 'name',
  ),
)
```

```dart
FoxyFormItem(
  label: '最低等级',
  child: FoxyNumberInput<int>(
    controller: viewModel.minLevelController,
    placeholder: 'minlevel',
  ),
)
```

禁止：

```dart
// 不存在 legacy 构造；不得隐式创建输入框
FoxyFormItem(label: '名称', controller: someTextController);
```

## 6. ViewModel 标准模式

### 6.1 声明

```dart
class MyViewModel with FieldControllerMixin {
  late final entryController = registerController(IntFieldController());
  late final nameController = registerController(StringFieldController());
  late final speedController = registerController(DoubleFieldController());
  late final flagsController = registerController(FlagFieldController());
  late final rankController = registerController(SelectFieldController<int>(fallback: 0));
}
```

声明即注册——无需再维护手工 `_controllers` 列表。
不要在 ViewModel 中为表单字段继续新增裸 `TextEditingController` 或 `ShadSelectController`。

### 6.2 初始化

迁移前：

```dart
entryController.text = formatNum(entity.entry);
rankController.value = {entity.rank};
```

迁移后：

```dart
entryController.init(entity.entry);
rankController.init(entity.rank);
```

### 6.3 收集

迁移前：

```dart
entry: parseIntField(entryController.text),
speed: parseDoubleField(speedController.text),
flags: FlagFieldController.parseFlagValue(flagsController.text),
rank: rankController.value.firstOrNull ?? 0,
```

迁移后：

```dart
entry: entryController.collect(),
speed: speedController.collect(),
flags: flagsController.collect(),
rank: rankController.collect(),
```

### 6.4 保存后回填

迁移前：

```dart
entryController.text = '$id';
```

迁移后：

```dart
entryController.init(id);
```

### 6.5 释放

由 `FieldControllerMixin.disposeControllers()` 统一释放，无需手工列表：

```dart
void dispose() => disposeControllers();
```

动态 Controller（如惰性 Map、运行时增删）因生命周期不归 mixin 管，需自行 dispose。

## 7. Page 标准模式

### 字符串

```dart
FoxyFormItem(
  label: '脚本',
  child: FoxyStringInput(
    controller: viewModel.scriptNameController,
    placeholder: 'ScriptName',
  ),
)
```

### 整数/浮点数

```dart
FoxyNumberInput<int>(
  controller: viewModel.entryController,
  readOnly: true,
)

FoxyNumberInput<double>(
  controller: viewModel.speedController,
)
```

### 下拉选择

```dart
FoxyShadSelect<int>(
  controller: viewModel.rankController,
  options: kRankOptions,
  placeholder: const Text('rank'),
)
```

### 位标记

```dart
FoxyFlagPicker(
  controller: viewModel.flagsController,
  flags: kFlagOptions,
  title: '标记',
)
```

### Entity Picker

```dart
FoxyEntityPicker(
  controller: viewModel.lootIdController,
  delegate: FoxyEntityPickerDelegates.creatureTemplate,
)
```

### Locale Picker

```dart
FoxyLocalePicker(
  entry: entry,
  controller: viewModel.nameController,
  delegate: FoxyLocalePickerDelegates.creatureTemplateName,
  title: '名称',
)
```

Page 中禁止出现：

```dart
// 禁止访问 FieldController 内部原始 Controller
controller: viewModel.nameController.controller
```

## 8. 单模块迁移步骤

每次只迁移一个业务模块，完成验证后再进入下一个模块。

1. 盘点模块 ViewModel 中所有裸 `TextEditingController` 和 `ShadSelectController`。
2. 根据字段真实语义选择 `String`、`Int`、`Double`、`Flag` 或 `Select` Controller。
3. 将实例变量统一重命名为 `xxxController`。
4. 建立 `_controllers` 列表并覆盖模块内全部 FieldController。
5. 将实体回填改为 `.init(value)`。
6. 将保存/收集改为 `.collect()`。
7. 删除该 ViewModel 中仅为旧模式服务的 `_fmt`、`_pi`、`_pd`、`_getSelectValue` 等辅助方法；若仍有非表单用途则保留。
8. 将 Page 中的输入组件切换到类型化 `controller:` 入口。
9. 将隐式文本输入改为 `FoxyFormItem + FoxyStringInput`。
10. 确认 Page 不再出现对 FieldController 内部 `.controller` 的访问（Widget 实现内部除外）。
11. 格式化、运行静态分析和测试。

## 9. 当前规则（双入口已清理）

共享输入组件**只**接受类型化 `XXXFieldController`，参数名统一为 `controller`。

### 禁止事项

- 不得为表单字段使用裸 `TextEditingController` / `ShadSelectController`。
- 不得为了省事给 FieldController 增加 `label`、`placeholder` 或 `errorLabel`。
- 不得让 Widget 释放 ViewModel 持有的 FieldController。
- 不得让 `FoxyNumberInput` 接受 `TextBackedFieldController<num>` 或裸 `TextEditingController`。
- 不得让 Page 访问 `fieldController.controller` / `xxxController.controller`（仅输入 Widget 内部可用）。
- 不得恢复 `FoxyFormItem.legacy` 或 `controller`/`fieldController` 双入口。

## 10. 验收检查

### 单模块搜索

```bash
rg "TextEditingController|ShadSelectController" lib/page/<module>
rg "fieldController:" lib/page/<module>
rg "FoxyFormItem\.legacy" lib/page/<module>
```

注意：输入 Widget 内部访问 `controller.controller` 是允许的。Page/ViewModel 的表单字段必须是 FieldController。

### 项目验证

```bash
dart format lib test
flutter analyze
flutter test
```

每个模块迁移完成必须至少满足：

- 格式化无变化；
- `flutter analyze` 无错误；
- `flutter test` 全部通过；
- 没有新增过渡 API 调用；
- 所有 Controller 通过 `registerController` 声明，无遗漏；
- 新建、加载、编辑、保存和离开页面的生命周期均正确。

## 11. 当前进度

截至 2026-07-13，全项目迁移已完成。

- 92 个 ViewModel 切换为 `FieldControllerMixin` + `registerController` + `disposeControllers`。
- 全项目无手工 `_controllers` 列表、无裸 `TextEditingController` / `ShadSelectController`。
- 所有 `FoxyNumberInput` / `FoxyShadSelect` / `FoxyFlagPicker` / `FoxyEntityPicker` / `FoxyStringInput` / `FoxyLocalePicker` 仅接受类型化 `controller:` 参数。
- `FoxyFormItem.legacy` 已删除。
- `.controller.addListener` / `.controller.removeListener` 已归入 `FieldController` 转发 API，项目中无直接访问。
- `FoxyStringInput.obscureText` 已支持，`bootstrap_simulator_form.dart` 密码框逃逸已消除。
- 5 个 `List.generate` / 动态 `signal` 模式已收敛为逐字段 `registerController` 声明。

验收标准：`dart format`、`flutter analyze`、`flutter test` 全部通过。

## 12. 架构决策摘要

1. 使用 `XXXFieldController`，不使用 `XXXField`。
2. 实例名使用 `xxxController`，不使用 `xxxField`。
3. 使用 `StringFieldController`，不使用 `TextFieldController`。
4. `label`、`placeholder`、`errorLabel` 不进入 Controller。
5. `FoxyFormItem` 只做标签布局（`label` + `child`），不隐式创建输入框。
6. 每类输入组件只接受语义匹配的 FieldController，参数名统一为 `controller`。
7. ViewModel 通过 `FieldControllerMixin` 拥有并释放 Controller，Widget 只借用。
8. Page 不得访问 FieldController 内部原始 Controller。
9. 不得恢复双入口或 `FoxyFormItem.legacy`。
