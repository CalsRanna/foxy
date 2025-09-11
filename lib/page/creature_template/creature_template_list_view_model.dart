import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/model/creature_template_filter_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:signals_flutter/signals_core.dart';

class CreatureTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final subNameController = TextEditingController();
  final repository = CreatureTemplateRepository();

  final page = signal(1);
  final templates = signal(<BriefCreatureTemplate>[]);
  final total = signal(0);

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    subNameController.dispose();
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefCreatureTemplates();
    total.value = await repository.count();
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    templates.value = await repository.getBriefCreatureTemplates(page: page);
    total.value = await repository.count();
  }

  Future<void> search() async {
    page.value = 1;
    var filter =
        CreatureTemplateFilterEntity()
          ..entry = entryController.text
          ..name = nameController.text
          ..subName = subNameController.text;
    templates.value = await repository.getBriefCreatureTemplates(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    subNameController.clear();
    page.value = 1;
    templates.value = await repository.getBriefCreatureTemplates();
    total.value = await repository.count();
  }

  void navigateCreatureTemplateDetailPage(BuildContext context, {int? entry}) {
    CreatureTemplateDetailRoute(entry: entry).push(context);
  }
}
