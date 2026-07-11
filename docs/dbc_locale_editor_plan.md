# DBC 本地化字段编辑器方案

> 状态：已实施（阶段 1–3 完成；阶段 4 覆盖**现有详情页**；阶段 5 导入导出回归待手工验证）  
> 最后更新：2026-07-12  
> 适用范围：Foxy 中带有 `*_lang_<locale>` 字段的 DBC 详情编辑页面

## 1. 背景

Foxy 现有普通世界库本地化数据通常存储在独立的 `*_locale` 表中：一条记录对应一种语言。`FoxyLocalePicker` 通过输入框尾部的地球按钮打开本地化编辑对话框，按语言行加载和保存数据。

DBC 的本地化字段采用不同的物理结构。一个可本地化字段会在同一条数据库记录中展开为 16 个字符串列和一个 Flags 列，例如：

```text
Name_lang_enUS
Name_lang_koKR
Name_lang_frFR
...
Name_lang_unk3
Name_lang_Flags
```

当前部分 DBC 页面只展示 `zhCN`，部分页面直接展示少数几种语言，编辑体验不统一，也无法方便地编辑完整的 DBC 本地化内容。

本方案在不改变 DBC 数据库存储、导入和导出结构的前提下，为每个 DBC 本地化字段提供与普通数据库字段一致的“输入框 + 地球按钮”编辑体验。

## 2. 已确定的交互方案

### 2.1 每个字段使用独立编辑器

每个可本地化字段都拥有自己的地球按钮。点击后，弹窗只编辑当前字段，不展示同一条 DBC 记录中的其他本地化字段。

例如 `dbc_faction` 包含：

- `Name_lang_*`：名称。
- `Description_lang_*`：描述。

点击“名称”的地球按钮时，弹窗只显示“语言编号”和“名称”；点击“描述”的地球按钮时，弹窗只显示“语言编号”和“描述”。

不采用将名称、描述等所有本地化字段放在同一个弹窗中的方案。

### 2.2 弹窗布局

弹窗固定为两列：

| 语言编号 | 当前字段 |
|---|---|
| `0 · enUS` | 当前字段的美式英语内容 |
| `1 · koKR` | 当前字段的韩语内容 |
| `2 · frFR` | 当前字段的法语内容 |
| `...` | `...` |
| `15 · unk3` | 当前字段的未知语言 3 内容 |

第二列标题使用当前字段的业务名称，例如“名称”“描述”“奖励文本”或“光环描述”。

DBC 语言槽位是固定结构，因此弹窗：

- 固定显示 16 行语言。
- 不提供“添加语言”按钮。
- 不提供“删除语言行”按钮。
- 不允许手动输入或修改语言编号。
- 允许将当前语言对应的字段值清空。

### 2.3 语言编号映射

语言顺序必须与 `warcrafty` DBC Schema 的 locstring 顺序保持一致：

| 编号 | Locale | 显示名称 |
|---:|---|---|
| 0 | `enUS` | 美式英语 |
| 1 | `koKR` | 韩语 |
| 2 | `frFR` | 法语 |
| 3 | `deDE` | 德语 |
| 4 | `zhCN` | 简体中文 |
| 5 | `zhTW` | 繁体中文 |
| 6 | `esES` | 西班牙语 |
| 7 | `esMX` | 墨西哥西班牙语 |
| 8 | `ruRU` | 俄语 |
| 9 | `jaJP` | 日语 |
| 10 | `ptPT` | 葡萄牙语 |
| 11 | `ptBR` | 巴西葡萄牙语 |
| 12 | `itIT` | 意大利语 |
| 13 | `unk1` | 未知语言 1 |
| 14 | `unk2` | 未知语言 2 |
| 15 | `unk3` | 未知语言 3 |

### 2.4 页面展示

详情页主表单继续只展示当前页面约定的主要语言值，现阶段默认使用 `zhCN`。输入框尾部增加地球按钮，用于打开当前字段的完整 16 语言编辑器。

例如 Spell 页面分别提供：

- 名称：编辑 `Name_lang_*`。
- 副标题：编辑 `NameSubtext_lang_*`。
- 描述：编辑 `Description_lang_*`。
- 光环描述：编辑 `AuraDescription_lang_*`。

四个按钮分别打开四个独立弹窗，任何一个弹窗都不会展示另外三个字段。

对于描述等长文本字段，第二列应支持多行输入；名称等短文本字段继续使用单行输入。该差异由字段定义配置，不在页面中重复判断。

## 3. 数据结构保持不变

本方案不创建 `dbc_*_locale` 分表，也不修改现有 `foxy.dbc_*` 表结构。

原因如下：

- DBC 文件本身使用固定的 16 语言 locstring 结构。
- 当前导入流程会直接将 DBC 字段写入对应的宽表列。
- 当前导出流程需要完整的宽表列生成 DBC 文件。
- 拆分成 locale 表会为导入和导出增加额外的拆分、合并及一致性维护成本。

因此只在 UI 与 Repository 之间增加转换层：

```text
DBC 宽表中的 16 个语言列
          ↕
DbcLocaleFieldCodec
          ↕
编辑器中的 16 行“语言编号 + 字段值”
```

## 4. 建议的领域模型

### 4.1 `DbcLocale`

定义 DBC 固定语言槽位，集中维护编号、代码和中文名称：

```dart
class DbcLocale {
  final int index;
  final String code;
  final String label;
}
```

语言定义只允许存在一份，Codec、Widget 和测试都使用同一份列表。

### 4.2 `DbcLocaleFieldDefinition`

描述单个可本地化字段组：

```dart
class DbcLocaleFieldDefinition {
  final String columnPrefix;
  final String label;
  final bool multiline;
}
```

示例：

```dart
const DbcLocaleFieldDefinition(
  columnPrefix: 'Name_lang',
  label: '名称',
  multiline: false,
);

const DbcLocaleFieldDefinition(
  columnPrefix: 'Description_lang',
  label: '描述',
  multiline: true,
);
```

`columnPrefix` 用于生成物理列名：

```text
${columnPrefix}_enUS
${columnPrefix}_koKR
...
${columnPrefix}_unk3
```

字段定义必须在创建时通过对应 `DbcDefinition.schema.fields` 校验，确保 16 个语言列全部存在且均为字符串字段。这样可以避免页面配置拼写错误导致写错列。

### 4.3 `DbcLocaleFieldValue`

编辑器只需要表示单个字段在一种语言下的值：

```dart
class DbcLocaleFieldValue {
  final DbcLocale locale;
  final String value;
}
```

不在该实体中放入同一记录的其他本地化字段。

### 4.4 `DbcLocaleFieldCodec`

Codec 负责以下转换：

- 从数据库行读取 `${columnPrefix}_${locale.code}`。
- 转换为固定顺序的 16 个 `DbcLocaleFieldValue`。
- 将编辑结果转换为仅包含当前字段组 16 个列的更新 Map。
- 拒绝缺失、重复或顺序非法的语言数据。

Codec 不读取或修改普通数值字段，也不自动修改 `${columnPrefix}_Flags`。

## 5. Widget 设计

### 5.1 设计原则：统一入口，分开实现

普通数据库 locale 分表与 DBC locstring 的用户目标相同，都是编辑一个字段的本地化内容，因此继续共用 `FoxyLocalePicker` 的输入框和地球按钮入口。

两者的存储结构和编辑约束不同，因此不在同一个编辑器主体中通过 `isDbc`、`fixedRows` 或模式枚举堆叠条件分支。组件结构应为：

```text
FoxyLocalePicker（共用输入框和地球按钮）
          │
          ├─ DatabaseLocaleEditor
          │    动态语言行，可添加、删除，保存到 *_locale 表
          │
          └─ DbcLocaleFieldEditor
               固定 16 行，只编辑一个字段，局部更新 DBC 主记录
```

弹窗标题、加载状态、错误提示、取消和保存按钮等外壳可以提取为共享组件；数据模型、表格主体、校验规则和保存流程必须分开。

### 5.2 强类型 Delegate

`FoxyLocalePicker` 接收一个共同的 Delegate 抽象，但普通数据库和 DBC 使用两个独立的强类型实现：

```dart
sealed class FoxyLocaleEditorDelegate {
  const FoxyLocaleEditorDelegate();
}

final class DatabaseLocaleEditorDelegate<T>
    extends FoxyLocaleEditorDelegate {
  // 独立 locale 表的加载、添加、删除和保存契约。
}

final class DbcLocaleFieldEditorDelegate
    extends FoxyLocaleEditorDelegate {
  final DbcLocaleFieldDefinition field;
  final Future<List<DbcLocaleFieldValue>> Function(int entry) onLoad;
  final Future<void> Function(
    int entry,
    List<DbcLocaleFieldValue> values,
  ) onSave;
}
```

两类 Delegate **不共用**同一套数据协议：

- **DBC**：强类型 `List<DbcLocaleFieldValue>`，在类型层表达固定 16 槽位、不能增删语言。
- **普通数据库**：编辑器主体仍使用 `List<Map<String, String>>` 作为弹窗协议（历史实现）；各模块在 Delegate 的 `onLoad`/`onSave` 闭包内与具体 locale Entity 互转。本次 DBC 改造不要求把普通 locale 也改成 Entity 级强类型。

`FoxyLocalePicker` 只在打开弹窗的入口处进行一次类型分派，不在具体编辑器内部混合两套规则：

```dart
switch (delegate) {
  case DatabaseLocaleEditorDelegate():
    await DatabaseLocaleEditor.show(...);
  case DbcLocaleFieldEditorDelegate():
    await DbcLocaleFieldEditor.show(...);
}
```

建议的 DBC 调用形式：

```dart
FoxyLocalePicker(
  entry: viewModel.id.value == 0 ? null : viewModel.id.value,
  controller: viewModel.nameLangZhCNController,
  title: '名称本地化',
  delegate: FoxyLocalePickerDelegates.dbcSpellName,
  onSaved: viewModel.applyNameLocales,
)
```

DBC Delegate 需要提供：

- 当前单个字段的定义。
- 加载当前记录 16 个语言值的方法。
- 保存当前字段 16 个语言值的方法。
- 保存后通知页面 ViewModel 的回调。

### 5.3 独立编辑器主体

`DatabaseLocaleEditor` 保留现有动态行语义，包括按实际数据添加和删除 locale 行。

`DbcLocaleFieldEditor` 是独立的固定行编辑器，并遵循以下规则：

- 第一列为只读语言编号及代码。
- 第二列为当前字段输入框。
- 固定显示 16 行，不提供添加或删除入口。
- 表头使用字段定义的 `label`。
- 根据 `multiline` 决定单行或多行输入。
- 只接收和返回 `List<DbcLocaleFieldValue>`。

这种拆分保证用户看到统一的入口和视觉风格，同时避免将两种不同的持久化语义强行塞进一个 Widget。

## 6. Repository 设计

### 6.1 每张表仍由自己的 Repository 管理

继续遵循“一张表一个 Repository”的项目约定。DBC Repository 对外提供本表的 locale 加载和保存方法，例如：

```dart
Future<List<DbcLocaleFieldValue>> getSpellLocales(
  int id,
  DbcLocaleFieldDefinition field,
);

Future<void> saveSpellLocales(
  int id,
  DbcLocaleFieldDefinition field,
  List<DbcLocaleFieldValue> locales,
);
```

各 Repository 可以共用一个 `DbcLocaleRepositoryMixin` 实现列选择、Codec 转换和局部更新，但页面不能绕过对应 Repository 直接操作 Laconic。

### 6.2 保存必须是局部更新

保存“名称”弹窗时，只更新 `Name_lang_*` 的 16 个列：

```sql
UPDATE foxy.dbc_faction
SET
  Name_lang_enUS = ?,
  Name_lang_koKR = ?,
  ...,
  Name_lang_unk3 = ?
WHERE ID = ?;
```

不得在 locale 弹窗保存时调用完整实体的 `update*()`，否则可能覆盖页面上尚未保存的其他字段。

所有列名必须来自经过 Schema 校验的静态字段定义，不能接受来自用户输入的表名或列名前缀。

### 6.3 Flags 处理

`${columnPrefix}_Flags` 不在普通语言行中展示，第一版也不自动计算或修改。

保存本地化内容时必须保持 Flags 原值。若以后确认 Flags 的业务语义并需要编辑，应作为单独的高级选项设计，不混入“语言编号 + 当前字段”两列表格。

## 7. ViewModel 状态同步

DBC locale 数据与普通 locale 分表不同，它和主实体存储在同一行。因此弹窗保存后，除了局部更新数据库，还必须同步详情页当前持有的完整 Entity。

推荐流程：

```text
打开字段弹窗
  → Repository 加载该字段的 16 个语言列
  → 用户编辑并保存
  → Repository 局部更新这 16 个列
  → onSaved 将结果合并回 ViewModel 当前 Entity
  → 更新页面当前显示语言的 Controller
```

必须满足：

- 修改 `zhCN` 后，页面主输入框立即显示新值。
- 修改其他语言后，当前页面的完整 Entity 也同步持有新值。
- 之后点击主页面“保存”时，不能用旧 Entity 覆盖刚刚保存的 locale 数据。
- 主页面收集数据时继续基于已加载 Entity 使用 `copyWith` 覆盖可见字段，保留未展示的 DBC 列。

新建记录在尚未获得真实 ID 前禁用地球按钮。主记录首次保存成功并回填 ID 后，才允许打开本地化编辑器。

## 8. 当前需要覆盖的 DBC 字段

按当前 Foxy 已同步的 DBC 定义，以下 13 张表包含本地化字段，共 23 个独立字段编辑器：

| DBC 表 | 字段前缀 | 编辑器标题 |
|---|---|---|
| `dbc_achievement` | `Title_lang` | 标题 |
| `dbc_achievement` | `Description_lang` | 描述 |
| `dbc_achievement` | `Reward_lang` | 奖励文本 |
| `dbc_area_table` | `AreaName_lang` | 区域名称 |
| `dbc_char_titles` | `Name_lang` | 男性称号 |
| `dbc_char_titles` | `Name1_lang` | 女性称号 |
| `dbc_faction` | `Name_lang` | 阵营名称 |
| `dbc_faction` | `Description_lang` | 阵营描述 |
| `dbc_item_random_properties` | `Name_lang` | 随机属性名称 |
| `dbc_item_random_suffix` | `Name_lang` | 随机后缀名称 |
| `dbc_item_set` | `Name_lang` | 套装名称 |
| `dbc_map` | `MapName_lang` | 地图名称 |
| `dbc_map` | `MapDescription0_lang` | 地图描述 1 |
| `dbc_map` | `MapDescription1_lang` | 地图描述 2 |
| `dbc_quest_info` | `InfoName_lang` | 任务类型名称 |
| `dbc_quest_sort` | `SortName_lang` | 任务分类名称 |
| `dbc_spell` | `Name_lang` | 法术名称 |
| `dbc_spell` | `NameSubtext_lang` | 法术副标题 |
| `dbc_spell` | `Description_lang` | 法术描述 |
| `dbc_spell` | `AuraDescription_lang` | 光环描述 |
| `dbc_spell_item_enchantment` | `Name_lang` | 附魔名称 |
| `dbc_spell_range` | `DisplayName_lang` | 距离名称 |
| `dbc_spell_range` | `DisplayNameShort_lang` | 距离简称 |

实施时应以 `dbcDefinitions` 和实际 `schema.fields` 的自动检查结果为最终依据。若 Schema 新增本地化字段但未注册编辑器，测试应直接失败并提示缺失配置。

## 9. 与全局 locale 设置的关系

`FoxyViewModel.localeEnabled` 和 `hasLocaleTables` 用于世界库 `*_locale` 分表的检测与显示逻辑。

DBC 的 16 个本地化列始终存在于 DBC 镜像表中，因此 DBC 本地化编辑器不应依赖世界库 locale 表是否存在，也不应被 `localeEnabled` 关闭。只要对应 DBC 表和记录存在，地球按钮就应可用。

## 10. 实施顺序

### 阶段 1：基础模型与 Codec

- 新增固定语言定义。
- 新增单字段定义和值实体。
- 实现单字段宽表与 16 行值之间的双向 Codec。
- 通过 `DbcSchema` 校验字段前缀和物理列。

### 阶段 2：共用入口与独立编辑器

- 保留 `FoxyLocalePicker` 作为共用输入框和地球按钮入口。
- 定义普通数据库与 DBC 两个强类型 Delegate。
- 保留现有普通数据库动态行编辑器语义。
- 新增独立的 `DbcLocaleFieldEditor`，固定为“语言编号 + 当前字段”两列。
- 视复用价值提取共享弹窗外壳，不共享两类编辑器的数据主体和保存逻辑。
- 支持 DBC 单行和多行字段配置。
- 增加 DBC 保存后的状态同步回调。

### 阶段 3：两个试点页面

优先选择：

1. `AreaTable`：只有一个本地化字段，验证基本读写流程。
2. `Spell`：包含四个独立本地化字段，验证多个地球按钮、长文本和状态合并。

### 阶段 4：覆盖现有可编辑页面

范围说明：**不是**「第 8 节 23 个字段全部有 UI 入口」，而是：

1. 第 8 节全部字段在 `DbcLocaleFields` / Delegate / Repository 层注册完毕（Schema 覆盖测试强制）。
2. **当前已有详情编辑页**的本地化字段全部改为「主语言输入框 + 地球按钮」。
3. 尚无详情页的模块（如 `CharTitles`、`Faction`、`Map`、`SpellRange`、`ItemRandomProperties/Suffix`）只具备底层能力；新建详情页时应直接复用对应 Delegate。

已接入详情页（共 12 个编辑器入口）：

| 页面 | 字段数 | Delegate |
|---|---:|---|
| AreaTable | 1 | `dbcAreaTableAreaName` |
| Spell | 4 | `dbcSpellName` 等 |
| Achievement | 3 | `dbcAchievementTitle` 等 |
| ItemSet | 1 | `dbcItemSetName` |
| QuestInfo | 1 | `dbcQuestInfoInfoName` |
| QuestSort | 1 | `dbcQuestSortSortName` |
| SpellItemEnchantment | 1 | `dbcSpellItemEnchantmentName` |

- 删除页面中直接展示多种语言的重复输入框。
- 页面主表单只保留当前主要语言输入框和地球按钮。

### 阶段 5：导入导出回归

- 导入 DBC。
- 通过字段编辑器修改多个语言值。
- 导出 DBC。
- 使用 `warcrafty` 回读并验证相同字段和语言槽位的内容。

## 11. 测试要求

### 11.1 Codec 单元测试

- 16 个语言列能够按固定编号正确解码。
- 解码后重新编码得到完全相同的 16 个字符串列。
- 更新一个语言不会改变其他语言。
- 一个字段的 Codec 不会包含另一个本地化字段的列。
- Flags 和普通字段不会出现在更新 Map 中。
- Schema 缺少语言列或字段类型不正确时返回明确错误。

### 11.2 Repository 测试

- 保存 `Name_lang_*` 不改变 `Description_lang_*`。
- 保存 locale 不改变普通数值字段。
- 清空一种语言能够写入空字符串。
- 一次保存使用单条局部 UPDATE 完成。

### 11.3 Widget 测试

- 普通数据库 Delegate 打开动态行编辑器，DBC Delegate 打开固定行编辑器。
- 普通数据库编辑器原有的添加和删除行为保持不变。
- 弹窗只显示语言列和当前字段列。
- 固定显示 16 个唯一语言编号。
- 不显示添加、删除语言按钮。
- 长文本字段使用多行输入。
- 保存 `zhCN` 后主页面 Controller 同步更新。
- 新记录尚无 ID 时地球按钮不可用。
- 主输入框有未保存草稿时打开弹窗，`zhCN` 行显示草稿而非库中旧值；仅改其它语言并保存后，草稿不被冲掉。

### 11.4 端到端回归

- DBC 导入、编辑和导出完整往返不丢失未编辑语言。
- 编辑一个本地化字段不影响同一记录的其他本地化字段。
- locale 弹窗保存后再保存主页面，不会回滚 locale 修改。

## 12. 完成标准

本方案实施完成时应满足：

- Schema 中出现的全部本地化字段均已在 `DbcLocaleFields` 注册（覆盖测试强制）。
- **现有 DBC 详情编辑页**上的本地化字段都使用输入框尾部的地球按钮编辑；无详情页的字段仅完成 Repository/Delegate 预埋。
- 普通数据库和 DBC 共用 `FoxyLocalePicker` 入口，但使用独立的强类型 Delegate 和编辑器主体。
- 每个弹窗只编辑一个字段，界面固定为“语言编号 + 当前字段”两列。
- 16 个语言槽位顺序与 DBC Schema 一致。
- 不新增 DBC locale 分表，不修改现有导入导出物理结构。
- 保存采用字段组级局部更新，不覆盖其他字段。
- Flags 默认保持不变。
- 页面 Entity、主要语言 Controller 和数据库状态保持同步。
- 打开弹窗时合并主输入框草稿到主语言槽位，避免未保存的主语言被库中旧值冲掉。
- 加载/保存失败时在 UI 中提示错误，不静默失败；保存失败时保留弹窗与用户已编辑内容。
- 导入、编辑、导出并回读后数据保持一致。
