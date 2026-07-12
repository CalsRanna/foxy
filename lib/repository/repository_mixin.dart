import 'package:foxy/database/database.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

mixin RepositoryMixin {
  Laconic get laconic => Database.instance.laconic;
  final kPageSize = 50;

  /// 是否 JOIN `*_locale` 表显示本地化名称。
  ///
  /// 读取 [FoxyViewModel.localeEnabled]；DI 未就绪时默认启用，保持向后兼容。
  bool get localeEnabled {
    try {
      return GetIt.instance.get<FoxyViewModel>().localeEnabled.value;
    } catch (_) {
      return true;
    }
  }
}
