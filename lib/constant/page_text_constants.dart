/// Locales of `Common.h::LocaleConstant` accepted by `LoadPageTextLocales`.
///
/// `enUS` is the base text of `page_text.Text`; the locale loader skips the
/// matching sub-table record.
const kPageTextLocaleOptions = <String, String>{
  'koKR': 'koKR',
  'frFR': 'frFR',
  'deDE': 'deDE',
  'zhCN': 'zhCN',
  'zhTW': 'zhTW',
  'esES': 'esES',
  'esMX': 'esMX',
  'ruRU': 'ruRU',
};

const kPageTextMaxSignedInt = 0x7FFFFFFF;
const kPageTextMaxUnsignedInt = 0xFFFFFFFF;
const kPageTextMinSignedInt = -0x80000000;
