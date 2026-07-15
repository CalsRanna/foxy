import 'package:foxy/entity/quest_info_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin QuestInfoValidationMixin on ViewModelValidationMixin {
  void validateQuestInfoFields(QuestInfoEntity value) {
    final id = value.id;
    final infoNameLangFlags = value.infoNameLangFlags;

    if (id <= 0 || id > 65535) {
      throw StateError('编号必须在 1..65535 之间');
    }
    if (infoNameLangFlags < -2147483648 || infoNameLangFlags > 2147483647) {
      throw StateError('名称语言标志超出 signed int32 范围');
    }
  }
}
