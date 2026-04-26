import 'package:foxy/model/page_text.dart';
import 'package:foxy/repository/repository_mixin.dart';

class PageTextRepository with RepositoryMixin {
  static const _table = 'page_text';

  /// 搜索页面文本（分页）
  Future<List<PageText>> search({String? id, int page = 1}) async {
    try {
      var offset = (page - 1) * kPageSize;
      var builder = laconic.table(_table);
      builder = builder.select(['ID', 'Text', 'NextPageID', 'VerifiedBuild']);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      builder = builder.limit(kPageSize).offset(offset);
      var results = await builder.get();
      return results.map((e) => PageText.fromJson(e.toMap())).toList();
    } catch (e) {
      return [];
    }
  }

  /// 计数
  Future<int> count({String? id}) async {
    try {
      var builder = laconic.table(_table);
      if (id != null && id.isNotEmpty) {
        builder = builder.where('ID', id);
      }
      return await builder.count();
    } catch (e) {
      return 0;
    }
  }

  /// 根据主键查找
  Future<PageText?> find(int id) async {
    try {
      var result = await laconic.table(_table).where('ID', id).first();
      return PageText.fromJson(result.toMap());
    } catch (e) {
      return null;
    }
  }
}
