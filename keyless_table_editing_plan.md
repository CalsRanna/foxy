# Foxy 无键表编辑方案

## 1. 问题

`playercreateinfo_cast_spell` 没有物理主键，也没有唯一约束。使用字段名猜测“主键”会漏掉可区分行的值；使用普通 WHERE 更新又可能一次修改多个重复行。

本方案只处理这一张已经审查的特殊表，不建立通用反射或 Map 后备机制。

## 2. 前置依赖

- `database_write_result_plan.md` 已提供 matched-row 和参数化 raw write。
- `row_locator_plan.md` 的强类型值对象合同已经建立。
- `brief_entity_plan.md` 允许显式全行定位器的 Brief 保留全部物理列。
- `inline_row_editing_plan.md` 已定义 `editingKey`。

## 3. 显式全行定位器

定义：

```dart
@immutable
final class PlayerCreateInfoCastSpellKey {
  final int raceMask;
  final int classMask;
  final int spell;
  final String? note;

  const PlayerCreateInfoCastSpellKey({
    required this.raceMask,
    required this.classMask,
    required this.spell,
    required this.note,
  });

  // fromEntity, == and hashCode use all four fields.
}
```

这不是主键，而是选中旧行时的完整值快照。即使存在完全相同的重复行，一次操作也只修改或删除其中一行；这些重复行在可观察数据上没有区别。

## 4. NULL 与空字符串

`note` 必须保持数据库真实可空性：

- Full Entity 使用 `String? note`；
- Brief Entity 使用 `String? note`；
- Key 使用 `String? note`；
- Controller/UI 允许明确表示 `NULL` 和 `''`；
- `fromJson()`、初始化、收集和 `toJson()` 不静默互相转换。

## 5. 精确 WHERE

旧行条件使用全部四列：

- 数值列正常参数绑定；
- `note` 使用 MySQL null-safe equality `<=>`；
- 文本比较使用 binary 语义，避免大小写不敏感 collation 命中可见内容不同的行；
- 所有值都通过 bindings 传递。

固定 SQL 结构由 Repository 维护，不从 Key 字段名动态生成。

## 6. UPDATE 与 DELETE LIMIT 1

Laconic QueryBuilder 不编译写入 limit，因此使用：

```dart
final matchedRows = await laconic.affectingStatement(
  'UPDATE playercreateinfo_cast_spell '
  'SET racemask = ?, classmask = ?, spell = ?, note = ? '
  'WHERE racemask = ? AND classmask = ? AND spell = ? '
  'AND BINARY note <=> BINARY ? LIMIT 1',
  [
    candidate.raceMask,
    candidate.classMask,
    candidate.spell,
    candidate.note,
    originalKey.raceMask,
    originalKey.classMask,
    originalKey.spell,
    originalKey.note,
  ],
);
```

具体列名大小写以实际物理 schema 为准。DELETE 使用相同 WHERE 并附加 `LIMIT 1`。

- UPDATE 返回 `0`：原行不存在。
- UPDATE 返回 `1`：成功，包括无变化保存。
- DELETE 返回 `0`：原行不存在。
- DELETE 返回 `1`：实际删除一行。

## 7. Brief 与内嵌编辑

Brief Entity 包含全部四个物理列并提供 `key`。选中已有行时保存 `editingKey = brief.key`，candidate 修改后仍使用原始 `editingKey` 定位。

保存成功后刷新当前父范围列表并清空选择与 `editingKey`。

## 8. 非目标

- 不修改 AzerothCore 表结构。
- 不增加代理 ID、主键或唯一约束。
- 不把该策略推广为通用“无键表自动支持”。
- 不使用 Map、反射或字段名推断生成定位器。
- 不尝试让用户选择完全相同重复行中的某个物理实例。

未来发现其他无键表时，必须新增同等级别的显式审查方案。

## 9. 测试

至少覆盖：

- Full、Brief、Key 和 Controller 保留 `NULL` / `''` 区别；
- Key 相等覆盖全部四列和 note 可空性；
- Brief 包含全部物理列；
- WHERE 使用全部旧值；
- note 使用 null-safe 和 binary 比较；
- UPDATE/DELETE 都附加 `LIMIT 1`；
- 所有值通过参数绑定；
- 完全重复行存在时一次最多影响一行；
- candidate 修改任意定位字段后仍使用旧 `editingKey`；
- 无变化保存按成功处理；
- 零行结果正确报告旧行不存在。

## 10. 验收标准

- 一次编辑或删除最多影响一个物理行。
- NULL、空字符串和大小写可见差异不会被错误合并。
- 没有任何用户值进入 SQL 插值。
- 该特殊策略严格限制在经过审查的表。
