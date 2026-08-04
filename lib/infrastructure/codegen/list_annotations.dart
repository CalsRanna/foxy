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
  /// The Full Entity type the list maps to.
  final Type entity;

  /// Repository type providing getBrief/count/copy/destroy.
  final Type repository;

  const FoxyListViewModel({required this.entity, required this.repository});
}
