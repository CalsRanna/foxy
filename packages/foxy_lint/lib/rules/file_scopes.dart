import 'package:path/path.dart' as p;

/// Utility file paths excluded from entity checks.
const _entityUtilities = {
  'dbc_locale_field_definition.dart',
};

String? collectionLoopScope(String path) {
  if (isEntityFile(path)) return 'Entity';
  if (isViewModelFile(path)) return 'ViewModel';
  if (isViewFile(path)) return 'View';
  return null;
}

bool isEntityFile(String path) {
  if (!path.endsWith('.dart')) return false;
  if (_entityUtilities.contains(p.basename(path))) return false;
  return path.contains(RegExp(r'[/\\]entity[/\\]')) ||
      p.basename(path).endsWith('_entity.dart');
}

bool isRepositoryFile(String path) {
  return p.basename(path).endsWith('_repository.dart');
}

bool isViewFile(String path) {
  return p.basename(path).endsWith('_view.dart');
}

bool isViewModelFile(String path) {
  final name = p.basename(path);
  return name.contains('_view_model.dart') ||
      name.contains('collection_editor_view_model.dart') ||
      name.contains('single_editor_view_model.dart') ||
      name.contains('detail_view_model.dart') ||
      name.contains('list_view_model.dart') ||
      name.contains('read_view_model.dart') ||
      name.contains('workflow_view_model.dart') ||
      name.contains('state_view_model.dart');
}
