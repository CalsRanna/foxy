import 'package:foxy/service/application.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application.g.dart';

@Riverpod(keepAlive: true)
Future<String> mysqlVersion(MysqlVersionRef ref) async {
  return await ApplicationService().getMysqlVersion();
}
