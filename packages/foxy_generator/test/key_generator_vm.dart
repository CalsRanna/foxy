import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:foxy_generator/builder.dart';
import 'package:test/test.dart';

import 'generator_test_support.dart';

void main() {
  test('A scalar key produces no extra key type', () async {
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, standardEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_sample_entity.foxy_entity.g.part':
            decodedMatches(isNot(contains('final class CodegenSampleKey'))),
      },
    );
  });

  test('A composite key includes all primary key fields and reads their entity values', () async {
    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(compositeEntityAsset, compositeEntitySource),
      outputs: {
        'foxy|lib/entity/codegen_relation_entity.foxy_entity.g.part':
            decodedMatches(
              allOf(<Matcher>[
                contains('final class CodegenRelationKey'),
                contains('final int ownerId;'),
                contains('final String locale;'),
                contains('const CodegenRelationKey({'),
                contains('factory CodegenRelationKey.fromEntity'),
                contains('ownerId: entity.ownerId'),
                contains('locale: entity.locale'),
              ]),
            ),
      },
    );
  });

  test('Generation rejects entities without key fields', () async {
    final source = standardEntitySource.replaceFirst(
      "@FoxyFullField('ID', key: true)",
      "@FoxyFullField('ID')",
    );
    final logs = <String>[];

    await testBuilder(
      foxyEntityBuilder(BuilderOptions.empty),
      sourceAsset(standardEntityAsset, source),
      outputs: {},
      onLog: (record) => logs.add(record.toString()),
    );
    expect(logContains(logs, 'has no physical primary key field'), isTrue);
  });
}
