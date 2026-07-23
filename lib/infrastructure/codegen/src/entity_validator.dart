// ignore_for_file: depend_on_referenced_packages

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import '../entity_annotations.dart';
import 'entity_model.dart';

final class EntityValidator {
  const EntityValidator();

  void validate(EntityGenerationModel model, ClassElement element) {
    if (model.table.trim().isEmpty) {
      _fail(
        '${model.className} 的 @FoxyFullEntity.table 不能为空。',
        element,
        '填写完整物理表名。',
      );
    }
    if (!model.className.endsWith('Entity')) {
      _fail(
        '${model.className} 必须以 Entity 结尾。',
        element,
        '按 <Name>Entity 形式命名 Full Entity。',
      );
    }
    if (model.keyFields.isEmpty) {
      _fail(
        '${model.className} 没有物理主键字段。',
        element,
        '在至少一个 @FoxyFullField 上设置 key: true。',
      );
    }

    final columns = <String>{};
    for (final field in model.fields) {
      if (field.columnName.trim().isEmpty) {
        _fail(
          '${model.className}.${field.dartName} 的物理列名不能为空。',
          element.getField(field.dartName) ?? element,
          '为 @FoxyFullField 填写精确物理列名。',
        );
      }
      if (!columns.add(field.columnName)) {
        _fail(
          '${model.className} 重复声明物理列名 ${field.columnName}。',
          element.getField(field.dartName) ?? element,
          '确保每个 @FoxyFullField.name 在 Entity 内唯一且区分大小写。',
        );
      }
    }

    if (model.generateBrief) {
      final missingKeys = model.keyFields
          .where((field) => !field.includeInBrief)
          .map((field) => field.dartName)
          .toList(growable: false);
      if (missingKeys.isNotEmpty) {
        _fail(
          '${model.briefClassName} 缺少完整物理身份：'
              '${missingKeys.join(', ')} 未标注 @FoxyBriefField。',
          element,
          '为全部 key 字段添加 @FoxyBriefField。',
        );
      }
    } else {
      final briefField = model.fields
          .where((field) => field.includeInBrief)
          .firstOrNull;
      if (briefField != null) {
        _fail(
          '${model.className}.${briefField.dartName} 使用了 @FoxyBriefField，'
              '但 class 没有 @FoxyBriefEntity。',
          element.getField(briefField.dartName) ?? element,
          '在 class 上添加 @FoxyBriefEntity，或移除字段注解。',
        );
      }
    }

    if (!model.generateFilter) {
      final filterField = model.fields
          .where((field) => field.filter != null)
          .firstOrNull;
      if (filterField != null) {
        _fail(
          '${model.className}.${filterField.dartName} 使用了 @FoxyFilterField，'
              '但 class 没有 @FoxyFilterEntity。',
          element.getField(filterField.dartName) ?? element,
          '在 class 上添加 @FoxyFilterEntity，或移除字段注解。',
        );
      }
    }

    for (final field in model.filterFields) {
      final filter = field.filter!;
      if (!_isFilterDefaultCompatible(filter)) {
        _fail(
          '${model.className}.${field.dartName} 的 Filter 默认值类型不匹配：'
              '${filter.type.name} 不能使用 ${filter.defaultValue.runtimeType}。',
          element.getField(field.dartName) ?? element,
          '让 defaultValue 与 FoxyFilterFieldType 对应的 Dart 类型一致。',
        );
      }
    }
  }

  bool _isFilterDefaultCompatible(FilterFieldGenerationModel filter) {
    final value = filter.defaultValue;
    if (value == null) return false;
    return switch (filter.type) {
      FoxyFilterFieldType.boolean => value is bool,
      FoxyFilterFieldType.decimal => value is num,
      FoxyFilterFieldType.integer => value is int,
      FoxyFilterFieldType.text => value is String,
    };
  }

  Never _fail(String message, Element element, String todo) {
    throw InvalidGenerationSourceError(message, element: element, todo: todo);
  }
}
