import 'dart:math';

import 'package:signals/signals.dart';

/// 分页浏览版本管理 mixin。
///
/// 提供「浏览基线版本」[queryVersion]：整页级内容变化（翻页、搜索、重置、
/// 删除导致页码缩减）时递增，页面将其传给 FoxyShadTable，使表格垂直滚动
/// 回到第一行。页内数据变化（删除、复制、编辑保存）不递增，保持浏览位置。
///
/// ```dart
/// class MyListViewModel with FieldControllerMixin, QueryVersionMixin {
///   final page = signal(1);
///   final total = signal(0);
///
///   Future<void> paginate(int page) async {
///     this.page.value = page;
///     markQueryVersion();
///     await _refresh();
///   }
///
///   Future<void> destroy(int key) async {
///     await repository.destroy(key);
///     normalizePageAfterDelete(total.value - 1);
///     await _refresh();
///   }
/// }
/// ```
mixin QueryVersionMixin {
  /// 当前分页页码（混入的 ViewModel 已声明 `final page = signal(1)`，天然满足）。
  Signal<int> get page;

  /// 每页行数（项目所有分页统一为 50）。
  int get pageSize => 50;

  /// 分页浏览基线版本：变化即代表表格内容整页切换，应回到第一行。
  final queryVersion = signal(0);

  /// 标记一次整页级变化（翻页 / 搜索 / 重置）。
  void markQueryVersion() => queryVersion.value++;

  /// 删除后修正浏览基线：总行数缩减导致当前页超界时，
  /// 回退到最后一页并标记版本变化（表格回顶）；否则保持当前浏览位置。
  ///
  /// [totalAfterDelete] 为删除后的总行数（调用处可用删除前的
  /// `total.value - 1` 传入，过滤条件未变时即删除后总数）。
  void normalizePageAfterDelete(int totalAfterDelete) {
    final pageCount = max(1, (totalAfterDelete / pageSize).ceil());
    if (page.value > pageCount) {
      page.value = pageCount;
      markQueryVersion();
    }
  }
}
