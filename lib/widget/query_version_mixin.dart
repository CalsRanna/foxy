import 'dart:math';

import 'package:signals/signals.dart';

/// Pagination browse-version management mixin.
///
/// Provides the "browse baseline version" [queryVersion]: incremented on
/// whole-page content changes (page turn, search, reset, delete shrinking
/// the page count); pages pass it to FoxyShadTable so the table scrolls
/// back to the first row. In-page data changes (delete, copy, edit-save)
/// do not increment, keeping the browse position.
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
  /// Pagination browse baseline: a change means the table content switched
  /// wholesale and should return to the first row.
  final queryVersion = signal(0);

  /// Current page number (the mixing-in ViewModel already declares
  /// `final page = signal(1)`, satisfying this naturally).
  Signal<int> get page;

  /// Rows per page (all pagination in the project uses 50).
  int get pageSize => 50;

  /// Marks a whole-page change (page turn / search / reset).
  void markQueryVersion() => queryVersion.value++;

  /// Corrects the browse baseline after a delete: when the reduced row
  /// count makes the current page out of range, step back to the last page
  /// and mark a version change (table scrolls to top); otherwise keep the
  /// current browse position.
  ///
  /// [totalAfterDelete] is the post-delete row count (callers can pass
  /// `total.value - 1` from before the delete; with unchanged filters that
  /// is the post-delete total).
  void normalizePageAfterDelete(int totalAfterDelete) {
    final pageCount = max(1, (totalAfterDelete / pageSize).ceil());
    if (page.value > pageCount) {
      page.value = pageCount;
      markQueryVersion();
    }
  }
}
