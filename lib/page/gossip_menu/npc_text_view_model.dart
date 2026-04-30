import 'package:flutter/widgets.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:signals/signals.dart';

/// Tab 2 (npc_text) ViewModel
/// 用 `Map<String, TextEditingController>` 管理约 114 个字段的 controller
class NpcTextViewModel {
  final _repository = NpcTextRepository();
  final _localeRepository = NpcTextLocaleRepository();

  final _controllers = <String, TextEditingController>{};

  final creating = signal(false);
  final currentTextId = signal(0);
  final localeExists = signal(false);

  /// 按需获取字段 controller（惰性初始化）
  TextEditingController controllerOf(String key) {
    return _controllers.putIfAbsent(key, () => TextEditingController());
  }

  /// 加载指定 textId 的数据到所有 controller
  Future<void> load(int textId) async {
    if (textId == 0) {
      _clearAll();
      creating.value = true;
      currentTextId.value = 0;
      controllerOf('ID').text = '0';
      controllerOf('VerifiedBuild').text = '0';
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
      final locales = await _localeRepository.getNpcTextLocales(id: textId);
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
  Future<void> onSave() async {
    try {
      final main = _collectMainFromControllers();
      if (creating.value) {
        await _repository.storeNpcText(main);
        creating.value = false;
      } else {
        await _repository.updateNpcText(currentTextId.value, main);
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
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
  }

  void _clearAll() {
    for (final c in _controllers.values) {
      c.text = '';
    }
  }

  void _applyMainToControllers(NpcTextEntity m) {
    controllerOf('ID').text = m.id.toString();
    controllerOf('VerifiedBuild').text = m.verifiedBuild.toString();
    for (var n = 0; n < 8; n++) {
      final e = m.entries[n];
      controllerOf('lang$n').text = e.lang;
      controllerOf('Probability$n').text = e.probability.toString();
      controllerOf('text${n}_0').text = e.text0;
      controllerOf('text${n}_1').text = e.text1;
      controllerOf('BroadcastTextID$n').text = e.broadcastTextId.toString();
      for (var i = 0; i < 6; i++) {
        controllerOf('em${n}_$i').text = e.emotes[i].toString();
      }
    }
  }

  void _applyLocaleToControllers(NpcTextLocaleEntity l) {
    controllerOf('locale.Locale').text = l.locale.isEmpty ? 'zhCN' : l.locale;
    for (var n = 0; n < 8; n++) {
      controllerOf('locale.Text${n}_0').text = l.texts[n][0];
      controllerOf('locale.Text${n}_1').text = l.texts[n][1];
    }
  }

  NpcTextEntity _collectMainFromControllers() {
    return NpcTextEntity(
      id: int.tryParse(controllerOf('ID').text) ?? 0,
      verifiedBuild: int.tryParse(controllerOf('VerifiedBuild').text) ?? 0,
      entries: List.generate(8, (n) {
        return NpcTextEntryEntity(
          lang: controllerOf('lang$n').text.isEmpty
              ? '0'
              : controllerOf('lang$n').text,
          probability: double.tryParse(controllerOf('Probability$n').text) ?? 0,
          text0: controllerOf('text${n}_0').text,
          text1: controllerOf('text${n}_1').text,
          broadcastTextId:
              int.tryParse(controllerOf('BroadcastTextID$n').text) ?? 0,
          emotes: List.generate(
            6,
            (i) => int.tryParse(controllerOf('em${n}_$i').text) ?? 0,
          ),
        );
      }),
    );
  }

  NpcTextLocaleEntity _collectLocaleFromControllers(int id) {
    return NpcTextLocaleEntity(
      id: id,
      locale: controllerOf('locale.Locale').text.isEmpty
          ? 'zhCN'
          : controllerOf('locale.Locale').text,
      texts: List.generate(
        8,
        (n) => [
          controllerOf('locale.Text${n}_0').text,
          controllerOf('locale.Text${n}_1').text,
        ],
      ),
    );
  }
}
