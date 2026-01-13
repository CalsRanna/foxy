import 'package:foxy/page/bootstrap/bootstrap_view_model.dart';
import 'package:foxy/page/creature_template/creature_equip_template_view_model.dart';
import 'package:foxy/page/creature_template/creature_on_kill_reputation_view_model.dart';
import 'package:foxy/page/creature_template/creature_quest_item_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_addon_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_detail_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_list_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_resistance_view_model.dart';
import 'package:foxy/page/creature_template/creature_template_spell_view_model.dart';
import 'package:foxy/page/dashboard/dashboard_view_model.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:foxy/page/scaffold/scaffold_view_model.dart';
import 'package:foxy/page/setting/setting_view_model.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';

class DI {
  static void ensureInitialized() {
    GetIt.instance.registerSingleton(RouterFacade());
    GetIt.instance.registerSingleton(FoxyViewModel());
    GetIt.instance.registerFactory(() => BootstrapViewModel());
    GetIt.instance.registerSingleton(ScaffoldViewModel());
    GetIt.instance.registerFactory(() => DashboardViewModel());
    GetIt.instance.registerLazySingleton(() => CreatureTemplateListViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateDetailViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateAddonViewModel());
    GetIt.instance.registerFactory(() => CreatureOnKillReputationViewModel());
    GetIt.instance.registerFactory(() => CreatureEquipTemplateViewModel());
    GetIt.instance.registerFactory(() => CreatureQuestItemViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateResistanceViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateSpellViewModel());
    GetIt.instance.registerFactory(() => SettingViewModel());
  }
}
