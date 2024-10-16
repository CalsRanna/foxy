import 'package:foxy/model/quest_template.dart';
import 'package:foxy/service/quest_template.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quest_template.g.dart';

@Riverpod(keepAlive: true)
Future<int> questTemplateTotal(QuestTemplateTotalRef ref) {
  return QuestTemplateService().count();
}

@Riverpod(keepAlive: true)
class QuestTemplatesNotifier extends _$QuestTemplatesNotifier {
  @override
  Future<List<QuestTemplate>> build() async {
    return QuestTemplateService().search();
  }

  Future<void> paginate(int page) async {
    final templates = await QuestTemplateService().search(page: page);
    state = AsyncData(templates);
  }

  Future<void> reset() async {
    ref.invalidateSelf();
    await future;
  }
}
