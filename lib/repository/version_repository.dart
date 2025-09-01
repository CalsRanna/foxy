import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:get_it/get_it.dart';

class VersionRepository {
  Future<void> connect() async {
    var viewModel = GetIt.instance.get<FoxyViewModel>();
    await viewModel.laconic.statement('select version()');
  }
}
