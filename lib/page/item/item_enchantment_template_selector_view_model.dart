import 'package:signals/signals.dart';
import 'package:foxy/entity/item_enchantment_template_entity.dart';
import 'package:foxy/repository/item_enchantment_template_repository.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:foxy/util/dialog_util.dart';

class ItemEnchantmentTemplateSelectorViewModel {
  final _repository = ItemEnchantmentTemplateRepository();

  final idFilter = signal('');
  final nameFilter = signal('');
  final items = signal<List<BriefItemEnchantmentTemplateEntity>>([]);
  final total = signal(0);
  final page = signal(1);
  final selectedId = signal<int?>(null);

  Future<void> search() async {
    try {
      final entry = idFilter.value.isEmpty ? null : idFilter.value;
      final items = await _repository.getItemEnchantmentTemplates(
        entry: entry,
        page: page.value,
      );
      final total = await _repository.countItemEnchantmentTemplates(
        entry: entry,
      );
      this.items.value = items;
      this.total.value = total;
    } catch (e) {
      LoggerUtil.instance.e('搜索附魔失败: $e');
      DialogUtil.instance.error('搜索附魔失败: $e');
    }
  }

  Future<void> paginate(int p) async {
    page.value = p;
    await search();
  }

  void reset() {
    idFilter.value = '';
    nameFilter.value = '';
    page.value = 1;
    search();
  }

  void select(int? id) => selectedId.value = id;

  void dispose() {}
}
