import 'repository_filter_model.dart';

final class RepositoryGenerationModel {
  final String entityClassName;
  final String entityParameterName;
  final List<RepositoryFilterFieldModel> filterFields;
  final List<RepositoryKeyFieldModel> keyFields;
  final String mixinName;
  final List<String> briefProjectionColumns;

  /// 是否存在 `lib/view_model/<base>_list_view_model.dart`(主表列表页)。
  /// 全量列表 `getXxxs` 与 `_applyFilter` 只为主表仓库生成。
  final bool listViewModelPresent;

  /// 是否生成 `get*Locales`/`save*Locales` 委托(仓库混入
  /// `DbcLocaleRepositoryMixin` 并声明 `dbcLocaleTableName`)。
  final bool localeHelpersEnabled;

  /// 关联键字段列表(声明 `linkKey:` 的子表仓库);空 = 主表形态。
  final List<RepositoryKeyFieldModel> linkKeyFields;
  final bool queryLayerEnabled;
  final String repositoryClassName;
  final String table;

  const RepositoryGenerationModel({
    required this.entityClassName,
    required this.entityParameterName,
    required this.filterFields,
    required this.keyFields,
    required this.listViewModelPresent,
    required this.localeHelpersEnabled,
    required this.mixinName,
    required this.briefProjectionColumns,
    required this.linkKeyFields,
    required this.queryLayerEnabled,
    required this.repositoryClassName,
    required this.table,
  });

  String get baseName =>
      entityClassName.substring(0, entityClassName.length - 'Entity'.length);

  String get briefEntityClassName => 'Brief${baseName}Entity';

  String get filterClassName => '${baseName}Filter';

  String get keyType =>
      keyFields.length == 1 ? keyFields.single.dartType : '${baseName}Key';
}

final class RepositoryKeyFieldModel {
  final String columnName;
  final String dartName;
  final String dartType;

  const RepositoryKeyFieldModel({
    required this.columnName,
    required this.dartName,
    required this.dartType,
  });
}
