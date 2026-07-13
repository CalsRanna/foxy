import 'package:foxy/entity/dbc_locale.dart';

/// 全部已注册的 DBC 本地化字段编辑器定义。
///
/// 创建时通过 Schema 校验 16 个语言列；覆盖完整性由测试保证：
/// Schema 中出现但未在此注册的本地化前缀会使测试失败。
class DbcLocaleFields {
  DbcLocaleFields._();

  // --- achievement ---
  static final achievementTitle = DbcLocaleFieldDefinition(
    tableName: 'dbc_achievement',
    columnPrefix: 'Title_lang',
    label: '标题',
  );
  static final achievementDescription = DbcLocaleFieldDefinition(
    tableName: 'dbc_achievement',
    columnPrefix: 'Description_lang',
    label: '描述',
    multiline: true,
  );
  static final achievementReward = DbcLocaleFieldDefinition(
    tableName: 'dbc_achievement',
    columnPrefix: 'Reward_lang',
    label: '奖励文本',
    multiline: true,
  );

  // --- area_table ---
  static final areaTableAreaName = DbcLocaleFieldDefinition(
    tableName: 'dbc_area_table',
    columnPrefix: 'AreaName_lang',
    label: '区域名称',
  );

  // --- char_titles ---
  static final charTitlesName = DbcLocaleFieldDefinition(
    tableName: 'dbc_char_titles',
    columnPrefix: 'Name_lang',
    label: '男性称号',
  );
  static final charTitlesName1 = DbcLocaleFieldDefinition(
    tableName: 'dbc_char_titles',
    columnPrefix: 'Name1_lang',
    label: '女性称号',
  );

  // --- faction ---
  static final factionName = DbcLocaleFieldDefinition(
    tableName: 'dbc_faction',
    columnPrefix: 'Name_lang',
    label: '阵营名称',
  );
  static final factionDescription = DbcLocaleFieldDefinition(
    tableName: 'dbc_faction',
    columnPrefix: 'Description_lang',
    label: '阵营描述',
    multiline: true,
  );

  // --- item_random_properties ---
  static final itemRandomPropertiesName = DbcLocaleFieldDefinition(
    tableName: 'dbc_item_random_properties',
    columnPrefix: 'Name_lang',
    label: '随机属性名称',
  );

  // --- item_bag_family ---
  static final itemBagFamilyName = DbcLocaleFieldDefinition(
    tableName: 'dbc_item_bag_family',
    columnPrefix: 'Name_lang',
    label: '背包类别名称',
  );

  // --- item_random_suffix ---
  static final itemRandomSuffixName = DbcLocaleFieldDefinition(
    tableName: 'dbc_item_random_suffix',
    columnPrefix: 'Name_lang',
    label: '随机后缀名称',
  );

  // --- item_limit_category ---
  static final itemLimitCategoryName = DbcLocaleFieldDefinition(
    tableName: 'dbc_item_limit_category',
    columnPrefix: 'Name_lang',
    label: '限制类别名称',
  );

  // --- item_set ---
  static final itemSetName = DbcLocaleFieldDefinition(
    tableName: 'dbc_item_set',
    columnPrefix: 'Name_lang',
    label: '套装名称',
  );

  // --- map ---
  static final mapMapName = DbcLocaleFieldDefinition(
    tableName: 'dbc_map',
    columnPrefix: 'MapName_lang',
    label: '地图名称',
  );
  static final mapMapDescription0 = DbcLocaleFieldDefinition(
    tableName: 'dbc_map',
    columnPrefix: 'MapDescription0_lang',
    label: '地图描述 1',
    multiline: true,
  );
  static final mapMapDescription1 = DbcLocaleFieldDefinition(
    tableName: 'dbc_map',
    columnPrefix: 'MapDescription1_lang',
    label: '地图描述 2',
    multiline: true,
  );

  // --- mail_template ---
  static final mailTemplateSubject = DbcLocaleFieldDefinition(
    tableName: 'dbc_mail_template',
    columnPrefix: 'Subject_lang',
    label: '邮件主题',
  );
  static final mailTemplateBody = DbcLocaleFieldDefinition(
    tableName: 'dbc_mail_template',
    columnPrefix: 'Body_lang',
    label: '邮件正文',
    multiline: true,
  );

  // --- quest_info ---
  static final questInfoInfoName = DbcLocaleFieldDefinition(
    tableName: 'dbc_quest_info',
    columnPrefix: 'InfoName_lang',
    label: '任务类型名称',
  );

  // --- quest_sort ---
  static final questSortSortName = DbcLocaleFieldDefinition(
    tableName: 'dbc_quest_sort',
    columnPrefix: 'SortName_lang',
    label: '任务分类名称',
  );

  // --- spell ---
  static final spellName = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell',
    columnPrefix: 'Name_lang',
    label: '法术名称',
  );
  static final spellNameSubtext = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell',
    columnPrefix: 'NameSubtext_lang',
    label: '法术副标题',
  );
  static final spellDescription = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell',
    columnPrefix: 'Description_lang',
    label: '法术描述',
    multiline: true,
  );
  static final spellAuraDescription = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell',
    columnPrefix: 'AuraDescription_lang',
    label: '光环描述',
    multiline: true,
  );

  // --- spell_focus_object ---
  static final spellFocusObjectName = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell_focus_object',
    columnPrefix: 'Name_lang',
    label: '法术焦点名称',
  );

  // --- spell_item_enchantment ---
  static final spellItemEnchantmentName = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell_item_enchantment',
    columnPrefix: 'Name_lang',
    label: '附魔名称',
  );

  // --- spell_range ---
  static final spellRangeDisplayName = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell_range',
    columnPrefix: 'DisplayName_lang',
    label: '距离名称',
  );
  static final spellRangeDisplayNameShort = DbcLocaleFieldDefinition(
    tableName: 'dbc_spell_range',
    columnPrefix: 'DisplayNameShort_lang',
    label: '距离简称',
  );

  // --- skill_line ---
  static final skillLineDisplayName = DbcLocaleFieldDefinition(
    tableName: 'dbc_skill_line',
    columnPrefix: 'DisplayName_lang',
    label: '技能线名称',
  );
  static final skillLineDescription = DbcLocaleFieldDefinition(
    tableName: 'dbc_skill_line',
    columnPrefix: 'Description_lang',
    label: '技能线描述',
    multiline: true,
  );
  static final skillLineAlternateVerb = DbcLocaleFieldDefinition(
    tableName: 'dbc_skill_line',
    columnPrefix: 'AlternateVerb_lang',
    label: '备选动词',
  );

  // --- totem_category ---
  static final totemCategoryName = DbcLocaleFieldDefinition(
    tableName: 'dbc_totem_category',
    columnPrefix: 'Name_lang',
    label: '图腾类别名称',
  );

  /// 全部已注册字段，供覆盖完整性测试使用。
  static final List<DbcLocaleFieldDefinition> all = [
    achievementTitle,
    achievementDescription,
    achievementReward,
    areaTableAreaName,
    charTitlesName,
    charTitlesName1,
    factionName,
    factionDescription,
    itemBagFamilyName,
    itemRandomPropertiesName,
    itemRandomSuffixName,
    itemLimitCategoryName,
    itemSetName,
    mapMapName,
    mapMapDescription0,
    mapMapDescription1,
    mailTemplateSubject,
    mailTemplateBody,
    questInfoInfoName,
    questSortSortName,
    spellName,
    spellNameSubtext,
    spellDescription,
    spellAuraDescription,
    spellFocusObjectName,
    spellItemEnchantmentName,
    spellRangeDisplayName,
    spellRangeDisplayNameShort,
    skillLineDisplayName,
    skillLineDescription,
    skillLineAlternateVerb,
    totemCategoryName,
  ];
}
