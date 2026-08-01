import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/query_version_mixin.dart';
import 'package:signals/signals.dart';

void main() {
  group('QueryVersionMixin', () {
    test('markQueryVersion 使 queryVersion 递增', () {
      final vm = _FakeVm();
      expect(vm.queryVersion.value, 0);
      vm.markQueryVersion();
      expect(vm.queryVersion.value, 1);
      vm.markQueryVersion();
      expect(vm.queryVersion.value, 2);
    });

    test('翻页/搜索场景：页码变化且版本递增（表格回顶）', () {
      final vm = _FakeVm();
      vm.page.value = 2;
      vm.markQueryVersion();
      expect(vm.page.value, 2);
      expect(vm.queryVersion.value, 1);
    });

    group('normalizePageAfterDelete', () {
      test('删除导致页超界时回退页码并递增版本（如 total=51 删光第 2 页）', () {
        final vm = _FakeVm()..page.value = 2;
        vm.normalizePageAfterDelete(50);
        expect(vm.page.value, 1);
        expect(vm.queryVersion.value, 1);
      });

      test('页内删除不修正页码、不递增版本（保持浏览位置）', () {
        final vm = _FakeVm()..page.value = 3;
        vm.normalizePageAfterDelete(4999);
        expect(vm.page.value, 3);
        expect(vm.queryVersion.value, 0);
      });

      test('删除后当前页仍合法时不修正页码', () {
        // total=101 → 2 页，page=2 删 1 条后 total=100 仍 2 页
        final vm = _FakeVm()..page.value = 2;
        vm.normalizePageAfterDelete(100);
        expect(vm.page.value, 2);
        expect(vm.queryVersion.value, 0);
      });

      test('第一页删光全部数据时回退到第 1 页', () {
        final vm = _FakeVm(); // page = 1
        vm.normalizePageAfterDelete(0);
        expect(vm.page.value, 1);
        expect(vm.queryVersion.value, 0);
      });
    });
  });
}

/// 假 ViewModel：仅提供 mixin 要求的 page 信号。
class _FakeVm with QueryVersionMixin {
  @override
  final page = signal(1);
}
