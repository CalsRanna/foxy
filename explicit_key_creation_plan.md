# Foxy 显式创建键方案

## 1. 问题

部分可编辑业务表使用 AUTO_INCREMENT 主键。若新建时向数据库提交 `0` 或 `NULL`，再通过 `insertAndGetId()` 修正页面身份，数据库最终 Key 就不再等于表单 candidate，破坏统一保存模型。

## 2. 范围

本方案只负责：

- 可编辑 AUTO_INCREMENT 主键的表单前预分配；
- `createFoo()` 与 `storeFoo()` 职责；
- 新建验证；
- 复制候选键分配；
- 并发冲突后的行为。

本方案不负责已有记录主键更新、页面路由、ActivityLog 自增 ID 或无键表。

## 3. 核心不变量

- `createFoo()` 在表单打开前返回带显式非零 Key 的完整未保存实体。
- 预分配 Key 只是可编辑默认值，用户可以修改。
- `storeFoo(candidate)` 原样插入 `candidate.toJson()`。
- Repository 不在保存阶段重新分配、替换或规范化 candidate Key。
- 可编辑业务实体不使用 `insertAndGetId()` 修正 candidate。
- `storeFoo()` 返回 `Future<void>`。
- 保存前拒绝会触发数据库隐式分配的 `0`、`NULL` 或其他哨兵值。

内部追加表如 ActivityLog 没有可编辑详情 candidate，不受本方案限制。

## 4. 创建流程

```dart
Future<FooEntity> createFoo() async {
  final nextId = await nextMaxPlusOne(...);
  return FooEntity(id: nextId);
}

Future<void> storeFoo(FooEntity candidate) async {
  _validateExplicitKey(candidate);
  await laconic.table(_table).insert([candidate.toJson()]);
}
```

不得在 `storeFoo()` 内出现：

- Key 为零时再次调用 `nextMaxPlusOne()`；
- `insertAndGetId()`；
- 使用插入返回值生成新的 Entity 或页面 Key；
- 静默替换用户修改过的 Key。

## 5. 复制流程

复制操作必须：

1. 使用源 `brief.key` 读取完整源实体；
2. 在插入前分配显式新 Key；
3. 构造包含全部物理字段的复制 candidate；
4. 调用 `storeFoo(candidate)`；
5. 不允许 store 方法选择另一个 Key。

## 6. 并发

`MAX + 1` 是可编辑默认值，不是并发唯一性保证。两个页面可能同时得到相同默认 Key；数据库唯一约束是最终保证。

发生冲突时：

- 保留当前 candidate 和用户输入；
- 显示明确中文错误；
- 不在失败后静默重新分配并自动重试；
- 用户可以修改 Key 或重新打开新建流程。

## 7. UI

- AUTO_INCREMENT 控件必须可编辑。
- 不因数据库通常自动生成该值而设为永久只读。
- 新建页展示预分配的显式非零默认值。
- 严格数字解析，空输入按现有 Controller 规则处理，但验证必须拒绝隐式分配值。

## 8. 测试

每个相关模块至少覆盖：

- `createFoo()` 返回显式非零 Key；
- 用户可修改预分配 Key；
- `storeFoo()` 原样插入 candidate；
- 零值或隐式分配哨兵被拒绝；
- store 阶段不调用 `nextMaxPlusOne()`；
- 可编辑业务 store 不使用 `insertAndGetId()`；
- store 返回 `Future<void>`；
- 复制 candidate 在插入前已经拥有最终新 Key；
- 并发重复键失败时不改写 candidate。

## 9. 验收标准

- 数据库最终 Key 始终等于 `FooKey.fromEntity(candidate)`。
- 新建和复制都在写入前持有最终显式 Key。
- Repository 保存阶段不分配或修复业务 Key。
- AUTO_INCREMENT 只影响数据库 schema，不构成 UI 只读理由。
