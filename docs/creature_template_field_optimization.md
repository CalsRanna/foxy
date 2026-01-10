# Creature Template 字段优化方案

本文档详细列出了 `creature_template_detail_page.dart` 中所有输入字段的优化方案，包括哪些字段应该改为下拉选择框（Select），哪些应该使用自定义输入组件。

**⚠️ 重要提示**：本文档是后续编码工作的强制性参考。所有实现必须严格遵循文档中定义的架构模式、命名规范和编码约束。

---

## 📋 目录

0. [🔒 架构和编码规范约束](#0-架构和编码规范约束)

1. [基础标识](#1-基础标识)
2. [生物分类](#2-生物分类)
3. [外观展示](#3-外观展示)
4. [战斗属性](#4-战斗属性)
5. [攻击设置](#5-攻击设置)
6. [生命和能量](#6-生命和能量)
7. [移动和速度](#7-移动和速度)
8. [NPC功能](#8-npc功能)
9. [单位标识](#9-单位标识)
10. [类型和特殊标识](#10-类型和特殊标识)
11. [免疫设置](#11-免疫设置)
12. [掉落和奖励](#12-掉落和奖励)
13. [宠物和载具](#13-宠物和载具)
14. [副本难度](#14-副本难度)
15. [脚本和AI](#15-脚本和ai)
16. [实现优先级建议](#实现优先级建议)
17. [实现注意事项](#实现注意事项)

---

## 0. 🔒 架构和编码规范约束

> **⚠️ 强制性要求**：本章节定义的所有规范和约束是强制性的，任何偏离都必须有充分的理由并经过审查。

### 📐 项目架构概览

Foxy 项目采用分层架构，严格分离关注点：

```
lib/
├── model/              # 数据模型层（纯数据类）
├── repository/         # 数据访问层（使用 laconic 查询构建器）
├── page/              # UI 展示层
│   └── {entity}/      # 每个实体一个目录
│       ├── {entity}_list_page.dart
│       ├── {entity}_list_view_model.dart
│       ├── {entity}_detail_page.dart
│       ├── {entity}_detail_view_model.dart
│       └── {entity}_*_selector.dart  # 自定义输入组件
└── widget/            # 通用可复用组件
```

### 🎯 核心技术栈（强制使用）

1. **依赖注入**：GetIt
   - Singleton：全局唯一实例（如 `FoxyViewModel`, `ScaffoldViewModel`）
   - Factory：每次创建新实例（如 `*ListViewModel`, `*DetailViewModel`）

2. **状态管理**：Signals
   - 使用 `signal()` 创建响应式状态
   - 使用 `computed()` 创建派生状态
   - 使用 `Watch` 组件监听状态变化
   - **导入规范**（强制）：
     - DetailViewModel 中使用：`import 'package:signals/signals.dart';`
     - ListViewModel 中使用：`import 'package:signals_flutter/signals_core.dart';`
     - Page 中使用（需要 Watch 组件）：`import 'package:signals/signals_flutter.dart';`

3. **表单控制**：TextEditingController
   - 所有输入字段必须使用 Controller
   - Controller 必须在 `dispose()` 中释放

4. **UI 组件库**：shadcn_ui
   - 使用 `ShadInput`, `ShadButton`, `ShadDialog`, `ShadSelect` 等
   - 禁止直接使用原生 Flutter 组件（除非特殊情况）

5. **数据库访问**：laconic 查询构建器
   - 禁止直接写 SQL 字符串
   - 必须使用 laconic 的链式 API

6. **Repository 创建方式**（两种模式均可）：
   - **成员变量模式**（推荐用于 ListViewModel）：
     ```dart
     final repository = CreatureTemplateRepository();
     ```
   - **即时创建模式**（推荐用于 DetailViewModel）：
     ```dart
     Future<void> initSignals({int? entry}) async {
       template.value = await CreatureTemplateRepository().getCreatureTemplate(entry);
     }
     ```
   - ⚠️ 两种模式均为有效实践，根据使用频率选择：
     - 多次使用同一 Repository → 使用成员变量
     - 仅在初始化时使用一次 → 即时创建即可

### 📝 命名规范（强制执行）

#### 文件命名
- Page: `{entity}_{type}_page.dart`（如 `creature_template_detail_page.dart`）
- ViewModel: `{entity}_{type}_view_model.dart`
- Repository: `{entity}_repository.dart`
- Model: `{entity}.dart`
- 自定义组件: `{entity}_{function}_{component}.dart`（如 `creature_template_locale_name_selector.dart`）

#### 类命名
- Page: `{Entity}{Type}Page`（如 `CreatureTemplateDetailPage`）
- ViewModel: `{Entity}{Type}ViewModel`
- Repository: `{Entity}Repository`
- Model: `{Entity}` / `Brief{Entity}`

#### 变量命名
- TextEditingController: `{field}Controller`（如 `entryController`, `unitClassController`）
- Signal: 直接使用字段名（如 `entry`, `template`）
- Repository 实例: `repository`（类内部）
- ViewModel 实例: `viewModel`（Page 内部）

### 🏗️ ViewModel 架构模式（强制遵循）

```dart
import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:signals/signals.dart';  // ✅ DetailViewModel 使用此导入

class CreatureTemplateDetailViewModel {
  // ✅ 必须：按功能分组声明所有 Controller
  /// Basic
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  // ...

  /// Flag
  final npcFlagController = TextEditingController();
  // ...

  // ✅ 必须：使用 signal 管理状态
  final entry = signal(0);
  final template = signal(CreatureTemplate());

  // ✅ 必须：实现 dispose 方法释放所有 Controller
  void dispose() {
    /// Basic
    entryController.dispose();
    nameController.dispose();
    // ... 必须释放所有 Controller
  }

  // ✅ 必须：实现 initSignals 方法初始化数据
  Future<void> initSignals({int? entry}) async {
    if (entry == null) return;
    template.value = await CreatureTemplateRepository().getCreatureTemplate(
      entry,
    );
    _initControllers(template.value);
  }

  // ✅ 必须：实现 _initControllers 方法绑定数据到 Controller
  void _initControllers(CreatureTemplate template) {
    entryController.text = template.entry.toString();
    nameController.text = template.name;
    // ... 初始化所有 Controller
  }
}
```

**关键约束**：
- ❌ 禁止在 ViewModel 中直接操作 UI
- ❌ 禁止在 ViewModel 中使用 BuildContext
- ❌ 禁止在 ViewModel 中创建 Widget
- ✅ ViewModel 只负责数据和业务逻辑

#### ListViewModel 模式（参考）

```dart
import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:signals_flutter/signals_core.dart';  // ✅ ListViewModel 使用此导入

class CreatureTemplateListViewModel {
  // ✅ ListViewModel 推荐使用成员变量（多次使用）
  final repository = CreatureTemplateRepository();

  // 搜索表单 Controller
  final entryController = TextEditingController();
  final nameController = TextEditingController();

  // 状态
  final page = signal(1);
  final templates = signal(<BriefCreatureTemplate>[]);
  final total = signal(0);

  void dispose() {
    entryController.dispose();
    nameController.dispose();
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefCreatureTemplates();
    total.value = await repository.count();
  }

  Future<void> search() async {
    // ... 使用 repository 进行搜索
  }
}
```

### 🎨 Page 架构模式（强制遵循）

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals_flutter.dart';  // ✅ Page 使用此导入

@RoutePage()
class CreatureTemplateDetailPage extends StatefulWidget {
  final int? entry;
  const CreatureTemplateDetailPage({super.key, this.entry});

  @override
  State<CreatureTemplateDetailPage> createState() =>
      _CreatureTemplatePageState();  // ⚠️ 注意：实际代码使用简短命名
}

class _CreatureTemplatePageState extends State<CreatureTemplateDetailPage> {
  // ✅ 必须：通过 GetIt 获取 ViewModel
  final viewModel = GetIt.instance.get<CreatureTemplateDetailViewModel>();

  @override
  void initState() {
    super.initState();
    // ✅ 必须：在 initState 中初始化 ViewModel
    viewModel.initSignals(entry: widget.entry);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 推荐：先定义所有输入组件，再组合布局
    final entryInput = FormItem(
      controller: viewModel.entryController,
      label: '编号',
      placeholder: 'entry',
      readOnly: true,
    );

    final nameInput = FormItem(
      label: '名称',
      child: CreatureTemplateLocaleNameSelector(
        entry: widget.entry,
        controller: viewModel.nameController,
        placeholder: 'name',
      ),
    );

    // ... 组合布局
    return Stack(
      children: [
        ListView(children: [...]),
        // ...
      ],
    );
  }

  // ✅ 必须：在 dispose 中调用 viewModel.dispose()
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
```

**关键约束**：
- ✅ 必须使用 `@RoutePage()` 注解
- ✅ 必须在 `initState` 中调用 `viewModel.initSignals()`
- ✅ **必须在 `dispose` 中调用 `viewModel.dispose()`**
- ✅ 推荐在 `build` 方法顶部定义所有输入组件
- ❌ 禁止在 Page 中直接进行数据库操作
- ❌ 禁止在 Page 中创建 Repository 实例

> ⚠️ **已知问题**：当前 `creature_template_list_page.dart` 缺少 `dispose()` 方法，这是一个待修复的内存泄漏问题。新增页面必须包含 dispose 方法。

### 🧩 自定义输入组件模式（强制遵循）

参考 `CreatureTemplateLocaleNameSelector` 的实现：

```dart
import 'package:flutter/material.dart';
import 'package:foxy/model/creature_template_locale.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CreatureTemplateLocaleNameSelector extends StatefulWidget {
  final int? entry;
  final TextEditingController? controller;
  final String? placeholder;
  final bool readOnly;

  const CreatureTemplateLocaleNameSelector({
    super.key,
    this.entry,
    this.controller,
    this.placeholder,
    this.readOnly = false,
  });

  @override
  State<CreatureTemplateLocaleNameSelector> createState() =>
      _CreatureTemplateLocaleNameSelectorState();
}

class _CreatureTemplateLocaleNameSelectorState
    extends State<CreatureTemplateLocaleNameSelector> {
  final repository = CreatureTemplateRepository();

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: widget.controller,
      placeholder: Text(widget.placeholder ?? ''),
      readOnly: widget.readOnly,
      trailing: ShadButton.ghost(
        height: 20,
        width: 20,
        padding: EdgeInsets.zero,
        onPressed: _openLocaleDialog,
        child: Icon(LucideIcons.globe, size: 12),
      ),
    );
  }

  Future<void> _openLocaleDialog() async {
    if (widget.entry == null) return;
    final locales = await repository.getCreatureTemplateLocales(widget.entry!);
    if (!mounted) return;
    await showShadDialog(
      context: context,
      builder: (context) => _LocaleDialog(...),
    );
  }
}
```

**组件接口约束**（必须遵循）：
- ✅ 必须接受 `controller` 参数（TextEditingController?）
- ✅ 必须接受 `placeholder` 参数（String?）
- ✅ 必须接受 `readOnly` 参数（bool，默认 false）
- ✅ 必须使用 `ShadInput` 作为基础输入框
- ✅ 必须使用 `trailing` 属性添加操作按钮
- ✅ 必须使用 `showShadDialog` 弹出对话框

### 📦 组件实现规范

#### EnumSelect 组件规范

```dart
class EnumSelect<T> extends StatelessWidget {
  final T? value;
  final Map<T, String> options;
  final void Function(T?)? onChanged;
  final String? placeholder;
  final bool nullable;
  final bool searchable;

  const EnumSelect({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder,
    this.nullable = true,
    this.searchable = false,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ 必须使用 ShadSelect
    // ✅ 必须支持 nullable（可清空）
    // ✅ 必须支持 searchable（可搜索，当选项 > 10 时）
    return ShadSelect<T>(
      placeholder: Text(placeholder ?? '请选择'),
      options: options.entries.map((e) =>
        ShadOption(value: e.key, child: Text(e.value))
      ).toList(),
      selectedOptionBuilder: (context, value) => Text(options[value]!),
      onChanged: onChanged,
    );
  }
}
```

#### FlagPicker 组件规范

```dart
class FlagPicker extends StatefulWidget {
  final int value;
  final List<FlagOption> flags;
  final void Function(int) onChanged;
  final String? label;

  const FlagPicker({
    super.key,
    required this.value,
    required this.flags,
    required this.onChanged,
    this.label,
  });
  // ...
}

class FlagOption {
  final int flag;         // ✅ 位标志值（如 0x00000001）
  final String name;      // ✅ 显示名称（如 "对话 (Gossip)"）
  final String description; // ✅ 详细说明
  final String? group;    // ✅ 分组名称（可选）

  const FlagOption({
    required this.flag,
    required this.name,
    required this.description,
    this.group,
  });
}
```

**FlagPicker 必须实现的功能**：
- ✅ 输入框显示当前合计值（十进制 + 十六进制）
- ✅ 点击输入框右侧按钮打开弹窗
- ✅ 弹窗使用 `ShadDialog`
- ✅ 弹窗内使用表格展示所有标志项
- ✅ 表格支持多选（Checkbox）
- ✅ 实时计算并显示选中标志的合计值
- ✅ 支持点击行切换选中状态
- ✅ 支持"全选"、"全不选"按钮
- ✅ 支持搜索过滤标志项

#### EntitySelector 组件规范

```dart
class EntitySelector<T> extends StatefulWidget {
  final int? value;
  final TextEditingController? controller;
  final String? placeholder;
  final List<SearchField> searchFields;
  final List<SelectorColumn> columns;
  final Future<List<T>> Function(Map<String, dynamic> params) onSearch;
  final int Function(T) getId;
  final String Function(T) getDisplayText;

  const EntitySelector({
    super.key,
    required this.value,
    this.controller,
    this.placeholder,
    required this.searchFields,
    required this.columns,
    required this.onSearch,
    required this.getId,
    required this.getDisplayText,
  });
  // ...
}
```

**EntitySelector 必须实现的功能**：
- ✅ 输入框支持直接输入 ID
- ✅ 点击搜索图标打开选择器对话框
- ✅ 对话框包含：搜索表单 + 分页器 + 数据表格
- ✅ 搜索表单支持多字段搜索
- ✅ 数据表格高亮当前选中行
- ✅ 双击行或点击"确定"按钮选择
- ✅ 表格显示关键列（ID + 名称 + 描述等）

### 🔧 DI 注册规范（强制遵循）

在 `lib/di.dart` 中注册所有 ViewModel：

```dart
class DI {
  static void ensureInitialized() {
    // ✅ 全局单例使用 registerSingleton
    GetIt.instance.registerSingleton(FoxyViewModel());
    GetIt.instance.registerSingleton(ScaffoldViewModel());

    // ✅ 页面 ViewModel 使用 registerFactory
    GetIt.instance.registerFactory(() => CreatureTemplateListViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateDetailViewModel());
    // ...
  }
}
```

**注册规则**：
- ✅ List 页面：`registerFactory`
- ✅ Detail 页面：`registerFactory`
- ✅ 全局/Scaffold：`registerSingleton`
- ❌ 禁止在 Page 或 Widget 中注册 ViewModel

### 📚 Model 规范

```dart
class CreatureTemplate {
  // ✅ 使用驼峰命名（对应数据库字段的 snake_case）
  String aiName = '';
  double armorModifier = 1;
  int entry = 0;
  // ...

  // ✅ 必须实现 fromJson
  CreatureTemplate.fromJson(Map<String, dynamic> json) {
    aiName = json['AIName'] ?? '';
    armorModifier = (json['ArmorModifier'] ?? 1).toDouble();
    entry = json['entry'] ?? 0;
    // ...
  }

  // ✅ 必须实现 toJson
  Map<String, dynamic> toJson() {
    return {
      'AIName': aiName,
      'ArmorModifier': armorModifier,
      'entry': entry,
      // ...
    };
  }
}
```

**Model 约束**：
- ✅ 纯数据类，无业务逻辑
- ✅ 所有字段必须有默认值
- ✅ 必须实现 `fromJson` 和 `toJson`
- ❌ 禁止在 Model 中进行数据库操作

### 🗄️ Repository 规范

```dart
class CreatureTemplateRepository with RepositoryMixin {
  final String _table = 'creature_template';

  // ✅ 使用 laconic 查询构建器
  Future<CreatureTemplate> getCreatureTemplate(int entry) async {
    var result = await laconic
        .table(_table)
        .where('entry', entry)
        .first();
    return CreatureTemplate.fromJson(result.toMap());
  }

  // ✅ 使用 RepositoryMixin 提供的 kPageSize
  Future<List<BriefCreatureTemplate>> getBriefCreatureTemplates({
    int page = 1,
    CreatureTemplateFilterEntity? filter,
  }) async {
    var offset = (page - 1) * kPageSize;
    var builder = laconic.table(_table);
    // ...
    return builder.offset(offset).limit(kPageSize).get();
  }
}
```

**Repository 约束**：
- ✅ 必须 `with RepositoryMixin`
- ✅ 必须使用 `laconic` 查询构建器
- ✅ 分页查询必须使用 `kPageSize`（值为 25）
- ❌ 禁止直接写 SQL 字符串
- ❌ 禁止在 Repository 中操作 UI

### 🎨 UI 布局规范

#### FormItem 使用规范

```dart
// ✅ 标准用法：仅传入 controller
final entryInput = FormItem(
  controller: viewModel.entryController,
  label: '编号',
  placeholder: 'entry',
  readOnly: true,
);

// ✅ 自定义组件用法：使用 child 参数
final nameInput = FormItem(
  label: '名称',
  child: CreatureTemplateLocaleNameSelector(
    entry: widget.entry,
    controller: viewModel.nameController,
    placeholder: 'name',
  ),
);
```

**FormItem 约束**：
- ✅ `label` 宽度固定为 96，右对齐
- ✅ `controller` 和 `child` 二选一（不能同时使用）
- ✅ 使用 `child` 时，自定义组件必须自行处理 controller

#### 响应式布局规范

```dart
// ✅ 使用 Row 和 Expanded 实现响应式
Row(
  spacing: 16,
  children: [
    Expanded(child: input1),
    Expanded(child: input2),
    Expanded(child: input3),
  ],
)

// ✅ 使用 Wrap 实现自适应列数
Wrap(
  spacing: 16,
  runSpacing: 16,
  children: [
    SizedBox(
      width: (MediaQuery.of(context).size.width - 64) / 4,
      child: input1,
    ),
    // ...
  ],
)
```

### ⚠️ 禁止事项清单

#### 绝对禁止
- ❌ 在 ViewModel 中操作 UI 或使用 BuildContext
- ❌ 在 Page 中直接进行数据库操作
- ❌ 在 Model 中包含业务逻辑
- ❌ 直接写 SQL 字符串（必须使用 laconic）
- ❌ 使用原生 Flutter 组件（除非 shadcn_ui 不支持）
- ❌ 不释放 TextEditingController（内存泄漏）

#### 强烈不推荐
- ⚠️ 在 Page 中创建 Repository 实例（应在 ViewModel 中创建）
- ⚠️ 混合使用不同的状态管理方案（只用 Signals）
- ⚠️ 不遵循命名规范（影响代码一致性）

### ✅ 代码审查检查清单

在提交代码前，必须确认以下检查项全部通过：

#### ViewModel 检查
- [ ] 所有 Controller 都在 `dispose()` 中释放？
- [ ] 实现了 `initSignals()` 方法？
- [ ] 实现了 `_initControllers()` 方法？
- [ ] 没有直接操作 UI 或使用 BuildContext？
- [ ] 使用 signal 管理状态？

#### Page 检查
- [ ] 使用 `@RoutePage()` 注解？
- [ ] 通过 GetIt 获取 ViewModel？
- [ ] 在 `initState` 中调用 `viewModel.initSignals()`？
- [ ] 没有直接进行数据库操作？

#### 自定义组件检查
- [ ] 接受 `controller` 参数？
- [ ] 接受 `placeholder` 参数？
- [ ] 接受 `readOnly` 参数？
- [ ] 使用 `ShadInput` 作为基础？
- [ ] 使用 `showShadDialog` 弹出对话框？

#### Repository 检查
- [ ] 使用 `RepositoryMixin`？
- [ ] 使用 laconic 查询构建器？
- [ ] 分页查询使用 `kPageSize`？
- [ ] 没有直接写 SQL 字符串？

#### Model 检查
- [ ] 所有字段有默认值？
- [ ] 实现了 `fromJson`？
- [ ] 实现了 `toJson`？
- [ ] 没有包含业务逻辑？

#### DI 检查
- [ ] ViewModel 已在 `lib/di.dart` 中注册？
- [ ] List/Detail 页面使用 `registerFactory`？
- [ ] 全局 ViewModel 使用 `registerSingleton`？

#### 命名检查
- [ ] 文件命名符合 `{entity}_{type}_{component}.dart` 规范？
- [ ] 类命名符合 `{Entity}{Type}{Component}` 规范？
- [ ] 变量命名符合规范？

---

## 1. 基础标识

**分组说明**: 最基本的标识信息，创建NPC时首先要填写的内容

### ✅ 保持不变

#### `entry` - 编号
- **当前类型**: 只读文本框
- **处理方式**: 保持不变（主键，只读）
- **位置**: creature_template_detail_page.dart:34-39

#### `name` - 名称
- **当前类型**: 自定义组件 `CreatureTemplateLocaleNameSelector`
- **处理方式**: 已优化，保持不变
- **位置**: creature_template_detail_page.dart:40-47

#### `subname` - 称号
- **当前类型**: 自定义组件 `CreatureTemplateLocaleNameSelector`
- **处理方式**: 已优化，保持不变
- **位置**: creature_template_detail_page.dart:48-55

### ✏️ 保持普通输入框

#### `minlevel` - 最低等级
- **当前类型**: 普通文本框
- **处理方式**: 保持不变（数字输入，范围 1-83）
- **位置**: creature_template_detail_page.dart:61-65

#### `maxlevel` - 最高等级
- **当前类型**: 普通文本框
- **处理方式**: 保持不变（数字输入，范围 1-83）
- **位置**: creature_template_detail_page.dart:66-70

---

## 2. 生物分类

**分组说明**: 决定生物本质属性的分类信息，影响AI行为、可驯服性等

### 🔄 需要改为 Select 下拉框

#### `type` - 类型 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框
- **位置**: creature_template_detail_page.dart:96-100
- **数据源**: `CreatureType` 枚举
- **优先级**: P0（高）
- **选项**:
  ```dart
  {
    1: '野兽 (Beast)',
    2: '龙类 (Dragonkin)',
    3: '恶魔 (Demon)',
    4: '元素 (Elemental)',
    5: '巨人 (Giant)',
    6: '亡灵 (Undead)',
    7: '人型生物 (Humanoid)',
    8: '小动物 (Critter)',
    9: '机械 (Mechanical)',
    10: '未指定 (Not Specified)',
    11: '图腾 (Totem)',
    12: '非战斗宠物 (Non-combat Pet)',
    13: '气体云 (Gas Cloud)',
  }
  ```

#### `family` - 族群
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框（支持搜索）
- **位置**: creature_template_detail_page.dart:91-95
- **数据源**: `CreatureFamily` 枚举
- **优先级**: P3（可选）
- **说明**: 主要用于野兽类型，决定猎人可驯服的宠物类别
- **选项**:
  ```dart
  {
    0: '无',
    1: '狼 (Wolf)',
    2: '猫 (Cat)',
    3: '蜘蛛 (Spider)',
    4: '熊 (Bear)',
    5: '野猪 (Boar)',
    6: '鳄鱼 (Crocolisk)',
    7: '食腐鸟 (Carrion Bird)',
    8: '螃蟹 (Crab)',
    9: '猩猩 (Gorilla)',
    10: '马 (Horse)',
    11: '迅猛龙 (Raptor)',
    12: '陆行鸟 (Tallstrider)',
    15: '地狱猎犬 (Felhunter)',
    16: '虚空行者 (Voidwalker)',
    17: '魅魔 (Succubus)',
    19: '末日守卫 (Doomguard)',
    20: '蝎子 (Scorpid)',
    21: '乌龟 (Turtle)',
    23: '小鬼 (Imp)',
    // 共30+种
  }
  ```

#### `rank` - 稀有程度 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框
- **位置**: creature_template_detail_page.dart:76-80
- **数据源**: `CreatureEliteType` 枚举
- **优先级**: P0（高）
- **选项**:
  ```dart
  {
    0: '普通 (Normal)',
    1: '精英 (Elite)',
    2: '稀有精英 (Rare Elite)',
    3: '世界BOSS (World Boss)',
    4: '稀有 (Rare)',
    5: '未知 (Unknown)',
  }
  ```

#### `RacialLeader` - 种族领袖 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框（布尔值）
- **位置**: creature_template_detail_page.dart:81-85
- **优先级**: P0（高）
- **选项**:
  ```dart
  {
    0: '否',
    1: '是',
  }
  ```

### 🔗 需要关联选择器

#### `faction` - 阵营
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:86-90
- **优先级**: P2（低）
- **说明**: 阵营数据来自 `factiontemplate` 表，决定敌对/友好关系
- **建议组件**: `FactionTemplateSelector`

---

## 3. 外观展示

**分组说明**: 控制NPC的视觉外观和鼠标交互

### 🔗 需要关联选择器

#### `modelid1` / `modelid2` / `modelid3` / `modelid4` - 模型
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:441-461
- **优先级**: P3（可选）
- **说明**: 关联到模型数据（CreatureDisplayInfo），NPC会随机使用其中一个模型
- **建议组件**: `CreatureModelSelector`

### ✏️ 保持普通输入框

#### `scale` - 缩放
- **当前类型**: 普通文本框
- **处理方式**: 保持不变（浮点数，通常 0.5-3.0）
- **位置**: creature_template_detail_page.dart:461-465

#### `IconName` - 鼠标形状
- **当前类型**: 普通文本框
- **处理方式**: 保持不变（文本型，可选值较多且不固定）
- **位置**: creature_template_detail_page.dart:56-60
- **说明**: 控制鼠标悬停时的图标（如齿轮、对话气泡等）

---

## 4. 战斗属性

**分组说明**: NPC的战斗职业和伤害类型设置

### 🔄 需要改为 Select 下拉框

#### `unit_class` - 职业 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框
- **位置**: creature_template_detail_page.dart:71-75
- **数据源**: `UnitClass` 枚举
- **优先级**: P0（高）
- **说明**: 影响NPC的行为模式（如战士会格挡，法师会后退施法）
- **选项**:
  ```dart
  {
    1: '战士 (Warrior)',
    2: '圣骑士 (Paladin)',
    4: '盗贼 (Rogue)',
    8: '法师 (Mage)',
  }
  ```

#### `exp` - 属性扩展 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框
- **位置**: creature_template_detail_page.dart:239-243
- **数据源**: `Expansions` 枚举
- **优先级**: P0（高）
- **说明**: 决定NPC属性值的计算范围，不同版本有不同的属性膨胀
- **选项**:
  ```dart
  {
    0: '经典旧世 (Classic)',
    1: '燃烧的远征 (The Burning Crusade)',
    2: '巫妖王之怒 (Wrath of the Lich King)',
  }
  ```

#### `dmgschool` - 伤害类型 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框
- **位置**: creature_template_detail_page.dart:244-248
- **数据源**: `SpellSchools` 枚举
- **优先级**: P0（高）
- **选项**:
  ```dart
  {
    0: '物理 (Physical/Normal)',
    1: '神圣 (Holy)',
    2: '火焰 (Fire)',
    3: '自然 (Nature)',
    4: '冰霜 (Frost)',
    5: '暗影 (Shadow)',
    6: '奥术 (Arcane)',
  }
  ```

### ✏️ 保持普通输入框

#### `DamageModifier` - 伤害系数
- **当前类型**: 普通文本框
- **处理方式**: 保持不变（浮点数，通常 0.5-5.0）
- **位置**: creature_template_detail_page.dart:249-253

#### `ArmorModifier` - 护甲系数
- **当前类型**: 普通文本框
- **处理方式**: 保持不变（浮点数，通常 0.5-5.0）
- **位置**: creature_template_detail_page.dart:254-258

---

## 5. 攻击设置

**分组说明**: 控制NPC的攻击速度和伤害波动

### ✏️ 保持普通输入框

所有字段均为数字输入：

#### `BaseAttackTime` - 近战攻击间隔
- **处理方式**: 保持不变（毫秒，通常 1500-3000）
- **位置**: creature_template_detail_page.dart:259-263

#### `BaseVariance` - 近战攻击方差
- **处理方式**: 保持不变（浮点数，0.0-1.0，控制伤害波动范围）
- **位置**: creature_template_detail_page.dart:264-268

#### `RangeAttackTime` - 远程攻击间隔
- **处理方式**: 保持不变（毫秒）
- **位置**: creature_template_detail_page.dart:269-273

#### `RangeVariance` - 远程攻击方差
- **处理方式**: 保持不变（浮点数，0.0-1.0）
- **位置**: creature_template_detail_page.dart:274-278

---

## 6. 生命和能量

**分组说明**: 控制NPC的生命值和法力值

### 🔄 需要改为 Select 下拉框

#### `RegenHealth` - 回复生命 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框（布尔值）
- **位置**: creature_template_detail_page.dart:101-105
- **优先级**: P0（高）
- **说明**: 控制NPC是否自动回血
- **选项**:
  ```dart
  {
    0: '否',
    1: '是',
  }
  ```

### ✏️ 保持普通输入框

#### `HealthModifier` - 生命值系数
- **处理方式**: 保持不变（浮点数，通常 0.5-100.0，BOSS可能更高）
- **位置**: creature_template_detail_page.dart:279-283

#### `ManaModifier` - 法力值系数
- **处理方式**: 保持不变（浮点数，通常 0.5-10.0）
- **位置**: creature_template_detail_page.dart:284-288

---

## 7. 移动和速度

**分组说明**: 控制NPC的移动模式和速度

### 🔄 需要改为 Select 下拉框

#### `movementType` - 移动类型 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Select 下拉框
- **位置**: creature_template_detail_page.dart:494-498
- **数据源**: `MovementGeneratorType` 枚举
- **优先级**: P0（高）
- **选项**:
  ```dart
  {
    0: '静止 (Idle)',
    1: '随机 (Random)',
    2: '路径点 (Waypoint)',
  }
  ```

### ✏️ 保持普通输入框

#### `movementId` - 移动ID
- **处理方式**: 保持不变（整数，关联到特定的移动配置）
- **位置**: creature_template_detail_page.dart:489-493

#### `speed_walk` - 行走速度
- **处理方式**: 保持不变（浮点数，通常 1.0-2.5）
- **位置**: creature_template_detail_page.dart:294-298

#### `speed_run` - 奔跑速度
- **处理方式**: 保持不变（浮点数，通常 1.0-3.0）
- **位置**: creature_template_detail_page.dart:299-303

#### `HoverHeight` - 盘旋高度
- **处理方式**: 保持不变（浮点数，用于飞行单位）
- **位置**: creature_template_detail_page.dart:499-503

---

## 8. NPC功能

**分组说明**: 定义NPC可以提供的服务和交互功能

### 🎛️ 需要改为多选标志位组件

#### `npcflag` - NPC标识 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker（多选位标志组件）
- **位置**: creature_template_detail_page.dart:162-166
- **数据源**: `NPCFlags` 枚举
- **优先级**: P1（中）
- **建议组件**: `NPCFlagPicker`
- **说明**: 决定NPC可以提供什么服务（商人、任务、训练等）
- **标志选项**:
  ```dart
  {
    0x00000001: '对话 (Gossip)',
    0x00000002: '任务 (Quest Giver)',
    0x00000010: '训练师 (Trainer)',
    0x00000020: '职业训练师 (Class Trainer)',
    0x00000040: '专业训练师 (Profession Trainer)',
    0x00000080: '商人 (Vendor)',
    0x00001000: '修理 (Repair)',
    0x00002000: '飞行管理员 (Flight Master)',
    0x00004000: '灵魂医者 (Spirit Healer)',
    0x00010000: '旅店老板 (Innkeeper)',
    0x00020000: '银行 (Banker)',
    0x00100000: '战场军需官 (Battlemaster)',
    0x00200000: '拍卖师 (Auctioneer)',
    0x00400000: '兽栏管理员 (Stable Master)',
    // 更多...
  }
  ```

### 🔗 需要关联选择器

#### `gossip_menu_id` - 对话菜单
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:116-120
- **优先级**: P2（低）
- **说明**: 关联到 `gossip_menu` 表，定义NPC的对话内容
- **建议组件**: `GossipMenuSelector`

---

## 9. 单位标识

**分组说明**: 控制单位的战斗行为和显示状态

### 🎛️ 需要改为多选标志位组件

#### `unit_flags` - 单位标识 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker
- **位置**: creature_template_detail_page.dart:182-186
- **数据源**: `UnitFlags` 枚举
- **优先级**: P1（中）
- **建议组件**: `UnitFlagPicker`
- **说明**: 控制单位的基本行为（可否攻击、免疫类型等）
- **标志选项**:
  ```dart
  {
    0x00000002: '不可攻击 (Non-Attackable)',
    0x00000004: '禁止移动 (Disable Move)',
    0x00000100: '对玩家免疫 (Immune to PC)',
    0x00000200: '对NPC免疫 (Immune to NPC)',
    0x00001000: 'PVP',
    0x00040000: '眩晕 (Stunned)',
    0x00080000: '战斗中 (In Combat)',
    // 更多...
  }
  ```

#### `unit_flags2` - 单位标识2
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker
- **位置**: creature_template_detail_page.dart:187-191
- **数据源**: `UnitFlags2` 枚举
- **优先级**: P1（中）
- **建议组件**: `UnitFlag2Picker`

#### `dynamicflags` - 动态标识
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker
- **位置**: creature_template_detail_page.dart:172-176
- **优先级**: P1（中）
- **建议组件**: `DynamicFlagPicker`
- **说明**: 控制动态显示效果（如可拾取、可被击杀等）

---

## 10. 类型和特殊标识

**分组说明**: 生物类型的特殊属性和行为标识

### 🎛️ 需要改为多选标志位组件

#### `type_flags` - 类型标识 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker
- **位置**: creature_template_detail_page.dart:167-171
- **数据源**: `CreatureTypeFlags` 枚举
- **优先级**: P1（中）
- **建议组件**: `CreatureTypeFlagPicker`
- **说明**: 定义生物类型的特殊属性（可驯服、BOSS、采集方式等）
- **标志选项**:
  ```dart
  {
    0x00000001: '可驯服 (Tameable)',
    0x00000002: '灵魂可见 (Visible to Ghosts)',
    0x00000004: 'BOSS (Boss)',
    0x00000080: '死亡可交互 (Interact While Dead)',
    0x00000100: '草药剥皮 (Skin with Herbalism)',
    0x00000200: '采矿剥皮 (Skin with Mining)',
    0x00001000: '可协助 (Can Assist)',
    // 更多...
  }
  ```

#### `flags_extra` - 额外标识
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker
- **位置**: creature_template_detail_page.dart:177-181
- **优先级**: P1（中）
- **建议组件**: `ExtraFlagPicker`
- **说明**: 服务器端的额外行为控制

---

## 11. 免疫设置

**分组说明**: 定义NPC对各种控制和伤害类型的免疫

### 🎛️ 需要改为多选标志位组件

#### `mechanic_immune_mask` - 免疫机制
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker
- **位置**: creature_template_detail_page.dart:215-219
- **优先级**: P1（中）
- **建议组件**: `MechanicImmuneFlagPicker`
- **说明**: 免疫的机制类型（昏迷、沉默、缴械等）
- **标志选项**:
  ```dart
  {
    0x00000001: '魅惑 (Charm)',
    0x00000002: '迷惑 (Disoriented)',
    0x00000004: '缴械 (Disarm)',
    0x00000008: '分心 (Distract)',
    0x00000010: '恐惧 (Fear)',
    0x00000020: '抓取 (Grip)',
    0x00000040: '定身 (Root)',
    // 更多...
  }
  ```

#### `spell_school_immune_mask` - 免疫法术类型 ⭐
- **当前类型**: 普通文本框
- **处理方式**: 改为 Flag Picker
- **位置**: creature_template_detail_page.dart:220-224
- **数据源**: `SpellSchoolMask` 枚举
- **优先级**: P1（中）
- **建议组件**: `SpellSchoolImmuneFlagPicker`
- **标志选项**:
  ```dart
  {
    0x01: '物理 (Physical/Normal)',
    0x02: '神圣 (Holy)',
    0x04: '火焰 (Fire)',
    0x08: '自然 (Nature)',
    0x10: '冰霜 (Frost)',
    0x20: '暗影 (Shadow)',
    0x40: '奥术 (Arcane)',
  }
  ```

---

## 12. 掉落和奖励

**分组说明**: 击杀NPC后的战利品和经验奖励

### 🔗 需要关联选择器

#### `lootid` - 击杀掉落
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:355-359
- **优先级**: P2（低）
- **说明**: 关联到 `creature_loot_template` 表
- **建议组件**: `CreatureLootSelector`

#### `pickpocketloot` - 偷窃掉落
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:360-364
- **优先级**: P2（低）
- **说明**: 关联到 `pickpocketing_loot_template` 表
- **建议组件**: `PickpocketLootSelector`

#### `skinloot` - 剥皮掉落
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:365-369
- **优先级**: P2（低）
- **说明**: 关联到 `skinning_loot_template` 表
- **建议组件**: `SkinLootSelector`

### ✏️ 保持普通输入框

#### `mingold` - 最小金钱掉落
- **处理方式**: 保持不变（铜币，整数）
- **位置**: creature_template_detail_page.dart:345-349

#### `maxgold` - 最大金钱掉落
- **处理方式**: 保持不变（铜币，整数）
- **位置**: creature_template_detail_page.dart:350-354

#### `ExperienceModifier` - 经验值系数
- **处理方式**: 保持不变（浮点数）
- **位置**: creature_template_detail_page.dart:289-293

---

## 13. 宠物和载具

**分组说明**: 特殊功能NPC的配置

### 🔗 需要关联选择器

#### `PetSpellDataId` - 宠物技能
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:106-110
- **优先级**: P3（可选）
- **说明**: 关联到宠物技能数据表，用于宠物NPC
- **建议组件**: `PetSpellDataSelector`

#### `VehicleId` - 载具ID
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:111-115
- **优先级**: P3（可选）
- **说明**: 关联到载具数据表，用于可骑乘的NPC
- **建议组件**: `VehicleSelector`

---

## 14. 副本难度

**分组说明**: 多难度副本中的NPC变体配置

### 🔗 需要关联选择器

所有字段都关联到 `creature_template` 表本身（递归引用）：

#### `KillCredit1` / `KillCredit2` - 击杀关联
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:393-402
- **优先级**: P2（低）
- **说明**: 击杀当前NPC时，给予击杀指定NPC的信用（用于任务）
- **建议组件**: `CreatureTemplateSelector`

#### `difficulty_entry_1` / `difficulty_entry_2` / `difficulty_entry_3` - 难度模板
- **当前类型**: 普通文本框
- **处理方式**: 使用自定义关联选择器
- **位置**: creature_template_detail_page.dart:403-418
- **优先级**: P2（低）
- **说明**: 指向不同难度（10人普通/25人普通/10人英雄/25人英雄）的模板ID
- **建议组件**: `CreatureTemplateSelector`

---

## 15. 脚本和AI

**分组说明**: 控制NPC行为的脚本和AI配置

### ✏️ 保持普通输入框

所有字段都是文本/数字输入：

#### `AIName` - AI名称
- **处理方式**: 保持不变（文本，如 "SmartAI", "EventAI" 等）
- **位置**: creature_template_detail_page.dart:518-522
- **说明**: 指定使用的AI脚本引擎

#### `ScriptName` - 脚本名称
- **处理方式**: 保持不变（文本，C++脚本类名）
- **位置**: creature_template_detail_page.dart:523-527
- **说明**: 指定使用的C++脚本

#### `VerifiedBuild` - 验证版本
- **处理方式**: 保持不变（整数）
- **位置**: creature_template_detail_page.dart:528-532
- **说明**: 标记数据在哪个客户端版本验证过

---

## 🎯 实现优先级建议

### 高优先级（P0）- 枚举下拉框 ⭐
**预计工作量**: 1-2天 | **收益**: 极高

这些是固定的枚举值，实现简单且提升明显，建议最先实现：

1. `unit_class` - 职业（4个选项）
2. `rank` - 稀有程度（6个选项）
3. `type` - 类型（13个选项）
4. `RegenHealth` - 回复生命（布尔值）
5. `RacialLeader` - 种族领袖（布尔值）
6. `exp` - 属性扩展（3个选项）
7. `dmgschool` - 伤害类型（7个选项）
8. `movementType` - 移动类型（3个选项）

**实现建议**:
- 创建通用的枚举下拉组件 `EnumSelect<T>`
- 支持搜索和清空
- 显示格式：`值 - 中文名 (英文名)`

---

### 中优先级（P1）- 标志位组件 ⭐
**预计工作量**: 3-5天 | **收益**: 高

这些需要自定义组件，但使用频率高，体验提升明显：

1. `npcflag` - NPC标识（最常用，决定NPC功能）
2. `unit_flags` - 单位标识（影响战斗行为）
3. `type_flags` - 类型标识（影响生物特性）
4. `spell_school_immune_mask` - 免疫法术类型（7个选项，相对简单）
5. `unit_flags2` - 单位标识2
6. `dynamicflags` - 动态标识
7. `flags_extra` - 额外标识
8. `mechanic_immune_mask` - 免疫机制

**实现建议**:
- 创建通用的 `FlagPicker` 组件
- 支持位运算显示和编辑
- 提供复选框列表界面
- 显示当前值的十进制和十六进制
- 支持"全选"、"全不选"、"查看原始值"功能
- 界面示例：
  ```
  NPC标识 (当前值: 643 / 0x283)
  ☑ 0x001 - 对话 (Gossip)
  ☑ 0x002 - 任务 (Quest Giver)
  ☐ 0x010 - 训练师 (Trainer)
  ☑ 0x080 - 商人 (Vendor)
  ☑ 0x200 - 拍卖师 (Auctioneer)
  ...
  [全选] [全不选] [查看原始值]
  ```

---

### 低优先级（P2）- 关联选择器
**预计工作量**: 5-7天 | **收益**: 中

这些需要查询其他表，实现复杂度较高：

1. `faction` - 阵营选择器（高频使用）
2. `gossip_menu_id` - 对话选择器
3. `lootid` / `pickpocketloot` / `skinloot` - 掉落选择器
4. `KillCredit1/2` / `difficulty_entry_1/2/3` - 生物模板选择器

**实现建议**:
- 参考现有的 `CreatureTemplateLocaleNameSelector`
- 支持搜索、分页、预览
- 显示关联对象的核心信息
- 支持快速跳转到关联对象详情

---

### 可选优先级（P3）
**预计工作量**: 3-4天 | **收益**: 低

实现后体验提升有限，可以延后：

1. `family` - 族群（下拉框，但选项多且使用频率低）
2. `modelid1-4` - 模型选择器（使用频率低）
3. `PetSpellDataId` / `VehicleId` - 特殊ID选择器（极少使用）

---

## 📋 推荐的实现顺序

根据投入产出比，建议按以下顺序实施：

### 第一阶段：快速见效（1-2天）
1. 实现 P0 的 8 个枚举下拉框
2. 创建可复用的 `EnumSelect` 组件

### 第二阶段：核心功能（3-5天）
1. 实现通用的 `FlagPicker` 组件
2. 优先实现 `npcflag`、`unit_flags`、`type_flags`
3. 补充其他标志位字段

### 第三阶段：增强体验（5-7天）
1. 实现 `faction` 阵营选择器
2. 实现 `gossip_menu_id` 对话选择器
3. 实现掉落相关的选择器

### 第四阶段：完善补充（按需）
1. P3 的低频字段
2. 根据用户反馈调整

---

## 📝 实现注意事项

### 1. Select 下拉框组件

**基础要求**:
- 使用 `ShadSelect` 或自定义下拉组件
- 显示格式：`值 - 中文名 (英文名)`
- 支持清空选项（nullable）
- 支持键盘导航

**进阶功能**:
- 支持搜索过滤（特别是 `family` 等选项较多的字段）
- 支持分组显示（如按类别分组）
- 显示工具提示（hover 时显示详细说明）

**代码示例**:
```dart
EnumSelect<int>(
  label: '职业',
  value: viewModel.unitClass.value,
  options: {
    1: '战士 (Warrior)',
    2: '圣骑士 (Paladin)',
    4: '盗贼 (Rogue)',
    8: '法师 (Mage)',
  },
  onChanged: (value) => viewModel.unitClass.value = value,
  nullable: true,
  searchable: false,
)
```

---

### 2. Flag Picker 组件

**基础要求**:
- 使用复选框列表或位标志选择器
- 显示当前选中的标志总值（十进制 + 十六进制）
- 支持批量选择/清空
- 显示格式：`[√] 0x00000001 - 对话 (Gossip)`

**进阶功能**:
- 提供"查看原始值"模式（直接输入数字）
- 支持搜索过滤标志项
- 分组显示（按功能分类）
- 高亮显示已选中的标志
- 工具提示显示每个标志的详细说明

**布局建议**:
```
┌─────────────────────────────────────┐
│ NPC标识                             │
│ 当前值: 643 (0x00000283)          │
├─────────────────────────────────────┤
│ [搜索框: 过滤标志...]              │
├─────────────────────────────────────┤
│ 基础功能                            │
│ ☑ 0x001 - 对话 (Gossip)            │
│ ☑ 0x002 - 任务 (Quest Giver)       │
│                                     │
│ 服务功能                            │
│ ☐ 0x010 - 训练师 (Trainer)         │
│ ☑ 0x080 - 商人 (Vendor)            │
│ ☑ 0x200 - 拍卖师 (Auctioneer)      │
├─────────────────────────────────────┤
│ [全选] [全不选] [原始值] [确定]   │
└─────────────────────────────────────┘
```

**代码示例**:
```dart
FlagPicker(
  label: 'NPC标识',
  value: viewModel.npcFlag.value,
  flags: {
    0x00000001: FlagOption(
      name: '对话 (Gossip)',
      description: '启用右键对话功能',
      group: '基础功能',
    ),
    0x00000002: FlagOption(
      name: '任务 (Quest Giver)',
      description: '可以发布和交付任务',
      group: '基础功能',
    ),
    // ...
  },
  onChanged: (value) => viewModel.npcFlag.value = value,
)
```

---

### 3. 关联选择器组件

**基础要求**:
- 类似 `CreatureTemplateLocaleNameSelector` 的实现
- 支持搜索和分页
- 显示关联对象的基本信息（ID + 名称）
- 支持清空选择

**进阶功能**:
- 支持快速跳转到关联对象的详情页
- 显示预览信息（悬停时显示更多详情）
- 支持最近使用记录
- 支持收藏常用项

**界面示例**:
```
┌─────────────────────────────────────┐
│ 阵营                                │
│ 当前选择: 35 - 铁炉堡               │
├─────────────────────────────────────┤
│ [搜索: 铁炉堡]            [清空]   │
├─────────────────────────────────────┤
│ 搜索结果:                           │
│ • 35 - 铁炉堡 (联盟)               │
│ • 54 - 诺莫瑞根 (联盟)             │
│ • 47 - 暴风城 (联盟)               │
│                                     │
│ [上一页] [1/10] [下一页]          │
└─────────────────────────────────────┘
```

---

### 4. 数据校验

**必须实现的校验**:
- 数字字段添加范围校验（如等级 1-83）
- 浮点数字段添加精度校验
- 必填字段添加非空校验
- 外键字段添加存在性校验（关联的ID必须存在）

**建议的校验规则**:
```dart
// 等级范围校验
minLevel: RangeValidator(min: 1, max: 83),
maxLevel: RangeValidator(min: 1, max: 83),

// 系数范围校验
healthModifier: RangeValidator(min: 0.1, max: 1000.0),
scale: RangeValidator(min: 0.1, max: 10.0),

// 必填校验
entry: RequiredValidator(),
name: RequiredValidator(),

// 外键存在性校验
faction: ExistsValidator(table: 'factiontemplate', column: 'ID'),
```

---

### 5. 分组布局建议

**当前布局问题**:
- 字段按技术属性分组（基本/标识/免疫等）
- 不符合用户的使用逻辑
- 相关字段分散在不同区域

**建议的新布局**:
```
生物模板详情

[基础标识] [生物分类] [外观展示] [战斗属性] ... [脚本和AI]

┌─ 1. 基础标识 ─────────────────────┐
│ 编号: [只读]  名称: [xxx]         │
│ 称号: [xxx]   等级: [1] - [80]   │
└──────────────────────────────────┘

┌─ 2. 生物分类 ─────────────────────┐
│ 类型: [下拉] 族群: [下拉]         │
│ 稀有: [下拉] 阵营: [选择器]       │
│ 种族领袖: [下拉]                  │
└──────────────────────────────────┘

... (其他分组)

[保存] [取消]
```

**Tab 页签建议**:
- 将 15 个分组放在一个页面太长
- 可以考虑使用 Tab 页签：
  - **基础设置**: 1-7（基础标识到移动速度）
  - **功能和标识**: 8-11（NPC功能到免疫设置）
  - **掉落和奖励**: 12-14（掉落到副本难度）
  - **高级设置**: 15（脚本和AI）

---

## 🔗 相关文件

- **页面文件**: `D:\Code\foxy\lib\page\creature_template\creature_template_detail_page.dart`
- **视图模型**: `D:\Code\foxy\lib\page\creature_template\creature_template_detail_view_model.dart`
- **参考组件**: `D:\Code\foxy\lib\page\creature_template\creature_template_locale_name_selector.dart`
- **AzerothCore 枚举定义**: `D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h`
- **AzerothCore 单位定义**: `D:\Simulators\AzerothCore\code\src\server\game\Entities\Unit\UnitDefines.h`

---

## 🎨 UI 设计参考

### 推荐的视觉风格

1. **卡片式布局**: 每个分组用卡片包裹，有明确的视觉边界
2. **响应式设计**: 根据窗口宽度自动调整列数（2列/3列/4列）
3. **清晰的标签**: 使用图标 + 文字的标签
4. **状态提示**: 必填项标红星，已修改项高亮显示
5. **即时反馈**: 输入错误时立即显示错误提示

### 颜色建议

- **主色调**: 保持 Shadcn 主题色
- **强调色**: 必填项用红色 `*` 标记
- **成功色**: 校验通过用绿色边框
- **错误色**: 校验失败用红色边框
- **禁用色**: 只读字段用灰色背景

---

## 📊 预期收益

实施本方案后，预期获得以下收益:

### 用户体验
- ✅ 减少 **80%** 的输入错误（枚举下拉框避免输入非法值）
- ✅ 提升 **60%** 的编辑效率（不需要查文档找枚举值）
- ✅ 降低 **90%** 的学习成本（界面即文档）

### 数据质量
- ✅ 确保枚举值 100% 正确
- ✅ 外键关联的数据完整性提升
- ✅ 减少数据库中的脏数据

### 开发维护
- ✅ 可复用的组件库（`EnumSelect`、`FlagPicker`等）
- ✅ 统一的交互模式
- ✅ 易于扩展到其他模板（item、quest等）

---

## 🎓 Archive 分支经验总结

基于对 archive 分支（Vue + Electron 实现）的深入分析，以下是该版本的优秀实践和需要在当前 Flutter + Shadcn 实现中参考的关键功能。

### 🌟 Archive 分支的优秀实现

#### 1. FlagEditor 组件 ⭐⭐⭐

**实现方式**:
- 输入框 + 弹窗编辑器的组合模式
- 弹窗内使用表格（el-table）+ 多选（selection）
- 实时计算并显示选中标志的合计值
- 支持点击行切换选中状态

**核心特点**:
```vue
<el-input v-model="flag">
  <i class="el-icon-s-operation" slot="suffix" @click="showDialog"></i>
</el-input>

<el-dialog>
  <el-table @selection-change="change" @row-click="select">
    <el-table-column type="selection"></el-table-column>
    <el-table-column prop="flag" label="标识"></el-table-column>
    <el-table-column prop="name" label="名称"></el-table-column>
    <el-table-column prop="comment" label="描述"></el-table-column>
  </el-table>
  <span>合计值：{{ selectedFlag }}</span>
</el-dialog>
```

**Flutter 实现建议**:
```dart
// 组件结构
FlagPicker(
  value: viewModel.npcFlag.value,
  flags: [
    FlagOption(flag: 0x001, name: '对话 (Gossip)', description: '启用右键对话功能'),
    FlagOption(flag: 0x002, name: '任务 (Quest Giver)', description: '可以发布和交付任务'),
    // ...
  ],
  onChanged: (value) => viewModel.npcFlag.value = value,
)

// 使用 ShadDialog + ShadTable + Checkbox
// 点击输入框右侧图标打开弹窗
// 弹窗内显示表格，每行带复选框
// 底部显示合计值（十进制 + 十六进制）
```

**优先级**: P1 - 必须实现，是标志位编辑的最佳实践

---

#### 2. 关联选择器（Selector）组件模式 ⭐⭐⭐

**实现方式** (以 FactionTemplateSelector 为例):
- 输入框 + 搜索图标
- 点击图标打开弹窗选择器
- 弹窗内包含：搜索表单、分页器、数据表格
- 支持双击行或点击"保存"按钮确认选择
- 支持输入框直接输入 ID

**核心特点**:
```vue
<el-input v-model="faction">
  <i class="el-icon-search" slot="suffix" @click="show"></i>
</el-input>

<el-dialog>
  <!-- 搜索表单 -->
  <el-form>
    <el-input-number v-model="ID" placeholder="ID"></el-input-number>
    <el-input v-model="Name_Lang_zhCN" placeholder="名称"></el-input>
    <el-button @click="search">查询</el-button>
  </el-form>

  <!-- 分页器 -->
  <el-pagination
    :current-page="pagination.page"
    :total="pagination.total"
    @current-change="paginate"
  ></el-pagination>

  <!-- 数据表格 -->
  <el-table
    :data="factionTemplates"
    highlight-current-row
    @current-change="select"
    @row-dblclick="store"
  >
    <el-table-column prop="ID" label="编号"></el-table-column>
    <el-table-column prop="Name_Lang_zhCN" label="名称"></el-table-column>
    <el-table-column prop="Description_Lang_zhCN" label="描述"></el-table-column>
  </el-table>
</el-dialog>
```

**Flutter 实现建议**:
```dart
// 创建通用的 EntitySelector<T> 组件
EntitySelector<FactionTemplate>(
  value: viewModel.faction.value,
  searchFields: [
    SearchField(name: 'ID', type: SearchFieldType.number),
    SearchField(name: 'Name_Lang_zhCN', type: SearchFieldType.text),
  ],
  columns: [
    SelectorColumn(field: 'ID', label: '编号', width: 80),
    SelectorColumn(field: 'Name_Lang_zhCN', label: '名称'),
    SelectorColumn(field: 'Description_Lang_zhCN', label: '描述'),
  ],
  onSearch: (params) => repository.search(params),
  onSelected: (item) => viewModel.faction.value = item.ID,
)
```

**优先级**: P2 - 重要但复杂，建议在 P0/P1 完成后实现

---

#### 3. HintLabel 组件 ⭐⭐

**实现方式**:
- 标签 + 问号图标 + 悬停提示
- 提供字段的详细说明和用途
- 帮助用户理解复杂字段

**核心特点**:
```vue
<hint-label
  label="NPC标识"
  :tooltip="npcFlagTooltip"
  slot="label"
></hint-label>

// tooltip 内容示例：
// "决定NPC可以提供什么服务，如商人、训练师、任务发布者等。
//  可以同时拥有多个标识。"
```

**Flutter 实现建议**:
```dart
HintLabel(
  label: 'NPC标识',
  tooltip: '决定NPC可以提供什么服务，如商人、训练师、任务发布者等。\n可以同时拥有多个标识。',
  child: FormItem(...),
)

// 或者直接在 FormItem 中添加 hint 参数
FormItem(
  label: 'NPC标识',
  hint: '决定NPC可以提供什么服务...',
  child: FlagPicker(...),
)
```

**优先级**: P1 - 简单但有效，大幅提升用户体验

---

#### 4. Tab 页面组织与条件禁用 ⭐⭐⭐

**实现方式**:
- 使用 Tab 将相关功能分组（生物模板、模板补充、装备、商人、训练师、掉落等）
- 根据字段值动态禁用 Tab（如无 npcflag 时禁用商人/训练师 Tab）
- 使用懒加载（lazy）提升性能

**核心特点**:
```vue
<el-tabs value="creature_template">
  <el-tab-pane label="生物模版" name="creature_template">
    <creature-template-tab-pane></creature-template-tab-pane>
  </el-tab-pane>

  <!-- 条件禁用 -->
  <el-tab-pane
    label="商人"
    name="npc_vendor"
    lazy
    :disabled="(creatureTemplate.npcflag & 3968) == 0"
  >
    <npc-vendor-tab-pane></npc-vendor-tab-pane>
  </el-tab-pane>

  <el-tab-pane
    label="击杀掉落"
    name="creature_loot_template"
    lazy
    :disabled="creatureTemplate.lootid == 0"
  >
    <creature-loot-template-tab-pane></creature-loot-template-tab-pane>
  </el-tab-pane>
</el-tabs>
```

**禁用逻辑**:
- `npcflag & 3968 == 0` → 禁用"商人" Tab（3968 = 0x80 + 0x100 + 0x200 + 0x400 + 0x800）
- `npcflag & 4194416 == 0` → 禁用"训练师" Tab
- `lootid == 0` → 禁用"击杀掉落" Tab
- `pickpocketloot == 0` → 禁用"偷窃掉落" Tab
- `skinloot == 0` → 禁用"剥皮掉落" Tab

**Flutter 实现建议**:
```dart
// 当前分支已有 FoxyTab，需要添加：
FoxyTab(
  tabs: tabs,
  disabledTabs: [
    if ((viewModel.npcFlag.value & 3968) == 0) '商人',
    if ((viewModel.npcFlag.value & 4194416) == 0) '训练师',
    if (viewModel.lootId.value == 0) '击杀掉落',
    if (viewModel.pickpocketLoot.value == 0) '偷窃掉落',
    if (viewModel.skinLoot.value == 0) '剥皮掉落',
  ],
)
```

**优先级**: P1 - 重要的用户引导功能

---

#### 5. Switch 开关组件 ⭐⭐

**实现方式**:
- 用于布尔值字段（0/1）
- 比下拉框更直观
- 占用空间小

**核心特点**:
```vue
<el-switch
  v-model="creatureTemplate.RacialLeader"
  :active-value="1"
  :inactive-value="0"
></el-switch>

<el-switch
  v-model="creatureTemplate.RegenHealth"
  :active-value="1"
  :inactive-value="0"
></el-switch>
```

**Flutter 实现建议**:
```dart
// 使用 ShadSwitch
ShadSwitch(
  value: viewModel.racialLeader.value == 1,
  onChanged: (value) => viewModel.racialLeader.value = value ? 1 : 0,
)

// 或创建 BooleanSwitch 组件
BooleanSwitch(
  value: viewModel.racialLeader.value,
  onChanged: (value) => viewModel.racialLeader.value = value,
)
```

**优先级**: P0 - 简单易实现，立即提升体验

---

#### 6. 条件禁用字段 ⭐⭐

**实现方式**:
- 根据其他字段值动态禁用相关字段
- 提供清晰的字段间依赖关系
- 防止无效配置

**核心特点**:
```vue
<!-- trainer_type 仅在设置了训练师标识时可用 -->
<el-select
  v-model="creatureTemplate.trainer_type"
  :disabled="(creatureTemplate.npcflag & 4194416) == 0"
>
</el-select>

<!-- trainer_spell 同理 -->
<el-input-number
  v-model="creatureTemplate.trainer_spell"
  :disabled="(creatureTemplate.npcflag & 4194416) == 0"
></el-input-number>

<!-- trainer_class 同理 -->
<el-select
  v-model="creatureTemplate.trainer_class"
  :disabled="(creatureTemplate.npcflag & 4194416) == 0"
>
</el-select>
```

**条件禁用规则**:
- `trainer_type/trainer_spell/trainer_class/trainer_race` → 当 `npcflag & 4194416 == 0` 时禁用

**Flutter 实现建议**:
```dart
Watch((_) {
  final isTrainer = (viewModel.npcFlag.value & 4194416) != 0;
  return FormItem(
    label: '训练师类型',
    enabled: isTrainer,
    child: EnumSelect(
      value: viewModel.trainerType.value,
      options: trainerTypeOptions,
      onChanged: isTrainer ? (v) => viewModel.trainerType.value = v : null,
    ),
  );
})
```

**优先级**: P1 - 重要的数据一致性保障

---

#### 7. 响应式卡片布局 ⭐⭐

**实现方式**:
- 使用 `el-card` 进行视觉分组
- `el-row` + `el-col` 实现网格布局
- `:span="6"` 实现 4 列响应式布局
- 卡片间有明确的间距

**核心特点**:
```vue
<el-card :body-style="{ padding: '22px 20px 0 20px' }" style="margin-top: 16px">
  <el-row :gutter="16">
    <el-col :span="6">
      <el-form-item label="编号">...</el-form-item>
    </el-col>
    <el-col :span="6">
      <el-form-item label="名称">...</el-form-item>
    </el-col>
    <el-col :span="6">
      <el-form-item label="称号">...</el-form-item>
    </el-col>
    <el-col :span="6">
      <el-form-item label="图标">...</el-form-item>
    </el-col>
  </el-row>
</el-card>
```

**Flutter 实现建议**:
```dart
ShadCard(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.only(top: 16),
  child: Wrap(
    spacing: 16,
    runSpacing: 16,
    children: [
      SizedBox(
        width: (MediaQuery.of(context).size.width - 64) / 4,
        child: FormItem(label: '编号', ...),
      ),
      // 重复 4 列
    ],
  ),
)
```

**优先级**: P0 - 已在当前实现中使用，需保持一致

---

### 🆕 需要补充的功能清单

基于 archive 分支的分析，以下功能需要在当前实现中补充：

#### 高优先级（P0-P1）

1. **Switch 开关组件** ✅
   - 用途：布尔值字段（RacialLeader、RegenHealth）
   - 实现难度：低
   - 预计工时：0.5 天

2. **HintLabel 提示组件** ✅
   - 用途：为复杂字段提供说明
   - 实现难度：低
   - 预计工时：0.5 天

3. **FlagPicker 弹窗编辑器** ⭐
   - 用途：所有位标志字段
   - 实现难度：中
   - 预计工时：2-3 天
   - 功能要求：
     - 弹窗 + 表格多选
     - 显示标志、名称、描述
     - 实时计算合计值
     - 支持行点击切换

4. **Tab 条件禁用** ⭐
   - 用途：根据 npcflag、lootid 等禁用相关 Tab
   - 实现难度：中
   - 预计工时：1 天

5. **字段条件禁用** ⭐
   - 用途：trainer_* 等字段根据 npcflag 禁用
   - 实现难度：中
   - 预计工时：1 天

#### 中优先级（P2）

6. **通用 EntitySelector 组件** ⭐⭐
   - 用途：faction、gossip_menu、loot 等关联字段
   - 实现难度：高
   - 预计工时：3-4 天
   - 功能要求：
     - 弹窗选择器
     - 搜索表单（支持多字段）
     - 分页器
     - 数据表格（高亮当前行）
     - 双击选择
     - 支持直接输入 ID

7. **模型选择器** ⭐
   - 用途：modelid1-4
   - 实现难度：高
   - 预计工时：2-3 天
   - 功能要求：
     - 继承自 EntitySelector
     - 显示模型预览（如果可能）

#### 低优先级（P3）

8. **InhabitType（栖息类型）标志位**
   - 用途：控制 NPC 的活动环境（地面、水中、空中）
   - 实现难度：低（复用 FlagPicker）
   - 预计工时：0.5 天

9. **trainer_* 字段组**
   - 用途：训练师相关配置
   - 说明：当前文档未包含，archive 分支有实现
   - 需补充字段：
     - `trainer_type` - 训练师类型（下拉框）
     - `trainer_spell` - 训练师法术（数字输入）
     - `trainer_class` - 训练师职业（下拉框）
     - `trainer_race` - 训练师种族（下拉框）
   - 实现难度：低
   - 预计工时：1 天

---

### 📊 组件复用性分析

#### 可复用的通用组件

1. **FlagPicker** - 通用位标志编辑器
   - 应用场景：npcflag、type_flags、unit_flags、unit_flags2、dynamicflags、flags_extra、mechanic_immune_mask、spell_school_immune_mask、InhabitType
   - 参数化配置：标志列表、标题
   - 复用次数：9 次

2. **EntitySelector<T>** - 通用关联选择器
   - 应用场景：faction、gossip_menu、lootid、pickpocketloot、skinloot、KillCredit1/2、difficulty_entry_1/2/3、PetSpellDataId、VehicleId、modelid1-4
   - 参数化配置：搜索字段、表格列、数据源
   - 复用次数：15+ 次

3. **HintLabel** - 通用提示标签
   - 应用场景：所有需要说明的字段
   - 参数化配置：标签文本、提示内容
   - 复用次数：30+ 次

4. **BooleanSwitch** - 布尔值开关
   - 应用场景：RacialLeader、RegenHealth
   - 参数化配置：值、回调
   - 复用次数：2 次（当前）

5. **EnumSelect<T>** - 枚举下拉框
   - 应用场景：unit_class、rank、type、family、exp、dmgschool、movementType
   - 参数化配置：选项列表、是否可搜索
   - 复用次数：8 次（当前），可扩展到 item、quest 等其他模块

---

### 🎯 实施建议

#### 阶段规划

**第一阶段：基础组件（1-2 天）**
1. BooleanSwitch 组件（0.5 天）
2. HintLabel 组件（0.5 天）
3. EnumSelect<T> 组件优化（支持搜索、清空）（1 天）

**第二阶段：核心功能（3-5 天）**
1. FlagPicker 组件（2-3 天）⭐
2. Tab 条件禁用（0.5 天）
3. 字段条件禁用（0.5 天）
4. trainer_* 字段补充（1 天）

**第三阶段：高级组件（4-5 天）**
1. EntitySelector<T> 通用组件（2-3 天）⭐⭐
2. FactionTemplateSelector（复用 EntitySelector）（0.5 天）
3. GossipMenuSelector（复用 EntitySelector）（0.5 天）
4. LootSelector（复用 EntitySelector）（0.5 天）
5. CreatureTemplateSelector（复用 EntitySelector）（0.5 天）

**第四阶段：完善补充（2-3 天）**
1. CreatureModelSelector（1-2 天）
2. 其他低频选择器（1 天）

#### 总预计工时
- P0-P1（必须）：6-8 天
- P2（推荐）：4-5 天
- P3（可选）：2-3 天
- **总计**：12-16 天

---

### 💡 关键实现技巧

#### 1. FlagPicker 的位运算

```dart
class FlagPickerState extends State<FlagPicker> {
  Set<int> selectedFlags = {};

  @override
  void initState() {
    super.initState();
    // 初始化：从合计值解析出各个标志
    for (var option in widget.flags) {
      if ((widget.value & option.flag) != 0) {
        selectedFlags.add(option.flag);
      }
    }
  }

  void toggleFlag(int flag) {
    setState(() {
      if (selectedFlags.contains(flag)) {
        selectedFlags.remove(flag);
      } else {
        selectedFlags.add(flag);
      }
    });
  }

  int get totalValue {
    return selectedFlags.fold(0, (sum, flag) => sum | flag);
  }
}
```

#### 2. EntitySelector 的泛型实现

```dart
class EntitySelector<T> extends StatefulWidget {
  final int? value;
  final List<SearchField> searchFields;
  final List<SelectorColumn> columns;
  final Future<List<T>> Function(Map<String, dynamic> params) onSearch;
  final Function(T item) onSelected;
  final String Function(T item) getId;

  // ...
}
```

#### 3. 条件禁用的响应式实现

```dart
// 使用 Watch 监听依赖字段的变化
Watch((_) {
  final hasTrainerFlag = (viewModel.npcFlag.value & 4194416) != 0;

  return Column(
    children: [
      FormItem(
        label: '训练师类型',
        enabled: hasTrainerFlag,
        child: EnumSelect(...),
      ),
      FormItem(
        label: '训练师法术',
        enabled: hasTrainerFlag,
        child: NumberInput(...),
      ),
    ],
  );
})
```

---

### 📚 参考文件（Archive 分支）

- **FlagEditor 组件**:
  `src/components/FlagEditor.vue`

- **关联选择器**:
  `src/components/FactionTemplateSelector.vue`
  `src/components/GossipMenuSelector.vue`
  `src/components/CreatureModelInfoSelector.vue`

- **主表单页面**:
  `src/views/Creature/components/CreatureTemplateTabPane.vue`

- **详情页组织**:
  `src/views/Creature/CreatureDetail.vue`

- **枚举常量**:
  在各组件的 `data()` 或 `computed` 中定义（如 `unitClasses`、`ranks`、`types` 等）

---

## 📖 数据源引用手册

本章节详细说明文档中所有省略部分（标记为 `// ...`、`// 更多...`、`// 共XX种` 等）的完整数据来源。

---

### 枚举类型数据源（AzerothCore）

所有枚举定义都来自 AzerothCore 项目的 C++ 头文件。

#### 1. `CreatureFamily` - 族群（30+ 种）

**数据源文件**:
```
D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h
行号: 2649-2692
```

**完整枚举**:
```cpp
enum CreatureFamily
{
    CREATURE_FAMILY_WOLF           = 1,
    CREATURE_FAMILY_CAT            = 2,
    CREATURE_FAMILY_SPIDER         = 3,
    CREATURE_FAMILY_BEAR           = 4,
    CREATURE_FAMILY_BOAR           = 5,
    CREATURE_FAMILY_CROCOLISK      = 6,
    CREATURE_FAMILY_CARRION_BIRD   = 7,
    CREATURE_FAMILY_CRAB           = 8,
    CREATURE_FAMILY_GORILLA        = 9,
    CREATURE_FAMILY_HORSE_CUSTOM   = 10,
    CREATURE_FAMILY_RAPTOR         = 11,
    CREATURE_FAMILY_TALLSTRIDER    = 12,
    CREATURE_FAMILY_FELHUNTER      = 15,
    CREATURE_FAMILY_VOIDWALKER     = 16,
    CREATURE_FAMILY_SUCCUBUS       = 17,
    CREATURE_FAMILY_DOOMGUARD      = 19,
    CREATURE_FAMILY_SCORPID        = 20,
    CREATURE_FAMILY_TURTLE         = 21,
    CREATURE_FAMILY_IMP            = 23,
    CREATURE_FAMILY_BAT            = 24,
    CREATURE_FAMILY_HYENA          = 25,
    CREATURE_FAMILY_BIRD_OF_PREY   = 26,
    CREATURE_FAMILY_WIND_SERPENT   = 27,
    CREATURE_FAMILY_REMOTE_CONTROL = 28,
    CREATURE_FAMILY_FELGUARD       = 29,
    CREATURE_FAMILY_DRAGONHAWK     = 30,
    CREATURE_FAMILY_RAVAGER        = 31,
    CREATURE_FAMILY_WARP_STALKER   = 32,
    CREATURE_FAMILY_SPOREBAT       = 33,
    CREATURE_FAMILY_NETHER_RAY     = 34,
    CREATURE_FAMILY_SERPENT        = 35,
    CREATURE_FAMILY_MOTH           = 37,
    CREATURE_FAMILY_CHIMAERA       = 38,
    CREATURE_FAMILY_DEVILSAUR      = 39,
    CREATURE_FAMILY_GHOUL          = 40,
    CREATURE_FAMILY_SILITHID       = 41,
    CREATURE_FAMILY_WORM           = 42,
    CREATURE_FAMILY_RHINO          = 43,
    CREATURE_FAMILY_WASP           = 44,
    CREATURE_FAMILY_CORE_HOUND     = 45,
    CREATURE_FAMILY_SPIRIT_BEAST   = 46
};
```

**翻译对照表**（可选，用于界面显示）:
```dart
const familyNames = {
  0: '无',
  1: '狼 (Wolf)',
  2: '猫 (Cat)',
  3: '蜘蛛 (Spider)',
  4: '熊 (Bear)',
  5: '野猪 (Boar)',
  6: '鳄鱼 (Crocolisk)',
  7: '食腐鸟 (Carrion Bird)',
  8: '螃蟹 (Crab)',
  9: '猩猩 (Gorilla)',
  10: '马 (Horse)',
  11: '迅猛龙 (Raptor)',
  12: '陆行鸟 (Tallstrider)',
  15: '地狱猎犬 (Felhunter)',
  16: '虚空行者 (Voidwalker)',
  17: '魅魔 (Succubus)',
  19: '末日守卫 (Doomguard)',
  20: '蝎子 (Scorpid)',
  21: '乌龟 (Turtle)',
  23: '小鬼 (Imp)',
  24: '蝙蝠 (Bat)',
  25: '鬣狗 (Hyena)',
  26: '猛禽 (Bird of Prey)',
  27: '风蛇 (Wind Serpent)',
  28: '遥控 (Remote Control)',
  29: '恶魔卫士 (Felguard)',
  30: '龙鹰 (Dragonhawk)',
  31: '劫掠者 (Ravager)',
  32: '曲光掠夺者 (Warp Stalker)',
  33: '孢子蝠 (Sporebat)',
  34: '虚空鳐 (Nether Ray)',
  35: '蛇 (Serpent)',
  37: '蛾 (Moth)',
  38: '奇美拉 (Chimaera)',
  39: '魔暴龙 (Devilsaur)',
  40: '食尸鬼 (Ghoul)',
  41: '异种蝎 (Silithid)',
  42: '蠕虫 (Worm)',
  43: '犀牛 (Rhino)',
  44: '黄蜂 (Wasp)',
  45: '熔火犬 (Core Hound)',
  46: '灵魂兽 (Spirit Beast)',
};
```

---

#### 2. `NPCFlags` - NPC标识（20+ 种）

**数据源文件**:
```
D:\Simulators\AzerothCore\code\src\server\game\Entities\Unit\UnitDefines.h
行号: 316-342
```

**完整枚举**:
```cpp
enum NPCFlags : uint32
{
    UNIT_NPC_FLAG_NONE                      = 0x00000000,
    UNIT_NPC_FLAG_GOSSIP                    = 0x00000001,       // 对话
    UNIT_NPC_FLAG_QUESTGIVER                = 0x00000002,       // 任务发布者
    UNIT_NPC_FLAG_UNK1                      = 0x00000004,
    UNIT_NPC_FLAG_UNK2                      = 0x00000008,
    UNIT_NPC_FLAG_TRAINER                   = 0x00000010,       // 训练师
    UNIT_NPC_FLAG_TRAINER_CLASS             = 0x00000020,       // 职业训练师
    UNIT_NPC_FLAG_TRAINER_PROFESSION        = 0x00000040,       // 专业训练师
    UNIT_NPC_FLAG_VENDOR                    = 0x00000080,       // 商人
    UNIT_NPC_FLAG_VENDOR_AMMO               = 0x00000100,       // 弹药商人
    UNIT_NPC_FLAG_VENDOR_FOOD               = 0x00000200,       // 食物商人
    UNIT_NPC_FLAG_VENDOR_POISON             = 0x00000400,       // 毒药商人
    UNIT_NPC_FLAG_VENDOR_REAGENT            = 0x00000800,       // 材料商人
    UNIT_NPC_FLAG_REPAIR                    = 0x00001000,       // 修理
    UNIT_NPC_FLAG_FLIGHTMASTER              = 0x00002000,       // 飞行管理员
    UNIT_NPC_FLAG_SPIRITHEALER              = 0x00004000,       // 灵魂医者
    UNIT_NPC_FLAG_SPIRITGUIDE               = 0x00008000,       // 灵魂向导
    UNIT_NPC_FLAG_INNKEEPER                 = 0x00010000,       // 旅店老板
    UNIT_NPC_FLAG_BANKER                    = 0x00020000,       // 银行
    UNIT_NPC_FLAG_PETITIONER                = 0x00040000,       // 公会/竞技场请愿人
    UNIT_NPC_FLAG_TABARDDESIGNER            = 0x00080000,       // 公会徽章设计师
    UNIT_NPC_FLAG_BATTLEMASTER              = 0x00100000,       // 战场军需官
    UNIT_NPC_FLAG_AUCTIONEER                = 0x00200000,       // 拍卖师
    UNIT_NPC_FLAG_STABLEMASTER              = 0x00400000,       // 兽栏管理员
    UNIT_NPC_FLAG_GUILD_BANKER              = 0x00800000,       // 公会银行
    UNIT_NPC_FLAG_SPELLCLICK                = 0x01000000,       // 法术点击
    UNIT_NPC_FLAG_PLAYER_VEHICLE            = 0x02000000,       // 玩家载具
    UNIT_NPC_FLAG_MAILBOX                   = 0x04000000,       // 邮箱
};
```

**Archive 分支参考**:
```
archive 分支文件: src/views/Creature/components/CreatureTemplateTabPane.vue
查找: npcFlags
可找到完整的中文翻译和描述
```

---

#### 3. `UnitFlags` - 单位标识（30+ 种）

**数据源文件**:
```
D:\Simulators\AzerothCore\code\src\server\game\Entities\Unit\UnitDefines.h
行号: 251-289
```

**部分重要标志**:
```cpp
enum UnitFlags : uint32
{
    UNIT_FLAG_NONE                          = 0x00000000,
    UNIT_FLAG_SERVER_CONTROLLED             = 0x00000001,
    UNIT_FLAG_NON_ATTACKABLE                = 0x00000002,       // 不可攻击
    UNIT_FLAG_DISABLE_MOVE                  = 0x00000004,       // 禁止移动
    UNIT_FLAG_PLAYER_CONTROLLED             = 0x00000008,       // 玩家控制
    UNIT_FLAG_RENAME                        = 0x00000010,       // 可重命名
    UNIT_FLAG_PREPARATION                   = 0x00000020,       // 准备状态
    UNIT_FLAG_UNK_6                         = 0x00000040,
    UNIT_FLAG_NOT_ATTACKABLE_1              = 0x00000080,       // 不可攻击1
    UNIT_FLAG_IMMUNE_TO_PC                  = 0x00000100,       // 对玩家免疫
    UNIT_FLAG_IMMUNE_TO_NPC                 = 0x00000200,       // 对NPC免疫
    UNIT_FLAG_LOOTING                       = 0x00000400,       // 拾取中
    UNIT_FLAG_PET_IN_COMBAT                 = 0x00000800,       // 宠物战斗中
    UNIT_FLAG_PVP                           = 0x00001000,       // PVP
    UNIT_FLAG_SILENCED                      = 0x00002000,       // 沉默
    UNIT_FLAG_CANNOT_SWIM                   = 0x00004000,       // 不能游泳
    UNIT_FLAG_SWIMMING                      = 0x00008000,       // 游泳中
    UNIT_FLAG_NON_ATTACKABLE_2              = 0x00010000,       // 不可攻击2
    UNIT_FLAG_PACIFIED                      = 0x00020000,       // 无法攻击
    UNIT_FLAG_STUNNED                       = 0x00040000,       // 昏迷
    UNIT_FLAG_IN_COMBAT                     = 0x00080000,       // 战斗中
    UNIT_FLAG_TAXI_FLIGHT                   = 0x00100000,       // 飞行中
    UNIT_FLAG_DISARMED                      = 0x00200000,       // 缴械
    UNIT_FLAG_CONFUSED                      = 0x00400000,       // 混乱
    // ... 更多标志，完整列表参见源文件
};
```

**获取完整列表**: 阅读上述源文件的完整枚举定义

---

#### 4. `UnitFlags2` - 单位标识2（20+ 种）

**数据源文件**:
```
D:\Simulators\AzerothCore\code\src\server\game\Entities\Unit\UnitDefines.h
行号: 290-313
```

**完整枚举**:
```cpp
enum UnitFlags2 : uint32
{
    UNIT_FLAG2_NONE                         = 0x00000000,
    UNIT_FLAG2_FEIGN_DEATH                  = 0x00000001,       // 假死
    UNIT_FLAG2_HIDE_BODY                    = 0x00000002,       // 隐藏身体
    UNIT_FLAG2_IGNORE_REPUTATION            = 0x00000004,       // 忽略声望
    UNIT_FLAG2_COMPREHEND_LANG              = 0x00000008,       // 理解语言
    UNIT_FLAG2_MIRROR_IMAGE                 = 0x00000010,       // 镜像
    UNIT_FLAG2_DO_NOT_FADE_IN               = 0x00000020,       // 不淡入
    UNIT_FLAG2_FORCE_MOVEMENT               = 0x00000040,       // 强制移动
    UNIT_FLAG2_DISARM_OFFHAND               = 0x00000080,       // 缴械副手
    UNIT_FLAG2_DISABLE_PRED_STATS           = 0x00000100,       // 禁用预测状态
    UNIT_FLAG2_DISARM_RANGED                = 0x00000400,       // 缴械远程
    UNIT_FLAG2_REGENERATE_POWER             = 0x00000800,       // 回复能量
    UNIT_FLAG2_RESTRICT_PARTY_INTERACTION   = 0x00001000,       // 限制队伍交互
    UNIT_FLAG2_PREVENT_SPELL_CLICK          = 0x00002000,       // 阻止法术点击
    UNIT_FLAG2_ALLOW_ENEMY_INTERACT         = 0x00004000,       // 允许敌对交互
    UNIT_FLAG2_CANNOT_TURN                  = 0x00008000,       // 不能转向
    UNIT_FLAG2_UNK2                         = 0x00010000,
    UNIT_FLAG2_PLAY_DEATH_ANIM              = 0x00020000,       // 播放死亡动画
    UNIT_FLAG2_ALLOW_CHEAT_SPELLS           = 0x00040000,       // 允许作弊法术
    UNIT_FLAG2_UNUSED_6                     = 0x01000000
};
```

---

#### 5. `CreatureTypeFlags` - 类型标识（20+ 种）

**数据源文件**:
```
D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h
行号: 2694-2718
```

**部分重要标志**:
```cpp
enum CreatureTypeFlags
{
    CREATURE_TYPE_FLAG_TAMEABLE                          = 0x00000001,   // 可驯服
    CREATURE_TYPE_FLAG_VISIBLE_TO_GHOSTS                 = 0x00000002,   // 灵魂可见
    CREATURE_TYPE_FLAG_BOSS_MOB                          = 0x00000004,   // BOSS
    CREATURE_TYPE_FLAG_DO_NOT_PLAY_WOUND_ANIM            = 0x00000008,   // 不播放受伤动画
    CREATURE_TYPE_FLAG_NO_FACTION_TOOLTIP                = 0x00000010,   // 无阵营提示
    CREATURE_TYPE_FLAG_MORE_AUDIBLE                      = 0x00000020,   // 更响亮
    CREATURE_TYPE_FLAG_SPELL_ATTACKABLE                  = 0x00000040,   // 法术可攻击
    CREATURE_TYPE_FLAG_INTERACT_WHILE_DEAD               = 0x00000080,   // 死亡可交互
    CREATURE_TYPE_FLAG_SKIN_WITH_HERBALISM               = 0x00000100,   // 草药剥皮
    CREATURE_TYPE_FLAG_SKIN_WITH_MINING                  = 0x00000200,   // 采矿剥皮
    CREATURE_TYPE_FLAG_NO_DEATH_MESSAGE                  = 0x00000400,   // 无死亡消息
    CREATURE_TYPE_FLAG_ALLOW_MOUNTED_COMBAT              = 0x00000800,   // 允许骑乘战斗
    CREATURE_TYPE_FLAG_CAN_ASSIST                        = 0x00001000,   // 可协助
    CREATURE_TYPE_FLAG_NO_PET_BAR                        = 0x00002000,   // 无宠物栏
    // ... 更多标志，完整列表参见源文件
};
```

**获取完整列表**: 阅读上述源文件的 2694-2718 行

---

#### 6. 法术学派和机制相关

**SpellSchools - 法术学派**:
```
文件: D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h
行号: 292-301
```

```cpp
enum SpellSchools
{
    SPELL_SCHOOL_NORMAL                 = 0,    // 物理
    SPELL_SCHOOL_HOLY                   = 1,    // 神圣
    SPELL_SCHOOL_FIRE                   = 2,    // 火焰
    SPELL_SCHOOL_NATURE                 = 3,    // 自然
    SPELL_SCHOOL_FROST                  = 4,    // 冰霜
    SPELL_SCHOOL_SHADOW                 = 5,    // 暗影
    SPELL_SCHOOL_ARCANE                 = 6     // 奥术
};
```

**SpellSchoolMask - 法术学派掩码**:
```
文件: D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h
行号: 305-315
```

```cpp
enum SpellSchoolMask
{
    SPELL_SCHOOL_MASK_NONE    = 0x00,
    SPELL_SCHOOL_MASK_NORMAL  = (1 << SPELL_SCHOOL_NORMAL),  // 0x01
    SPELL_SCHOOL_MASK_HOLY    = (1 << SPELL_SCHOOL_HOLY),    // 0x02
    SPELL_SCHOOL_MASK_FIRE    = (1 << SPELL_SCHOOL_FIRE),    // 0x04
    SPELL_SCHOOL_MASK_NATURE  = (1 << SPELL_SCHOOL_NATURE),  // 0x08
    SPELL_SCHOOL_MASK_FROST   = (1 << SPELL_SCHOOL_FROST),   // 0x10
    SPELL_SCHOOL_MASK_SHADOW  = (1 << SPELL_SCHOOL_SHADOW),  // 0x20
    SPELL_SCHOOL_MASK_ARCANE  = (1 << SPELL_SCHOOL_ARCANE),  // 0x40
    // 组合掩码
    SPELL_SCHOOL_MASK_SPELL   = (SPELL_SCHOOL_MASK_FIRE | SPELL_SCHOOL_MASK_NATURE |
                                 SPELL_SCHOOL_MASK_FROST | SPELL_SCHOOL_MASK_SHADOW |
                                 SPELL_SCHOOL_MASK_ARCANE),
    SPELL_SCHOOL_MASK_MAGIC   = (SPELL_SCHOOL_MASK_HOLY | SPELL_SCHOOL_MASK_SPELL),
    SPELL_SCHOOL_MASK_ALL     = 0x7F
};
```

**Mechanics - 机制类型**（用于 mechanic_immune_mask）:
```
文件: D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h
行号: 317-350（大约）
```

部分常见机制（完整列表需查看源文件）:
- MECHANIC_CHARM（魅惑）
- MECHANIC_DISORIENTED（迷惑）
- MECHANIC_DISARM（缴械）
- MECHANIC_DISTRACT（分心）
- MECHANIC_FEAR（恐惧）
- MECHANIC_GRIP（抓取）
- MECHANIC_ROOT（定身）
- MECHANIC_SILENCE（沉默）
- MECHANIC_SLEEP（睡眠）
- MECHANIC_SNARE（减速）
- MECHANIC_STUN（昏迷）
- 等等...

---

#### 7. 其他枚举

**MovementGeneratorType - 移动类型**:
```
文件: D:\Simulators\AzerothCore\code\src\server\game\Movement\MotionMaster.h
行号: 37-50
```

```cpp
enum MovementGeneratorType
{
    IDLE_MOTION_TYPE      = 0,    // 静止
    RANDOM_MOTION_TYPE    = 1,    // 随机
    WAYPOINT_MOTION_TYPE  = 2,    // 路径点
    // 以下类型不能在数据库中设置
    MAX_DB_MOTION_TYPE    = 3,
    ANIMAL_RANDOM_MOTION_TYPE = MAX_DB_MOTION_TYPE,
    CONFUSED_MOTION_TYPE  = 4,
    CHASE_MOTION_TYPE     = 5,
    HOME_MOTION_TYPE      = 6,
    FLIGHT_MOTION_TYPE    = 7,
    // ... 更多类型
};
```

**InhabitType - 栖息类型**（位标志）:
```
文件: D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h
行号: 2720-2726（大约）
```

```cpp
enum InhabitTypeValues
{
    INHABIT_GROUND = 1,    // 地面
    INHABIT_WATER  = 2,    // 水中
    INHABIT_AIR    = 4,    // 空中
    INHABIT_ROOT   = 8,    // 根部（不移动）
    INHABIT_ANYWHERE = INHABIT_GROUND | INHABIT_WATER | INHABIT_AIR
};
```

---

### Archive 分支实现参考

对于需要翻译和详细说明的字段，可以参考 archive 分支的 Vue 实现。

#### 完整的标志位选项（带中文翻译和说明）

**文件位置**: `archive` 分支
```
src/views/Creature/components/CreatureTemplateTabPane.vue
```

**查找方式**: 在该文件中搜索对应的数据定义：

1. **npcFlags** - 搜索 `npcFlags:`
2. **unitFlags** - 搜索 `unitFlags:`
3. **unitFlags2** - 搜索 `unitFlags2:`
4. **typeFlags** - 搜索 `typeFlags:`
5. **dynamicFlags** - 搜索 `dynamicFlags:`
6. **flagsExtra** - 搜索 `flagsExtra:`
7. **mechanicImmuneMasks** - 搜索 `mechanicImmuneMasks:`
8. **spellSchoolImmuneMasks** - 搜索 `spellSchoolImmuneMasks:`
9. **inhabitTypes** - 搜索 `inhabitTypes:`

**示例** (npcFlags 的数据结构):
```javascript
// archive 分支中的格式
npcFlags: [
  { flag: 1, name: '对话', comment: '启用右键对话功能' },
  { flag: 2, name: '任务', comment: '可以发布和交付任务' },
  { flag: 16, name: '训练师', comment: '普通技能训练师' },
  { flag: 32, name: '职业训练师', comment: '职业技能训练师' },
  { flag: 64, name: '专业训练师', comment: '专业技能训练师' },
  { flag: 128, name: '商人', comment: '普通物品商人' },
  // ... 完整列表
]
```

**转换为 Flutter/Dart**:
```dart
final npcFlags = [
  FlagOption(flag: 0x00000001, name: '对话 (Gossip)', description: '启用右键对话功能'),
  FlagOption(flag: 0x00000002, name: '任务 (Quest Giver)', description: '可以发布和交付任务'),
  FlagOption(flag: 0x00000010, name: '训练师 (Trainer)', description: '普通技能训练师'),
  // ... 更多选项
];
```

---

#### 枚举下拉框选项（带中文翻译）

**文件位置**: `archive` 分支
```
src/views/Creature/components/CreatureTemplateTabPane.vue
```

**查找方式**: 在该文件的 `data()` 或 `computed` 部分搜索：

1. **unitClasses** - 职业选项
2. **ranks** - 稀有程度选项
3. **types** - 类型选项
4. **families** - 族群选项
5. **exps** - 属性扩展选项
6. **dmgSchools** - 伤害类型选项
7. **movementTypes** - 移动类型选项
8. **trainerTypes** - 训练师类型选项
9. **trainerClasses** - 训练师职业选项（Classes 枚举）
10. **trainerRaces** - 训练师种族选项

**示例提取**:
```javascript
// archive 分支中查找这些定义
data() {
  return {
    unitClasses: ["", "战士", "圣骑士", "", "盗贼", "", "", "", "法师"],
    ranks: ["普通", "精英", "稀有精英", "世界BOSS", "稀有"],
    types: ["", "野兽", "龙类", "恶魔", "元素", "巨人", "亡灵", "人型生物",
            "小动物", "机械", "未指定", "图腾", "非战斗宠物", "气体云"],
    // ... 更多
  }
}
```

---

### Tooltip 说明文本

所有字段的详细说明文本（tooltip）也可以从 archive 分支提取。

**文件位置**: `archive` 分支
```
src/views/Creature/components/CreatureTemplateTabPane.vue
```

**查找方式**: 搜索 `Tooltip` 相关的 computed 属性：

```javascript
computed: {
  unitClassTooltip() {
    return "影响NPC的行为模式，如战士类型会格挡，法师类型会后退施法等";
  },
  rankTooltip() {
    return "决定NPC的稀有程度和血量倍数，BOSS级别会显示??等级";
  },
  npcFlagTooltip() {
    return "决定NPC可以提供什么服务，如商人、任务、训练等。可以同时拥有多个标识。";
  },
  // ... 更多 tooltip
}
```

**使用这些 tooltip**:
将这些说明文本用于 Flutter 实现中的 `HintLabel` 组件。

---

### 数据库关联字段

对于需要关联数据库其他表的字段，参考以下表结构：

#### Faction Template（阵营模板）

**表名**: `factiontemplate`（DBC 表）

**关键字段**:
- `ID` - 阵营模板ID
- `Name_Lang_zhCN` - 中文名称
- `Description_Lang_zhCN` - 中文描述

**选择器实现参考**:
```
archive 分支: src/components/FactionTemplateSelector.vue
```

---

#### Gossip Menu（对话菜单）

**表名**: `gossip_menu`

**关键字段**:
- `MenuID` - 菜单ID
- `TextID` - 文本ID（关联到 npc_text）

**选择器实现参考**:
```
archive 分支: src/components/GossipMenuSelector.vue
```

---

#### Creature Model（生物模型）

**表名**: `CreatureDisplayInfo`（DBC 表）

**关键字段**:
- `ID` - 模型显示ID
- `ModelID` - 模型ID

**选择器实现参考**:
```
archive 分支: src/components/CreatureModelInfoSelector.vue
```

---

#### Loot Templates（掉落模板）

**表名**:
- `creature_loot_template` - 击杀掉落
- `pickpocketing_loot_template` - 偷窃掉落
- `skinning_loot_template` - 剥皮掉落

**关键字段**:
- `Entry` - 掉落模板ID（对应 creature_template.lootid 等）
- `Item` - 物品ID
- `Chance` - 掉落概率

**选择器实现**: 可参考 faction 选择器的模式，查询相应表

---

### 快速查找指南

#### 场景 1: 我需要完整的 CreatureFamily 枚举

**步骤**:
1. 打开 `D:\Simulators\AzerothCore\code\src\server\shared\SharedDefines.h`
2. 跳转到第 2649 行
3. 复制 `enum CreatureFamily` 的完整定义

#### 场景 2: 我需要 NPC标识 的中文翻译和说明

**步骤**:
1. 切换到 `archive` 分支: `git checkout archive`
2. 打开 `src/views/Creature/components/CreatureTemplateTabPane.vue`
3. 搜索 `npcFlags:`
4. 找到类似这样的数组定义:
   ```javascript
   npcFlags: [
     { flag: 1, name: '对话', comment: '启用右键对话功能' },
     // ...
   ]
   ```

#### 场景 3: 我需要某个字段的 Tooltip 说明

**步骤**:
1. 切换到 `archive` 分支
2. 打开 `src/views/Creature/components/CreatureTemplateTabPane.vue`
3. 搜索对应字段名 + `Tooltip`（如 `npcFlagTooltip`）
4. 在 `computed` 部分找到说明文本

#### 场景 4: 我需要实现一个关联选择器

**步骤**:
1. 切换到 `archive` 分支
2. 打开 `src/components/` 目录
3. 找到对应的选择器组件（如 `FactionTemplateSelector.vue`）
4. 参考其实现模式：输入框 + 弹窗 + 搜索表单 + 分页 + 表格

---

### 注意事项

1. **枚举值的对应关系**:
   - C++ 中的枚举值直接对应数据库中存储的数值
   - 翻译时注意保持数值不变，只翻译显示名称

2. **位标志的计算**:
   - 标志位使用位运算（OR）组合: `flag1 | flag2 | flag3`
   - 检查是否包含某标志: `(value & flag) != 0`
   - Archive 分支的 FlagEditor 组件有完整的位运算实现

3. **数据库表的查询**:
   - DBC 表（如 factiontemplate、CreatureDisplayInfo）通常只读，用于选择器
   - 世界数据表（如 creature_template、gossip_menu）可读写

4. **版本兼容性**:
   - 本文档基于 AzerothCore 3.3.5a (WotLK) 版本
   - 不同版本的枚举值可能略有差异

---

---

## 📌 实施总结与强制约束

### ⚠️ 关键提醒

本文档不仅是功能需求文档，更是**架构和编码规范的强制性约束文档**。

### 🎯 实施优先级

1. **首要任务**：熟读并理解 [第 0 章：架构和编码规范约束](#0-架构和编码规范约束)
2. **第二步**：按优先级实施功能（P0 → P1 → P2 → P3）
3. **每次提交前**：使用 [代码审查检查清单](#代码审查检查清单) 自查

### 🔒 不可妥协的原则

以下规范是**绝对不允许违反**的：

1. **架构分层**：严格分离 Model、Repository、ViewModel、Page
2. **依赖注入**：所有 ViewModel 必须通过 GetIt 注册和获取
3. **状态管理**：统一使用 Signals，禁止混用其他方案
4. **命名规范**：严格遵循文档定义的命名规则
5. **资源释放**：所有 TextEditingController 必须在 dispose 中释放
6. **数据访问**：禁止直接写 SQL，必须使用 laconic
7. **组件接口**：自定义组件必须遵循标准接口规范

### ✅ 质量保证

代码提交前必须通过以下检查：

#### 自动检查
- [ ] `flutter analyze` 无错误和警告
- [ ] `flutter test` 所有测试通过（如有）

#### 手动检查
- [ ] 完整过一遍 [代码审查检查清单](#代码审查检查清单)
- [ ] 验证命名规范符合文档要求
- [ ] 确认无内存泄漏（所有 Controller 已释放）
- [ ] 确认 ViewModel 未直接操作 UI
- [ ] 确认 Page 未直接进行数据库操作

### 📐 架构一致性

**为什么架构约束如此重要？**

1. **可维护性**：统一的架构和编码风格使代码易于理解和维护
2. **可扩展性**：严格的分层使功能扩展不会破坏现有代码
3. **团队协作**：统一规范减少沟通成本，避免代码风格冲突
4. **质量保证**：标准化的检查清单确保代码质量
5. **长期价值**：良好的架构使项目能够持续健康发展

### 🚀 开始实施

**推荐实施流程**：

1. **阅读第 0 章**：完整阅读架构和编码规范约束（约 30 分钟）
2. **理解现有代码**：阅读 `creature_template_detail_page.dart` 和 `creature_template_detail_view_model.dart`，理解当前实现模式（约 20 分钟）
3. **实施 P0 任务**：先实施 8 个枚举下拉框，熟悉流程（1-2 天）
4. **代码审查**：自查是否符合所有规范
5. **迭代实施**：继续 P1、P2、P3 任务

### 📞 遇到问题？

如果遇到以下情况：

- **架构约束与需求冲突**：优先满足架构约束，重新思考实现方式
- **不确定某个规范是否适用**：参考现有代码中的类似实现
- **发现规范中的错误或遗漏**：记录并讨论，更新文档

### 🎓 持续改进

本文档应该随项目演进而更新：

- ✅ 当发现新的最佳实践时，更新相应章节
- ✅ 当架构发生变化时，及时更新第 0 章
- ✅ 当实施过程中发现问题时，补充到检查清单

---

最后更新: 2026-01-10（添加架构和编码规范约束章节）

---

## 📊 实施进度追踪

### 第一阶段：P0 枚举下拉框 ✅ 已完成

**完成时间**: 2026-01-10

| 序号 | 字段 | 中文名 | 状态 |
|------|------|--------|------|
| 1 | `unit_class` | 职业 | ✅ 已完成 |
| 2 | `rank` | 稀有程度 | ✅ 已完成 |
| 3 | `type` | 类型 | ✅ 已完成 |
| 4 | `RacialLeader` | 种族领袖 | ✅ 已完成 |
| 5 | `RegenHealth` | 回复生命 | ✅ 已完成 |
| 6 | `exp` | 属性扩展 | ✅ 已完成 |
| 7 | `dmgschool` | 伤害类型 | ✅ 已完成 |
| 8 | `movementType` | 移动类型 | ✅ 已完成 |

**新建文件**:
- `lib/constant/creature_enums.dart` - 枚举常量定义

**修改文件**:
- `lib/page/creature_template/creature_template_detail_page.dart` - 应用 EnumSelect 组件

---

### 第二阶段：P1 标志位组件 ⬜ 待实施

| 序号 | 字段 | 中文名 | 状态 |
|------|------|--------|------|
| 1 | `npcflag` | NPC标识 | ⬜ 待实现 |
| 2 | `unit_flags` | 单位标识 | ⬜ 待实现 |
| 3 | `unit_flags2` | 单位标识2 | ⬜ 待实现 |
| 4 | `type_flags` | 类型标识 | ⬜ 待实现 |
| 5 | `dynamicflags` | 动态标识 | ⬜ 待实现 |
| 6 | `flags_extra` | 额外标识 | ⬜ 待实现 |
| 7 | `mechanic_immune_mask` | 免疫机制 | ⬜ 待实现 |
| 8 | `spell_school_immune_mask` | 免疫法术类型 | ⬜ 待实现 |

---

### 第三阶段：P2 关联选择器 ⬜ 待实施

| 序号 | 字段 | 中文名 | 状态 |
|------|------|--------|------|
| 1 | `faction` | 阵营 | ⬜ 待实现 |
| 2 | `gossip_menu_id` | 对话菜单 | ⬜ 待实现 |
| 3 | `lootid` | 击杀掉落 | ⬜ 待实现 |
| 4 | `pickpocketloot` | 偷窃掉落 | ⬜ 待实现 |
| 5 | `skinloot` | 剥皮掉落 | ⬜ 待实现 |
| 6 | `KillCredit1/2` | 击杀关联 | ⬜ 待实现 |
| 7 | `difficulty_entry_*` | 难度模板 | ⬜ 待实现 |

---

### 第四阶段：P3 可选优化 ⬜ 待实施

| 序号 | 字段 | 中文名 | 状态 |
|------|------|--------|------|
| 1 | `family` | 族群 | ⬜ 待实现 |
| 2 | `modelid1-4` | 模型ID | ⬜ 待实现 |
| 3 | `PetSpellDataId` | 宠物技能 | ⬜ 待实现 |
| 4 | `VehicleId` | 载具ID | ⬜ 待实现 |
