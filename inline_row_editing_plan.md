# Foxy 内嵌子表行编辑方案

## 1. 问题

父详情 Tab 中的内嵌行编辑器没有独立详情路由。用户选中一条 Brief 行后可能修改其联合键或父过滤列；如果保存时从 candidate 重新构造 Key，就无法定位原始子行。

## 2. 范围

本方案只负责内嵌子表编辑器的行身份与交互状态：

- `editingKey`；
- 新建与编辑区分；
- Brief 选择和完整实体加载；
- 保存、删除、复制和刷新；
- candidate 移出当前父查询范围后的状态清理。

父详情身份由 `persisted_identity_plan.md` 负责，行定位类型由 `row_locator_plan.md` 负责。

## 3. 核心状态

```dart
final editingKey = signal<FooKey?>(null);
```

`editingKey` 是当前选中持久化子行的原始定位器，不是 candidate 的当前键，也不是父级 `persistedKey`。

## 4. 状态转换

### 新建

1. 清空当前选择。
2. `editingKey.value = null`。
3. 调用 `createFoo()` 得到候选默认值。
4. 初始化 Controller。

### 选中已有行

1. 将 `brief.key` 赋给 `editingKey.value`。
2. 按该 Key 加载完整实体。
3. 使用完整实体初始化 Controller。

### 保存

```dart
final candidate = _collectFromControllers();
validateFooFields(candidate);

final originalKey = editingKey.value;
if (originalKey == null) {
  await repository.storeFoo(candidate);
} else {
  await repository.updateFoo(originalKey, candidate);
}
```

保存成功后：

1. 重新加载当前父过滤范围的 Brief 列表；
2. 清空选中行；
3. `editingKey.value = null`；
4. 清空或重新初始化表单。

即使 candidate 修改父过滤列后移出当前 Tab，也不得留下指向旧行的选择状态。

## 5. 父 Key 变化

父详情 `persistedKey` 变化时：

- 切换子表查询范围；
- 清空子行选择与 `editingKey`；
- 不自动改写数据库中已有子行的父 Key；
- 不把旧父 Key 下的子行迁移到新父 Key。

## 6. 删除与复制

- 删除直接使用当前选中 `brief.key`。
- 复制先按 `brief.key` 加载源行，再按创建键方案构造完整复制 candidate。
- 不使用正在编辑的 Controller 值定位删除或复制源行。

## 7. 测试

至少覆盖：

- 新建时 `editingKey == null`；
- 选中已有 Brief 后 `editingKey == brief.key`；
- 修改 candidate 键不会改变 UPDATE 的 WHERE；
- 联合键多列变化仍使用完整旧 Key；
- 保存成功后刷新并清空选择和 `editingKey`；
- candidate 移出当前父范围后不会残留选中状态；
- 保存失败时保留 `editingKey` 供重试；
- 父 `persistedKey` 变化后切换查询范围并清空编辑状态；
- 删除和复制使用 `brief.key`。

## 8. 验收标准

- 每个已迁移内嵌编辑器都有独立 `editingKey`。
- 不从 candidate 新键定位旧子行。
- 父身份、子行身份和表单草稿三者明确分离。
- 保存后的列表与选择状态和数据库当前范围一致。
