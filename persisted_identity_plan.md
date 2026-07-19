# Foxy 独立详情页持久化身份方案

## 1. 问题

详情路由中的初始 Key 在页面存活期间不会自动变化。如果新建首次保存或已有记录修改主键后继续读取构造参数，后续保存、删除、复制、刷新和子 Tab 会继续使用旧身份。通过替换当前路由修正参数又会重建页面并丢失运行期状态。

## 2. 范围

本方案只负责独立详情页的运行期持久化身份：

- `persistedKey` signal；
- 保存后的身份切换；
- 删除、复制、刷新和子 Tab 使用最新 Key；
- 新建/已有状态响应；
- 面包屑标签更新；
- 移除为保存而替换详情路由的 API。

内嵌子表的行身份由 `inline_row_editing_plan.md` 负责。

## 3. 核心模型

详情 ViewModel 保存：

```dart
final persistedKey = signal<FooKey?>(null);
```

路由参数 `FooKey?` 只作为首次初始化输入：

- 新建：`persistedKey.value = null`；
- 编辑：先把路由 Key 赋给 `persistedKey.value`，再按该 Key 加载记录。

页面存活后，`persistedKey` 是当前持久化记录身份的唯一事实来源。Controller 中尚未保存的 candidate 主键不得提前写入 signal。

## 4. 保存后的切换

```dart
final originalKey = persistedKey.value;
final newKey = FooKey.fromEntity(candidate);

if (originalKey == null) {
  await repository.storeFoo(candidate);
} else {
  await repository.updateFoo(originalKey, candidate);
}

persistedKey.value = newKey;
```

- 写入成功后才切换。
- 写入失败时保留旧 Key。
- 普通字段保存也可以重新赋相等的新 Key，但不得重建页面。
- 不额外维护重复的 `_originalKey` 或 `_originalCredential`。

## 5. 页面消费者

以下状态必须通过 `Watch` 读取 `persistedKey`：

- 页面标题和“新建/编辑”状态；
- 保存操作的 create/update 分支；
- 删除、复制和重新加载；
- 只有父记录持久化后才可使用的子 Tab；
- 子 ViewModel 当前父过滤键；
- 依赖父 ID 的缓存或筛选条件。

子 Tab 在父 Key 变化后查询新范围，不自动迁移旧 Key 下的子行。

## 6. 路由与面包屑

- 当前详情路由不因保存而 replace、push 或重建。
- AutoRoute 栈保留首次初始化参数是可接受的。
- 面包屑显示名称通过 `RouterFacade.updateCurrentLabel()` 更新 `path` signal。
- 删除 `RouterFacade.replaceCurrentDetail`。
- 删除未参与查找、比较、去重或导航的 `RouterNode.id`。
- `RouterFacade.navigateToDetail` 不再要求冗余字符串 `id`。
- 不给 `FooKey` 增加只用于路由身份的稳定字符串编码。

本项目当前不依赖 URL 深链或进程重启后的详情状态恢复。未来如增加恢复能力，应单独设计持久化状态。

## 7. 路由生成

当详情页声明从松散标量或 Map 改为 `FooKey?` 时，运行：

```bash
dart run build_runner build --delete-conflicting-outputs
```

提交生成的 `lib/router/router.gr.dart`，不得手工编辑。仅更新 `persistedKey.value` 不需要重新生成路由。

## 8. 操作语义

- 保存主键变化后，删除使用新 Key。
- 复制以新 Key 重新读取当前记录。
- 刷新使用 `persistedKey.value`。
- 返回列表后由列表正常刷新，不在内存中猜测替换旧行。
- 保存失败后仍可用旧 Key 重试。

## 9. 测试

至少覆盖：

- 编辑初始化把路由 Key 写入 `persistedKey`；
- 新建初始化保持 null；
- 首次保存后 signal 从 null 变为新 Key；
- 主键修改后 signal 切换到新 Key；
- 连续第二次保存使用新 Key；
- 保存失败时 signal 保留旧 Key；
- 删除、复制和刷新使用 signal，不读取初始参数；
- 子 Tab 在 signal 变化后切换查询范围；
- 保存不调用 route replace；
- 面包屑标签更新但页面不重建；
- `RouterNode` 不再保存冗余 `id`。

## 10. 验收标准

- 独立详情页只有一个运行期持久化身份 signal。
- 初始路由参数不再承担页面存活期身份。
- 新建首次保存和主键变化均不重建详情页。
- 所有后续操作使用最新 Key。
- 保存失败不会丢失旧行定位能力。
