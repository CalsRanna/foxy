import 'package:foxy/page/bootstrap/bootstrap_view_model.dart';
import 'package:foxy/router/router.dart';
import 'package:get_it/get_it.dart';

class DI {
  static void ensureInitialized() {
    GetIt.instance.registerSingleton(FoxyRouter());
    GetIt.instance.registerFactory(() => BootstrapViewModel());
  }
}
