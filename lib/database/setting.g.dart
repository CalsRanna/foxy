// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSettingCollection on Isar {
  IsarCollection<Setting> get settings => this.collection();
}

const SettingSchema = CollectionSchema(
  name: r'settings',
  id: -5221820136678325216,
  properties: {
    r'database': PropertySchema(
      id: 0,
      name: r'database',
      type: IsarType.string,
    ),
    r'dbc_path': PropertySchema(
      id: 1,
      name: r'dbc_path',
      type: IsarType.string,
    ),
    r'host': PropertySchema(
      id: 2,
      name: r'host',
      type: IsarType.string,
    ),
    r'mpq_name': PropertySchema(
      id: 3,
      name: r'mpq_name',
      type: IsarType.string,
    ),
    r'mpq_path': PropertySchema(
      id: 4,
      name: r'mpq_path',
      type: IsarType.string,
    ),
    r'password': PropertySchema(
      id: 5,
      name: r'password',
      type: IsarType.string,
    ),
    r'port': PropertySchema(
      id: 6,
      name: r'port',
      type: IsarType.long,
    ),
    r'username': PropertySchema(
      id: 7,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _settingEstimateSize,
  serialize: _settingSerialize,
  deserialize: _settingDeserialize,
  deserializeProp: _settingDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _settingGetId,
  getLinks: _settingGetLinks,
  attach: _settingAttach,
  version: '3.1.0+1',
);

int _settingEstimateSize(
  Setting object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.database.length * 3;
  bytesCount += 3 + object.dbcPath.length * 3;
  bytesCount += 3 + object.host.length * 3;
  bytesCount += 3 + object.mpqName.length * 3;
  bytesCount += 3 + object.mpqPath.length * 3;
  bytesCount += 3 + object.password.length * 3;
  bytesCount += 3 + object.username.length * 3;
  return bytesCount;
}

void _settingSerialize(
  Setting object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.database);
  writer.writeString(offsets[1], object.dbcPath);
  writer.writeString(offsets[2], object.host);
  writer.writeString(offsets[3], object.mpqName);
  writer.writeString(offsets[4], object.mpqPath);
  writer.writeString(offsets[5], object.password);
  writer.writeLong(offsets[6], object.port);
  writer.writeString(offsets[7], object.username);
}

Setting _settingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Setting();
  object.database = reader.readString(offsets[0]);
  object.dbcPath = reader.readString(offsets[1]);
  object.host = reader.readString(offsets[2]);
  object.id = id;
  object.mpqName = reader.readString(offsets[3]);
  object.mpqPath = reader.readString(offsets[4]);
  object.password = reader.readString(offsets[5]);
  object.port = reader.readLong(offsets[6]);
  object.username = reader.readString(offsets[7]);
  return object;
}

P _settingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _settingGetId(Setting object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _settingGetLinks(Setting object) {
  return [];
}

void _settingAttach(IsarCollection<dynamic> col, Id id, Setting object) {
  object.id = id;
}

extension SettingQueryWhereSort on QueryBuilder<Setting, Setting, QWhere> {
  QueryBuilder<Setting, Setting, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SettingQueryWhere on QueryBuilder<Setting, Setting, QWhereClause> {
  QueryBuilder<Setting, Setting, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Setting, Setting, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Setting, Setting, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Setting, Setting, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SettingQueryFilter
    on QueryBuilder<Setting, Setting, QFilterCondition> {
  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'database',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'database',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'database',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> databaseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'database',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dbc_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dbc_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dbc_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dbc_path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dbc_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dbc_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dbc_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dbc_path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dbc_path',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> dbcPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dbc_path',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'host',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'host',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'host',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'host',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> hostIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'host',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mpq_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mpq_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mpq_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mpq_name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mpq_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mpq_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mpq_name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mpq_name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mpq_name',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mpq_name',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mpq_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mpq_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mpq_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mpq_path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mpq_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mpq_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mpq_path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mpq_path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mpq_path',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> mpqPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mpq_path',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'password',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'password',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> passwordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> portEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> portGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> portLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'port',
        value: value,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> portBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'port',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<Setting, Setting, QAfterFilterCondition> usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension SettingQueryObject
    on QueryBuilder<Setting, Setting, QFilterCondition> {}

extension SettingQueryLinks
    on QueryBuilder<Setting, Setting, QFilterCondition> {}

extension SettingQuerySortBy on QueryBuilder<Setting, Setting, QSortBy> {
  QueryBuilder<Setting, Setting, QAfterSortBy> sortByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByDbcPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbc_path', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByDbcPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbc_path', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByHost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByHostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByMpqName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_name', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByMpqNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_name', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByMpqPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_path', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByMpqPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_path', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension SettingQuerySortThenBy
    on QueryBuilder<Setting, Setting, QSortThenBy> {
  QueryBuilder<Setting, Setting, QAfterSortBy> thenByDatabase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByDatabaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'database', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByDbcPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbc_path', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByDbcPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbc_path', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByHost() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByHostDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'host', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByMpqName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_name', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByMpqNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_name', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByMpqPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_path', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByMpqPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mpq_path', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByPortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'port', Sort.desc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<Setting, Setting, QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension SettingQueryWhereDistinct
    on QueryBuilder<Setting, Setting, QDistinct> {
  QueryBuilder<Setting, Setting, QDistinct> distinctByDatabase(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'database', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Setting, Setting, QDistinct> distinctByDbcPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dbc_path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Setting, Setting, QDistinct> distinctByHost(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'host', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Setting, Setting, QDistinct> distinctByMpqName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mpq_name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Setting, Setting, QDistinct> distinctByMpqPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mpq_path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Setting, Setting, QDistinct> distinctByPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'password', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Setting, Setting, QDistinct> distinctByPort() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'port');
    });
  }

  QueryBuilder<Setting, Setting, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension SettingQueryProperty
    on QueryBuilder<Setting, Setting, QQueryProperty> {
  QueryBuilder<Setting, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Setting, String, QQueryOperations> databaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'database');
    });
  }

  QueryBuilder<Setting, String, QQueryOperations> dbcPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dbc_path');
    });
  }

  QueryBuilder<Setting, String, QQueryOperations> hostProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'host');
    });
  }

  QueryBuilder<Setting, String, QQueryOperations> mpqNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mpq_name');
    });
  }

  QueryBuilder<Setting, String, QQueryOperations> mpqPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mpq_path');
    });
  }

  QueryBuilder<Setting, String, QQueryOperations> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'password');
    });
  }

  QueryBuilder<Setting, int, QQueryOperations> portProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'port');
    });
  }

  QueryBuilder<Setting, String, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
