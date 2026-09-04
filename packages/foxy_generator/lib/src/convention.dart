/// Convention-derived names shared across all readers.
///
/// Each function returns what the convention would derive; a reader falls
/// back to it only when the annotation omits the parameter. Explicit values
/// always win and are validated against the derivation where meaningful.
library;

import 'package:foxy_generator/src/naming.dart';

/// Derived physical table name for a Full Entity class name:
/// `CreatureLootTemplateEntity` → `creature_loot_template`.
///
/// Returns the empty string when the base is empty (a class named exactly
/// `Entity`), which callers must reject.
String tableNameOf(String entityClassName) {
  final base = stripEntitySuffix(entityClassName);
  return base.isEmpty ? '' : toSnakeCase(base);
}

/// Derived Full Entity class name for a Repository class name:
/// `CreatureLootTemplateRepository` → `CreatureLootTemplateEntity`.
String entityClassNameOfRepository(String repositoryClassName) =>
    '${stripSuffix(repositoryClassName, 'Repository')}Entity';

/// ViewModel suffixes, longest first. `XxxLinkedDetailViewModel` must be
/// stripped before `XxxDetailViewModel` (its name *ends with* the shorter
/// suffix too).
const _viewModelSuffixes = <String>[
  'LinkedDetailViewModel',
  'LinkedListViewModel',
  'DetailViewModel',
  'ListViewModel',
];

/// Base name of a ViewModel class, stripping the conventional suffix:
/// `CreatureTemplateListViewModel` → `CreatureTemplate`.
///
/// Returns null when no known suffix matches (a hand-written ViewModel name
/// like `BootstrapWorkflowViewModel`); callers must reject that.
String? baseNameOfViewModel(String viewModelClassName) {
  for (final suffix in _viewModelSuffixes) {
    if (viewModelClassName.endsWith(suffix) &&
        viewModelClassName.length > suffix.length) {
      return viewModelClassName.substring(
        0,
        viewModelClassName.length - suffix.length,
      );
    }
  }
  return null;
}

/// Derived Full Entity class name for a ViewModel class name:
/// `CreatureTemplateListViewModel` → `CreatureTemplateEntity`.
///
/// Returns null when the class name has no conventional suffix.
String? entityClassNameOfViewModel(String viewModelClassName) {
  final base = baseNameOfViewModel(viewModelClassName);
  return base == null ? null : '${base}Entity';
}

/// Derived Repository class name for a ViewModel class name:
/// `CreatureTemplateListViewModel` → `CreatureTemplateRepository`.
///
/// Returns null when the class name has no conventional suffix.
String? repositoryClassNameOfViewModel(String viewModelClassName) {
  final base = baseNameOfViewModel(viewModelClassName);
  return base == null ? null : '${base}Repository';
}

String stripEntitySuffix(String entityClassName) =>
    stripSuffix(entityClassName, 'Entity');

String stripSuffix(String name, String suffix) {
  if (name.endsWith(suffix) && name.length > suffix.length) {
    return name.substring(0, name.length - suffix.length);
  }
  return name;
}
