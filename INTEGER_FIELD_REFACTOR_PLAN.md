# Condition / GameObject / SmartScript 整数字段重构方案

## 1. 结论

这次重构不新增 `FoxyIntSelect`，也不把 `FoxyIntEnumInput` 换成另一个包装组件。

最终方案是：

1. 保留并直接使用项目已有组件：
   - 枚举：`FoxyShadSelect<int>`
   - 普通整数：`FoxyNumberInput<int>`
   - 位标记：`FoxyFlagPicker`
   - 实体引用：`FoxyEntityPicker`
2. 在 ViewModel 层增加一个“同一物理整数列的 typed controller 组”，为动态字段同时提供：
   - `IntFieldController`
   - `SelectFieldController<int>`
   - `FlagFieldController`
3. 把目前通过 `reference/options/flags` 三个 nullable 属性表达的配置，改成 sealed 字段规格。数字、枚举、Flags、引用四种状态在类型层互斥。
4. `GameObject` 的 `Data0..Data23` 从巨大的 `(type, index)` 扁平 switch 改成按 GameObject 类型分组的 schema registry。
5. `Condition` 的两个有符号复合列拆成“编辑模式 + typed controller”，保存时再编码回 AzerothCore 的单个物理整数列。
6. 三个模块迁移完成后，处理 `SpellItemEnchantment` 中仅剩的两个调用场景，然后删除 `FoxyIntEnumInput` 和它专用的 `_IntEnumDialog`。

这个方案只重构表单表达和控制器绑定，不改变 Entity 的物理标量字段，不改变数据库列、Repository、路由或持久化身份规则。

## 2. 当前问题

### 2.1 `FoxyIntEnumInput` 同时承担了两个互相冲突的职责

当前 `FoxyIntEnumInput` 接受 `IntFieldController`，主体仍然是任意整数输入框，再通过尾部 list icon 打开独立 Dialog 选择枚举。

这导致：

- 严格枚举没有使用项目统一的 `FoxyShadSelect<int>`。
- 枚举交互与其他详情表单不一致。
- 组件为了兼容 Condition 的负数引用 ID，被所有普通枚举字段一起迁就。
- ViewModel 中字段的实际编辑语义仍然只有 `IntFieldController`，类型信息停留在 View 的临时判断中。

`FoxyIntEnumInput` 当前共有 9 个调用点：

- Condition：5 个
- GameObject：1 个动态分支
- SmartScript：1 个动态分支
- SpellItemEnchantment：2 个动态分支

### 2.2 三套动态字段配置结构重复且状态不安全

当前存在三套形状相近的配置：

- `ConditionValueFieldConfig`
- `GameObjectDataFieldConfig`
- `SmartParameterFieldConfig`

它们通过下列 nullable 字段组合推断控件类型：

```dart
reference != none
flags != null
options != null
否则为普通整数
```

这种结构允许出现本不应该存在的组合，例如一个字段同时带 `reference` 和 `options`。View 只能依赖 if 顺序决定优先级，编译器无法检查配置是否完整或冲突。

### 2.3 动态字段的控制器类型与实际组件不匹配

以下物理列会随判别字段变化而切换编辑语义：

- Condition：
  - `SourceGroup`
  - `SourceId`
  - `ConditionValue1..3`
- GameObject：
  - `Data0..Data23`
- SmartScript：
  - `event_param1..6`
  - `action_param1..6`
  - `target_param1..4`
- SpellItemEnchantment：
  - `EffectArg0..2`

目前它们全部声明为 `IntFieldController`。这正是 View 无法直接把它们传给 `FoxyShadSelect<int>` 的根因。

### 2.4 类型联动分散在 View

- Condition 使用 ViewModel Signal 驱动重建。
- GameObject 在 Stateful View 中监听 `typeController` 并 `setState`。
- SmartScript 在 Stateful View 中监听四个类型 Controller 并 `setState`。

同一种联动有两套生命周期管理方式。按照当前项目架构，判别字段和表单状态应由 DetailViewModel 管理，View 只负责渲染。

### 2.5 `gameObjectDataFieldConfig` 的结构不利于维护

当前函数把 36 种 GameObject 类型和 24 个 Data 槽位压平成一个很长的 `(type, index)` switch。

问题不在于 Data 字段多——AzerothCore 的 `GameObjectTemplate` 本来就是 typed union；问题在于代码没有保留“每个 GameObject 类型是一份独立 schema”的结构，导致：

- 同一个类型的字段定义不容易整体审阅。
- 新增或核对某种类型时，需要在超长 switch 中定位。
- 很难一眼确认某个类型有哪些可编辑槽位。
- 配置定义与 View 控件选择耦合在 nullable 属性约定上。

## 3. 重构边界

### 3.1 必须完成

- Condition、GameObject、SmartScript 的动态整数编辑器全部使用 typed controller。
- 所有严格枚举直接使用 `FoxyShadSelect<int>`。
- 删除三个模块中的 `_valueEditor/_dataEditor/_parameterEditor` nullable 优先级判断。
- GameObject Data 配置改为按类型分组。
- Condition 的负数引用不再依赖“可输入任意整数的枚举控件”。
- 清理 SpellItemEnchantment 的剩余调用后删除 `FoxyIntEnumInput`。
- ViewModel 负责类型 Signal、Controller 初始化、收集和释放。

### 3.2 明确不做

- 不修改 `ConditionEntity`、`GameObjectTemplateEntity`、`SmartScriptEntity` 的标量字段。
- 不把 Data/Param 字段聚合进 Entity 的 List 或 Map。
- 不修改 SQL/DBC 列名、类型值、Flags 值、引用含义或 Repository 边界。
- 不引入通用 CRUD ViewModel、通用表单 ViewModel 或新的 UI effect 框架。
- 不新增 `FoxyIntSelect`、`FoxyDynamicIntInput` 一类平行 UI 组件。
- 不把实体选择器塞进 `FoxyShadSelect`。
- 不在这次重构中顺便改动无关详情页。

## 4. 目标结构

### 4.1 sealed 整数字段规格

新增：

```text
lib/constant/integer_field_spec.dart
```

它不依赖 Flutter，只描述一个整数列当前应使用哪种既有编辑器。

建议 API：

```dart
enum IntegerFieldEditor {
  number,
  select,
  flags,
  reference,
}

sealed class IntegerFieldSpec<R> {
  final String label;
  final bool editable;

  const IntegerFieldSpec(this.label, {this.editable = true});

  IntegerFieldEditor get editor;
}

final class IntegerNumberFieldSpec<R> extends IntegerFieldSpec<R> {
  const IntegerNumberFieldSpec(super.label, {super.editable});

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.number;
}

final class IntegerSelectFieldSpec<R> extends IntegerFieldSpec<R> {
  final Map<int, String> options;

  const IntegerSelectFieldSpec(
    super.label, {
    required this.options,
    super.editable,
  });

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.select;
}

final class IntegerFlagsFieldSpec<R> extends IntegerFieldSpec<R> {
  final List<FlagItem> flags;

  const IntegerFlagsFieldSpec(
    super.label, {
    required this.flags,
  });

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.flags;
}

final class IntegerReferenceFieldSpec<R> extends IntegerFieldSpec<R> {
  final R reference;

  const IntegerReferenceFieldSpec(
    super.label, {
    required this.reference,
    super.editable,
  });

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.reference;
}
```

收益：

- 四种编辑状态互斥，不再靠 nullable 属性和 if 顺序推断。
- `options` 只会出现在 select 规格中。
- `flags` 只会出现在 flags 规格中。
- `reference` 只会出现在 reference 规格中。
- View 使用 exhaustive switch，新增规格时编译器会提示三个模块同步处理。
- `ConditionValueReference.none`、`GameObjectDataReference.none`、`SmartParameterReference.none` 可以删除；普通数字不再伪装成 “none reference”。

当前三套配置中的 Flags 字段全部可编辑，因此
`IntegerFlagsFieldSpec` 不开放 `editable: false`。如果未来确实出现只读 Flags，
应先为现有 `FoxyFlagPicker` 增加统一的禁用能力，再扩展规格，不能让配置声明出
Widget 无法兑现的状态。

“未使用”字段使用：

```dart
const IntegerNumberFieldSpec<SomeReference>('未使用', editable: false)
```

不再需要一套带空 payload 的特殊配置对象。

### 4.2 同一物理整数列的 controller 组

在现有文件中扩展：

```text
lib/widget/form/field_controller.dart
```

新增 `IntFieldControllerGroup`。它是 Controller 层能力，不是 UI 组件。

建议公开接口：

```dart
class IntFieldControllerGroup extends FieldController<int> {
  final IntFieldController numberController;
  final SelectFieldController<int> selectController;
  final FlagFieldController flagController;

  IntegerFieldEditor get editor;

  void configure(IntegerFieldEditor editor);

  @override
  void init(int value);

  @override
  int collect();
}
```

行为约定：

1. `init(value)` 同时初始化三个 typed controller。
2. 当前可见 controller 的合法变化同步到另外两个 controller。
3. 同步过程必须有 `_syncing` 防重入保护。
4. `collect()` 根据当前 `editor` 调用对应 typed controller 的 `collect()`：
   - number/reference → `IntFieldController.collect()`
   - select → `SelectFieldController<int>.collect()`
   - flags → `FlagFieldController.collect()`
5. 数字输入中的非法非空文本仍然抛 `FormatException`，不能回落为 0 或上一次值。
6. 切换判别类型时，如果旧数字编辑器正处于非法临时文本：
   - 丢弃该非法临时文本；
   - 恢复 controller 组最后一次合法整数；
   - 再切换 editor。
   这是唯一可预测的行为，因为非法文本不是可持久化的字段值。
7. 当前值不在新 `options` 中时不得自动改成首项或 0。`FoxyShadSelect` 现有 `selectedOptionBuilder` 会显示原始整数文本，可保留未知但真实存在的数据库值。
8. `dispose()` 统一释放三个子 controller；ViewModel 仍然只调用一次 `registerController(...)`。
9. `addListener/removeListener` 对外暴露 controller 组的有效整数变化，使 Condition 的 `ConditionValue1` 联动仍由 ViewModel 管理。

这个类解决的是“一个物理 int 字段需要多个现有 typed controller”的适配问题，不承担 label、options、引用解析或 Widget 构建。

### 4.3 View 直接使用现有组件

每个模块保留一个很小的 module-specific renderer，并使用 sealed switch：

```dart
return switch (spec) {
  IntegerNumberFieldSpec() => FoxyNumberInput<int>(
      controller: controllers.numberController,
      placeholder: column,
      readOnly: !spec.editable,
    ),
  IntegerSelectFieldSpec(:final options) => FoxyShadSelect<int>(
      controller: controllers.selectController,
      options: options,
      placeholder: Text(column),
      enabled: spec.editable,
    ),
  IntegerFlagsFieldSpec(:final flags) => FoxyFlagPicker(
      controller: controllers.flagController,
      flags: flags,
      title: spec.label,
      placeholder: column,
    ),
  IntegerReferenceFieldSpec(:final reference) => FoxyEntityPicker(
      controller: controllers.numberController,
      delegate: _delegateFor(reference),
      placeholder: column,
      readOnly: !spec.editable,
    ),
};
```

这里没有增加任何 `Foxy...` 包装控件：

- select 分支就是 `FoxyShadSelect<int>`
- number 分支就是 `FoxyNumberInput<int>`
- flags 分支就是 `FoxyFlagPicker`
- reference 分支就是 `FoxyEntityPicker`

三个模块的引用枚举仍然保持独立，因为它们代表不同领域集合；各 View 使用 exhaustive switch 映射到现有 `FoxyEntityPickerDelegates`。

## 5. Condition 详细迁移

### 5.1 负数引用使用显式语义，不再混入枚举输入

以下两个物理列不是严格枚举：

- `SourceTypeOrReferenceId`
- `ConditionTypeOrReference`

非负数表示类型，负数表示引用 ID。因此不能简单替换为单个 `FoxyShadSelect<int>`。

ViewModel 改成两组语义 controller：

```dart
sourceModeController            // SelectFieldController<int>
sourceTypeController            // SelectFieldController<int>
sourceReferenceIdController     // IntFieldController

conditionModeController         // SelectFieldController<int>
conditionTypeController         // SelectFieldController<int>
conditionReferenceIdController  // IntFieldController
```

模式选项保持 int，以便直接使用：

```dart
const kConditionModeOptions = <int, String>{
  0: '普通类型',
  1: '引用模板',
};
```

加载时解码：

```dart
if (value < 0) {
  mode = 1;
  referenceId = -value;
} else {
  mode = 0;
  type = value;
}
```

收集候选时编码：

```dart
final value = mode == 1 ? -referenceId : type;
```

引用 ID 必须为正数；自引用和 int32 范围仍交给现有 Condition validation 做最终检查。

模式切换只切换当前使用的 controller，不覆盖另一个模式中的草稿值。用户切回原模式时，之前的 type/reference ID 仍然存在。

### 5.2 ConditionValue 与来源联动字段

改成 controller 组：

- `sourceGroupController`
- `sourceIdController`
- `conditionValue1Controller`
- `conditionValue2Controller`
- `conditionValue3Controller`

`sourceEntryController` 只在普通整数与实体引用之间切换，两者都使用 `IntFieldController`，无需 controller 组。

`conditionValueConfig(...)` 改为返回：

```dart
IntegerFieldSpec<ConditionValueReference>
```

原有映射语义不变，包括：

- `ConditionType == 31` 时 Value1 决定 Value2 的 creature/gameObject 引用。
- `ConditionType == 42` 时 Value1 决定 Value2 的 options。
- Flags、DBC/世界表引用和未使用字段含义不变。

`ConditionValue1` 的 controller 组通过 aggregate listener 更新 `selectedConditionValue1`，从而重算 Value2 规格。

### 5.3 Condition View 布局

来源区域调整为四等份：

第一行：

1. 来源模式
2. 来源类型 / 引用模板 ID
3. SourceGroup
4. SourceEntry

第二行：

1. SourceId
2. ElseGroup
3. 空占位
4. 空占位

条件区域第一行：

1. 条件模式
2. 条件类型 / 引用条件 ID
3. ConditionTarget
4. NegativeCondition

第二行仍为 Value1、Value2、Value3、空占位。

所有 Row 保持四个 `Expanded` 槽位。

### 5.4 Condition 候选投影

引用模式下，AzerothCore 明确不使用的物理字段在候选中投影为 0，但不清空对应 controller 草稿：

- 来源引用模式：
  - `SourceGroup`
  - `SourceEntry`
  - `SourceId`
  - `ConditionTarget`
  - `ErrorType`
  - `ErrorTextId`
- 条件引用模式：
  - `ConditionTarget`
  - `ConditionValue1..3`
  - `NegativeCondition`

这样既不会因为隐藏的旧值导致保存失败，也不会在用户临时切换模式时销毁原编辑草稿。切回普通模式后原草稿继续可用。

## 6. GameObject 详细迁移

### 6.1 配置按 GameObject 类型分组

保留文件：

```text
lib/constant/game_object_constants.dart
```

删除扁平 `gameObjectDataFieldConfig(type, index)` switch，改为：

```dart
class GameObjectDataSchema {
  final Map<int, IntegerFieldSpec<GameObjectDataReference>> fields;

  const GameObjectDataSchema(this.fields);

  IntegerFieldSpec<GameObjectDataReference> field(int index) =>
      fields[index] ?? kUnusedGameObjectDataField;
}

const kGameObjectDataSchemas = <int, GameObjectDataSchema>{
  0: GameObjectDataSchema({
    0: IntegerSelectFieldSpec(
      '初始开启',
      options: kGameObjectBooleanOptions,
    ),
    1: IntegerReferenceFieldSpec(
      '锁 ID',
      reference: GameObjectDataReference.lock,
    ),
    2: IntegerNumberFieldSpec('自动关闭时间'),
    // ...
  }),
  1: GameObjectDataSchema({
    // button fields
  }),
  // ...
};

IntegerFieldSpec<GameObjectDataReference> gameObjectDataFieldSpec(
  int type,
  int index,
) {
  RangeError.checkValueInInterval(index, 0, 23, 'index');
  return kGameObjectDataSchemas[type]?.field(index) ??
      kUnusedGameObjectDataField;
}
```

规则：

- 每个 GameObject type 独立一段，并标注对应 AzerothCore struct 名。
- Map 只写实际字段，缺失槽位统一回落为只读“未使用”。
- 稀疏的 type 33 不需要填充大量占位。
- 所有已有 label、options 和 reference 必须逐项迁移，不在结构重构时修改语义。
- `kGameObjectTrapTypeOptions` 变成 `IntegerSelectFieldSpec`，最终由 `FoxyShadSelect<int>` 渲染。

### 6.2 GameObject ViewModel

`data0Controller..data23Controller` 保持显式字段名，但类型改为：

```dart
IntFieldControllerGroup
```

仍然逐一注册、初始化和收集，不把 Entity 或候选字段聚合为 List/Map。

新增：

```dart
final selectedType = signal(0);
```

ViewModel 监听 `typeController`：

1. 更新 `selectedType`。
2. 根据 `gameObjectDataFieldSpec(type, index).editor` 显式配置 24 个 controller 组。

`GameObjectTemplateView` 改为 StatelessWidget + `Watch`，删除 View 自己的 `addListener/removeListener/setState`。

类型切换不自动清零 Data 字段，也不改写未知原始值。GameObject union 中不同 type 复用同一批物理 Data 列，静默清零会造成数据丢失。

## 7. SmartScript 详细迁移

### 7.1 参数规格

保留现有三个领域入口：

- `smartEventParameterConfig`
- `smartActionParameterConfig`
- `smartTargetParameterConfig`

它们本来就对应 SmartAI 的三个独立 union，不需要为了“统一”强行合并成一个超大 registry。

只替换字段规格类型：

```dart
SmartParameterFieldConfig
    ↓
IntegerFieldSpec<SmartParameterReference>
```

`SmartParameterGroupConfig` 可保留六个显式 `param1..param6` 字段和 `field(index)`，但字段类型改为 sealed spec。

### 7.2 SmartScript ViewModel

下列 controller 改成 `IntFieldControllerGroup`：

- `eventParam1..6`
- `actionParam1..6`
- `targetParam1..4`

新增四个 Signal：

```dart
selectedSourceType
selectedEventType
selectedActionType
selectedTargetType
```

ViewModel 监听四个 type controller：

- source type 改变时更新 event type 可选项。
- event/action/target type 改变时重新配置对应参数 controller 组。
- Listener 在 ViewModel 的 `initSignals` 中注册，在 `dispose` 中移除。

`SmartScriptView` 改为 StatelessWidget + `Watch`，删除 View 中四组 Controller listener。

### 7.3 未使用参数策略

这次重构保留现有验证语义：

- `editable == false` 的 Smart 参数仍必须为 0。
- 不在 controller 组或 schema 层偷偷清零。
- 类型切换后如果旧值落入未使用字段，现有 validation 继续明确报错。

原因是自动清零属于数据语义变化，不应和控件重构混在同一批提交中。后续如要改善切换类型体验，应单独设计“确认并清空不兼容参数”的显式操作。

## 8. SpellItemEnchantment 收尾

虽然主要重构范围是三个模块，但如果不处理 SpellItemEnchantment，`FoxyIntEnumInput` 无法删除。

只做最小兼容迁移：

- `EffectArg0..2` 改为 `IntFieldControllerGroup`。
- type 1/3/7：直接使用 `FoxyEntityPicker` + `numberController`。
- type 4/5：直接使用 `FoxyShadSelect<int>` + `selectController`。
- 其他类型：直接使用 `FoxyNumberInput<int>` + `numberController`。
- 不改附魔业务校验、Entity 或页面布局。

完成后从：

```text
lib/widget/foxy_shad_select.dart
```

删除：

- `FoxyIntEnumInput`
- `_IntEnumDialog`
- 因此变成未使用的 Dialog、readonly input import

## 9. 文件级变更清单

### 新增

- `lib/constant/integer_field_spec.dart`
- `test/int_field_controller_group_test.dart`
- 必要的三个模块 widget 行为测试文件；优先并入现有模块测试，避免碎片化。

### 修改

- `lib/widget/form/field_controller.dart`
- `lib/widget/foxy_shad_select.dart`
- `lib/constant/condition_value_config.dart`
- `lib/constant/game_object_constants.dart`
- `lib/constant/smart_script_constants.dart`
- `lib/page/condition/condition_detail_view_model.dart`
- `lib/page/condition/condition_view.dart`
- `lib/page/game_object/game_object_template_detail_view_model.dart`
- `lib/page/game_object/game_object_template_view.dart`
- `lib/page/smart_script/smart_script_detail_view_model.dart`
- `lib/page/smart_script/smart_script_view.dart`
- `lib/page/spell_item_enchantment/spell_item_enchantment_detail_view_model.dart`
- `lib/page/spell_item_enchantment/spell_item_enchantment_view.dart`
- `test/condition_contract_test.dart`
- `test/condition_database_editing_contract_test.dart`
- `test/game_object_contract_test.dart`
- `test/smart_script_contract_test.dart`
- `test/smart_script_database_editing_contract_test.dart`
- `test/foxy_shad_select_test.dart`

### 不修改

- 三个模块的 Entity 与生成文件
- Repository 与生成文件
- router.gr.dart
- 数据库 migration
- DBC schema

## 10. 实施顺序

### 阶段 1：建立共享基础能力

1. 新增 sealed `IntegerFieldSpec<R>`。
2. 新增并单测 `IntFieldControllerGroup`。
3. 扩充 `FoxyShadSelect` 测试：
   - 正常选择。
   - 当前值不在 options 中时显示原始整数。
   - `enabled: false` 时不可修改。

阶段验收：不迁移业务页面，现有测试全部保持原行为。

### 阶段 2：迁移 GameObject

1. 把 `(type, index)` switch 逐类型迁入 schema registry。
2. 先让现有 contract test 对新 API 通过，确认 36 种类型的 editable slot 集合完全不变。
3. 迁移 24 个 controller。
4. View 改为直接使用四种现有组件。
5. 把类型监听移入 ViewModel。

阶段验收：

- 36 种类型的可编辑槽位集合与当前测试一致。
- 关键外键引用不变。
- `kGameObjectTrapTypeOptions` 显示为普通 Shad select。
- 保存前后 24 个 Data 物理值不丢失。

### 阶段 3：迁移 SmartScript

1. 把三组参数配置替换为 sealed spec。
2. 迁移 16 个参数 controller。
3. 把四个类型监听移入 ViewModel。
4. View 改为 Stateless + Watch。

阶段验收：

- event/action/target 的 label、options、flags、reference 全部不变。
- source type 对 event type 的过滤不变。
- 未使用参数仍由现有 validation 拒绝非 0。
- SmartScript composite persisted key 行为不变。

### 阶段 4：迁移 Condition

1. 先增加负数引用 encode/decode 的 ViewModel 单测。
2. 拆分来源模式与条件模式 controller。
3. 迁移 SourceGroup、SourceId、Value1..3 controller。
4. 配置改为 sealed spec。
5. 调整四等份布局。
6. 更新数据库编辑 contract test 的 controller 初始化 helper。

阶段验收：

- 普通来源/条件 type 使用 `FoxyShadSelect<int>`。
- 负数引用可以无损加载、编辑、保存。
- `-7` 仍编码为物理值 `-7`，不会变成枚举值或字符串。
- 自引用、未使用字段、ConditionTarget 等现有校验继续生效。
- Value1 驱动 Value2 类型变化的两个特殊分支继续生效。

### 阶段 5：删除旧组件

1. 最小迁移 SpellItemEnchantment 的三个 EffectArg。
2. 全仓确认 `FoxyIntEnumInput` 无调用。
3. 删除组件和专用 Dialog。
4. 清理仅因此存在的 import。

阶段验收：

```bash
rg -n "FoxyIntEnumInput|_IntEnumDialog" lib test
```

无输出。

### 阶段 6：完整验证

只格式化变更的 Dart 文件，然后执行：

```bash
dart format <changed dart files>
flutter test test/int_field_controller_group_test.dart
flutter test test/foxy_shad_select_test.dart
flutter test test/condition_contract_test.dart
flutter test test/condition_database_editing_contract_test.dart
flutter test test/game_object_contract_test.dart
flutter test test/smart_script_contract_test.dart
flutter test test/smart_script_database_editing_contract_test.dart
dart run tool/foxy_lint.dart
flutter analyze
flutter test
```

全量测试结果需要按仓库已知 baseline 区分：

- lint plugin 自身已有 deprecated warning。
- `creature_template_spell_database_editing_contract_test.dart` 已知存在字段顺序 baseline failure。
- MySQL integration 未提供环境变量时会跳过。

## 11. 必须新增或调整的测试

### Controller 组

- `init(7)` 后三个 typed controller 都是 7。
- select 修改为 1 后，number/flags 同步为 1。
- flags 修改后，number/select 同步。
- number 非法非空文本在 number editor 下 `collect()` 抛 `FormatException`。
- 从非法 number 草稿切到 select 时恢复最后合法整数。
- 多次 configure 不产生 listener 重入或重复通知。
- dispose 后无残留 listener。

### 配置规格

- GameObject 0..35 的 editable Data slot 集合完全保持。
- 关键 GameObject Data 引用仍指向同一 reference enum。
- trap type、boolean、chair height 是 `IntegerSelectFieldSpec`。
- Condition 的关键 Value 是正确的 number/select/flags/reference subtype。
- SmartScript 的关键参数是正确的 subtype。
- 不再测试 nullable 属性组合。

### ViewModel

- Condition 普通 type encode/decode。
- Condition source reference encode/decode。
- Condition condition reference encode/decode。
- 引用模式投影未使用列为 0，但切回普通模式仍保留 controller 草稿。
- GameObject/SmartScript 判别 controller 改变后，相应 controller 组 editor 正确更新。
- Repository store/update 调用和 persistedKey 变化保持原 contract。

### Widget

- 一个 GameObject enum Data 字段渲染 `FoxyShadSelect<int>`，不出现 list icon。
- 一个 Condition options Value 渲染 `FoxyShadSelect<int>`。
- 一个 SmartScript options 参数渲染 `FoxyShadSelect<int>`。
- reference、flags、number 分支分别仍使用现有对应组件。

这些是行为测试，不通过读取 Dart 源文件断言类名或 import。

## 12. 风险与控制措施

### 风险 1：切换类型时丢失原始整数

控制：

- controller 组保存最后合法整数并同步 typed controller。
- options 不包含当前值时不自动归零。
- GameObject Data 不因 type 切换自动清零。
- SmartScript 暂不混入自动清理策略。

### 风险 2：程序化同步造成 listener 循环

控制：

- controller 组使用 `_syncing`。
- 只有实际值变化才通知 aggregate listener。
- 单测覆盖 number → select → flags 的双向同步。

### 风险 3：初始化顺序触发错误 schema

控制：

- ViewModel 先注册 listener，再应用 candidate。
- `_applyCandidate` 先初始化判别 controller，再初始化动态字段值。
- `_applyCandidate` 末尾显式调用一次 `_refresh...FieldEditors()`，不依赖隐含通知顺序。

### 风险 4：Condition 的负号编码被破坏

控制：

- 正负转换只存在于 DetailViewModel 的两个私有 encode/decode helper。
- Entity、Key、Repository 继续接收原始物理整数。
- 增加 `-1`、`-7` 和 int32 边界附近值的 round-trip 测试。

### 风险 5：重构配置时漏字段

控制：

- GameObject 先迁配置并运行现有 36 类型 slot contract，再迁 UI。
- Condition/SmartScript 对关键 subtype 和 reference 增加行为断言。
- 不在配置结构迁移的同一个阶段改 label、枚举值或引用目标。

## 13. 完成标准

只有同时满足以下条件才算完成：

- Condition、GameObject、SmartScript 的严格枚举均直接使用 `FoxyShadSelect<int>`。
- 全仓不存在 `FoxyIntEnumInput` 和 `_IntEnumDialog`。
- 三套动态字段配置使用 sealed spec，不存在 `options/flags/reference` nullable 组合判断。
- GameObject Data 配置按 GameObject type 分组。
- GameObject 和 SmartScript 的类型监听不再由 Stateful View 手工管理。
- Condition 的负数引用 round-trip 不变。
- 三个 Entity 的物理字段、JSON、Repository 写入和 persisted identity contract 不变。
- 所有详情 Row 仍保持四等份。
- focused tests、custom lint、`flutter analyze` 和全量测试已执行，并清楚报告已知 baseline。

## 14. 推荐提交拆分

建议按以下顺序形成可独立审阅、可回退的提交：

1. `refactor(form): add typed integer field specs and controller group`
2. `refactor(game-object): group data schemas and use typed editors`
3. `refactor(smart-script): use typed parameter editors`
4. `refactor(condition): separate reference modes and typed value editors`
5. `refactor(form): remove legacy integer enum dialog`

任何阶段失败都可以只回退该模块，不需要同时回退 Entity、Repository 或数据库代码。
