# Foxy 完整物理字段可编辑方案

## 1. 问题

部分详情 Entity 的 `toJson()` 包含未在表单中呈现或永久只读的物理列。保存时重新构造不完整 Entity 会覆盖未渲染字段，或者让用户无法修改数据库真实可写列。

这一问题比“主键是否可编辑”更广，不应绑在主键改造中一次解决。

## 2. 范围

本方案只负责：

- Full Entity 物理字段与表单 Controller 覆盖；
- candidate 完整收集；
- 永久只读和动态禁用边界；
- Brief 展示数据与详情 candidate 分离；
- 遗留模块的数据保全过渡策略。

本方案不负责 Key、Repository WHERE、列表分页或跨表引用。

## 3. 完整 candidate

完整详情 Entity `toJson()` 中的每个物理列都属于 candidate，并必须具备：

1. 对应 FieldController；
2. 从加载实体初始化；
3. 在 UI 中提供可编辑控件；
4. 保存时从 Controller 严格收集；
5. 相应字段验证。

物理字段重复槽必须保持显式 scalar Controller 和 UI，不用 List、Map、循环或索引分发隐藏结构。

## 4. 不构成永久只读的理由

以下情况都不能单独作为永久只读理由：

- 主键；
- AUTO_INCREMENT；
- 数据库默认值；
- Repository 提供预分配默认值；
- 旧模块惯例；
- 笼统的“业务语义限制”。

数据库字段是否可显式写入由真实 schema 决定，不由常见使用方式决定。

## 5. 动态禁用

只有当前明确类型或模式不使用某字段时，才允许临时禁用：

- 类型切换后字段重新适用时必须恢复可编辑；
- 自动清空不再适用字段时，UI 必须立即可见；
- 也可以保留草稿值，但保存前要求用户处理无效组合；
- 不得把动态禁用退化为 `isExisting` 永久只读。

## 6. 展示数据边界

以下内容不是 Full candidate 的物理字段：

- Brief 查询别名；
- locale join 的展示名称；
- `displayText` 等计算 getter；
- 列表、Picker 和面包屑组合标签。

它们不进入 INSERT/UPDATE，也不应伪装成详情页永久只读输入框。

## 7. 过渡期数据保全

遗留模块尚未完成所有控件时，允许暂时使用：

```dart
loadedEntity.copyWith(
  renderedField: controller.collect(),
)
```

以保留未渲染物理列。这只是防止数据丢失的过渡措施：

- 必须登记在模块遗留 allowlist；
- 不得视为模块完成；
- 完成改造后所有 candidate 字段都应来自可编辑控件。

## 8. Controller 与验证

- 使用与物理类型匹配的 `IntFieldController`、`DoubleFieldController`、`StringFieldController`、Flag 或 Select Controller。
- 数值解析保持严格：空输入成为零，格式错误抛 `FormatException`。
- 不恢复 `tryParse(...) ?? 0` 静默容错。
- 字段规则位于 validation mixin，不加入 Entity。
- `dispose()` 调用 `disposeControllers()`。

## 9. UI 布局

- 使用 Foxy 现有表单组件。
- 保持模块合同要求的四等宽 `Expanded` 行结构。
- 重复物理槽保持显式控件声明。
- 中国用户可见标签和错误保持中文。

## 10. 实施策略

1. 对每个模块比较 Full Entity `toJson()` 列与 Controller/UI。
2. 为缺失列先增加回归测试。
3. 补齐 Controller 初始化、UI、收集与验证。
4. 删除只因已有记录、主键、自增或默认值产生的永久只读。
5. 保留并测试真正的类型/模式动态规则。
6. 从遗留 allowlist 移除完成模块。

## 11. 测试

至少覆盖：

- `toJson()` 每个物理列存在 Controller；
- 每个 Controller 从加载实体初始化；
- 保存 candidate 收集全部字段；
- 每个物理字段有可编辑 UI；
- 主键、自增和默认值不产生永久只读；
- 动态不适用字段正确禁用并可恢复；
- 展示别名不进入 Full candidate；
- 严格数字解析没有回退；
- 遗留 copyWith 保全不会丢失未渲染列。

## 12. 验收标准

- 已完成模块的 Full Entity 物理列全部可由用户编辑。
- candidate 不因表单字段缺失而覆盖数据库数据。
- 永久只读与动态禁用的语义明确。
- Brief/Picker 展示数据和详情物理字段完全分离。
