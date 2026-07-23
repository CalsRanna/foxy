import 'dart:io';

String readLocalDartLibrarySource(String path) {
  return _readLocalDartLibrarySource(File(path), <String>{});
}

String _readLocalDartLibrarySource(File file, Set<String> visited) {
  final normalizedPath = file.absolute.path;
  if (!visited.add(normalizedPath)) return '';

  final source = file.readAsStringSync();
  final relatedSources = <String>[];
  final directive = RegExp(r'''(?:part|export)\s+['"]([^'"]+\.dart)['"]''');
  for (final match in directive.allMatches(source)) {
    final uri = match.group(1)!;
    if (uri.contains(':')) continue;
    final related = File.fromUri(file.parent.uri.resolve(uri));
    if (!related.existsSync()) continue;
    relatedSources.add(_readLocalDartLibrarySource(related, visited));
  }

  return [source, ...relatedSources].join('\n');
}
