# foxy_game_file

Foxy 的纯 Dart 游戏文件包，负责 DBC 读写、MPQ 读取与打包、图标提取和路径规则。

## 公开入口

统一通过 `package:foxy_game_file/foxy_game_file.dart` 使用：

| 接口 | 职责 |
| --- | --- |
| `DbcFileReader` | 校验头部容量，按 schema 读取字段值，保留原文件行索引 |
| `DbcFileWriter` | 字段归一化、写入、回读校验、文件复制与替换 |
| `DbcHeaderGuard`、`DbcFileException` | DBC 读取前的容量限制与文件诊断 |
| `MpqFilePacker` | 将已有 DBC 文件打包到 MPQ 的 `DBFilesClient` 目录，支持进度与取消 |
| `GameMpqSource`、`WarcraftyMpqSource` | MPQ 文件枚举和内容读取 |
| `GameIconExtractor`、提取 worker 与进度模型、`GameIconPaths` | 图标提取、归档优先级与路径规则 |

实现文件直接放在 `lib/src/`，测试放在 `test/`，不再增加 `core/` 层级。包内实现保持纯 Dart，不依赖 Flutter 或 `foxy_widget`。外部调用使用公开入口，不直接导入 `src/`。

`GameIconExtractor` 和提取 worker 由调用者传入客户端目录与输出目录，保存原始 BLP 文件。`GameIconPaths` 定义运行目录下的 `data/icon/<归一化名称>.blp` 缓存布局与图标名称归一化规则。

BLP 解码、图片缓存适配与图标显示位于 `foxy_widget`，由该包依赖本包。`FoxyBlpIconProvider`、`FoxyGameAssetIcon` 和 `FoxyIconText` 通过 `package:foxy_widget/foxy_widget.dart` 使用；`FoxyBlpDecoder` 是 Provider 的内部实现，不对外导出。

DBC 接口接收 `warcrafty` 的 `DbcSchema`，不接收应用的数据库表定义。读取结果携带 `index` 和字段名到值的 `values`，写入器按传入记录顺序写文件。SQL 拼接、表映射、隐藏行序列列、暂存表切换、配置保存和任务编排留在主应用；应用把文件错误、复制错误转换为自己的异常和进度模型。本包不依赖 `foxy`、`foxy_widget`、数据库或全局应用状态。

MPQ 打包按文件名排序，返回已打包文件数；空目录不创建归档，取消时保留原目标并清理临时文件。数据库导出为 DBC 后再打包的组合流程由主应用组织。

## 验证

在本包目录执行：

```sh
dart analyze
dart test
```

测试覆盖 DBC 文件往返、行顺序、字符串和字段类型、头部容量校验、文件替换、MPQ 打包读取及取消，不需要客户端或数据库。真实数据库导入导出测试留在 `foxy/test/integration/`。BLP 解码和图片显示测试及其 BLP/PNG 样本保存在 `foxy_widget` 中。
