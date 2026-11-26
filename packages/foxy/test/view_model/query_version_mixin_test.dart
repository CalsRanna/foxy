import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/query_version_mixin.dart';
import 'package:signals/signals.dart';

void main() {
  group('QueryVersionMixin', () {
    test('markQueryVersion increments queryVersion', () {
      final vm = _FakeVm();
      expect(vm.queryVersion.value, 0);
      vm.markQueryVersion();
      expect(vm.queryVersion.value, 1);
      vm.markQueryVersion();
      expect(vm.queryVersion.value, 2);
    });

    test('Paging and searching change the page and increment the version so the table scrolls to the top', () {
      final vm = _FakeVm();
      vm.page.value = 2;
      vm.markQueryVersion();
      expect(vm.page.value, 2);
      expect(vm.queryVersion.value, 1);
    });

    group('normalizePageAfterDelete', () {
      test('Deleting the last row on an out-of-range page moves back and increments the version', () {
        final vm = _FakeVm()..page.value = 2;
        vm.normalizePageAfterDelete(50);
        expect(vm.page.value, 1);
        expect(vm.queryVersion.value, 1);
      });

      test('Deletion within a valid page preserves the page, version, and scroll position', () {
        final vm = _FakeVm()..page.value = 3;
        vm.normalizePageAfterDelete(4999);
        expect(vm.page.value, 3);
        expect(vm.queryVersion.value, 0);
      });

      test('Deletion keeps the current page when it remains valid', () {
        // total=101 → 2 pages; after deleting 1 row on page=2, total=100
        // still 2 pages
        final vm = _FakeVm()..page.value = 2;
        vm.normalizePageAfterDelete(100);
        expect(vm.page.value, 2);
        expect(vm.queryVersion.value, 0);
      });

      test('Deleting all rows on the first page returns to page one', () {
        final vm = _FakeVm(); // page = 1
        vm.normalizePageAfterDelete(0);
        expect(vm.page.value, 1);
        expect(vm.queryVersion.value, 0);
      });
    });
  });
}

/// Fake ViewModel: only provides the page signal the mixin requires.
class _FakeVm with QueryVersionMixin {
  @override
  final page = signal(1);
}
