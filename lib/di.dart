import 'package:foxy/page/bootstrap/bootstrap_view_model.dart';
import 'package:get_it/get_it.dart';

class DI {
  static void ensureInitialized() {
    GetIt.instance.registerLazySingleton(() => BootstrapViewModel());
  }
}
