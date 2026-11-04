import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  const allowedLayers = {
    'constant': {'constant', 'model'},
    'entity': {'constant', 'entity', 'model'},
    'model': {'constant', 'model'},
    'infrastructure': {'constant', 'exception', 'infrastructure', 'model'},
    'repository': {
      'constant',
      'entity',
      'exception',
      'infrastructure',
      'model',
      'repository',
    },
    'use_case': {
      'constant',
      'entity',
      'event',
      'exception',
      'infrastructure',
      'model',
      'repository',
      'use_case',
    },
    'view_model': {
      'constant',
      'entity',
      'event',
      'exception',
      'infrastructure',
      'model',
      'repository',
      'use_case',
      'view_model',
    },
    'widget': {
      'constant',
      'entity',
      'exception',
      'infrastructure',
      'model',
      'router',
      'theme',
      'view_model',
      'widget',
    },
  };
  final directive = RegExp(
    r'''^\s*(?:import|export)\s+['"](package:[^'"]+)['"]''',
    multiLine: true,
  );

  for (final entry in allowedLayers.entries) {
    test('${entry.key} keeps its dependencies within its layer boundary', () {
      final sources = Directory(p.join('lib', entry.key))
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => p.extension(file.path) == '.dart')
          .toList();
      expect(sources, isNotEmpty);

      final violations = <String>[];
      for (final file in sources) {
        final allowed = {
          ...entry.value,
          if (p.isWithin(
            p.join('lib', 'widget', 'picker', 'delegate'),
            file.path,
          ))
            'repository',
        };
        for (final match in directive.allMatches(file.readAsStringSync())) {
          final uri = Uri.parse(match.group(1)!);
          final segments = uri.pathSegments;
          if ((segments.first == 'foxy' && !allowed.contains(segments[1])) ||
              (segments.first == 'foxy_widget' &&
                  !allowed.contains('widget'))) {
            violations.add('${file.path} imports $uri');
          }
          if ({'foxy_game_file', 'foxy_widget'}.contains(segments.first) &&
              segments[1] == 'src') {
            violations.add('${file.path} imports a private package API: $uri');
          }
          if (entry.key == 'model' &&
              {
                'flutter',
                'shadcn_ui',
                'signals_flutter',
              }.contains(segments.first)) {
            violations.add('${file.path} couples a shared model to $uri');
          }
        }
      }

      expect(violations, isEmpty, reason: violations.join('\n'));
    });
  }
}
