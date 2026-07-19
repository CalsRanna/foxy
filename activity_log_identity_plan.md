# Foxy ActivityLog 身份方案

## 1. 问题

`foxy.activity_log.entity_id` 假定所有业务记录都能用一个整数表示。联合主键、字符串键和无键表无法正确映射；选择一个“代表性 ID”又会制造错误的业务身份。

ActivityLog 是展示型操作轨迹，不承担业务记录定位、导航或关联职责。

## 2. 范围

本方案只负责：

- 保留日志自身 AUTO_INCREMENT `id`；
- 删除业务 `entity_id`；
- 使用可读目标标签；
- 更新 Entity、Repository、查询、调用方和迁移；
- 保持 best-effort 写入。

本方案不负责业务 Key、详情路由或主键更新。

## 3. 身份模型

ActivityLog 自身的 `id` 是日志行唯一身份。业务目标只保存：

- 模块；
- 动作类型；
- 可读对象标签；
- 创建时间。

不得保存：

- `entityId` / `entity_id`；
- 完整 `FooKey`；
- 联合键中的代表性整数；
- 为日志生成的稳定 Key 字符串；
- 旧键和新键结构化副本。

现有 `entity_name` 可以直接承载目标标签，不要求本次重命名。

## 4. 标签

每个调用方提供适合人类阅读的标签，例如：

```text
Condition 17 / 12345
Creature 123 - 暴风城卫兵
```

标签：

- 只用于 Dashboard 展示；
- 不用于重新查询业务记录；
- 不保证全局唯一；
- 不需要可逆编码。

## 5. 数据库迁移

新增时间戳迁移删除 `foxy.activity_log.entity_id`：

- 不修改已应用的旧迁移；
- 在 `MigrationRunner` 中按时间顺序注册；
- 在隔离测试 schema 验证；
- 不针对默认 `foxy` schema 运行破坏性自动化测试。

应用回滚到依赖旧列的版本将不再兼容，应在实施记录中明确这一 schema 兼容边界。

## 6. 代码变更

- `ActivityLogEntity` 删除 `entityId` 字段、构造参数、`copyWith` 参数和 JSON 列。
- Repository 查询不再读取 `entity_id`。
- 所有调用方改为提供可读 `entityName`/target label。
- Dashboard 继续按日志自身 `id` 排序。

## 7. Best-effort 行为

业务表写入成功后调用：

```dart
storeActivityLogBestEffort(log);
```

- 日志失败只记录 Logger 错误。
- 日志失败不得把成功业务写入变成失败。
- 更新/删除未实际命中行时不得写成功日志。
- 不使用没有错误归宿的裸 fire-and-forget。

## 8. 测试

至少覆盖：

- 新迁移删除业务列并记录 migration name；
- `ActivityLogEntity.toJson()` 不包含 `entity_id`；
- `fromJson()` 不读取该列；
- 所有业务调用方不传业务 ID 或 Key；
- 标签能正常展示；
- 成功业务写后日志失败不影响返回结果；
- 更新/删除零行时不写成功日志；
- ActivityLog 自身仍使用 AUTO_INCREMENT `id`。

## 9. 验收标准

- `foxy.activity_log` 不存在业务 `entity_id`。
- 日志不承担业务对象定位职责。
- 联合键和无键表不需要伪造代表性 ID。
- 日志始终是业务写入后的 best-effort 附加行为。
