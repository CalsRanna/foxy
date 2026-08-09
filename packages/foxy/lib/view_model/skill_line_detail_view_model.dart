import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// Hand-written (not generated): the three multi-language groups are edited
/// through [FoxyLocalePicker], which merges all 16 languages back into the
/// entity — a generated controller-based collect would drop the hidden
/// languages.
class SkillLineDetailViewModel with FieldControllerMixin {
  void _logActivity(ActivityActionType action, SkillLineEntity t) {
    final log = ActivityLogEntity(
      module: 'skill_line',
      actionType: action,
      entityName: t.displayNameLangZhCN,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(log));
  }

  final _repository = GetIt.instance.get<SkillLineRepository>();

  final entity = signal<SkillLineEntity?>(null);
  final persistedKey = signal<int?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  /// Primary key; prefilled with MAX+1 by [createSkillLine] on create,
  /// still editable afterwards.
  late final idController = registerController(IntFieldController());

  // === Basic ===
  late final categoryIdController = registerController(IntFieldController());
  late final skillCostsIdController = registerController(IntFieldController());
  late final spellIconIdController = registerController(IntFieldController());
  late final canLinkController = registerController(IntFieldController());

  // === Localized text (zhCN input + Flags) ===
  late final displayNameLangZhCNController = registerController(
    StringFieldController(),
  );
  late final displayNameLangFlagsController = registerController(
    IntFieldController(),
  );
  late final descriptionLangZhCNController = registerController(
    StringFieldController(),
  );
  late final descriptionLangFlagsController = registerController(
    IntFieldController(),
  );
  late final alternateVerbLangZhCNController = registerController(
    StringFieldController(),
  );
  late final alternateVerbLangFlagsController = registerController(
    IntFieldController(),
  );

  /// After the dialog saves the display-name localization, merges it back
  /// into the current Entity and syncs the main-language input.
  void applyDisplayNameLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      displayNameLangEnUS: values.valueOf('enUS'),
      displayNameLangKoKR: values.valueOf('koKR'),
      displayNameLangFrFR: values.valueOf('frFR'),
      displayNameLangDeDE: values.valueOf('deDE'),
      displayNameLangZhCN: values.valueOf('zhCN'),
      displayNameLangZhTW: values.valueOf('zhTW'),
      displayNameLangEsES: values.valueOf('esES'),
      displayNameLangEsMX: values.valueOf('esMX'),
      displayNameLangRuRU: values.valueOf('ruRU'),
      displayNameLangJaJP: values.valueOf('jaJP'),
      displayNameLangPtPT: values.valueOf('ptPT'),
      displayNameLangPtBR: values.valueOf('ptBR'),
      displayNameLangItIT: values.valueOf('itIT'),
      displayNameLangUnk1: values.valueOf('unk1'),
      displayNameLangUnk2: values.valueOf('unk2'),
      displayNameLangUnk3: values.valueOf('unk3'),
    );
    displayNameLangZhCNController.init(values.zhCN);
  }

  /// After the dialog saves the description localization, merges it back
  /// into the current Entity and syncs the main-language input.
  void applyDescriptionLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      descriptionLangEnUS: values.valueOf('enUS'),
      descriptionLangKoKR: values.valueOf('koKR'),
      descriptionLangFrFR: values.valueOf('frFR'),
      descriptionLangDeDE: values.valueOf('deDE'),
      descriptionLangZhCN: values.valueOf('zhCN'),
      descriptionLangZhTW: values.valueOf('zhTW'),
      descriptionLangEsES: values.valueOf('esES'),
      descriptionLangEsMX: values.valueOf('esMX'),
      descriptionLangRuRU: values.valueOf('ruRU'),
      descriptionLangJaJP: values.valueOf('jaJP'),
      descriptionLangPtPT: values.valueOf('ptPT'),
      descriptionLangPtBR: values.valueOf('ptBR'),
      descriptionLangItIT: values.valueOf('itIT'),
      descriptionLangUnk1: values.valueOf('unk1'),
      descriptionLangUnk2: values.valueOf('unk2'),
      descriptionLangUnk3: values.valueOf('unk3'),
    );
    descriptionLangZhCNController.init(values.zhCN);
  }

  /// After the dialog saves the alternate-verb localization, merges it back
  /// into the current Entity and syncs the main-language input.
  void applyAlternateVerbLocales(List<DbcLocaleFieldValue> values) {
    entity.value = entity.value!.copyWith(
      alternateVerbLangEnUS: values.valueOf('enUS'),
      alternateVerbLangKoKR: values.valueOf('koKR'),
      alternateVerbLangFrFR: values.valueOf('frFR'),
      alternateVerbLangDeDE: values.valueOf('deDE'),
      alternateVerbLangZhCN: values.valueOf('zhCN'),
      alternateVerbLangZhTW: values.valueOf('zhTW'),
      alternateVerbLangEsES: values.valueOf('esES'),
      alternateVerbLangEsMX: values.valueOf('esMX'),
      alternateVerbLangRuRU: values.valueOf('ruRU'),
      alternateVerbLangJaJP: values.valueOf('jaJP'),
      alternateVerbLangPtPT: values.valueOf('ptPT'),
      alternateVerbLangPtBR: values.valueOf('ptBR'),
      alternateVerbLangItIT: values.valueOf('itIT'),
      alternateVerbLangUnk1: values.valueOf('unk1'),
      alternateVerbLangUnk2: values.valueOf('unk2'),
      alternateVerbLangUnk3: values.valueOf('unk3'),
    );
    alternateVerbLangZhCNController.init(values.zhCN);
  }

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createSkillLine();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getSkillLine(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw BusyException('operation already in progress');
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storeSkillLine(candidate);
      } else {
        await _repository.updateSkillLine(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _applyCandidate(SkillLineEntity skillLine) {
    idController.init(skillLine.id);
    categoryIdController.init(skillLine.categoryId);
    skillCostsIdController.init(skillLine.skillCostsId);
    spellIconIdController.init(skillLine.spellIconId);
    canLinkController.init(skillLine.canLink);
    displayNameLangZhCNController.init(skillLine.displayNameLangZhCN);
    displayNameLangFlagsController.init(skillLine.displayNameLangFlags);
    descriptionLangZhCNController.init(skillLine.descriptionLangZhCN);
    descriptionLangFlagsController.init(skillLine.descriptionLangFlags);
    alternateVerbLangZhCNController.init(skillLine.alternateVerbLangZhCN);
    alternateVerbLangFlagsController.init(skillLine.alternateVerbLangFlags);
  }

  SkillLineEntity _collectCandidate() {
    // Overlay UI fields from the loaded entity, so hidden columns such as
    // multi-language ones are never cleared.
    return entity.value!.copyWith(
      id: idController.collect(),
      categoryId: categoryIdController.collect(),
      skillCostsId: skillCostsIdController.collect(),
      spellIconId: spellIconIdController.collect(),
      canLink: canLinkController.collect(),
      displayNameLangZhCN: displayNameLangZhCNController.collect(),
      displayNameLangFlags: displayNameLangFlagsController.collect(),
      descriptionLangZhCN: descriptionLangZhCNController.collect(),
      descriptionLangFlags: descriptionLangFlagsController.collect(),
      alternateVerbLangZhCN: alternateVerbLangZhCNController.collect(),
      alternateVerbLangFlags: alternateVerbLangFlagsController.collect(),
    );
  }
}
