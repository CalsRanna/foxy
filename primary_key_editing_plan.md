# Foxy 主键可编辑核心方案

## 1. 问题

Foxy 当前普遍把主键当作不可变身份：详情页锁定主键控件，Repository 更新时从 `candidate.toJson()` 中移除主键列，再使用实体当前主键定位记录。

这种模型对 `conditions` 等业务字段组成的联合主键尤其不合适。用户无法修改条件来源、条件类型和参数，而这些字段正是记录的业务内容。

## 2. 目标

本方案建立一个核心更新模型：

> 原始 Key 是打开记录时的旧行定位快照；candidate 是当前表单期望写入的完整最终数据。编辑时使用原始 Key 定位旧行，并用完整 candidate 更新它。

本方案只解决已有记录的主键更新语义，以及新建/更新操作的明确区分。

## 3. 非目标

以下问题由独立方案负责：

- Laconic 写入行数和重复键错误：`database_write_result_plan.md`；
- 强类型 Key 的字段选择与值相等：`row_locator_plan.md`；
- 页面运行期 `persistedKey`、面包屑和路由：`persisted_identity_plan.md`；
- 内嵌子表 `editingKey`：`inline_row_editing_plan.md`；
- AUTO_INCREMENT 新建和复制：`explicit_key_creation_plan.md`；
- Brief Entity：`brief_entity_plan.md`；
- 无键表：`keyless_table_editing_plan.md`；
- 跨表引用和 Repository 边界：`repository_boundary_plan.md`；
- ActivityLog：`activity_log_identity_plan.md`；
- 所有物理字段的表单覆盖：`full_field_editability_plan.md`。

本方案不要求上述独立治理轨道全项目完成后才能迁移 `conditions`。

## 4. 前置依赖

具体模块进入本方案前必须满足：

1. 已有经过物理 schema 审查的强类型 `FooKey`。
2. Repository 能获得 MySQL matched-row 语义的更新结果。
3. 数据库重复主键/唯一键错误能够稳定转换为中文错误。
4. 完整 Entity 的 `toJson()` 只包含当前物理表字段。

## 5. 核心概念

### 5.1 原始 Key

`originalKey` 是开始编辑已有记录时捕获的强类型定位快照，只用于 UPDATE 的 WHERE。用户修改表单中的主键控件不会改变它。

### 5.2 Candidate

`candidate` 是从全部表单 Controller 严格收集并完成验证后的完整实体。`candidate.toJson()` 表示用户期望写入当前表的最终状态，包括修改后的主键列。

### 5.3 新 Key

写入成功后的新定位器由 `FooKey.fromEntity(candidate)` 得到。Repository 不返回一次能够从 candidate 确定的 Key，也不在保存过程中改写 candidate。

## 6. 不变量

- 新建没有原始 Key，执行 INSERT。
- 编辑必须有原始 Key，执行 UPDATE。
- 不使用 candidate 的新 Key 定位旧行。
- 不通过“candidate 的键当前是否存在”推断创建或更新。
- 不因为字段属于主键而从 UPDATE payload 移除它。
- UPDATE 使用原始 Key 的全部定位字段作为 WHERE。
- UPDATE 使用 `candidate.toJson()` 的完整字段作为 SET。
- 更新主键只使用一条 UPDATE，不使用先删除再插入。
- 更新成功后才能将页面身份切换到新 Key。
- 写入失败时必须保留旧 Key，允许用户修正后重试。

## 7. Repository 合同

Repository 更新签名统一为：

```dart
Future<void> updateFoo(
  FooKey originalKey,
  FooEntity candidate,
) async {
  final matchedRows = await _whereKey(
    laconic.table(_table),
    originalKey,
  ).update(candidate.toJson());

  if (matchedRows == 0) {
    throw StateError('原记录不存在，可能已被其他操作修改或删除');
  }
}
```

`matchedRows` 语义由 `database_write_result_plan.md` 保证。无变化保存也必须返回 `1` 并成功。

Repository 必须逐个审计类似代码：

```dart
json.remove('ID');
json.remove('entry');
json.remove('CreatureID');
```

只有在确认删除行为唯一目的是禁止主键更新时才移除。SQL 保留字应正确引用，不能以删除字段代替引用。不得进行无审查的全局替换。

## 8. 创建与更新区分

操作类型由页面是否持有原始 Key 决定：

```dart
final originalKey = persistedKey.value;

if (originalKey == null) {
  await repository.storeFoo(candidate);
} else {
  await repository.updateFoo(originalKey, candidate);
}
```

本方案要求 `storeFoo()` 与 `updateFoo()` 对外均返回 `Future<void>`。新建键如何在表单打开前确定由 `explicit_key_creation_plan.md` 负责。

## 9. 主键冲突

编辑操作不执行候选 Key 冲突预检，无论新旧 Key 在 Dart 中是否相等：

- Dart 字符串相等可能与 MySQL collation 不同；
- 预检与 UPDATE 之间存在并发窗口。

直接执行单条 UPDATE，并把数据库 duplicate-key 错误转换为：

```text
修改后的主键已存在，无法保存。
```

UPDATE 失败时旧记录保持不变。不得使用删除再插入规避冲突。

创建操作可以做候选键存在性预检以改善提示，但数据库唯一约束仍是最终保证。

## 10. ViewModel 保存流程

详情 ViewModel 的运行期身份由 `persisted_identity_plan.md` 定义。保存核心流程为：

```dart
final candidate = _collectFromControllers();
validateFooFields(candidate);

final originalKey = persistedKey.value;
final newKey = FooKey.fromEntity(candidate);
final isCreate = originalKey == null;

if (isCreate) {
  await repository.storeFoo(candidate);
} else {
  await repository.updateFoo(originalKey, candidate);
}

persistedKey.value = newKey;
```

`newKey` 可以在写入前计算，但只能在写入成功后赋给 `persistedKey`。

## 11. UI 边界

已迁移模块不得仅因为记录已存在而锁定主键控件：

```dart
readOnly: isExisting
enabled: !isExisting
```

如果这些条件只表达“已有记录主键不可修改”，应移除。由当前业务类型或模式决定的临时动态禁用不属于本方案，仍按真实语义保留。

可以显示非阻断式说明：

```text
修改主键只更新当前记录，Foxy 不会同步修改其他表中的引用。
```

## 12. `conditions` 首个纵向验证

第一批只改造 `conditions`：

1. 使用完整 10 列 `ConditionKey`。
2. 移除 Map credential 公共 API。
3. 解锁 10 个联合主键字段。
4. Repository 使用旧 `ConditionKey` 定位并写入全部 15 列。
5. 保存成功后切换到 candidate 产生的新 Key。
6. 保留真正由条件类型和来源类型决定的动态字段规则。

不得把 ActivityLog migration、全项目 Brief 重构、AUTO_INCREMENT 或无键表加入该纵向验证。

## 13. 测试

每个迁移模块至少覆盖：

- 不修改主键时正常保存；
- 单列主键发生变化时使用旧键定位；
- 联合主键一列或多列变化时使用完整旧键定位；
- UPDATE payload 包含 candidate 的全部物理字段；
- 主键修改后连续第二次保存使用新键；
- 新主键冲突时旧记录不丢失；
- 编辑操作不执行候选键冲突预检；
- 原始行不存在时不切换页面 Key，不写成功日志；
- candidate 与当前行相同时仍成功；
- 保存失败后保留旧 Key，可以修正并重试；
- 已有记录的主键控件可编辑；
- 动态字段规则没有因解锁主键而回退。

Repository 合同必须验证：

```text
WHERE = originalKey 的全部定位字段
SET   = candidate.toJson() 的完整字段
```

## 14. 验收标准

- 已迁移模块明确区分原始 Key 与 candidate 新 Key。
- 不使用 candidate 新键定位旧行。
- 不存在仅为保持主键不可变而删除 UPDATE payload 字段的代码。
- 主键修改是一条原子 UPDATE。
- 冲突、旧行不存在和无变化保存得到正确结果。
- 成功后可以继续保存；失败后仍可使用旧 Key 重试。
- `conditions` 纵向链路独立通过测试，且不依赖其他治理方案全项目完成。
