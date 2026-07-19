# Foxy 数据库编辑架构改造索引

## 1. 目的

本文档是数据库编辑架构改造的总索引，只描述各方案的边界、依赖、实施顺序和状态，不重复各领域的具体设计。

原有 `primary_key_editing_plan.md` 同时覆盖主键更新、行定位、路由状态、Brief Entity、无键表、创建键分配、Repository 边界、活动日志和表单完整性，无法独立实施或验收。现在将这些问题拆成可以单独决策、测试和合并的领域方案。

这些方案共同适用于 Foxy 暴露的 AzerothCore world 表、`foxy.dbc_*` 镜像表、locale 表、单列键、联合键以及父子详情中的子表。是否进入某个方案取决于模块实际涉及的问题，不要求每个模块同时实施所有方案。

## 2. 方案清单

| 方案 | 负责的问题 | 状态 |
| --- | --- | --- |
| [database_write_result_plan.md](database_write_result_plan.md) | Laconic 写入结果、matched-row、删除行数、参数化 raw write、重复键识别 | 已完成 |
| [row_locator_plan.md](row_locator_plan.md) | 强类型 Key、物理主键/唯一键选择、值相等、Repository 行定位 | 已完成 |
| [primary_key_editing_plan.md](primary_key_editing_plan.md) | 使用原始 Key 定位旧行并写入完整 candidate | 已完成 |
| [persisted_identity_plan.md](persisted_identity_plan.md) | 独立详情页 `persistedKey`、连续操作、面包屑和路由生命周期 | 已完成 |
| [inline_row_editing_plan.md](inline_row_editing_plan.md) | 内嵌子表编辑器的 `editingKey`、选择和刷新状态 | 已完成 |
| [explicit_key_creation_plan.md](explicit_key_creation_plan.md) | AUTO_INCREMENT 显式预分配、新建和复制流程 | 已完成 |
| [brief_entity_plan.md](brief_entity_plan.md) | 独立 Brief Entity、`brief.key`、分页列表与 Picker 查询 | 已完成 |
| [keyless_table_editing_plan.md](keyless_table_editing_plan.md) | `playercreateinfo_cast_spell` 的全行定位与 `LIMIT 1` 写入 | 已完成 |
| [repository_boundary_plan.md](repository_boundary_plan.md) | 单 Repository 单表、不扫描引用、不隐式级联 | 已完成 |
| [activity_log_identity_plan.md](activity_log_identity_plan.md) | 移除业务 `entity_id`，改用可读目标标签 | 已完成 |
| [full_field_editability_plan.md](full_field_editability_plan.md) | 完整详情 candidate 的物理字段与可编辑控件覆盖 | 已完成 |

## 3. 依赖关系

```text
database_write_result
        ↓
row_locator
        ↓
primary_key_editing
        ↓
persisted_identity
        ↓
inline_row_editing

row_locator ───────────→ brief_entity
row_locator ───────────→ explicit_key_creation
database_write_result ─→ keyless_table_editing
row_locator ───────────→ keyless_table_editing

repository_boundary
activity_log_identity
full_field_editability
        └── 独立治理轨道，按受影响模块逐步实施
```

依赖表示后续方案需要前一方案提供的合同，不表示必须等前一方案全项目迁移完成。已经迁移并通过合同测试的具体模块可以继续进入下一步。

## 4. 推荐实施顺序

### 第一批：`conditions` 纵向验证

仅完成以下范围：

1. 升级并验证 Laconic matched-row 写入结果。
2. 新增 `ConditionKey`，替换 Map credential。
3. `ConditionRepository.updateCondition(originalKey, candidate)` 使用旧键定位并写入全部 15 列。
4. `ConditionDetailViewModel` 使用 `persistedKey`。
5. 解锁 10 个联合主键字段，同时保留真正的动态字段规则。
6. 覆盖主键冲突、无变化保存、连续保存、旧行不存在和保存失败重试。

第一批明确不包含 ActivityLog schema 迁移、全项目 Brief 补全、AUTO_INCREMENT、无键表、全项目跨表校验清理或所有模块路由改造。

### 第二批：联合键与内嵌子表

按模块改造 loot template、`npc_vendor`、`gossip_menu_option`、locale、SmartAI 和 creature/game object/quest 关系子表。独立详情页使用 `persistedKey`，内嵌编辑器使用 `editingKey`。

### 第三批：显式创建键与单列主键

先完成 AUTO_INCREMENT 显式预分配合同，再迁移 `ID`、`entry` 等单列主键模块及复制流程。

### 第四批：特殊表与独立治理轨道

在参数化 raw write 和 matched-row 能力稳定后实施无键表方案。Brief、Repository 边界、活动日志和完整字段可编辑性按各自方案独立收敛。

## 5. 全局合同测试

渐进式迁移已于 2026-07-19 收敛，遗留 allowlist 已移除。`test/database_editing_global_contract_test.dart` 现在无例外检查：

- 117 个 Brief Entity 文件均独立定义并暴露强类型身份。
- 120 个 `getBrief*` 查询均返回 Brief Entity 并使用 `kPageSize` 分页。
- 113 个候选 UPDATE 均接收 `originalKey`，并检查 matched/affected rows。
- 113 个单行 DELETE 均接收强类型 Key，并检查 deleted/affected rows。
- 26 个独立详情 ViewModel 均使用 `persistedKey`，路由层不再维护第二套详情身份。
- Repository 不再暴露候选身份推断式 `save*`、替代键返回式 `store*` 或空 UPDATE。
- 页面不再包含永久 `readOnly: true` 的物理字段，数值控制器拒绝非法输入。

各模块的 `*_database_editing_contract_test.dart` 继续覆盖物理列、复合键、完整 candidate、`editingKey`、写入失败重试和 UI 控件等领域细节。

## 6. 总体验收

总改造完成时，各领域方案分别达到自己的验收标准，并满足：

- 原始行定位与 candidate 最终数据明确分离。
- 保存成功后页面身份切换到新 Key，失败时保留旧 Key。
- 创建流程在写入前拥有最终显式键。
- 列表、Picker 和详情读取不会混用 Full/Brief Entity。
- Repository 写入边界、活动日志身份和表单字段完整性分别符合对应方案。
- `flutter analyze` 和相关测试通过，完整测试不引入超出已知基线的新失败。

2026-07-19 最终验收结果：

- `flutter analyze`：通过，无问题。
- 数据库编辑专项合同：385 项通过。
- 完整测试：707 项通过，5 项按条件跳过；仅保留仓库指南已记录的 `dbc_sync_util_test.dart` 多文件匹配基线失败。
