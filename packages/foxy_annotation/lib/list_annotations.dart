import 'package:meta/meta_meta.dart';

/// Annotates a List ViewModel, declaring the entity and repository its list
/// maps to.
///
/// Filter fields are not re-declared here: the generator reads them from
/// the repository's `@FoxyFilter` annotations (the same philosophy as
/// `@FoxyDetailViewModel` inferring from the entity's constructor — a
/// single source of truth). Only `@FoxyFilter.text` text filters are
/// supported today.
///
/// Controller names match filter field names (single source of truth; no
/// legacy naming is kept).
@Target({TargetKind.classType})
class FoxyListViewModel {
  /// Exception override: the Full Entity type the list maps to. When
  /// omitted, derived from the class name (`XxxListViewModel` →
  /// `XxxEntity`).
  final Type? entity;

  /// Exception override: Repository type providing getBrief/count/copy/
  /// destroy. When omitted, derived from the class name.
  final Type? repository;

  const FoxyListViewModel({this.entity, this.repository});
}
