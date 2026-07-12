# Repository CRUD 模板清单

> 状态：**已落地对齐 `lib/repository/` 与 `AGENTS.md`（2026-07-10）**  
> 目的：约定 `lib/repository/` 统一 CRUD 表面与写法。  
> 原则：**模板定义契约；标准方法以约定为准；一张表一个 Repository。**

---

## 1. 目标与非目标

### 1.1 目标

- 所有业务 Repository 遵循**同一套 CRUD 动词与命名**。
- 同类操作在不同模块间**可预期**（参数、返回值、副作用一致）。
- **列表页与 Entity Picker 共用** `getBrief*` + `count*`（精简列 + 分页）；二者共用同一套 `Brief{Entity}Entity`。
- **`get{Entities}` 保留**：返回**全字段**实体，用于 DBC 导出等需要「全部列、全部行」的场景，**不**给列表/Picker 用。

### 1.2 非目标（本清单不要求）

- 不强制所有表字段集合相同。
- 不在本阶段引入泛型 BaseRepository / 代码生成（可作为后续优化，非模板前提）。
- 不统一 UI / ViewModel（仅 Repository 层；Picker 迁移到 Brief 可在落地阶段做）。

---

## 2. 通用约定

### 2.1 结构

```dart
class FooRepository with RepositoryMixin {
  static const _table = '...';           // 必填
  // 仅「分表 locale」且暂挂本仓储时：_localeTable（目标仍是独立 Locale Repository）
  // DBC 宽表多语言列：无 _localeTable，语言字段即本表列

  // —— 公开 API：按下方固定顺序排列 ——
  // getBrief* / get*s / count* / get* / create* / store* / update* / destroy* / copy* / save*
  // 分表 locale 另见 §4.3.A（独立 Locale Repository 或过渡 get/save*Locales）

  // —— 私有 ——
  // _getNextId | _getNextEntry | _applyFilter | 其它仅本文件使用的 helper
}
```

- 一律 `with RepositoryMixin`，使用 `laconic` 与 `kPageSize`（默认 50）。
- 表名：`static const _table`；跨库 DBC 用 `foxy.dbc_*` 全名。

### 2.2 命名

| 操作 | 方法名模式 | 说明 |
|------|------------|------|
| 分页精简列表 | `getBrief{Entities}` | 列表页与 Picker；只拉展示列 |
| 全量完整列表 | `get{Entities}` | **全部列 + 全部行**；**仅** DBC 导出等批处理 |
| 计数 | `count{Entities}` | 与 `getBrief*` 共用 filter 语义（分页 UI） |
| 单条 | `get{Entity}` | 详情 / 编辑；可空见 §3.4 |
| 内存占位（不落库） | `create{Entity}` | 正式模板方法，见 §4.1 |
| 插入 | `store{Entity}` | 参数用语义名，见 §3.5 |
| 更新 | `update{Entity}` | |
| 删除 | `destroy{Entity}` | 不用 `delete` |
| 复制 | `copy{Entity}` | 返回 `void`，见 §3.8 |
| 存在则更新否则插入 | `save{Entity}` | 正式模板方法，见 §4.2 |
| 分表 locale 读写 | `get{Entity}Locales` / `save{Entity}Locales` | **仅**世界库分表 locale（§4.3.A）；DBC 宽表不适用 |

**禁止：** `search` / `query` 等与上表重复的列表别名。

实体名与表语义对应，保持现有模块用词（`CreatureTemplate`、`ItemTemplate`、`QuestTemplate` 等）。

### 2.3 方法声明顺序（公开方法）

1. `getBrief*`
2. `get*s`（全量完整列表；导出用）
3. `count*`
4. `get*`（单条）
5. `create*`
6. `store*`
7. `update*`
8. `destroy*`
9. `copy*`
10. `save*`（upsert）
11. 分表 locale（仅 §4.3.A 过渡挂靠时）：`get*Locales` / `save*Locales`
12. 其它公开辅助（如必须预显号的 `getNextMenuId`，尽量少；优先 private `_getNext*`）

私有方法放在所有公开方法之后：`_getNextId` / `_getNextEntry` → `_applyFilter` → 其它。

### 2.4 局部写法（轻量风格，与模板绑定）

- Query builder 链式重赋值可用 `var builder`。
- 不再赋值的局部量优先 `final`。
- `count`：`return builder.count();`（不必 `return await`）。
- 文本模糊查询统一：`comparator: 'like'`，值为 `'%$keyword%'`。
- 主键类筛选字段是否 `int.tryParse`：**按表约定**（有的列本就字符串语义，不强行全仓统一）。

---

## 3. 标准 CRUD 模板（独立主实体）

适用于：每张业务表对应的 Repository（世界库、DBC、条件、智能脚本等）。  
`{Entity}` / `{Entities}` / `{Filter}` 为占位。

### 3.1 分页精简列表 — `getBrief{Entities}`

```dart
Future<List<Brief{Entity}Entity>> getBrief{Entities}({
  int page = 1,
  {Filter}Entity? filter,
}) async
```

- **用途（同一方法、同一返回类型）：**
  - 模块**分页列表**表格
  - Entity **Picker**
- 本表列 + **需要展示的关联列**一并 `select`；关联列通过 laconic **`leftJoin` / `join`** 挂上（见 §5.3），映射进 `Brief{Entity}Entity`。
- `offset = (page - 1) * kPageSize`，`limit(kPageSize)`。
- 用户筛选条件走 `filter` + `_applyFilter`（`where` / `whereAny`），**不是**用 Filter 表达表关联。

**与 `get{Entities}` 的分工：** 列表 / Picker **只**走 `getBrief*`；禁止为 UI 去调全量完整列表。

#### Brief 字段规则（硬约定）

```
Brief 字段集  ⊇  分页列表展示列
Brief 字段集  ⊇  Picker 展示列
```

更具体：

1. **Brief 以分页列表列集为基准：** `Brief 字段集 ≡ 列表列集`。
2. **Picker 列 ⊆ Brief**（与列表相同，或更少；不得出现 Brief 没有的字段）。
3. **不允许：** 为 Picker 再写分页 `get{Entities}`、单独查全实体、或第二套 `PickerFoo` DTO。
4. 列表加列 → 同步改 Brief 与 `getBrief*` 的 `select`（及必要 join）。

示意：

```
列表列:  [ id, name, level, icon ]  ──► Brief = [ id, name, level, icon ]
Picker列: [ id, name ]  (⊆ Brief，合法)
详情/导出: 全表字段 ──► get{Entity} / get{Entities}
```

### 3.2 全量完整列表 — `get{Entities}`

```dart
// 导出场景：无 page；一般无 filter（全表）
Future<List<{Entity}Entity>> get{Entities}() async
// 若确有「按条件导出子集」再保留可选 filter（默认不用）
// Future<List<{Entity}Entity>> get{Entities}({{Filter}Entity? filter}) async
```

- **用途：几乎专用于 DBC 导出**（及同类全表批处理）；**不是** UI 列表 API。
- 返回 **`{Entity}Entity` 全字段**，**不是** Brief。
- **不分页**：一次取全部行；不设 `page` / `kPageSize`。
- **禁止**用于列表页、Picker（必须走 `getBrief*` + `count*`）。

**实现注意：**

- 大表（如 `dbc_spell`）内存压力大；首版全量加载；不够再引入流式/分批，**不**把 UI 分页语义塞回本方法。
- **DBC 导出须走 Repository.`get{Entities}`**（不再以 isolate 内手写 `SELECT *` 为长期方案；落地时改 `DbcExportUtil`）。

### 3.3 计数 — `count{Entities}`

```dart
Future<int> count{Entities}({{Filter}Entity? filter}) async
```

- filter 与 `getBrief*` **完全一致**（服务分页 UI）。
- 实现上与 `getBrief*` 共用 `_applyFilter`（及 filter 依赖的相同 join）。
- 若 `_applyFilter` 会打到关联表列上，`count*` 须与 `getBrief*` 使用**相同的 join**，否则计数与列表不一致。
- 导出用的 `get{Entities}` 一般不 join 展示表；与 `count*` 无强制同一套 join。

### 3.4 单条 — `get{Entity}`

```dart
// 单列主键（可空）
Future<{Entity}Entity?> get{Entity}(int id) async
// 或 entry
Future<{Entity}Entity?> get{Entity}(int entry) async
// 复合主键：每个主键列一个参数（禁止 Map）
Future<{Entity}Entity?> get{Entity}(int menuId, int textId) async
```

- 用途：**详情 / 编辑**，返回全字段 `{Entity}Entity` 单行。
- 与 `get{Entities}` 区别：本方法按主键取**一行**；`get{Entities}` 取**全表全部行**（导出）。
- 若详情需要关联展示列，允许在本查询中 `leftJoin`（与 §5.3 一致）；写路径仍只更新 `_table`。
- **空结果（已定）：** 找不到 → `null`；调用方判空（符合 UI）。全仓统一可空，去掉「标了 `?` 却 `!` 强解」。

### 3.5 新增 — `store{Entity}`

```dart
// 主键由库内 MAX+1（或等价）分配时：
Future<int> storeCreatureTemplate(CreatureTemplateEntity template) async
// 主键由调用方给出（复合键、业务键）时：
Future<void> storeCondition(ConditionEntity condition) async
```

- 自动分配主键：在 Repository 内写入 json，**返回新主键**（供 ViewModel 写回 controller）。
- **参数名用语义名**（`template` / `achievement` / `condition` 等），不强制统一成 `entity`。
- 插入使用 `laconic.table(_table).insert([json])`。
- MySQL 保留字等表特例在 store/update/copy 中同样处理。

### 3.6 更新 — `update{Entity}`

```dart
Future<void> update{Entity}({Entity}Entity entity) async
// 复合主键且允许改键时：原主键列各一个参数 + entity
Future<void> update{Entity}(
  int menuId,
  int textId,
  {Entity}Entity entity,
) async
```

- `toJson()` 后 **remove 主键字段**，再按主键 `where` 更新。
- 复合主键参数与 `get` / `destroy` 列序、命名一致。

### 3.7 删除 — `destroy{Entity}`

```dart
Future<void> destroy{Entity}(int id) async
// 复合主键：与 get 相同，每列一个参数
Future<void> destroy{Entity}(int menuId, int textId) async
```

- 动词统一 `destroy`，不使用 `delete*`。
- 是否级联删除其它表行：**不在本模板强制**；行为另文约定。默认仅删本表匹配行。

### 3.8 复制 — `copy{Entity}`

```dart
Future<void> copy{Entity}(int id) async
// 复合主键：与 get 相同，多参数
Future<void> copy{Entity}(int menuId, int textId) async
```

- 返回 **`void`**（不返回新主键）。
- 读取源行 → 分配新主键 → insert。
- 默认**浅拷贝本表一行**；级联/深拷贝**不在本模板范围**。

### 3.9 过滤 — `_applyFilter`

```dart
QueryBuilder _applyFilter(
  QueryBuilder builder,
  {Filter}Entity? filter,
) { ... }
```

- `filter == null` 时原样返回。
- 空字符串条件不施加 where。

### 3.10 主键分配 — `_getNextId` / `_getNextEntry`

```dart
Future<int> _getNextId() async      // 列名为 ID
Future<int> _getNextEntry() async   // 列名为 entry
```

- 实现：委托 `RepositoryMixin.nextMaxPlusOne`（`MAX(pk) + 1`，空表从 1）。
- 范围序号（父键下子序号）用 `nextMaxPlusOne(table, column, where: {...})`。
- 公开的 `getNext*` 尽量少；UI 预显号优先走 `create*`。

---

## 4. 扩展动词（同属模板，语义固定）

### 4.1 `create{Entity}` — 不落库（正式模板，各业务表均提供）

```dart
Future<{Entity}Entity> create{Entity}(/* 可选：预填默认值或下一序号所需参数 */) async
```

- **只构造**默认/空白实体，**不** `insert`。
- **必须**通过 `_getNext*` / `nextMaxPlusOne` 预填自增主键，供新建表单只读展示。
- 新建详情 / 弹窗：`id == null` 时 ViewModel 调 `create*`，**禁止**在 ViewModel 内自行算号。
- 主键在 UI 上**始终 `readOnly: true`**（新建与编辑相同）。
- 与 `store` 严格区分：`create` ≠ 插入。

### 4.1.1 `store{Entity}` 与预填主键

- 实体主键 **`> 0`**（来自 `create*` 预填）时：`store` **沿用**该主键插入。
- 主键为 `0` 时：`store` 再调用 `_getNext*` 分配（兜底）。
- 保证表单展示的编号与落库编号一致。

### 4.2 `save{Entity}` — upsert（正式模板，各业务表均提供）

```dart
Future<void> save{Entity}(CreatureTemplateEntity template) async // 参数语义名
```

- 语义：存在则 `update`，不存在则 `store`。
- 各业务表均提供该方法；调用方仍可直接用 `store` / `update`。
- 典型：按主键可能尚无行的编辑（如 addon 的 `entry`）。

### 4.3 本地化：两种数据形态（必须分开处理）

本地化**不是**一种统一的 Repository 模式，取决于数据从哪来：

| 形态 | 来源 | 存储方式 | 例 |
|------|------|----------|-----|
| **A. 分表 locale** | 世界库 / acore 常规表 | **另一张表**，行式：`(entry, locale, Name, …)` | `creature_template_locale`、`item_template_locale`、`quest_template_locale` |
| **B. 同表多语言列** | **DBC 导入**到 `foxy.dbc_*` | **同一张表**上多列：`Title_lang_zhCN`、`Name_lang_enUS` 等 | `foxy.dbc_achievement`、`foxy.dbc_spell`、`foxy.dbc_area_table` |

---

#### 4.3.A 分表 locale（普通数据库表）

- Locale **是独立表** → 按「一表一 Repository」：
  - **目标：** 独立 `*LocaleRepository`（如 `CreatureTemplateLocaleRepository`），CRUD 同本模板。
  - **过渡：** 可暂把下列方法挂在业务表 Repository 上（现网常见），但须标明这是挂靠，不是「locale 不是表」。

```dart
Future<List<{Entity}LocaleEntity>> get{Entity}Locales(int id) async

Future<void> save{Entity}Locales(
  int id,
  List<{Entity}LocaleEntity> locales,
) async
```

- `save*Locales`：事务内按关联键 delete 再 insert（允许空列表 = 清空）。
- 列表展示本地化名：业务表 `getBrief*` 上对 locale 表做 **`leftJoin`**（见 §5.3），`on locale = 'zhCN'`（或配置语言）。
- **不要**把分表 locale 的字段做成主表 Entity 上的 `nameLangZhCN` 一长串列（那是 DBC 形态）。

---

#### 4.3.B 同表多语言列（DBC 导入表）

- **没有**单独的 `*_locale` 表；多语言已是本表列的一部分。
- **只有一个 Repository**（对应这一张 `foxy.dbc_*` 表），**不**建 `*LocaleRepository`，**不**提供 `get*Locales` / `save*Locales`。
- 读写多语言 = 普通字段读写：
  - `get` / `store` / `update` 的 Entity 含 `titleLangZhCN`、`titleLangEnUS` 等；
  - `getBrief*` 的 Brief 只 select 列表/Picker 需要的语言列（通常 `*_lang_zhCN` 或当前 UI 语言对应列）；
  - `get{Entities}` 导出时带上 **DBC 要求的全部语言列**（全列）。
- 列表需要「中文名」时：**不必 join locale 表**，直接 `select` 本表 `Name_lang_zhCN` 等。
- 切换展示语言：改 Brief/`getBrief*` 的 select 列（或映射），不是 join 另一张表。

```
分表 locale:   creature_template  ──join──►  creature_template_locale (多行/多 locale)
DBC 宽表:      foxy.dbc_spell 一行内 Name_lang_zhCN | Name_lang_enUS | …
```

---

## 5. 表与 Repository 的对应（无「主从表」）

### 5.1 基本原则

| 约定 | 说明 |
|------|------|
| **一对一** | **一个 Repository 对应一张数据库表**（`static const _table`） |
| **无主从分类** | Repository 层**不**区分「主表 / 子表 / 从表」 |
| **同一套 CRUD** | 每张业务表的 Repository 都套 §2～§3 同一套动词 |

例：

- `CreatureTemplateRepository` → 表 `creature_template`
- `CreatureTemplateAddonRepository` → 表 `creature_template_addon`
- `NpcVendorRepository` → 表 `npc_vendor`

页面如何组织 Tab、是否「挂在某个详情下」与 Repository 划分无关。

### 5.2 主键形状

只影响 `get` / `update` / `destroy` / `copy` 的参数，**不**引入第二套模板：

| 主键 | 参数示例 |
|------|----------|
| 单列 `ID` / `entry` | `getFoo(int id)` |
| 复合主键 | **多参数**，每列一个，与 `get`/`update`/`destroy`/`copy` 对称，例如 `getFoo(int menuId, int textId)`；**禁止** `Map<String, dynamic>` |

局部序号（如某列范围内的 `MAX(slot)+1`）是该表自己的主键/唯一键策略，写在该 Repository 的 `_getNext*` / `store` / `copy` 里即可。

### 5.3 关联查询 = laconic `join` / `leftJoin`（写清楚）

Repository **仍然只对应一张主查表**（`_table`）。  
若 Brief / 详情需要**另一张物理表上的列**（分表 locale 名、图标 DBC 等），在**本 Repository 的查询**里用 laconic 做 JOIN。  
**DBC 同表多语言列不是「另一张表」**，见 §4.3.B，用本表 `select` 即可。

#### 机制对照

| 需求 | 做法 | 典型 API |
|------|------|----------|
| 分表 locale / 它表字段用于列表/Picker | `leftJoin` / `join` + `select` | `getBrief*`；`count*` 在 filter 命中关联列时用**相同 join** |
| DBC 本表语言列用于列表/Picker | **不 join**，`select` `*_lang_zhCN` 等本表列 | `getBrief*` |
| 详情单行需要它表列 | join | `get*`（可选） |
| 用户输入的筛选 | `where` / `whereAny` / `_applyFilter` | `filter` 参数 |
| 按主键写本表 | 只动 `_table` | `store` / `update` / `destroy` |
| 导出本表全列全行 | 查 `_table` 全字段；分表 locale **不**并进导出行（locale 表自行导出若需要） | `get{Entities}` |

#### 示例（与现网一致）

列表要显示生物英文名 + 本地化名：主表 `creature_template`，关联 `creature_template_locale`。

```dart
var builder = laconic.table('$_table AS ct');
builder = builder.select([
  'ct.entry',
  'ct.name',
  'ct.subname',
  'ctl.Name',   // 来自 locale 表
  'ctl.Title',
]);
builder = builder.leftJoin(
  'creature_template_locale AS ctl',
  (join) => join
      .on('ct.entry', 'ctl.entry')
      .on('ctl.locale', '"zhCN"'),
);
builder = _applyFilter(builder, filter); // 仅用户筛选，不是「定义关联」
builder = builder.limit(kPageSize).offset(offset);
```

物品列表带图标：对本表 `item_template` `leftJoin` `item_template_locale`、`foxy.dbc_item_display_info` 等，把需要的列写入 Brief。

#### 约定

1. **JOIN 写在「需要这些列的那个查询」里**（几乎总是 `getBrief*`；`count*` 仅当 filter 用到了关联表列时才需要同样 join）。
2. **关联表不单独为了展示再开一套 list Repository 调用**；由当前表的 `getBrief*` 一次查齐 Brief 字段。
3. **写操作（store/update/destroy）只动 `_table`**。分表 locale 写另一张表（独立 Repository 或 `save*Locales`）；DBC 多语言列随本表 Entity 一起 store/update。
4. **Filter ≠ 关联**：Filter 只描述「用户筛什么」；join 的 on 描述「表怎么连」。
5. 分表 locale 展示默认 `zhCN`：join + `on locale`；DBC 展示默认选 `*_lang_zhCN` 列（均与现网一致，切换策略另议）。

### 5.4 三个易混概念

| 概念 | 是什么 | 实现 |
|------|--------|------|
| **关联查询** | 查询时带上其它表的列 | laconic `join` / `leftJoin` + `on` + `select` |
| **Filter** | 列表/Picker 的用户筛选条件 | `where` / `whereAny`（可打在本表列或已 join 的列上） |
| **主键参数** | 定位本表一行 | `get`/`update`/`destroy`/`copy` 的参数 |

### 5.5 多表结构相同、逻辑复用（例外实现）

例：多种 `*_loot_template` 列结构相同，现网用 `LootTemplateRepository(LootTableType)` 注入表名。

- 这是**实现复用**，避免 N 份复制粘贴。
- 语义上仍是「一次操作一张 `_table`」（由 `type` 选定）。
- 需要物品名等展示列时，同样在该 Repository 内 `leftJoin`，不另搞分类。

---

## 6. 特殊说明（仍是一表一 Repository）

| 类型 | 说明 |
|------|------|
| 原「只读」数据源（如部分 DBC、broadcast_text） | **仍写满标准 CRUD 表面**（含 store/update/destroy/copy/create/save）；UI 可以暂时只调读方法 |
| 可导出 DBC 表 | 必须实现可用的 `get{Entities}`；导出调用它 |
| 应用自有表（activity_log、feature） | 同一套动词；无 `delete*` |
| 配置 / 探测（setting、version） | 若不是标准行表，可不套满 CRUD，但**不得**使用与模板冲突的动词名 |

列表/Picker 仍只走 `getBrief*` + `count*`；补 Brief，禁止用全实体冒充列表 DTO。

---

## 7. Filter 与 Brief 实体

### 7.1 Brief

| 规则 | 说明 |
|------|------|
| 谁用 | 分页列表 + Picker **共用** `Brief{Entity}Entity` |
| 字段基准 | **以分页列表列集为基准**定义 Brief |
| 与 Picker | Picker 列 = 列表列，**或** 列表列的**真子集**（更少） |
| 交集 | 因 Picker ⊆ 列表（或相等），**Brief ≡ 列表列集**即可 |
| 扩展 | 列表要加列 → 改 Brief + `getBrief*` select；Picker 不得引用 Brief 外字段 |
| 不是什么 | 不是详情 DTO；不是导出 DTO |

> 一句话：**Brief = 列表行模型；Picker 复用它，字段相同或更少。**

### 7.2 Filter

- 列表与 Picker **共用** `{Entity}FilterEntity`（同一套筛选字段与语义）。
- `getBrief*` 与 `count*` 使用同一 filter。

### 7.3 全字段 Entity

- 单条：`get{Entity}`（详情/编辑）。
- 整表：`get{Entities}`（DBC 导出等）。

Filter / Brief / Entity **不是** Repository 方法，但是 CRUD 模板的配套约定。

---

## 8. 与 ViewModel / Picker / 导出的衔接（仅约定边界）

- 列表页：`getBrief*` + `count*`；表格列绑定 Brief 字段。
- Entity Picker：同一 `getBrief*` + `count*` + 同一 Filter；列从 Brief 中取（全用或少用）。
- 详情加载：`get{Entity}`（全字段单行）。
- DBC 导出 / 全表批处理：`get{Entities}`（全字段全部行）。
- 保存：新建 `store*` 并写回主键；编辑 `update*`。
- 按主键可能尚无行的表：可用 `save*`，或调用方分支 `store` / `update`。
- Repository **不**依赖 Flutter。  
- **GetIt / EventBus：** 现网 `ActivityLogRepository` 写库后发事件；属横切，**允许**仅在此类仓储注入 EventBus，业务表 Repository 禁止依赖 UI 与路由。

---

## 9. 标准方法清单（检查用）

对齐一张业务表的 Repository 时勾选：

- [ ] 仅一张 `_table`；一表一 Repository
- [ ] `getBrief{Entities}`（列表 + Picker，分页）
- [ ] `Brief{Entity}Entity` ≡ 列表列集；Picker 列 ⊆ Brief
- [ ] 列表与 Picker 共用 Filter；无第二套 Picker DTO
- [ ] `get{Entities}`（全列全行、无 page；供导出）
- [ ] `count{Entities}`
- [ ] `get{Entity}` → `Future<{Entity}Entity?>`（可空）
- [ ] `create{Entity}`（不落库）
- [ ] `store{Entity}`（语义名参数；自动主键 → `Future<int>`）
- [ ] `update{Entity}`
- [ ] `destroy{Entity}`
- [ ] `copy{Entity}` → `Future<void>`
- [ ] `save{Entity}`（upsert）
- [ ] UI/Picker 未误用 `get{Entities}`
- [ ] `_applyFilter`（有筛选时）
- [ ] `_getNextId` 或 `_getNextEntry`（自动主键时）
- [ ] 方法顺序符合 §2.3
- [ ] 无 `delete*` 命名
- [ ] LIKE 带 `comparator: 'like'`
- [ ] 关联展示列用 laconic join，而非 Filter「表达关联」

分表 locale（§4.3.A）追加：

- [ ] 独立 `*LocaleRepository`（目标）或过渡 `get*Locales` / `save*Locales`
- [ ] `getBrief*` 用 join 带展示语言，而非把 locale 行塞进主表 Entity 宽列

DBC 同表多语言（§4.3.B）追加：

- [ ] **无** `*LocaleRepository` / **无** `get*Locales`
- [ ] Entity / Brief / `get{Entities}` 正确覆盖所需 `*_lang_*` 列

---

## 10. 已确认决议（原问题区，已写入正文）

| # | 决议 |
|---|------|
| 1 | `get` **允许返回 null**（符合 UI） |
| 2 | `copy` 返回 **`void`** |
| 3 | store 等参数用 **语义名** |
| 4 | 业务表 **写满** 标准 CRUD 接口（含原「只读」表） |
| 5 | **`create` / `save` 均写入正式模板**，各业务表提供 |
| 6 | Filter 主键是否 parse：**按表** |
| 7 | 级联删除 / 深拷贝：**本模板不涉及** |
| 8 | `get{Entities}` **面向导出**；无 page；一次全表 |
| 9 | DBC 导出 **改为使用** Repository.`get{Entities}` |
| 10 | 现有带 `page` 的全量 `getXxxs` → 拆成 UI 的 `getBrief*` + 导出的无分页 `get{Entities}` |

---

## 11. 落地步骤（预告）

1. 本清单定稿后更新 `AGENTS.md` Repository 小节（或指向本文）。  
2. 按模块分批对齐 Repository + Picker + 导出调用。  
3. 每批 `flutter analyze`。

---

## 12. 修订记录

| 日期 | 说明 |
|------|------|
| 2026-07-09 | 初稿，待确认 |
| 2026-07-09 | 曾草案去掉 `get{Entities}`；列表与 Picker 统一 Brief |
| 2026-07-09 | **恢复 `get{Entities}`**：语义为全列全行，服务 DBC 导出等；UI 仍只用 `getBrief*`；默认无分页 |
| 2026-07-09 | 明确 Brief：以分页列表列集为基准；Picker 列相同或为子集；共用 `getBrief*` / Filter |
| 2026-07-10 | 删除「子表形态」；明确 Repository 与表一对一，无主从概念；主键仅影响参数 |
| 2026-07-10 | 澄清：表关联 ≠ Filter；Filter 仅服务列表/Picker 筛选 |
| 2026-07-10 | 复合主键统一多参数，禁止 Map |
| 2026-07-10 | 明确关联查询用 laconic join/leftJoin；与 Filter、主键参数分开写清 |
| 2026-07-10 | 自我复查：将 §10 批注写入正文；消除与「只读子集 / get 非空 / copy 返回值」等矛盾 |
| 2026-07-10 | 本地化分两态：分表 locale（独立表/Repository）vs DBC 同表多语言列（无 Locale Repository） |
| 2026-07-10 | 落地：DBC 导出经 `DbcExportRegistry` → Repository.`get{Entities}`；1:1 子表与 Locale 仓储补全标准 CRUD |
