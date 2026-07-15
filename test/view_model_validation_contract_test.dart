import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Entity 保持纯数据对象且 Repository 不执行纯字段校验', () {
    final entityFiles = Directory(
      'lib/entity',
    ).listSync().whereType<File>().where((file) => file.path.endsWith('.dart'));
    final repositoryFiles = Directory(
      'lib/repository',
    ).listSync().whereType<File>().where((file) => file.path.endsWith('.dart'));

    for (final file in entityFiles) {
      final source = file.readAsStringSync();
      expect(
        source,
        isNot(contains('void validate()')),
        reason: '${file.path} 不应包含业务校验方法',
      );
    }
    for (final file in repositoryFiles) {
      final source = file.readAsStringSync();
      expect(
        source,
        isNot(contains('.validate()')),
        reason: '${file.path} 不应执行 Entity 纯字段校验',
      );
    }
  });

  test('全部迁移规则由 ViewModel validation mixin 暴露', () {
    final validationFiles = Directory('lib/widget/form/validation')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('_validation_mixin.dart'))
        .toList();
    final methodCount = validationFiles.fold<int>(0, (count, file) {
      final source = file.readAsStringSync();
      return count +
          RegExp(r'void validate\w+Fields\(').allMatches(source).length;
    });

    expect(validationFiles, hasLength(39));
    expect(methodCount, 44);
  });

  test('ViewModel validation mixin 不通过 Entity extension 承载规则', () {
    final validationFiles = Directory('lib/widget/form/validation')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('_validation_mixin.dart'));

    for (final file in validationFiles) {
      final source = file.readAsStringSync();
      expect(
        source,
        isNot(matches(RegExp(r'extension\s+on\s+\w*Entity\b'))),
        reason: '${file.path} 应直接在 ViewModel validation mixin 中实现规则',
      );
      expect(
        source,
        isNot(contains('._validateFields()')),
        reason: '${file.path} 不应把校验转发给 Entity extension',
      );
    }
  });
}
