# Foxy 单列行定位器简化方案

> 实施后的永久物理分类与消费层审计见
> `scalar_row_locator_schema_inventory.md`；全局合同以该分类验证标量与专用
> 定位器，不再把 Key 类是否存在当作正确性依据。

## 1. 背景

第一轮数据库编辑重构为每个可编辑模块引入了领域专用 `FooKey`，统一解决了
旧行定位、联合主键漏列、候选主键修改、路由身份和内嵌子表身份等问题。这个
模型对联合键、特殊唯一键和无键表是必要的，但对只有一个普通物理主键列的表
产生了较多低价值样板代码：

- 单字段 Key 类及其构造函数；
- `fromEntity()`；
- 手写 `operator ==` 和 `hashCode`；
- Brief、Repository、ViewModel、路由和测试中的包装与解包；
- 大量只验证 `FooKey(id)` 与整数 `id` 等价的合同测试。

单列标量已经具备正确的值相等语义，而 Foxy 的 Repository、Brief Entity、
Picker delegate 和路由都是领域专用 API，通常不存在把一种记录的 ID 传给另一
种 Repository 的通用入口。因此，把所有单列主键都包装为 nominal Key 的收益
不足以抵消项目规模上的维护成本。

本方案只简化行定位器的表示，不回退第一轮重构建立的身份生命周期和数据库
写入不变量。

## 2. 目标

- 单列普通定位器直接使用数据库物理列对应的 Dart 标量类型。
- 联合键、特殊比较、nullable 定位和无键表继续使用专用 Key 值对象。
- 保留 `originalKey`、`persistedKey` 和 `editingKey` 的语义名称。
- 保留“旧行定位器”和“完整 candidate”严格分离。
- 删除无业务价值的单字段 Key 文件、转换代码和测试。
- 让全局合同验证“定位器完整且语义正确”，而不是验证“每张表都有 Key 类”。

## 3. 非目标

本方案不改变：

- 主键字段可编辑；
- UPDATE 使用旧行定位器，写入 candidate 全部物理字段；
- UPDATE 使用 matched-row 语义；
- DELETE 检查实际删除行数；
- AUTO_INCREMENT 在打开表单前显式预分配；
- Full Entity 与 Brief Entity 分离；
- Repository 单次写入只修改一张物理表；
- 不执行跨表引用扫描、隐式级联或外键存在性校验；
- `playercreateinfo_cast_spell` 的全行定位和 `LIMIT 1` 策略。

本方案也不引入通用 `PrimaryKey<T>`、反射、Map locator 或字符串稳定编码。

## 4. 定位器分类规则

每张表按物理 schema 归入以下一种类型。

### 4.1 普通单列定位器：使用标量

同时满足以下条件时，直接使用物理列类型：

1. 表存在单列 `PRIMARY KEY`；或者没有主键，但存在单列、非空的物理
   `UNIQUE` 约束；
2. 定位只需要普通 MySQL 等值比较；
3. 不需要区分多个 nullable 唯一值；
4. 不需要 binary、null-safe 或 `LIMIT 1` 等特殊语义。

示例：

```dart
Future<void> updateAchievement(
  int originalKey,
  AchievementEntity candidate,
) async {
  final matchedRows = await laconic
      .table(_table)
      .where('ID', originalKey)
      .update(candidate.toJson());

  if (matchedRows == 0) {
    throw StateError('原记录不存在，可能已被其他操作修改或删除');
  }
}
```

标量类型必须与物理列兼容，例如 `int`、`String`。不得为了统一外观把所有键
强制转换成 `int` 或 `String`。

### 4.2 联合定位器：保留专用 Key

定位约束包含两个或更多物理列时，继续使用专用 Key：

```dart
final class ConditionKey {
  final int sourceTypeOrReferenceId;
  final int sourceGroup;
  // 其余全部物理主键列……
}
```

专用 Key 必须继续满足：

- 显式声明全部定位列；
- 字段类型和可空性与数据库一致；
- 从全部字段实现值相等和 `hashCode`；
- Repository WHERE 覆盖全部字段；
- 不使用 Map、List、索引分派或反射隐藏物理结构。

### 4.3 特殊定位器：保留专用 Key

即使定位字段数量为一，只要存在以下任一条件，也保留经过审查的专用类型或
独立方案：

- nullable 定位语义；
- MySQL null-safe equality；
- binary 文本比较；
- 没有主键或合格唯一约束；
- 必须使用全行快照；
- 必须限制 `UPDATE` / `DELETE` 为一行；
- 一个公共、跨领域 API 确实同时接收多种相同标量类型，且编译期混淆风险已
  被实际调用关系证明。

最后一种情况必须有具体调用证据，不能仅以“以后可能误传”为由保留所有
单字段包装类。

### 4.4 不使用 typedef 或 extension type 作为默认替代

- `typedef FooKey = int` 不提供 nominal 类型安全，只会更换名字，没有必要。
- Dart extension type 虽能提供零运行时成本的 nominal 边界，但仍保留包装、
  转换和 API 迁移成本；Foxy 当前领域专用 Repository 已经提供足够边界。
- 如果未来出现真实的跨领域通用 API，可以只为该 API 涉及的身份引入
  extension type，不作为全项目默认规则。

## 5. 各层 API 约定

### 5.1 Brief Entity

Brief Entity 继续暴露语义统一的 `key`，但单列键返回标量：

```dart
final class BriefAchievementEntity {
  final int id;
  final String name;

  int get key => id;
}
```

保留 `key` 而不统一改成 `id`，因为真实物理列可能名为 `ID`、`entry`、
`recordId` 或其他名称。调用方仍然可以统一传递 `brief.key`。

联合和特殊定位器继续返回专用类型：

```dart
ConditionKey get key => ConditionKey(/* 全部定位列 */);
```

### 5.2 Repository

单列定位器直接作为公共参数：

```dart
Future<FooEntity?> getFoo(int key);

Future<void> updateFoo(
  int originalKey,
  FooEntity candidate,
);

Future<void> destroyFoo(int key);
```

必须保留以下规则：

- 参数名使用 `originalKey` 或 `key`，不使用 candidate 当前字段定位旧行；
- UPDATE 写入完整 `candidate.toJson()`；
- 更新键冲突由数据库唯一约束最终裁决；
- matched rows 为 0 时报告原记录不存在；
- DELETE 为 0 行时报告原记录不存在；
- 不增加接受旧 `FooKey` 和标量的双重兼容重载。

### 5.3 独立详情 ViewModel

继续使用 `persistedKey`，只改变 signal 的类型：

```dart
final persistedKey = signal<int?>(null);
```

保存逻辑保持不变：

```dart
final originalKey = persistedKey.value;

if (originalKey == null) {
  await repository.storeFoo(candidate);
} else {
  await repository.updateFoo(originalKey, candidate);
}

persistedKey.value = candidate.id;
```

不建议全局改名为 `persistedId`。`persistedKey` 表达的是统一的生命周期语义，
而其具体类型可以是标量或联合 Key；保留名称能减少无价值的路由和 UI 改动。

### 5.4 内嵌编辑器

单列子表使用标量 `editingKey`：

```dart
int? editingKey;
```

选择 Brief 行时保存 `brief.key`，保存成功后切换成 candidate 的新标量键，失败
时保留旧值。联合子表继续使用专用 Key。

### 5.5 路由

单列详情路由使用物理标量：

```dart
const FooDetailRoute({int? key});
```

路由参数仍只负责首次加载；页面存活期间继续以 ViewModel 的 `persistedKey`
为真实身份。修改路由声明后统一运行 build_runner，不手改 `router.gr.dart`。

### 5.6 candidate 新身份

单列模块不再调用 `FooKey.fromEntity(candidate)`，直接读取对应物理字段：

```dart
persistedKey.value = candidate.id;
```

联合和特殊模块继续从完整 candidate 构造专用 Key。

## 6. 实施方式

### 6.1 先建立物理 schema 清单

在修改源码前审计所有现有 `*_key.dart`，为每个定位器记录：

- 物理表；
- 主键或唯一约束来源；
- 定位列及其可空性；
- 标量、联合或特殊分类；
- 使用它的 Brief、Repository、ViewModel、路由和 Picker。

这个清单是 schema 决策记录，不是迁移期 allowlist。分类必须来自物理约束，
不得只通过 Key 类当前恰好有几个字段进行机械判断。

### 6.2 先做两个试点

选择两个代表模块验证简化边界：

1. 一个普通单列 DBC 模块，例如 `achievement`；
2. 一个具有创建、复制、Picker 或 AUTO_INCREMENT 流程的 world 模块。

试点必须完整迁移 Entity/Brief、Repository、ViewModel、页面、路由和测试，不能
留下 `FooKey` 与标量长期双轨。确认以下行为后再扩大范围：

- 新建；
- 无变化保存；
- 主键修改；
- 连续保存；
- 主键冲突；
- 原记录并发删除；
- 删除；
- 复制；
- 列表和 Picker 打开详情。

### 6.3 按领域分批迁移

建议顺序：

1. 简单只读引用较少的 DBC 单列键；
2. 普通 world 单列键；
3. 带 Picker 和详情路由的单列键；
4. 带内嵌编辑器、复制或 AUTO_INCREMENT 的单列键；
5. 最后审计剩余 Key，确认全部确实属于联合或特殊定位器。

每个模块的修改顺序：

1. Brief `key` 改为标量；
2. Repository 公共方法和 `_whereKey` 改为标量；
3. ViewModel `persistedKey` / `editingKey` 改为标量；
4. 页面、Picker 和路由改传 `brief.key` 标量；
5. candidate 新身份改为读取物理字段；
6. 删除单字段 `FooKey` 文件和专属样板测试；
7. 更新该模块合同测试；
8. 有路由变化时按批次统一生成 `router.gr.dart`。

## 7. 合同测试调整

### 7.1 全局合同表达定位器完整性

将“所有模块都有专用 FooKey”的合同改为：

- 普通单列表使用准确的物理标量类型；
- 联合和特殊表使用专用 Key；
- Brief 始终包含全部定位列并暴露 `key`；
- Repository UPDATE 始终接收独立 `originalKey`；
- DELETE 始终接收完整 locator；
- 不允许 Map、反射或字符串编码 locator；
- candidate 当前键不得用于定位旧行。

### 7.2 保留的 Key 合同

联合和特殊 Key 继续测试：

- 全部字段构造；
- 任一字段变化导致不相等；
- `hashCode` 覆盖全部字段；
- Brief `key` 完整；
- Repository WHERE 完整。

### 7.3 标量模块合同

标量模块至少覆盖：

- Brief `key` 等于真实物理键字段；
- Repository 使用 `originalKey` 定位；
- candidate 的新键包含在完整 UPDATE payload 中；
- 保存成功后 `persistedKey` / `editingKey` 更新为 candidate 标量键；
- 保存失败后旧标量键保持不变；
- 不存在遗留单字段 `FooKey` 包装。

测试中可以维护“经物理 schema 审查后必须保留的联合/特殊定位器清单”，但它
是永久架构分类，不得重新变成迁移期例外 allowlist。

## 8. 风险与控制

### 8.1 跨领域整数误传

风险：多个模块都使用 `int`。

控制：

- Repository 和 ViewModel API 保持领域专用；
- 不新增 `destroyByKey(Object)`、通用 Map CRUD 等跨领域入口；
- Picker delegate 保持具体实体类型；
- 路由类型和参数名保持具体页面边界。

如果未来确实出现一个跨领域泛型 API，再针对该入口评估 extension type，而不
预先让所有表承担成本。

### 8.2 大规模机械删除遗漏调用方

控制：

- 按领域小批提交；
- 每批先运行模块合同，再运行全局数据库编辑合同；
- 路由批次运行 build_runner；
- 用 `rg` 检查被删除 Key 类型的全部引用；
- 不保留临时兼容构造函数掩盖遗漏。

### 8.3 误删实际特殊定位器

控制：

- 分类依据是物理 schema 和比较语义，不是字段数量；
- nullable unique、binary comparison、全行定位和 `LIMIT 1` 必须单独审查；
- `playercreateinfo_cast_spell` 明确保留现有专用 Key。

## 9. 验收标准

- 所有普通单列定位器使用数据库兼容的 Dart 标量类型。
- 不再存在仅包装一个普通标量字段的 `FooKey` 类。
- 所有联合和特殊定位器继续由专用 Key 完整表达。
- Brief、Repository、ViewModel、路由和 Picker 不存在标量/包装类双轨 API。
- `originalKey` 与 candidate 始终分离。
- 主键修改、连续保存、失败重试、并发删除、删除和复制行为不变。
- 全局合同不再把“存在 Key 类”误当成“定位正确”。
- `flutter analyze` 通过。
- 数据库编辑专项合同全部通过。
- 完整测试不引入超出已知 DBC 基线的新失败。

## 10. 决策结论

Foxy 的最终规则调整为：

> 行定位器必须完整、不可含糊，并与 candidate 分离。普通单列定位器使用其
> 物理标量类型；联合、nullable、特殊比较或无键表定位器使用专用 Key 值对象。

这条规则保留第一轮重构真正需要的数据库正确性，同时移除单列包装类带来的
低价值复杂度。
