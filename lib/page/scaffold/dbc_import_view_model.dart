import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/database/database.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:signals/signals.dart';
import 'package:warcrafty/warcrafty.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class DbcImportViewModel {
  /// DBC 是否已就绪（导入完成、应用可用）
  final dbcImported = signal(false);

  /// DBC 文件目录路径，null 表示未配置
  final dbcPath = signal<String?>(null);

  /// 导入进度文本，空字符串表示不在导入中
  final dbcImportProgress = signal('');

  /// 错误信息，null 表示无错误
  final dbcImportError = signal<String?>(null);

  /// 应用业务实际使用的 DBC 表名（foxy 库中，不含 foxy. 前缀）
  static const requiredDbcTableNames = [
    'dbc_achievement',
    'dbc_area_table',
    'dbc_char_titles',
    'dbc_creature_display_info',
    'dbc_creature_model_data',
    'dbc_creature_spell_data',
    'dbc_currency_types',
    'dbc_emotes_text',
    'dbc_faction',
    'dbc_gem_properties',
    'dbc_glyph_properties',
    'dbc_item_display_info',
    'dbc_item_extended_cost',
    'dbc_item_random_properties',
    'dbc_item_random_suffix',
    'dbc_item_set',
    'dbc_lock',
    'dbc_map',
    'dbc_quest_faction_reward',
    'dbc_quest_info',
    'dbc_quest_sort',
    'dbc_scaling_stat_distribution',
    'dbc_scaling_stat_values',
    'dbc_spell',
    'dbc_spell_duration',
    'dbc_spell_icon',
    'dbc_spell_item_enchantment',
    'dbc_spell_range',
    'dbc_talent',
    'dbc_vehicle',
  ];

  // ========== 导入流程 ==========

  /// 检查 foxy 数据库中是否存在业务所需的全部 DBC 表（且有数据）。
  /// 仅查询数据库状态，不启动导入。若 config 中已预设 dbc_path 则同步到信号。
  Future<void> checkAndImport() async {
    try {
      if (dbcImported.value) return;

      // 1. 查询数据库中已有的 DBC 表
      final missing = await _checkRequiredTablesExist();
      if (missing.isEmpty) {
        dbcImported.value = true;
        return;
      }

      // 2. 有缺失 → 检查是否已配置 DBC 路径（不在此启动导入，由 UI 层决定时机）
      final config = await _loadConfig();
      final path = config['dbc_path'] as String?;
      if (path != null && path.isNotEmpty) {
        dbcPath.value = path;
      }
    } catch (e) {
      LoggerUtil.instance.e('检查DBC导入状态失败: $e');
      DialogUtil.instance.error('检查DBC导入状态失败: $e');
    }
  }

  /// 启动 DBC 导入（需先设置 [dbcPath]）。
  /// 调用后立即返回，导入进度通过 [dbcImportProgress] / [dbcImported] / [dbcImportError] 信号跟踪。
  void startImport() {
    if (dbcPath.value == null) return;
    _runImport(Database.instance.laconic).catchError((_) {
      // 错误已在 _runImport 内部通过 dbcImportError 信号处理
    });
  }

  /// 查询 information_schema 检查必需表是否存在且有数据。
  /// 返回缺失的表名列表（均缺失时返回完整列表）。
  Future<List<String>> _checkRequiredTablesExist() async {
    try {
      final laconic = Database.instance.laconic;
      final results = await laconic.select(
        "SELECT TABLE_NAME FROM information_schema.TABLES "
        "WHERE TABLE_SCHEMA = 'foxy' AND TABLE_NAME LIKE 'dbc_%' AND TABLE_ROWS > 0",
      );
      final existing =
          results.map((r) => r['TABLE_NAME'] as String).toSet();
      return requiredDbcTableNames
          .where((t) => !existing.contains(t))
          .toList();
    } catch (e) {
      LoggerUtil.instance.w('查询 DBC 表状态失败: $e');
      // 查询失败视为全部缺失，触发导入流程
      return requiredDbcTableNames.toList();
    }
  }

  /// 用户选择 DBC 路径后保存并开始导入
  Future<void> setDbcPath(String path) async {
    try {
      dbcPath.value = path;
      dbcImportError.value = null;
      await _updateConfig('dbc_path', path);

      await _runImport(Database.instance.laconic);
    } catch (e) {
      LoggerUtil.instance.e('设置DBC路径失败: $e');
      DialogUtil.instance.error('设置DBC路径失败: $e');
    }
  }

  /// 重试导入
  Future<void> retryImport() async {
    try {
      dbcImportError.value = null;
      await _runImport(Database.instance.laconic);
    } catch (e) {
      LoggerUtil.instance.e('重试DBC导入失败: $e');
      DialogUtil.instance.error('重试DBC导入失败: $e');
    }
  }

  Future<void> _runImport(Laconic laconic) async {
    try {
      dbcImportProgress.value = '准备导入...';
      final config = await _loadConfig();

      // 扫描 DBC 目录，匹配 schema（DbcSchema 不可跨 isolate 传递）
      final registry = _buildSchemaRegistry();
      final dir = Directory(dbcPath.value!);
      final fileDefs = <_FileDef>[];
      for (final entry in dir.listSync()) {
        if (entry is! File) continue;
        final fileNameWithExt = p.basename(entry.path);
        if (!fileNameWithExt.endsWith('.dbc')) continue;
        final name = fileNameWithExt.substring(0, fileNameWithExt.length - 4);
        final schema = registry[name];
        if (schema == null) {
          LoggerUtil.instance.w('未找到 DBC schema: $name，跳过');
          continue;
        }
        final fields = <_FieldDef>[];
        for (final field in schema.fields) {
          if (field.type.isSkip) continue;
          fields.add((
            index: field.index,
            name: field.name,
            type: field.type.name,
          ));
        }
        fileDefs.add((
          name: name,
          tableName: 'foxy.dbc_${_toSnakeCase(schema.name)}',
          format: schema.format,
          fields: fields,
        ));
      }

      final receivePort = ReceivePort();
      final _WorkerArgs workerArgs = (
        sendPort: receivePort.sendPort,
        dbcPath: dbcPath.value!,
        host: config['host'] as String? ?? '127.0.0.1',
        port: int.tryParse(config['port'] as String? ?? '3306') ?? 3306,
        database: config['database'] as String? ?? 'acore_world',
        username: config['username'] as String? ?? 'acore',
        password: config['password'] as String? ?? 'acore',
        files: fileDefs,
      );
      if (fileDefs.isEmpty) {
        dbcImportProgress.value = '';
        dbcImportError.value =
            '未在目录中找到可导入的 DBC 文件，请确认目录路径是否正确。\n'
            '目录：${dbcPath.value}';
        return;
      }

      await Isolate.spawn<_WorkerArgs>(_importWorker, workerArgs);

      var lastDone = 0;
      var lastTotal = fileDefs.length;
      var finalMessageReceived = false;

      // 超时保护：10 分钟内无任何消息视为异常
      Timer? timeout;
      void resetTimeout() {
        timeout?.cancel();
        timeout = Timer(const Duration(minutes: 10), () {
          if (!finalMessageReceived) {
            LoggerUtil.instance.e('DBC 导入超时');
            dbcImportProgress.value = '';
            dbcImportError.value = 'DBC 导入超时（10 分钟无响应），请检查文件是否完整并重试';
            receivePort.close();
          }
        });
      }

      try {
        resetTimeout();
        await for (final msg in receivePort) {
          resetTimeout();
          switch (msg) {
            case (int done, int total):
              lastDone = done;
              lastTotal = total;
              dbcImportProgress.value = '$done / $total';
            case (String fileName, int processed):
              final prefix = lastTotal > 0 ? '$lastDone / $lastTotal\n' : '';
              if (processed < 0) {
                dbcImportProgress.value = '$prefix导入中：$fileName ...';
              } else {
                dbcImportProgress.value = '$prefix导入中：$fileName ($processed 行)';
              }
            case (String fileName, 'skip', _):
              LoggerUtil.instance.i('DBC $fileName: 已跳过（表已有数据）');
              dbcImportProgress.value = '$lastDone / $lastTotal\n$fileName: 已跳过';
            case (String fileName, 'err', String errMsg):
              LoggerUtil.instance.w('DBC $fileName: $errMsg');
              dbcImportProgress.value = '$lastDone / $lastTotal\n$fileName: 导入失败（$errMsg）';
            case (
              String fileName,
              int _,
              int _,
              int _,
              int _,
            ):
              LoggerUtil.instance.i('DBC $fileName: 导入完成');
            case (bool success, int imported, int skipped, List errs):
              finalMessageReceived = true;
              timeout?.cancel();
              if (success) {
                LoggerUtil.instance.i('DBC 导入完成: $imported 个文件, 跳过 $skipped 个');
                dbcImportProgress.value = '';
                dbcImported.value = true;
              } else {
                LoggerUtil.instance.w('DBC 导入完成但有错误: 成功 $imported, 跳过 $skipped, 失败 ${errs.length}');
                for (final e in errs) {
                  LoggerUtil.instance.w('  $e');
                }
                final top = errs.take(3).join('\n');
                dbcImportError.value =
                    '导入完成，但部分文件失败：\n$top'
                    '${errs.length > 3 ? '\n...等 ${errs.length} 个错误' : ''}';
                dbcImportProgress.value = '';
              }
              receivePort.close();
            default:
              break;
          }
        }
      } finally {
        timeout?.cancel();
        receivePort.close();
        if (!finalMessageReceived) {
          LoggerUtil.instance.e('DBC 导入异常中断：工作者 isolate 未发送完成消息');
          dbcImportProgress.value = '';
          dbcImportError.value = 'DBC 导入异常中断，请检查文件是否完整并重试';
        }
      }
    } catch (e) {
      dbcImportProgress.value = '';
      dbcImportError.value = '导入出错：$e';
    }
  }

  // ========== 配置持久化 ==========

  Future<Map<String, dynamic>> _loadConfig() async {
    final file = File(_configPath);
    if (!await file.exists()) return {};
    final content = await file.readAsString();
    if (content.isEmpty) return {};
    return Map<String, dynamic>.from(loadYaml(content));
  }

  Future<void> _updateConfig(String key, String value) async {
    final file = File(_configPath);
    if (!await file.exists()) await file.create(recursive: true);
    final content = await file.readAsString();
    Map<String, dynamic> existingConfig = {};
    if (content.isNotEmpty) {
      existingConfig = Map<String, dynamic>.from(loadYaml(content));
    }
    existingConfig[key] = value;
    final editor = YamlEditor('');
    editor.update([], existingConfig);
    await file.writeAsString(editor.toString());
  }

  String get _configPath => p.join(Directory.current.path, 'config.yaml');
}

// ========== 辅助类型和函数 ==========

/// 根据 [Definitions] 中的所有预定义结构建立 schema 注册表。
/// 键为 [DbcSchema.name]（对应 .dbc 文件名，不含扩展名）。
Map<String, DbcSchema> _buildSchemaRegistry() {
  final schemas = <DbcSchema>[
    // achievement
    Definitions.achievement,
    Definitions.achievementCategory,
    Definitions.achievementCriteria,

    // area
    Definitions.areaGroup,
    Definitions.areaPOI,
    Definitions.areaTable,
    Definitions.areaTrigger,
    Definitions.wMOAreaTable,
    Definitions.worldChunkSounds,
    Definitions.worldMapArea,
    Definitions.worldMapContinent,
    Definitions.worldMapOverlay,
    Definitions.worldMapTransforms,
    Definitions.worldSafeLocs,
    Definitions.worldStateUI,
    Definitions.worldStateZoneSounds,

    // character
    Definitions.charBaseInfo,
    Definitions.charHairGeosets,
    Definitions.charHairTextures,
    Definitions.charSections,
    Definitions.charStartOutfit,
    Definitions.charTitles,
    Definitions.characterFacialHairStyles,
    Definitions.chatChannels,
    Definitions.chatProfanity,
    Definitions.chrClasses,
    Definitions.chrRaces,

    // creature
    Definitions.creatureDisplayInfo,
    Definitions.creatureDisplayInfoExtra,
    Definitions.creatureFamily,
    Definitions.creatureModelData,
    Definitions.creatureMovementInfo,
    Definitions.creatureSoundData,
    Definitions.creatureSpellData,
    Definitions.creatureType,

    // faction
    Definitions.faction,
    Definitions.factionGroup,
    Definitions.factionTemplate,

    // gameobject
    Definitions.gameObjectArtKit,
    Definitions.gameObjectDisplayInfo,

    // item
    Definitions.gemProperties,
    Definitions.item,
    Definitions.itemBagFamily,
    Definitions.itemClass,
    Definitions.itemCondExtCosts,
    Definitions.itemDisplayInfo,
    Definitions.itemExtendedCost,
    Definitions.itemGroupSounds,
    Definitions.itemLimitCategory,
    Definitions.itemPetFood,
    Definitions.itemPurchaseGroup,
    Definitions.itemRandomProperties,
    Definitions.itemRandomSuffix,
    Definitions.itemSet,
    Definitions.itemSubClass,
    Definitions.itemSubClassMask,
    Definitions.itemVisualEffects,
    Definitions.itemVisuals,

    // light
    Definitions.light,
    Definitions.lightFloatBand,
    Definitions.lightIntBand,
    Definitions.lightParams,
    Definitions.lightSkybox,

    // map
    Definitions.dungeonEncounter,
    Definitions.dungeonMap,
    Definitions.dungeonMapChunk,
    Definitions.lFGDungeonExpansion,
    Definitions.lFGDungeonGroup,
    Definitions.lFGDungeons,
    Definitions.map,
    Definitions.mapDifficulty,

    // misc
    Definitions.animationData,
    Definitions.attackAnimKits,
    Definitions.attackAnimTypes,
    Definitions.auctionHouse,
    Definitions.bankBagSlotPrices,
    Definitions.bannedAddOns,
    Definitions.barberShopStyle,
    Definitions.battlemasterList,
    Definitions.cameraShakes,
    Definitions.cfgCategories,
    Definitions.cfgConfigs,
    Definitions.cinematicCamera,
    Definitions.cinematicSequences,
    Definitions.currencyCategory,
    Definitions.currencyTypes,
    Definitions.danceMoves,
    Definitions.deathThudLookups,
    Definitions.declinedWord,
    Definitions.declinedWordCases,
    Definitions.destructibleModelData,
    Definitions.durabilityCosts,
    Definitions.durabilityQuality,
    Definitions.emotes,
    Definitions.emotesText,
    Definitions.emotesTextData,
    Definitions.emotesTextSound,
    Definitions.environmentalDamage,
    Definitions.exhaustion,
    Definitions.fileData,
    Definitions.footprintTextures,
    Definitions.footstepTerrainLookup,
    Definitions.gMSurveyAnswers,
    Definitions.gMSurveyCurrentSurvey,
    Definitions.gMSurveyQuestions,
    Definitions.gMSurveySurveys,
    Definitions.gMTicketCategory,
    Definitions.gameTables,
    Definitions.gameTips,
    Definitions.groundEffectDoodad,
    Definitions.groundEffectTexture,
    Definitions.helmetGeosetVisData,
    Definitions.holidayDescriptions,
    Definitions.holidayNames,
    Definitions.holidays,
    Definitions.languageWords,
    Definitions.languages,
    Definitions.liquidMaterial,
    Definitions.liquidType,
    Definitions.loadingScreenTaxiSplines,
    Definitions.loadingScreens,
    Definitions.lock,
    Definitions.lockType,
    Definitions.mailTemplate,
    Definitions.material,
    Definitions.movie,
    Definitions.movieFileData,
    Definitions.movieVariation,
    Definitions.nPCSounds,
    Definitions.nameGen,
    Definitions.namesProfanity,
    Definitions.namesReserved,
    Definitions.objectEffect,
    Definitions.objectEffectGroup,
    Definitions.objectEffectModifier,
    Definitions.objectEffectPackage,
    Definitions.objectEffectPackageElem,
    Definitions.overrideSpellData,
    Definitions.package,
    Definitions.pageTextMaterial,
    Definitions.paperDollItemFrame,
    Definitions.particleColor,
    Definitions.petPersonality,
    Definitions.petitionType,
    Definitions.powerDisplay,
    Definitions.pvpDifficulty,
    Definitions.randPropPoints,
    Definitions.resistances,
    Definitions.scalingStatDistribution,
    Definitions.scalingStatValues,
    Definitions.screenEffect,
    Definitions.serverMessages,
    Definitions.sheatheSoundLookups,
    Definitions.spamMessages,
    Definitions.stableSlotPrices,
    Definitions.startupStrings,
    Definitions.stationery,
    Definitions.stringLookups,
    Definitions.summonProperties,
    Definitions.teamContributionPoints,
    Definitions.terrainType,
    Definitions.terrainTypeSounds,
    Definitions.transportAnimation,
    Definitions.transportPhysics,
    Definitions.transportRotation,
    Definitions.uISoundLookups,
    Definitions.unitBlood,
    Definitions.unitBloodLevels,
    Definitions.videoHardware,
    Definitions.vocalUISounds,
    Definitions.weaponImpactSounds,
    Definitions.weaponSwingSounds2,
    Definitions.weather,
    Definitions.wowErrorStrings,
    Definitions.zoneIntroMusicTable,
    Definitions.zoneMusic,
    Definitions.gtbarberShopCostBase,
    Definitions.gtchanceToMeleeCrit,
    Definitions.gtchanceToMeleeCritBase,
    Definitions.gtchanceToSpellCrit,
    Definitions.gtchanceToSpellCritBase,
    Definitions.gtcombatRatings,
    Definitions.gtnPCManaCostScaler,
    Definitions.gtoCTClassCombatRatingScalar,
    Definitions.gtoCTRegenHP,
    Definitions.gtoCTRegenMP,
    Definitions.gtregenHPPerSpt,
    Definitions.gtregenMPPerSpt,

    // quest
    Definitions.questFactionReward,
    Definitions.questInfo,
    Definitions.questSort,
    Definitions.questXP,

    // skill
    Definitions.skillCostsData,
    Definitions.skillLine,
    Definitions.skillLineAbility,
    Definitions.skillLineCategory,
    Definitions.skillRaceClassInfo,
    Definitions.skillTiers,

    // sound
    Definitions.soundAmbience,
    Definitions.soundEmitters,
    Definitions.soundEntries,
    Definitions.soundEntriesAdvanced,
    Definitions.soundFilter,
    Definitions.soundFilterElem,
    Definitions.soundProviderPreferences,
    Definitions.soundSamplePreferences,
    Definitions.soundWaterType,

    // spell
    Definitions.glyphProperties,
    Definitions.glyphSlot,
    Definitions.spell,
    Definitions.spellCastTimes,
    Definitions.spellCategory,
    Definitions.spellChainEffects,
    Definitions.spellDescriptionVariables,
    Definitions.spellDifficulty,
    Definitions.spellDispelType,
    Definitions.spellDuration,
    Definitions.spellEffectCameraShakes,
    Definitions.spellFocusObject,
    Definitions.spellIcon,
    Definitions.spellItemEnchantment,
    Definitions.spellItemEnchantmentCondition,
    Definitions.spellMechanic,
    Definitions.spellMissile,
    Definitions.spellMissileMotion,
    Definitions.spellRadius,
    Definitions.spellRange,
    Definitions.spellRuneCost,
    Definitions.spellShapeshiftForm,
    Definitions.spellVisual,
    Definitions.spellVisualEffectName,
    Definitions.spellVisualKit,
    Definitions.spellVisualKitAreaModel,
    Definitions.spellVisualKitModelAttach,
    Definitions.spellVisualPrecastTransitions,
    Definitions.totemCategory,

    // talent
    Definitions.talent,
    Definitions.talentTab,

    // taxi
    Definitions.taxiNodes,
    Definitions.taxiPath,
    Definitions.taxiPathNode,

    // vehicle
    Definitions.vehicle,
    Definitions.vehicleSeat,
    Definitions.vehicleUIIndSeat,
    Definitions.vehicleUIIndicator,
  ];
  return {for (final s in schemas) s.name: s};
}

typedef _FieldDef = ({int index, String name, String type});
typedef _FileDef = ({
  String name,
  String tableName,
  String format,
  List<_FieldDef> fields,
});
typedef _WorkerArgs = ({
  SendPort sendPort,
  String dbcPath,
  String host,
  int port,
  String database,
  String username,
  String password,
  List<_FileDef> files,
});

String _toSnakeCase(String input) {
  if (input.isEmpty) return input;
  final buffer = StringBuffer();
  for (var i = 0; i < input.length; i++) {
    final char = input[i];
    if (char == '_' || char == ' ') {
      buffer.write(char);
    } else if (char.toUpperCase() == char) {
      if (i > 0 && input[i - 1] != '_' && input[i - 1] != ' ') {
        if (input[i - 1].toLowerCase() == input[i - 1] ||
            input[i - 1].toUpperCase() != input[i - 1]) {
          buffer.write('_');
        } else if (i + 1 < input.length &&
            input[i + 1].toLowerCase() == input[i + 1]) {
          buffer.write('_');
        }
      }
      buffer.write(char.toLowerCase());
    } else {
      buffer.write(char);
    }
  }
  return buffer.toString().replaceAll(' ', '_');
}

String _sqlTypeFromString(String type) {
  return switch (type) {
    'id' => 'INT NOT NULL',
    'int32' => 'INT',
    'uint8' => 'TINYINT UNSIGNED',
    'float' => 'FLOAT',
    'string' => 'TEXT',
    'boolean' => 'TINYINT(1)',
    _ => 'INT',
  };
}

const _maxConcurrent = 6;
const _batchSize = 200;

/// 安全 INSERT，使用反引号包裹列名以避免 MySQL 保留字和类型关键字冲突
///（如 Float4 会被 MySQL 误解析为 FLOAT4 类型关键字）。
Future<void> _safeInsert(
  Laconic laconic,
  String table,
  List<Map<String, dynamic>> records,
) async {
  if (records.isEmpty) return;
  final cols = records.first.keys.map((c) => '`$c`').join(', ');
  final row = '(${List.filled(records.first.length, '?').join(', ')})';
  final rows = List.filled(records.length, row).join(', ');
  final params = <Object?>[];
  for (final record in records) {
    params.addAll(record.values);
  }
  await laconic.statement('INSERT INTO $table ($cols) VALUES $rows', params);
}

// ========== 后台导入 worker (运行在独立 isolate 中) ==========

/// 整个 DBC 导入流程在后台 isolate 中执行，包含 DB 连接、建表和写入。
Future<void> _importWorker(_WorkerArgs args) async {
  final (
    :sendPort,
    :dbcPath,
    :host,
    :port,
    :database,
    :username,
    :password,
    :files,
  ) = args;

  try {
    final laconic = Laconic(
      MysqlDriver(
        MysqlConfig(
          host: host,
          port: port,
          database: database,
          username: username,
          password: password,
        ),
      ),
    );

    // 并发导入（建表逻辑在 _workerImportFile 中按需执行）
    final pool = Pool(_maxConcurrent);
    var imported = 0, skipped = 0;
    final errors = <String>[];
    await Future.wait(
      files.map(
        (file) => pool.withResource(() async {
          try {
            final result = await _workerImportFile(
              sendPort,
              laconic,
              dbcPath,
              file,
            );
            if (result.done) {
              imported++;
              sendPort.send((
                file.name,
                result.parseUs,
                result.convertUs,
                result.insertUs,
                result.startedAt,
              ));
            } else {
              skipped++;
              sendPort.send((file.name, 'skip'));
            }
          } catch (e) {
            final msg = '$e';
            errors.add('${file.name}: $msg');
            sendPort.send((file.name, 'err', msg));
          }
          sendPort.send((imported + skipped + errors.length, files.length));
        }),
      ),
    );

    sendPort.send((errors.isEmpty, imported, skipped, errors));
  } catch (e) {
    sendPort.send((false, 0, 0, <String>['worker 初始化失败: $e']));
  }
}

Future<void> _workerCreateTable(Laconic laconic, _FileDef file) async {
  final columns = <String>[];
  for (final field in file.fields) {
    columns.add('`${field.name}` ${_sqlTypeFromString(field.type)}');
  }
  if (columns.isEmpty) return;
  await laconic.statement('DROP TABLE IF EXISTS ${file.tableName}');
  final sql =
      'CREATE TABLE ${file.tableName} (\n'
      '  ${columns.join(',\n  ')}\n'
      ') ENGINE=InnoDB DEFAULT CHARSET=utf8mb4';
  try {
    await laconic.statement(sql);
  } catch (e) {
    throw Exception('CREATE TABLE 失败: $e\nSQL: $sql');
  }
}

Future<({bool done, int parseUs, int convertUs, int insertUs, int startedAt})>
_workerImportFile(
  SendPort sendPort,
  Laconic laconic,
  String dbcPath,
  _FileDef file,
) async {
  final count = await laconic.table(file.tableName).count();
  if (count > 0) {
    return (done: false, parseUs: 0, convertUs: 0, insertUs: 0, startedAt: 0);
  }

  // 表为空 → 先 DROP + CREATE 确保 schema 正确，然后导入
  await _workerCreateTable(laconic, file);

  final path = p.join(dbcPath, '${file.name}.dbc');
  if (!File(path).existsSync()) {
    throw FileSystemException('DBC 文件不存在', path);
  }

  final sw = Stopwatch()..start();
  final startedAt = DateTime.now().microsecondsSinceEpoch;
  var parseUs = 0, convertUs = 0, insertUs = 0;
  sendPort.send((file.name, -1));

  await laconic.transaction(() async {
    final loader = DbcLoader(path, file.format);
    parseUs = sw.elapsedMicroseconds;
    var records = <Map<String, dynamic>>[];
    var processedCount = 0;

    for (final record in loader.records) {
      final before = sw.elapsedMicroseconds;
      final map = <String, dynamic>{};
      for (final (:index, :name, :type) in file.fields) {
        map[name] = switch (type) {
          'string' => record.getString(index),
          'float' => record.getFloat(index),
          'int32' || 'id' => record.getInt(index),
          'uint8' => record.getUint8(index),
          'boolean' => record.getInt(index) != 0,
          _ => null,
        };
      }
      records.add(map);
      convertUs += sw.elapsedMicroseconds - before;

      if (records.length >= _batchSize) {
        final beforeInsert = sw.elapsedMicroseconds;
        await _safeInsert(laconic, file.tableName, records);
        insertUs += sw.elapsedMicroseconds - beforeInsert;
        processedCount += records.length;
        sendPort.send((file.name, processedCount));
        records.clear();
      }
    }

    if (records.isNotEmpty) {
      final beforeFlush = sw.elapsedMicroseconds;
      await _safeInsert(laconic, file.tableName, records);
      insertUs += sw.elapsedMicroseconds - beforeFlush;
      processedCount += records.length;
      sendPort.send((file.name, processedCount));
    }
  });

  return (
    done: true,
    parseUs: parseUs,
    convertUs: convertUs,
    insertUs: insertUs,
    startedAt: startedAt,
  );
}
