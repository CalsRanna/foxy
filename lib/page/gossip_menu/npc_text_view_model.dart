import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

/// Tab 2 (npc_text) ViewModel
/// 用惰性 Map 管理约 114 个类型化 FieldController
class NpcTextViewModel {
  final _repository = GetIt.instance.get<NpcTextRepository>();
  final _localeRepository = GetIt.instance.get<NpcTextLocaleRepository>();

  final _stringControllers = <String, StringFieldController>{};
  final _intControllers = <String, IntFieldController>{};
  final _doubleControllers = <String, DoubleFieldController>{};

  final creating = signal(false);
  final currentTextId = signal(0);
  final localeExists = signal(false);

  StringFieldController stringOf(String key) {
    return _stringControllers.putIfAbsent(key, () => StringFieldController());
  }

  IntFieldController intOf(String key) {
    return _intControllers.putIfAbsent(key, () => IntFieldController());
  }

  DoubleFieldController doubleOf(String key) {
    return _doubleControllers.putIfAbsent(key, () => DoubleFieldController());
  }

  IntFieldController broadcastOf(int n) => intOf('BroadcastTextID$n');

  IntFieldController emoteOf(String key) => intOf(key);

  /// 加载指定 textId 的数据到所有 controller
  Future<void> load(int textId) async {
    if (textId == 0) {
      _clearAll();
      creating.value = true;
      currentTextId.value = 0;
      intOf('ID').init(0);
      intOf('VerifiedBuild').init(0);
      return;
    }
    try {
      currentTextId.value = textId;
      final main = await _repository.getNpcText(textId);
      if (main == null) {
        creating.value = true;
        final blank = NpcTextEntity(id: textId);
        _applyMainToControllers(blank);
      } else {
        creating.value = false;
        _applyMainToControllers(main);
      }
      final locales = await _localeRepository.getNpcTextLocales(textId);
      NpcTextLocaleEntity? zhCN;
      for (final l in locales) {
        if (l.locale == 'zhCN') {
          zhCN = l;
          break;
        }
      }
      localeExists.value = zhCN != null;
      final target = zhCN ?? NpcTextLocaleEntity(id: textId);
      _applyLocaleToControllers(target);
    } catch (e) {
      LoggerUtil.instance.e('加载NPC文本失败: $e');
      DialogUtil.instance.error('加载NPC文本失败: $e');
    }
  }

  /// 保存主表 + zhCN locale
  Future<void> save() async {
    try {
      final main = _collectMainFromControllers();
      if (creating.value) {
        await _repository.saveNpcText(main);
        creating.value = false;
      } else {
        await _repository.updateNpcText(main);
      }
      currentTextId.value = main.id;

      final locale = _collectLocaleFromControllers(main.id);
      final hasAnyText = locale.texts.any((g) => g.any((t) => t.isNotEmpty));
      if (hasAnyText) {
        try {
          await _localeRepository.saveNpcTextLocale(locale);
          localeExists.value = true;
        } catch (e) {
          LoggerUtil.instance.w('locale 保存失败（可能表不存在）：$e');
        }
      }
      DialogUtil.instance.success('保存成功');
    } catch (e) {
      LoggerUtil.instance.e(e.toString());
      DialogUtil.instance.error('保存失败: ${e.toString()}');
    }
  }

  void dispose() {
    for (final c in _stringControllers.values) {
      c.dispose();
    }
    _stringControllers.clear();
    for (final c in _intControllers.values) {
      c.dispose();
    }
    _intControllers.clear();
    for (final c in _doubleControllers.values) {
      c.dispose();
    }
    _doubleControllers.clear();
  }

  void _clearAll() {
    for (final c in _stringControllers.values) {
      c.init('');
    }
    for (final c in _intControllers.values) {
      c.init(0);
    }
    for (final c in _doubleControllers.values) {
      c.init(0.0);
    }
  }

  void _applyMainToControllers(NpcTextEntity m) {
    intOf('ID').init(m.id);
    intOf('VerifiedBuild').init(m.verifiedBuild);
    for (var n = 0; n < 8; n++) {
      final e = m.entries.isNotEmpty && n < m.entries.length
          ? m.entries[n]
          : const NpcTextEntryEntity();
      stringOf('lang$n').init(e.lang);
      doubleOf('Probability$n').init(e.probability);
      stringOf('text${n}_0').init(e.text0);
      stringOf('text${n}_1').init(e.text1);
      broadcastOf(n).init(e.broadcastTextId);
      for (var i = 0; i < 6; i++) {
        final emote = e.emotes.isNotEmpty && i < e.emotes.length
            ? e.emotes[i]
            : 0;
        emoteOf('em${n}_$i').init(emote);
      }
    }
  }

  void _applyLocaleToControllers(NpcTextLocaleEntity l) {
    stringOf('locale.Locale').init(l.locale.isEmpty ? 'zhCN' : l.locale);
    for (var n = 0; n < 8; n++) {
      final t0 =
          l.texts.isNotEmpty && n < l.texts.length && l.texts[n].isNotEmpty
          ? l.texts[n][0]
          : '';
      final t1 =
          l.texts.isNotEmpty && n < l.texts.length && l.texts[n].length > 1
          ? l.texts[n][1]
          : '';
      stringOf('locale.Text${n}_0').init(t0);
      stringOf('locale.Text${n}_1').init(t1);
    }
  }

  NpcTextEntity _collectMainFromControllers() {
    return NpcTextEntity(
      id: intOf('ID').collect(),
      verifiedBuild: intOf('VerifiedBuild').collect(),
      entries: List.generate(8, (n) {
        final lang = stringOf('lang$n').collect();
        return NpcTextEntryEntity(
          lang: lang.isEmpty ? '0' : lang,
          probability: doubleOf('Probability$n').collect(),
          text0: stringOf('text${n}_0').collect(),
          text1: stringOf('text${n}_1').collect(),
          broadcastTextId: broadcastOf(n).collect(),
          emotes: List.generate(6, (i) => emoteOf('em${n}_$i').collect()),
        );
      }),
    );
  }

  NpcTextLocaleEntity _collectLocaleFromControllers(int id) {
    final locale = stringOf('locale.Locale').collect();
    return NpcTextLocaleEntity(
      id: id,
      locale: locale.isEmpty ? 'zhCN' : locale,
      texts: List.generate(
        8,
        (n) => [
          stringOf('locale.Text${n}_0').collect(),
          stringOf('locale.Text${n}_1').collect(),
        ],
      ),
    );
  }
}
