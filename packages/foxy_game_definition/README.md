# foxy_game_definition

Foxy 的纯 Dart 游戏定义包，集中维护 AzerothCore / 3.3.5a 游戏枚举、标志位、数值范围与参数元数据。

## 公开入口

统一通过 `package:foxy_game_definition/foxy_game_definition.dart` 使用，不跨包导入 `src/`。实现文件平铺在 `lib/src/`。

- 物品、生物、任务、法术、角色初始数据等枚举、标志位与数值定义。
- Condition、SmartScript、GameObject 参数的含义、选项和引用类型。
- `FlagItem`：位值、标签、分组以及掩码标签展开。
- `IntegerFieldSpec<R>` 及其子类型：数字、枚举、位掩码和引用参数的描述。

本包没有运行时第三方依赖，不依赖 Flutter、主应用、文件包、数据库或应用状态。参数定义只描述引用的种类；具体组件渲染、引用对象查询和编辑流程由 `foxy` 处理。

DBC 表映射 `DbcDefinitions`、多语言字段注册 `DbcLocaleFields` 及 DBC 本地化模型保留在 `foxy`。DBC/MPQ 文件操作由 `foxy_game_file` 负责，界面组件由 `foxy_widget` 负责。

## 验证

在本包目录运行：

```sh
dart analyze
dart test
```

测试通过公开入口验证游戏取值、位掩码、动态参数定义和标签展开，无需 Flutter 或数据库。实体、仓储、DBC 表映射和界面使用这些定义的测试保留在 `foxy/test/`。
