import 'package:flutter/foundation.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';

/// 公用选择器组件的状态基类。
///
/// 与页面级 ViewModel 区分：选择器是短生命周期的弹窗组件，状态由
/// [ChangeNotifier] 驱动（搭配 [ListenableBuilder] 订阅），不使用 signals，
/// 也不进入 GetIt。子类只需提供筛选字段、查询逻辑与重置逻辑。
abstract class SelectorController<TBrief> extends ChangeNotifier {
  List<TBrief> items = [];
  int total = 0;
  int page = 1;
  int? selectedId;

  /// 错误提示文案，例如「搜索区域失败」。
  String get errorLabel;

  /// 子类实现具体查询：依据自身筛选字段与 [page] 执行查询，
  /// 并把结果写入 [items] 与 [total]。无需调用 [notifyListeners]，
  /// [search] 会统一负责通知与异常处理。
  Future<void> performSearch();

  Future<void> search() async {
    try {
      await performSearch();
      notifyListeners();
    } catch (e) {
      LoggerUtil.instance.e('$errorLabel: $e');
      DialogUtil.instance.error('$errorLabel: $e');
    }
  }

  Future<void> paginate(int p) async {
    page = p;
    await search();
  }

  void reset() {
    clearFilters();
    page = 1;
    search();
  }

  /// 重置子类自身的筛选字段为空。
  void clearFilters();

  void select(int? id) {
    selectedId = id;
    notifyListeners();
  }
}
