import 'package:foxy/model/item_template.dart';
import 'package:foxy/service/item_template.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item.g.dart';

@Riverpod(keepAlive: true)
Future<int> itemTemplateTotal(ItemTemplateTotalRef ref) {
  return ItemTemplateService().count();
}

@Riverpod(keepAlive: true)
class ItemTemplatesNotifier extends _$ItemTemplatesNotifier {
  @override
  Future<List<ItemTemplate>> build() async {
    return ItemTemplateService().search();
  }

  Future<void> paginate(int page) async {
    final templates = await ItemTemplateService().search(page: page);
    state = AsyncData(templates);
  }

  Future<void> reset() async {
    ref.invalidateSelf();
    await future;
  }
}
