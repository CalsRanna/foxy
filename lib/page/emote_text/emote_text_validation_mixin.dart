import 'package:foxy/entity/emote_text_entity.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';

mixin EmoteTextValidationMixin on ViewModelValidationMixin {
  void validateEmoteTextFields(EmoteTextEntity value) {
    requirePositive(value.id, '编号');
    requireNonNegative(value.emoteId, '表情编号');
    requireNonNegative(value.emoteText0, '表情文本 1');
    requireNonNegative(value.emoteText1, '表情文本 2');
    requireNonNegative(value.emoteText2, '表情文本 3');
    requireNonNegative(value.emoteText3, '表情文本 4');
    requireNonNegative(value.emoteText4, '表情文本 5');
    requireNonNegative(value.emoteText5, '表情文本 6');
    requireNonNegative(value.emoteText6, '表情文本 7');
    requireNonNegative(value.emoteText7, '表情文本 8');
    requireNonNegative(value.emoteText8, '表情文本 9');
    requireNonNegative(value.emoteText9, '表情文本 10');
    requireNonNegative(value.emoteText10, '表情文本 11');
    requireNonNegative(value.emoteText11, '表情文本 12');
    requireNonNegative(value.emoteText12, '表情文本 13');
    requireNonNegative(value.emoteText13, '表情文本 14');
    requireNonNegative(value.emoteText14, '表情文本 15');
    requireNonNegative(value.emoteText15, '表情文本 16');
  }
}
