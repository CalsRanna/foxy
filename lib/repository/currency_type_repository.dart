import 'package:foxy/constant/currency_type_constants.dart';
import 'package:foxy/entity/currency_type_entity.dart';
import 'package:foxy/entity/currency_type_filter_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

class CurrencyTypeRepository with RepositoryMixin {
  static const _table = 'foxy.dbc_currency_types';

  Future<List<BriefCurrencyTypeEntity>> getBriefCurrencyTypes({
    int page = 1,
    CurrencyTypeFilterEntity? filter,
  }) async {
    final joinLocale = localeEnabled;
    var builder = laconic.table('$_table AS ct').select([
      'ct.ID',
      'ct.ItemID',
      'ct.CategoryID',
      'ct.BitIndex',
      'it.name',
      if (joinLocale) 'itl.Name AS localeName',
    ]);
    builder = builder.leftJoin(
      'item_template AS it',
      (join) => join.on('ct.ItemID', 'it.entry'),
    );
    if (joinLocale) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    builder = _applyFilter(builder, filter, joinLocale: joinLocale);
    final rows = await builder
        .orderBy('ct.ID')
        .limit(kPageSize)
        .offset((page - 1) * kPageSize)
        .get();
    return rows
        .map((row) => BriefCurrencyTypeEntity.fromJson(row.toMap()))
        .toList();
  }

  Future<List<CurrencyTypeEntity>> getCurrencyTypes() async {
    final rows = await laconic.table(_table).get();
    return rows.map((row) => CurrencyTypeEntity.fromJson(row.toMap())).toList();
  }

  Future<int> countCurrencyTypes({CurrencyTypeFilterEntity? filter}) {
    final joinLocale = localeEnabled;
    var builder = laconic
        .table('$_table AS ct')
        .leftJoin(
          'item_template AS it',
          (join) => join.on('ct.ItemID', 'it.entry'),
        );
    if (joinLocale) {
      builder = builder.leftJoin(
        'item_template_locale AS itl',
        (join) => join.on('it.entry', 'itl.ID').where('itl.locale', 'zhCN'),
      );
    }
    return _applyFilter(builder, filter, joinLocale: joinLocale).count();
  }

  Future<CurrencyTypeEntity?> getCurrencyType(int id) async {
    final rows = await laconic.table(_table).where('ID', id).limit(1).get();
    return rows.isEmpty
        ? null
        : CurrencyTypeEntity.fromJson(rows.first.toMap());
  }

  Future<CurrencyTypeEntity> createCurrencyType() async {
    return CurrencyTypeEntity(id: await _getNextId());
  }

  Future<int> storeCurrencyType(CurrencyTypeEntity currencyType) async {
    final id = currencyType.id > 0 ? currencyType.id : await _getNextId();
    final stored = currencyType.copyWith(id: id);
    await _validateReferences(stored, preserveExisting: false);
    await _validateUniqueness(stored);
    await laconic.table(_table).insert([stored.toJson()]);
    return id;
  }

  Future<void> updateCurrencyType(CurrencyTypeEntity currencyType) async {
    final existing = await getCurrencyType(currencyType.id);
    await _validateReferences(currencyType, preserveExisting: true);
    await _validateUniqueness(currencyType);
    if (existing != null) {
      await _validateKeyChanges(existing, currencyType);
    }
    final json = currencyType.toJson()..remove('ID');
    await laconic.table(_table).where('ID', currencyType.id).update(json);
  }

  Future<void> destroyCurrencyType(int id) async {
    final source = await getCurrencyType(id);
    if (source == null) return;
    if (await _isCurrencyTokenItem(source.itemId)) {
      throw StateError('物品 ${source.itemId} 仍使用货币背包位，不能删除对应货币');
    }
    final characterReferences = await _countKnownCurrencyReferences(
      source.bitIndex,
    );
    if (characterReferences > 0) {
      throw StateError(
        '货币位 ${source.bitIndex} 仍被 $characterReferences 个角色记录引用，不能删除',
      );
    }
    await laconic.table(_table).where('ID', id).delete();
  }

  Future<void> copyCurrencyType(int id) async {
    if (await getCurrencyType(id) == null) return;
    throw StateError('CurrencyTypes 的 ItemID 和 BitIndex 必须唯一，请使用新增并选择新值');
  }

  Future<void> saveCurrencyType(CurrencyTypeEntity currencyType) async {
    final existing = currencyType.id == 0
        ? null
        : await getCurrencyType(currencyType.id);
    if (existing == null) {
      await storeCurrencyType(currencyType);
    } else {
      await updateCurrencyType(currencyType);
    }
  }

  Future<int> _getNextId() async {
    final id = await nextMaxPlusOne(_table, 'ID');
    if (id > 0x7fffffff) {
      throw StateError('CurrencyTypes ID 已超出 DBC int32 范围');
    }
    return id;
  }

  Future<void> _validateReferences(
    CurrencyTypeEntity currencyType, {
    required bool preserveExisting,
  }) async {
    final existing = preserveExisting
        ? await getCurrencyType(currencyType.id)
        : null;
    await _validateReference(
      table: 'item_template',
      column: 'entry',
      value: currencyType.itemId,
      existingValue: existing?.itemId,
      field: 'ItemID',
      target: '物品',
    );
    await _validateReference(
      table: 'foxy.dbc_currency_category',
      column: 'ID',
      value: currencyType.categoryId,
      existingValue: existing?.categoryId,
      field: 'CategoryID',
      target: '货币分类',
    );
    if (!await _isCurrencyTokenItem(currencyType.itemId) &&
        existing?.itemId != currencyType.itemId) {
      throw StateError(
        'ItemID 引用的物品 ${currencyType.itemId} 未设置货币背包位 '
        '0x${kCurrencyTokenBagFamilyMask.toRadixString(16)}',
      );
    }
  }

  Future<void> _validateReference({
    required String table,
    required String column,
    required int value,
    required int? existingValue,
    required String field,
    required String target,
  }) async {
    if (existingValue == value) return;
    final references = await laconic.table(table).where(column, value).count();
    if (references > 0) return;
    throw StateError('$field 引用的$target $value 不存在');
  }

  Future<void> _validateUniqueness(CurrencyTypeEntity currencyType) async {
    final itemDuplicates = await laconic
        .table(_table)
        .where('ItemID', currencyType.itemId)
        .where('ID', currencyType.id, comparator: '!=')
        .count();
    if (itemDuplicates > 0) {
      throw StateError('ItemID ${currencyType.itemId} 已被其他货币使用');
    }
    final bitDuplicates = await laconic
        .table(_table)
        .where('BitIndex', currencyType.bitIndex)
        .where('ID', currencyType.id, comparator: '!=')
        .count();
    if (bitDuplicates > 0) {
      throw StateError('BitIndex ${currencyType.bitIndex} 已被其他货币使用');
    }
  }

  Future<void> _validateKeyChanges(
    CurrencyTypeEntity existing,
    CurrencyTypeEntity changed,
  ) async {
    if (existing.itemId != changed.itemId &&
        await _isCurrencyTokenItem(existing.itemId)) {
      throw StateError('原物品 ${existing.itemId} 仍使用货币背包位，不能更换 ItemID');
    }
    if (existing.bitIndex != changed.bitIndex) {
      final references = await _countKnownCurrencyReferences(existing.bitIndex);
      if (references > 0) {
        throw StateError(
          '原货币位 ${existing.bitIndex} 仍被 $references 个角色记录引用，不能更换 BitIndex',
        );
      }
    }
  }

  Future<bool> _isCurrencyTokenItem(int itemId) async {
    final count = await laconic
        .table('item_template')
        .where('entry', itemId)
        .whereRaw('(`BagFamily` & ?) <> 0', [kCurrencyTokenBagFamilyMask])
        .count();
    return count > 0;
  }

  Future<int> _countKnownCurrencyReferences(int bitIndex) async {
    final schemas = await laconic.select('''
SELECT DISTINCT TABLE_SCHEMA
FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'characters' AND COLUMN_NAME = 'knownCurrencies'
''');
    var references = 0;
    for (final row in schemas) {
      final schema = row['TABLE_SCHEMA'] as String;
      if (!RegExp(r'^[0-9A-Za-z_$]+$').hasMatch(schema)) continue;
      references += await laconic.table('$schema.characters').whereRaw(
        '(`knownCurrencies` & (CAST(1 AS UNSIGNED) << ?)) <> 0',
        [bitIndex - 1],
      ).count();
    }
    return references;
  }

  QueryBuilder _applyFilter(
    QueryBuilder builder,
    CurrencyTypeFilterEntity? filter, {
    required bool joinLocale,
  }) {
    if (filter == null) return builder;
    if (filter.id.isNotEmpty) builder = builder.where('ct.ID', filter.id);
    if (filter.name.isNotEmpty) {
      builder = builder.whereNested((query) {
        query.where('it.name', '%${filter.name}%', comparator: 'like');
        if (joinLocale) {
          query.orWhere('itl.Name', '%${filter.name}%', comparator: 'like');
        }
      });
    }
    return builder;
  }
}
