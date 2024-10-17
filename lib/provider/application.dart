import 'package:foxy/service/application.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application.g.dart';

@Riverpod(keepAlive: true)
Future<String> mysqlVersion(MysqlVersionRef ref) async {
  return await ApplicationService().getMysqlVersion();
}

@Riverpod(keepAlive: true)
class SelectedMenuIndexNotifier extends _$SelectedMenuIndexNotifier {
  @override
  int build() => 0;

  void select(int index) => state = index;
}
