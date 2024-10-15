import 'package:foxy/service/service.dart';

class ApplicationService with Service {
  Future<String> getMysqlVersion() async {
    const sql = 'select version()';
    final result = await execute(sql);
    return result.rows.first.typedColAt<String>(0) ?? '';
  }
}
