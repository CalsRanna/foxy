import 'package:foxy/page/bootstrap/bootstrap_view_model.dart';
import 'package:foxy/page/creature/creature_template_detail_view_model.dart';
import 'package:foxy/page/creature/creature_template_list_view_model.dart';
import 'package:foxy/page/dashboard/dashboard_view_model.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:get_it/get_it.dart';

class DI {
  static void ensureInitialized() {
    GetIt.instance.registerSingleton(FoxyViewModel());
    GetIt.instance.registerFactory(() => BootstrapViewModel());
    GetIt.instance.registerFactory(() => DashboardViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateListViewModel());
    GetIt.instance.registerFactory(() => CreatureTemplateDetailViewModel());
  }
}
