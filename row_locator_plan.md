# Foxy 强类型行定位方案

## 1. 问题

Foxy 当前部分模块使用松散标量或 `Map<String, dynamic>` 传递主键，联合键容易漏列，页面和 Repository 也可能把正在编辑的 candidate 键误当成旧行定位条件。

## 2. 范围

本方案只负责：

- 为可编辑记录定义领域专用强类型 Key；
- 确定物理行定位列；
- 定义 Key 的值相等和 `hashCode`；
- 定义 Full Entity、Brief Entity 与 Key 的转换边界；
- 定义 Repository `_whereKey` 映射。

本方案不决定主键是否可编辑，不管理 ViewModel signal，不规定创建键如何分配。无主键且无唯一约束表的具体写入策略由 `keyless_table_editing_plan.md` 负责。

## 3. 行定位列选择

按以下顺序确定：

1. 存在 `PRIMARY KEY`：使用全部物理主键列。
2. 没有主键但存在所有列均为 `NOT NULL` 的物理 `UNIQUE` 约束：使用该约束的全部列。
3. 两者都不存在：不得猜测键列，必须进入经过审查的显式定位方案。

`spell_linked_spell` 使用物理 `UNIQUE (spell_trigger, spell_effect, type)`。`playercreateinfo_cast_spell` 的特殊全行定位由独立方案管理。

不得根据字段名、UI 展示列或“看起来唯一”的业务含义发明定位键。

## 4. Key 值对象

每个可编辑实体使用专用类型，例如：

```dart
@immutable
final class AchievementKey {
  final int id;

  const AchievementKey(this.id);

  factory AchievementKey.fromEntity(AchievementEntity value) {
    return AchievementKey(value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AchievementKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
```

联合 Key 必须显式声明全部字段，并从全部字段计算 `==` 和 `hashCode`。不得使用 List、索引循环、反射或内部 Map 隐藏物理结构。

Key 字段类型和可空性必须与真实数据库定位列兼容。Key 是纯数据对象，不依赖 Repository、Laconic、数据库连接或 UI。

## 5. Full 与 Brief 转换边界

- Full Entity 不提供 `key` getter。
- `FooKey.fromEntity(candidate)` 是从完整 candidate 得到新键的公共入口。
- Brief Entity 提供 `FooKey get key`，因为列表行已经代表一条持久化记录。
- Brief 必须包含全部定位列，即使部分定位列不展示。
- 查看详情、复制和删除传递 `brief.key`，不传松散标量或 Map。

Brief 的完整查询和实体边界由 `brief_entity_plan.md` 负责。

## 6. Repository 映射

具体 Repository 显式把类型化字段映射为物理列：

```dart
QueryBuilder _whereKey(QueryBuilder builder, FooKey key) {
  return builder
      .where('KeyColumn1', key.value1)
      .where('KeyColumn2', key.value2);
}
```

- `_whereKey` 必须覆盖 Key 的全部字段。
- 保留字继续按相邻 Repository 的方式正确引用。
- Key 本身不生成 SQL。
- 不提供接受 `Map<String, dynamic>` 的公共兼容重载长期并存。

## 7. 路由参数

详情路由初始参数直接携带 `FooKey?`，而不是 Map、代表性整数或字符串稳定编码。Key 的值相等用于正常参数比较，但不为 URL、面包屑或日志增加 `encode()` / `stableKey` 等额外协议。

页面存活期间的身份管理由 `persisted_identity_plan.md` 负责。

## 8. 实施步骤

1. 根据目标 AzerothCore 3.3.5a 物理 schema 确认定位约束。
2. 新增 `FooKey` 与完整值相等测试。
3. 为对应 Brief Entity 增加完整定位字段和 `key` getter。
4. Repository 查询、更新、删除和复制改用 `FooKey`。
5. 页面、Picker 和路由调用方移除 Map 与松散标量。
6. 每完成一个模块，将其加入强类型 Key 合同覆盖范围。

## 9. 测试

每个 Key 至少覆盖：

- `fromEntity()` 精确构造全部字段；
- 相同字段的两个实例相等且 `hashCode` 相同；
- 任一定位字段不同即不相等；
- Brief `key` 与对应数据库行定位一致；
- Repository WHERE 使用全部定位字段；
- 路由、查看、复制和删除不退回 Map 或松散键参数。

## 10. 验收标准

- 每个已迁移模块都有领域专用强类型 Key。
- Key 完整覆盖物理主键、合格唯一键或显式审查的定位器。
- 不使用 `Map<String, dynamic>` 表示或传递业务行定位器。
- Full Entity、Brief Entity 和 Key 的转换职责明确。
- 所有 Key 都显式实现完整值相等与 `hashCode`。
