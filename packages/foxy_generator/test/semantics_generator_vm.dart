import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('aggregates @FoxyFieldMeaning declarations into the registry', () async {
    await testBuilder(
      foxySemanticsBuilder(BuilderOptions.empty),
      _assets(_meaningEntitySource),
      isInput: (assetId) => assetId == _semanticsInputAsset,
      outputs: {
        'foxy|lib/constant/agent_field_semantics.foxy_semantics.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('abstract final class AgentFieldSemantics'),
                contains('static const values'),
                contains("'creature_template':"),
                contains('ColumnSemantics.enumValues('),
                contains("'生物类型'"),
                contains("1: '野兽'"),
                contains('ColumnSemantics.flags('),
                contains("ColumnFlag(value: 1, label: '不可攻击')"),
                contains('ColumnSemantics.reference('),
                contains("table: 'creature_loot_template'"),
                contains("'payload': ColumnSemantics.conditional("),
                contains("dependsOn: ['type', 'unit_flags']"),
                contains('branches: CodegenBranches.payload'),
                // Inferred from the FoxyEnumPicker wiring in the view fixture.
                contains("'rank'"),
                contains("1: '精英'"),
              ]),
            ),
      },
    );
  });

  test('rejects a meaning without a physical column', () async {
    final source = _meaningEntitySource.replaceFirst(
      "  @FoxyFullField('lootid')\n",
      '',
    );
    final logs = <String>[];

    await testBuilder(
      foxySemanticsBuilder(BuilderOptions.empty),
      _assets(source),
      isInput: (assetId) => assetId == _semanticsInputAsset,
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );

    expect(logContains(logs, 'requires @FoxyFullField'), isTrue);
  });

  for (final dependency in ['missing', 'type']) {
    test('rejects conditional dependency "$dependency"', () async {
      final source = _meaningEntitySource.replaceFirst(
        "dependsOn: ['type', 'unitFlags']",
        "dependsOn: ['type', '$dependency']",
      );
      final logs = <String>[];
      await testBuilder(
        foxySemanticsBuilder(BuilderOptions.empty),
        _assets(source),
        isInput: (assetId) => assetId == _semanticsInputAsset,
        outputs: {},
        onLog: (record) => logs.add(record.toString()),
      );
      expect(
        logContains(logs, 'unknown or repeated dependency "$dependency"'),
        isTrue,
      );
    });
  }
}

const _meaningEntityAsset = 'foxy|lib/entity/codegen_meaning_entity.dart';

const _meaningEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'codegen_meaning_entity.g.dart';

@FoxyFullEntity(table: 'creature_template')
class CodegenMeaningEntity with _CodegenMeaningEntityMixin {
  @FoxyFieldMeaning.enumValues('生物类型', values: {1: '野兽', 4: '元素生物'})
  @FoxyFullField('type')
  final int type;

  @FoxyFieldMeaning.flags('单位标志', flags: [FlagItem(1, '不可攻击')])
  @FoxyFullField('unit_flags')
  final int unitFlags;

  @FoxyFieldMeaning.reference(
    '掉落模板',
    table: 'creature_loot_template',
    column: 'entry',
  )
  @FoxyFullField('lootid')
  final int lootId;

  @FoxyFieldMeaning.conditional(
    '参数',
    dependsOn: ['type', 'unitFlags'],
    branches: CodegenBranches.payload,
  )
  @FoxyFullField('payload')
  final int payload;

  const CodegenMeaningEntity({
    this.type = 0,
    this.unitFlags = 0,
    this.lootId = 0,
    this.payload = 0,
  });

  factory CodegenMeaningEntity.fromJson(Map<String, dynamic> json) =>
      _CodegenMeaningEntityMixin.fromJson(json);
}

class CodegenBranches {
  static Object payload(List<String> columns) => columns;
}
''';

const _semanticsInputAsset = 'foxy|lib/constant/agent_field_semantics.dart';

const _semanticsInputSource = '''
import 'package:foxy_agent/foxy_agent.dart';

part 'agent_field_semantics.g.dart';
''';

const _viewAsset = 'foxy|lib/page/codegen/codegen_view.dart';

const _viewEntityAsset = 'foxy|lib/entity/codegen_view_entity.dart';

const _viewEntitySource = r'''
import 'package:foxy_annotation/entity_annotations.dart';

@FoxyFullEntity(table: 'creature_template')
class CodegenViewEntity {
  @FoxyFullField('rank')
  final int rank;

  const CodegenViewEntity({this.rank = 0});
}
''';

const _viewSource = r'''
class FoxyEnumPicker<T> {
  FoxyEnumPicker({
    required T controller,
    Map<int, String>? options,
    String? title,
  });
}

const codegenRankOptions = <int, String>{0: '普通', 1: '精英'};

class CodegenViewListViewModel {
  final int rankController = 0;
}

Object codegenView(CodegenViewListViewModel viewModel) => FoxyEnumPicker<int>(
  controller: viewModel.rankController,
  options: codegenRankOptions,
  title: '生物等级',
);
''';

Map<String, String> _assets(String entitySource) => {
  annotationAsset: annotationSource,
  'foxy_annotation|lib/semantic_annotations.dart': foxyAnnotationSource(
    'semantic_annotations.dart',
  ),
  _meaningEntityAsset: entitySource,
  _semanticsInputAsset: _semanticsInputSource,
  _viewEntityAsset: _viewEntitySource,
  _viewAsset: _viewSource,
  ..._gameDefinitionAssets(),
};

/// Provides the real `foxy_game_definition` sources so `FlagItem` resolves in
/// the hermetic test build (build_test defaults to the root package only).
Map<String, String> _gameDefinitionAssets() {
  final lib = Directory('../foxy_game_definition/lib');
  final files = lib
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'));
  final assets = <String, String>{};
  for (final file in files) {
    final relativePath = file.path
        .substring(lib.path.length + 1)
        .replaceAll(Platform.pathSeparator, '/');
    assets['foxy_game_definition|lib/$relativePath'] = file.readAsStringSync();
  }
  return assets;
}
