import 'package:foxy/service/service.dart';

class ApplicationService extends Service {
  Future<String> getMysqlVersion() async {
    const sql = 'select version()';
    final result = await pool.execute(sql);
    return result.rows.first.typedColAt<String>(0) ?? '';
  }
}
