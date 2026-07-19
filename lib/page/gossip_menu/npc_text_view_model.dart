import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/entity/npc_text_locale_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class NpcTextViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<NpcTextRepository>();
  final _localeRepository = GetIt.instance.get<NpcTextLocaleRepository>();

  final localeEditingKey = signal<NpcTextLocaleKey?>(null);
  final persistedKey = signal<int?>(null);

  late final idController = registerController(IntFieldController());
  late final text00Controller = registerController(StringFieldController());
  late final text01Controller = registerController(StringFieldController());
  late final broadcastTextId0Controller = registerController(
    IntFieldController(),
  );
  late final lang0Controller = registerController(IntFieldController());
  late final probability0Controller = registerController(
    DoubleFieldController(),
  );
  late final em00Controller = registerController(IntFieldController());
  late final em01Controller = registerController(IntFieldController());
  late final em02Controller = registerController(IntFieldController());
  late final em03Controller = registerController(IntFieldController());
  late final em04Controller = registerController(IntFieldController());
  late final em05Controller = registerController(IntFieldController());
  late final text10Controller = registerController(StringFieldController());
  late final text11Controller = registerController(StringFieldController());
  late final broadcastTextId1Controller = registerController(
    IntFieldController(),
  );
  late final lang1Controller = registerController(IntFieldController());
  late final probability1Controller = registerController(
    DoubleFieldController(),
  );
  late final em10Controller = registerController(IntFieldController());
  late final em11Controller = registerController(IntFieldController());
  late final em12Controller = registerController(IntFieldController());
  late final em13Controller = registerController(IntFieldController());
  late final em14Controller = registerController(IntFieldController());
  late final em15Controller = registerController(IntFieldController());
  late final text20Controller = registerController(StringFieldController());
  late final text21Controller = registerController(StringFieldController());
  late final broadcastTextId2Controller = registerController(
    IntFieldController(),
  );
  late final lang2Controller = registerController(IntFieldController());
  late final probability2Controller = registerController(
    DoubleFieldController(),
  );
  late final em20Controller = registerController(IntFieldController());
  late final em21Controller = registerController(IntFieldController());
  late final em22Controller = registerController(IntFieldController());
  late final em23Controller = registerController(IntFieldController());
  late final em24Controller = registerController(IntFieldController());
  late final em25Controller = registerController(IntFieldController());
  late final text30Controller = registerController(StringFieldController());
  late final text31Controller = registerController(StringFieldController());
  late final broadcastTextId3Controller = registerController(
    IntFieldController(),
  );
  late final lang3Controller = registerController(IntFieldController());
  late final probability3Controller = registerController(
    DoubleFieldController(),
  );
  late final em30Controller = registerController(IntFieldController());
  late final em31Controller = registerController(IntFieldController());
  late final em32Controller = registerController(IntFieldController());
  late final em33Controller = registerController(IntFieldController());
  late final em34Controller = registerController(IntFieldController());
  late final em35Controller = registerController(IntFieldController());
  late final text40Controller = registerController(StringFieldController());
  late final text41Controller = registerController(StringFieldController());
  late final broadcastTextId4Controller = registerController(
    IntFieldController(),
  );
  late final lang4Controller = registerController(IntFieldController());
  late final probability4Controller = registerController(
    DoubleFieldController(),
  );
  late final em40Controller = registerController(IntFieldController());
  late final em41Controller = registerController(IntFieldController());
  late final em42Controller = registerController(IntFieldController());
  late final em43Controller = registerController(IntFieldController());
  late final em44Controller = registerController(IntFieldController());
  late final em45Controller = registerController(IntFieldController());
  late final text50Controller = registerController(StringFieldController());
  late final text51Controller = registerController(StringFieldController());
  late final broadcastTextId5Controller = registerController(
    IntFieldController(),
  );
  late final lang5Controller = registerController(IntFieldController());
  late final probability5Controller = registerController(
    DoubleFieldController(),
  );
  late final em50Controller = registerController(IntFieldController());
  late final em51Controller = registerController(IntFieldController());
  late final em52Controller = registerController(IntFieldController());
  late final em53Controller = registerController(IntFieldController());
  late final em54Controller = registerController(IntFieldController());
  late final em55Controller = registerController(IntFieldController());
  late final text60Controller = registerController(StringFieldController());
  late final text61Controller = registerController(StringFieldController());
  late final broadcastTextId6Controller = registerController(
    IntFieldController(),
  );
  late final lang6Controller = registerController(IntFieldController());
  late final probability6Controller = registerController(
    DoubleFieldController(),
  );
  late final em60Controller = registerController(IntFieldController());
  late final em61Controller = registerController(IntFieldController());
  late final em62Controller = registerController(IntFieldController());
  late final em63Controller = registerController(IntFieldController());
  late final em64Controller = registerController(IntFieldController());
  late final em65Controller = registerController(IntFieldController());
  late final text70Controller = registerController(StringFieldController());
  late final text71Controller = registerController(StringFieldController());
  late final broadcastTextId7Controller = registerController(
    IntFieldController(),
  );
  late final lang7Controller = registerController(IntFieldController());
  late final probability7Controller = registerController(
    DoubleFieldController(),
  );
  late final em70Controller = registerController(IntFieldController());
  late final em71Controller = registerController(IntFieldController());
  late final em72Controller = registerController(IntFieldController());
  late final em73Controller = registerController(IntFieldController());
  late final em74Controller = registerController(IntFieldController());
  late final em75Controller = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());
  late final localeText00Controller = registerController(
    StringFieldController(),
  );
  late final localeText01Controller = registerController(
    StringFieldController(),
  );
  late final localeText10Controller = registerController(
    StringFieldController(),
  );
  late final localeText11Controller = registerController(
    StringFieldController(),
  );
  late final localeText20Controller = registerController(
    StringFieldController(),
  );
  late final localeText21Controller = registerController(
    StringFieldController(),
  );
  late final localeText30Controller = registerController(
    StringFieldController(),
  );
  late final localeText31Controller = registerController(
    StringFieldController(),
  );
  late final localeText40Controller = registerController(
    StringFieldController(),
  );
  late final localeText41Controller = registerController(
    StringFieldController(),
  );
  late final localeText50Controller = registerController(
    StringFieldController(),
  );
  late final localeText51Controller = registerController(
    StringFieldController(),
  );
  late final localeText60Controller = registerController(
    StringFieldController(),
  );
  late final localeText61Controller = registerController(
    StringFieldController(),
  );
  late final localeText70Controller = registerController(
    StringFieldController(),
  );
  late final localeText71Controller = registerController(
    StringFieldController(),
  );

  void dispose() => disposeControllers();

  Future<void> load(int textId) async {
    if (textId <= 0) return;
    try {
      localeEditingKey.value = null;
      final key = textId;
      final entity = await _repository.getNpcText(key);
      persistedKey.value = entity == null ? null : key;
      _applyMain(entity ?? NpcTextEntity(id: textId));
      final localeKey = NpcTextLocaleKey(id: textId, locale: 'zhCN');
      final locale = await _localeRepository.getNpcTextLocale(localeKey);
      localeEditingKey.value = locale == null ? null : localeKey;
      _applyLocale(locale ?? NpcTextLocaleEntity(id: textId));
    } catch (error) {
      LoggerUtil.instance.e('加载 NPC 文本失败: $error');
      DialogUtil.instance.error('加载 NPC 文本失败: $error');
    }
  }

  Future<void> save() async {
    try {
      final entity = _collectMain();
      if (entity.id <= 0) throw StateError('请先保存对话菜单并选择有效文本');
      final locale = _collectLocale(entity.id);
      final originalKey = persistedKey.value;
      final originalLocaleKey = localeEditingKey.value;
      final hasLocaleText = _localeHasText(locale);
      await _repository.laconic.transaction(() async {
        if (originalKey == null) {
          await _repository.storeNpcText(entity);
        } else {
          await _repository.updateNpcText(originalKey, entity);
        }
        if (hasLocaleText) {
          if (originalLocaleKey == null) {
            await _localeRepository.storeNpcTextLocale(locale);
          } else {
            await _localeRepository.updateNpcTextLocale(
              originalLocaleKey,
              locale,
            );
          }
        } else if (originalLocaleKey != null) {
          await _localeRepository.destroyNpcTextLocale(originalLocaleKey);
        }
      });
      persistedKey.value = entity.id;
      localeEditingKey.value = hasLocaleText
          ? NpcTextLocaleKey.fromEntity(locale)
          : null;
      DialogUtil.instance.success('保存成功');
    } catch (error) {
      LoggerUtil.instance.e(error.toString());
      DialogUtil.instance.error('保存失败: $error');
    }
  }

  void _applyLocale(NpcTextLocaleEntity entity) {
    localeText00Controller.init(entity.text00);
    localeText01Controller.init(entity.text01);
    localeText10Controller.init(entity.text10);
    localeText11Controller.init(entity.text11);
    localeText20Controller.init(entity.text20);
    localeText21Controller.init(entity.text21);
    localeText30Controller.init(entity.text30);
    localeText31Controller.init(entity.text31);
    localeText40Controller.init(entity.text40);
    localeText41Controller.init(entity.text41);
    localeText50Controller.init(entity.text50);
    localeText51Controller.init(entity.text51);
    localeText60Controller.init(entity.text60);
    localeText61Controller.init(entity.text61);
    localeText70Controller.init(entity.text70);
    localeText71Controller.init(entity.text71);
  }

  void _applyMain(NpcTextEntity entity) {
    idController.init(entity.id);
    text00Controller.init(entity.text00);
    text01Controller.init(entity.text01);
    broadcastTextId0Controller.init(entity.broadcastTextId0);
    lang0Controller.init(entity.lang0);
    probability0Controller.init(entity.probability0);
    em00Controller.init(entity.em00);
    em01Controller.init(entity.em01);
    em02Controller.init(entity.em02);
    em03Controller.init(entity.em03);
    em04Controller.init(entity.em04);
    em05Controller.init(entity.em05);
    text10Controller.init(entity.text10);
    text11Controller.init(entity.text11);
    broadcastTextId1Controller.init(entity.broadcastTextId1);
    lang1Controller.init(entity.lang1);
    probability1Controller.init(entity.probability1);
    em10Controller.init(entity.em10);
    em11Controller.init(entity.em11);
    em12Controller.init(entity.em12);
    em13Controller.init(entity.em13);
    em14Controller.init(entity.em14);
    em15Controller.init(entity.em15);
    text20Controller.init(entity.text20);
    text21Controller.init(entity.text21);
    broadcastTextId2Controller.init(entity.broadcastTextId2);
    lang2Controller.init(entity.lang2);
    probability2Controller.init(entity.probability2);
    em20Controller.init(entity.em20);
    em21Controller.init(entity.em21);
    em22Controller.init(entity.em22);
    em23Controller.init(entity.em23);
    em24Controller.init(entity.em24);
    em25Controller.init(entity.em25);
    text30Controller.init(entity.text30);
    text31Controller.init(entity.text31);
    broadcastTextId3Controller.init(entity.broadcastTextId3);
    lang3Controller.init(entity.lang3);
    probability3Controller.init(entity.probability3);
    em30Controller.init(entity.em30);
    em31Controller.init(entity.em31);
    em32Controller.init(entity.em32);
    em33Controller.init(entity.em33);
    em34Controller.init(entity.em34);
    em35Controller.init(entity.em35);
    text40Controller.init(entity.text40);
    text41Controller.init(entity.text41);
    broadcastTextId4Controller.init(entity.broadcastTextId4);
    lang4Controller.init(entity.lang4);
    probability4Controller.init(entity.probability4);
    em40Controller.init(entity.em40);
    em41Controller.init(entity.em41);
    em42Controller.init(entity.em42);
    em43Controller.init(entity.em43);
    em44Controller.init(entity.em44);
    em45Controller.init(entity.em45);
    text50Controller.init(entity.text50);
    text51Controller.init(entity.text51);
    broadcastTextId5Controller.init(entity.broadcastTextId5);
    lang5Controller.init(entity.lang5);
    probability5Controller.init(entity.probability5);
    em50Controller.init(entity.em50);
    em51Controller.init(entity.em51);
    em52Controller.init(entity.em52);
    em53Controller.init(entity.em53);
    em54Controller.init(entity.em54);
    em55Controller.init(entity.em55);
    text60Controller.init(entity.text60);
    text61Controller.init(entity.text61);
    broadcastTextId6Controller.init(entity.broadcastTextId6);
    lang6Controller.init(entity.lang6);
    probability6Controller.init(entity.probability6);
    em60Controller.init(entity.em60);
    em61Controller.init(entity.em61);
    em62Controller.init(entity.em62);
    em63Controller.init(entity.em63);
    em64Controller.init(entity.em64);
    em65Controller.init(entity.em65);
    text70Controller.init(entity.text70);
    text71Controller.init(entity.text71);
    broadcastTextId7Controller.init(entity.broadcastTextId7);
    lang7Controller.init(entity.lang7);
    probability7Controller.init(entity.probability7);
    em70Controller.init(entity.em70);
    em71Controller.init(entity.em71);
    em72Controller.init(entity.em72);
    em73Controller.init(entity.em73);
    em74Controller.init(entity.em74);
    em75Controller.init(entity.em75);
    verifiedBuildController.init(entity.verifiedBuild);
  }

  NpcTextLocaleEntity _collectLocale(int id) {
    return NpcTextLocaleEntity(
      id: id,
      text00: localeText00Controller.collect(),
      text01: localeText01Controller.collect(),
      text10: localeText10Controller.collect(),
      text11: localeText11Controller.collect(),
      text20: localeText20Controller.collect(),
      text21: localeText21Controller.collect(),
      text30: localeText30Controller.collect(),
      text31: localeText31Controller.collect(),
      text40: localeText40Controller.collect(),
      text41: localeText41Controller.collect(),
      text50: localeText50Controller.collect(),
      text51: localeText51Controller.collect(),
      text60: localeText60Controller.collect(),
      text61: localeText61Controller.collect(),
      text70: localeText70Controller.collect(),
      text71: localeText71Controller.collect(),
    );
  }

  NpcTextEntity _collectMain() {
    return NpcTextEntity(
      id: idController.collect(),
      text00: text00Controller.collect(),
      text01: text01Controller.collect(),
      broadcastTextId0: broadcastTextId0Controller.collect(),
      lang0: lang0Controller.collect(),
      probability0: probability0Controller.collect(),
      em00: em00Controller.collect(),
      em01: em01Controller.collect(),
      em02: em02Controller.collect(),
      em03: em03Controller.collect(),
      em04: em04Controller.collect(),
      em05: em05Controller.collect(),
      text10: text10Controller.collect(),
      text11: text11Controller.collect(),
      broadcastTextId1: broadcastTextId1Controller.collect(),
      lang1: lang1Controller.collect(),
      probability1: probability1Controller.collect(),
      em10: em10Controller.collect(),
      em11: em11Controller.collect(),
      em12: em12Controller.collect(),
      em13: em13Controller.collect(),
      em14: em14Controller.collect(),
      em15: em15Controller.collect(),
      text20: text20Controller.collect(),
      text21: text21Controller.collect(),
      broadcastTextId2: broadcastTextId2Controller.collect(),
      lang2: lang2Controller.collect(),
      probability2: probability2Controller.collect(),
      em20: em20Controller.collect(),
      em21: em21Controller.collect(),
      em22: em22Controller.collect(),
      em23: em23Controller.collect(),
      em24: em24Controller.collect(),
      em25: em25Controller.collect(),
      text30: text30Controller.collect(),
      text31: text31Controller.collect(),
      broadcastTextId3: broadcastTextId3Controller.collect(),
      lang3: lang3Controller.collect(),
      probability3: probability3Controller.collect(),
      em30: em30Controller.collect(),
      em31: em31Controller.collect(),
      em32: em32Controller.collect(),
      em33: em33Controller.collect(),
      em34: em34Controller.collect(),
      em35: em35Controller.collect(),
      text40: text40Controller.collect(),
      text41: text41Controller.collect(),
      broadcastTextId4: broadcastTextId4Controller.collect(),
      lang4: lang4Controller.collect(),
      probability4: probability4Controller.collect(),
      em40: em40Controller.collect(),
      em41: em41Controller.collect(),
      em42: em42Controller.collect(),
      em43: em43Controller.collect(),
      em44: em44Controller.collect(),
      em45: em45Controller.collect(),
      text50: text50Controller.collect(),
      text51: text51Controller.collect(),
      broadcastTextId5: broadcastTextId5Controller.collect(),
      lang5: lang5Controller.collect(),
      probability5: probability5Controller.collect(),
      em50: em50Controller.collect(),
      em51: em51Controller.collect(),
      em52: em52Controller.collect(),
      em53: em53Controller.collect(),
      em54: em54Controller.collect(),
      em55: em55Controller.collect(),
      text60: text60Controller.collect(),
      text61: text61Controller.collect(),
      broadcastTextId6: broadcastTextId6Controller.collect(),
      lang6: lang6Controller.collect(),
      probability6: probability6Controller.collect(),
      em60: em60Controller.collect(),
      em61: em61Controller.collect(),
      em62: em62Controller.collect(),
      em63: em63Controller.collect(),
      em64: em64Controller.collect(),
      em65: em65Controller.collect(),
      text70: text70Controller.collect(),
      text71: text71Controller.collect(),
      broadcastTextId7: broadcastTextId7Controller.collect(),
      lang7: lang7Controller.collect(),
      probability7: probability7Controller.collect(),
      em70: em70Controller.collect(),
      em71: em71Controller.collect(),
      em72: em72Controller.collect(),
      em73: em73Controller.collect(),
      em74: em74Controller.collect(),
      em75: em75Controller.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  bool _localeHasText(NpcTextLocaleEntity entity) {
    return entity.text00.isNotEmpty ||
        entity.text01.isNotEmpty ||
        entity.text10.isNotEmpty ||
        entity.text11.isNotEmpty ||
        entity.text20.isNotEmpty ||
        entity.text21.isNotEmpty ||
        entity.text30.isNotEmpty ||
        entity.text31.isNotEmpty ||
        entity.text40.isNotEmpty ||
        entity.text41.isNotEmpty ||
        entity.text50.isNotEmpty ||
        entity.text51.isNotEmpty ||
        entity.text60.isNotEmpty ||
        entity.text61.isNotEmpty ||
        entity.text70.isNotEmpty ||
        entity.text71.isNotEmpty;
  }
}
