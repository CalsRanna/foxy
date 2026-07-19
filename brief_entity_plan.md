# Foxy Brief Entity 方案

## 1. 问题

部分列表、Picker 和内嵌子表使用 Full Entity 作为列表行，导致查询加载不需要的物理字段，也缺少统一的强类型行定位入口。当前还有 `getBrief*` 方法名返回 Full Entity 的情况。

## 2. 范围

本方案只负责：

- 独立 Brief Entity；
- 展示列与定位列边界；
- `FooKey get key`；
- `getBrief*` 返回类型和查询字段；
- 列表、Picker、复制、删除和详情导航使用 Brief。

本方案不负责详情 candidate、主键更新、表单控件或无键表写入算法。

## 3. 必须使用 Brief 的流程

以下任何流程暴露可编辑模块时，都必须定义专用 Brief Entity：

- 分页列表；
- 实体 Picker；
- 可编辑子表列表；
- 从列表进入详情；
- 从列表复制或删除。

不得因为 Full Entity 已存在而跳过 Brief。

## 4. 字段边界

Brief 只包含：

1. 列表或 Picker 实际展示需要的物理列/查询别名；
2. `FooKey` 所需的全部定位列。

定位列即使不渲染也必须读取。计算 getter 如 `displayText` 可以存在于 Brief，但不进入 Full Entity 的 `toJson()`。

显式全行定位器是字段收窄的例外：其 Brief 必须包含全部物理列，但返回类型仍是专用 Brief Entity。

## 5. Key getter

```dart
class BriefFooEntity {
  // displayed and locator fields

  FooKey get key => FooKey(...);
}
```

- `key` 覆盖全部定位字段。
- 查看、复制、删除和详情导航统一传递 `brief.key`。
- 不从展示文本反向解析 Key。
- 不把 Brief 本身作为 UPDATE candidate。

## 6. Repository 合同

```dart
Future<List<BriefFooEntity>> getBriefFoos({
  int page = 1,
  FooFilterEntity? filter,
});
```

- `getBrief*` 不得返回 `Future<List<FooEntity>>`。
- 查询显式 select 展示列和全部定位列。
- 使用 `kPageSize`、limit、offset 和稳定排序。
- Picker 和列表不得调用加载完整表的 `getFoos()`。
- Full `getFoos()` 只保留给详情加载之外确实需要完整数据的 DBC 导出或批处理。

## 7. 分页与过滤

- 列表 Repository 提供 `count*` 和 `getBrief*`。
- 文本过滤继续使用 `LIKE '%...%'`。
- 联合键列表使用足以稳定分页的排序列。
- locale join 只选择实际展示需要的 locale 列，不把 locale 展示别名混入 Full Entity。

## 8. 实施策略

1. 盘点返回 Full Entity 的 `getBrief*`。
2. 按模块新增 Brief Entity 和测试。
3. 收窄 Repository SELECT。
4. 页面、Picker 和内嵌列表切换到 Brief 类型。
5. 查看、复制、删除和详情导航改传 `brief.key`。
6. 将完成模块移出遗留 allowlist。

该工作独立推进，不作为 `conditions` 主键编辑纵向验证之外所有模块的前置阻塞。

## 9. 测试

至少覆盖：

- Brief 包含所有展示列；
- Brief 包含完整定位列；
- `brief.key` 构造正确；
- `getBrief*` 返回专用 Brief 类型；
- 普通 Brief 查询不加载完整物理表字段；
- 列表与 Picker 使用分页查询；
- 查看、复制和删除传递 `brief.key`；
- 查询别名和计算 getter 不进入 Full Entity candidate。

## 10. 验收标准

- 所有已迁移列表/Picker/内嵌子表使用专用 Brief Entity。
- 不存在名称为 `getBrief*` 却返回 Full Entity 的方法。
- Brief 查询只加载展示与定位所需字段。
- 列表行通过强类型 `brief.key` 暴露完整定位器。
