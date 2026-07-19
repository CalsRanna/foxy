# Foxy Repository 单表边界方案

## 1. 问题

部分遗留 Repository 会校验其他表中的引用、阻止删除、自动保存 locale 或在父键变化时级联子记录。这让单次编辑的影响范围难以预测，也把数据库客户端变成了不完整的业务 ORM。

## 2. 范围

本方案只负责：

- 每个 Repository 写方法只修改一个物理表；
- 删除不扫描反向引用；
- 当前表写入不校验其他表外键是否存在；
- 父键变化不隐式级联 locale 或子记录；
- 多 candidate 保存由 ViewModel 明确协调。

本方案不负责 Key 建模、主键 UI、活动日志 schema 或数据库真实约束。

## 3. 产品边界

Foxy 是通用数据库编辑器风格工具。它负责：

- 当前表字段格式和值域；
- 当前表内部交叉字段规则；
- 当前表唯一性和数据库写入错误；
- 用户明确编辑并提交的 candidate。

Foxy 不负责：

- 查询其他表验证引用对象存在；
- 扫描其他表阻止修改或删除；
- 猜测字段间跨表关系；
- 自动级联主键变化；
- 绕过 MySQL 实际存在的约束。

跨表影响由用户负责。可以显示非阻断说明，但不以潜在引用为由拒绝当前表写入。

## 4. Repository 写入边界

每个公开写方法只操作自身 `_table`：

```text
storeFoo  -> INSERT Foo 表
updateFoo -> UPDATE Foo 表
destroyFoo -> DELETE Foo 表
```

不得在同一 Repository 方法中顺带：

- 创建/更新/删除 `Foo_locale`；
- 迁移子表父键；
- 删除关联表记录；
- 写另一个业务表以“保持一致”。

成功后的 best-effort ActivityLog 是独立基础设施行为，不把业务表写入合并成级联事务。

## 5. 多 candidate 保存

如果页面明确让用户同时编辑 base 和 locale candidate，ViewModel 可以：

1. 收集并分别验证多个 candidate；
2. 调用各自 Repository；
3. 在需要原子性时使用现有数据库事务协调。

事务中的每个 Repository 仍只修改自己的表。父 Key 变化本身不自动生成 locale 或子表 candidate。

## 6. 验证边界

- 纯范围、flags、enum 和交叉字段规则留在 ViewModel validation mixin。
- 当前表唯一性可以使用当前 Repository 查询。
- 不查询其他 Repository 验证所谓外键存在。
- 不统计其他表反向引用阻止删除。
- MySQL 真实约束失败照常向用户报告。

## 7. 实施策略

按模块迁移时搜索并审查：

- `exists*` 调用其他 Repository；
- `countReferences` / `usedBy` / `canDelete`；
- destroy 前的反向引用保护；
- update 后的 locale/child 级联；
- 一个 Repository 中多个物理表名；
- 旧合同测试中要求跨表保护的断言。

删除遗留行为时同步更新对应合同测试，不复制到新模块。

## 8. 测试

至少覆盖：

- store/update/destroy 各只写当前表；
- 不调用其他 Repository 做存在性校验；
- 删除不扫描反向引用；
- 父键变化不自动迁移 locale 或 child；
- ViewModel 明确提交多个 candidate 时调用各自 Repository；
- 多 candidate 事务失败时按页面定义回滚；
- MySQL 实际约束错误仍能传播或转换。

## 9. 验收标准

- 每个已迁移 Repository 写方法只修改一个物理表。
- 不存在 Foxy 自行实施的跨表外键存在性校验或反向删除保护。
- 不因父主键变化产生隐式级联。
- 多表保存只来自用户明确编辑的多个 candidate，并由 ViewModel 协调。
