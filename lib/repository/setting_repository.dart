import 'package:foxy/repository/repository_mixin.dart';

class SettingRepository with RepositoryMixin {
  Future<bool> hasLocaleTables() async {
    try {
      // Check if creature_template_locale table exists by trying to query it
      await laconic.table('creature_template_locale').limit(1).get();
      return true;
    } catch (e) {
      return false;
    }
  }
}
