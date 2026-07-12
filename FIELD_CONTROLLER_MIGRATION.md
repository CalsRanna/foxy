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

FieldController 由 ViewModel 创建，因此也必须由 ViewModel 释放：

```dart
late final _controllers = <FieldController>[
  entryController,
  nameController,
  rankController,
];

void dispose() {
  for (final controller in _controllers) {
    controller.dispose();
  }
}
```

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
final entryController = IntFieldController();
final nameController = StringFieldController();
final speedController = DoubleFieldController();
final flagsController = FlagFieldController();
final rankController = SelectFieldController<int>(fallback: 0);
```

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

所有 FieldController 必须加入 `_controllers` 列表，统一释放。新增字段时，声明完成后应立即加入列表，避免遗漏。

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
- Controller 列表与声明数量一致；
- 新建、加载、编辑、保存和离开页面的生命周期均正确。

## 11. 当前进度

截至 2026-07-13：

- `creature_template` 模块已完整迁移，包括列表、主详情和全部关联 Tab。
- 该模块共 13 个 ViewModel、137 个 FieldController，声明与 `_controllers` 释放列表完全一致。
- 该模块目录内已不存在裸 `TextEditingController`、`ShadSelectController`、直接 `ShadInput`、`FoxyFormItem.legacy` 或 Page 层内部 Controller 访问。
- `quest_sort` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、4 个 FieldController。
- `quest_info` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、4 个 FieldController。
- `glyph_property` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、5 个 FieldController。
- `currency_type` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、5 个 FieldController。
- `gem_property` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、6 个 FieldController。
- `quest_faction_reward` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、12 个 FieldController。
- `item_extended_cost` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、17 个 FieldController。
- `scaling_stat_distribution` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、23 个 FieldController。
- `scaling_stat_value` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、26 个 FieldController。
- `talent` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、24 个 FieldController。
- `spell_item_enchantment` 模块已完整迁移，包括列表筛选、详情编辑和 DBC 名称本地化，共 2 个 ViewModel、24 个 FieldController。
- `emote_text` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、21 个 FieldController。
- `area_table` 模块已完整迁移，包括列表筛选、详情编辑和 DBC 名称本地化，共 2 个 ViewModel、22 个 FieldController。
- `achievement` 模块已完整迁移，包括列表筛选、详情编辑和三组 DBC 本地化字段，共 2 个 ViewModel、61 个 FieldController。
- `item_set` 模块已完整迁移，包括列表筛选、详情编辑、DBC 名称本地化、物品/法术 EntityPicker 与门槛数值，共 2 个 ViewModel、54 个 FieldController。
- `condition` 模块已完整迁移，包括列表筛选、详情编辑、Select 联动与 EntityPicker 参数，共 2 个 ViewModel、17 个 FieldController。
- `reference_loot_template` 模块已完整迁移，包括列表筛选和详情编辑，共 2 个 ViewModel、12 个 FieldController。
- `page_text` 模块已完整迁移，包括列表筛选、主详情和动态 locale 行编辑，共 3 个 ViewModel、固定 6 个 FieldController（locale 行为动态 `StringFieldController`）。
- `player_create_info` 模块已完整迁移，包括列表筛选、主详情与动作/起始物品/自定义法术子 Tab，共 5 个 ViewModel、20 个 FieldController。
- `game_object` 模块已完整迁移，包括列表筛选、主详情（含 Data0–23 与类型 Select）、Addon、任务物品与掉落子 Tab，共 5 个 ViewModel、56 个 FieldController。
- `smart_script` 模块已完整迁移，包括列表筛选与详情编辑（事件/动作/目标参数），共 2 个 ViewModel、32 个 FieldController。
- `gossip_menu` 模块已完整迁移，包括列表筛选、主详情、选项表单与 npc_text 动态字段，共 4 个 ViewModel、固定 18 个 FieldController（npc_text 为按需惰性 Map）。
- `item` 模块已完整迁移，包括列表筛选、主详情（属性/法术/插槽等动态区）、附魔子 Tab 与 item/disenchant/milling/prospecting 四类掉落子 Tab，共 7 个 ViewModel、185 个 FieldController。
- `quest` 模块已完整迁移，包括列表筛选、主详情、Addon、发放奖励、提交物品、起止生物/物体 4 个子 Tab，以及 AreaTableOrQuestSortSelector 共享选择器，共 9 个 ViewModel、146 个 FieldController。
- `spell` 模块已完整迁移，包括列表筛选、主详情（效果联动/DBC 本地化/Flag/Select）、奖励系数、自定义属性、区域技能、技能组、链接技能、技能排行、技能掉落子 Tab，共 9 个 ViewModel、212 个 FieldController。
- `bootstrap` / `more` / `scaffold` DBC 导入对话框 / `setting` DBC 同步对话框 已迁移为 `StringFieldController`（连接表单、模块搜索、路径与导出搜索）。
- **双入口已清理**：`FoxyNumberInput` / `FoxyShadSelect` / `FoxyFlagPicker` / `FoxyEntityPicker` / `FoxyLocalePicker` 仅接受类型化 `controller:`；已删除 `FoxyFormItem.legacy`。

已完成模块：

| 模块 | 范围 | Controller 数量 | 验证 |
|---|---|---:|---|
| `creature_template` | 列表、主详情、装备、掉落、击杀声望、任务物品、Addon、抗性、法术、训练师、商人、偷窃掉落、剥皮掉落 | 137 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `quest_sort` | 列表筛选、详情编辑、DBC 名称本地化 | 4 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `quest_info` | 列表筛选、详情编辑、DBC 名称本地化 | 4 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `glyph_property` | 列表筛选、详情编辑、雕文数值属性 | 5 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `currency_type` | 列表筛选、详情编辑、货币数值属性 | 5 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `gem_property` | 列表筛选、详情编辑、宝石数值属性 | 6 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `quest_faction_reward` | 列表筛选、详情编辑、难度声望数值 | 12 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `item_extended_cost` | 列表筛选、详情编辑、荣誉/竞技场与物品消耗 | 17 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `scaling_stat_distribution` | 列表筛选、详情编辑、StatID/Bonus/Maxlevel | 23 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `scaling_stat_value` | 列表筛选、详情编辑、预算/护甲/DPS 数值 | 26 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `talent` | 列表筛选、详情编辑、法术等级/前置天赋/掩码 | 24 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `spell_item_enchantment` | 列表筛选、详情编辑、DBC 名称本地化、效果数值 | 24 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `emote_text` | 列表筛选、详情编辑、16 个 EmoteText 数值槽 | 21 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `area_table` | 列表筛选、详情编辑、DBC 名称本地化、音效/液体数值 | 22 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `achievement` | 列表筛选、详情编辑、标题/描述/奖励本地化与数值属性 | 61 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `item_set` | 列表筛选、详情编辑、DBC 名称本地化、物品/法术 Picker、门槛 | 54 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `condition` | 列表筛选、详情编辑、Select 联动、EntityPicker 参数 | 17 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `reference_loot_template` | 列表筛选、详情编辑、物品 Picker、掉落几率/模式 | 12 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `page_text` | 列表筛选、主详情、动态 locale 行 | 6+动态 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `player_create_info` | 列表筛选、主详情、动作按钮、起始物品、自定义法术 | 20 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `game_object` | 列表筛选、主详情、Addon、任务物品、物品掉落 | 56 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `smart_script` | 列表筛选、详情编辑（事件/动作/目标） | 32 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `gossip_menu` | 列表筛选、主详情、选项、npc_text 动态字段 | 18+动态 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `item` | 列表筛选、主详情、附魔、物品/分解/选矿/研磨掉落 | 185 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `quest` | 列表筛选、主详情、Addon、发放奖励、提交物品、起止生物/物体、区域/排序选择器 | 146 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `spell` | 列表筛选、主详情（效果联动/DBC 本地化）、奖励系数、自定义属性、区域/组/链接/排行/掉落子 Tab | 212 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `bootstrap` | 数据库连接表单 | 5 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `more` | 模块搜索 | 1 | `flutter analyze`、`flutter test`、架构残留扫描通过 |
| `scaffold` / `setting` | DBC 导入路径、导出目录/表名搜索对话框 | 4 | `flutter analyze`、`flutter test`、架构残留扫描通过 |

业务 Page 层 FieldController 迁移与共享组件双入口清理均已完成。

## 12. 架构决策摘要

1. 使用 `XXXFieldController`，不使用 `XXXField`。
2. 实例名使用 `xxxController`，不使用 `xxxField`。
3. 使用 `StringFieldController`，不使用 `TextFieldController`。
4. `label`、`placeholder`、`errorLabel` 不进入 Controller。
5. `FoxyFormItem` 只做标签布局（`label` + `child`），不隐式创建输入框。
6. 每类输入组件只接受语义匹配的 FieldController，参数名统一为 `controller`。
7. ViewModel 拥有并释放 Controller，Widget 只借用。
8. Page 不得访问 FieldController 内部原始 Controller。
9. 不得恢复双入口或 `FoxyFormItem.legacy`。
