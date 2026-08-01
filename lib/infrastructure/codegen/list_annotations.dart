import 'package:meta/meta_meta.dart';

/// 标注 List ViewModel,声明其列表对应的实体与仓库。
///
/// 筛选字段不在此重复声明:生成器从 repository 上的 `@FoxyFilter` 注解读取
/// (与 `@FoxyDetailViewModel` 从 entity 构造参数推断同一哲学——单一事实来源)。
/// 当前只支持 `@FoxyFilter.text` 文本筛选字段。
///
/// controller 名与 filter 字段名一致(单一事实,不保留历史命名)。
@Target({TargetKind.classType})
class FoxyListViewModel {
  /// 列表对应的 Full Entity 类型。
  final Type entity;

  /// 提供 getBrief/count/copy/destroy 方法的 Repository 类型。
  final Type repository;

  const FoxyListViewModel({required this.entity, required this.repository});
}
