import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:get_it/get_it.dart';

mixin RepositoryMixin {
  final laconic = GetIt.instance.get<FoxyViewModel>().laconic!;
  final kPageSize = 25;
}
