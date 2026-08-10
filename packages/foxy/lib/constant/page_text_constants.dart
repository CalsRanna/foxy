abstract final class PageTextConstants {
  static const pageTextMinSignedInt = -0x80000000;

  static const pageTextMaxUnsignedInt = 0xFFFFFFFF;

  static const pageTextMaxSignedInt = 0x7FFFFFFF;

  /// Locales of `Common.h::LocaleConstant` accepted by `LoadPageTextLocales`.
  ///
  /// `enUS` is the base text of `page_text.Text`; the locale loader skips the
  /// matching sub-table record.
  static const pageTextLocaleOptions = <String, String>{
    'koKR': 'koKR',
    'frFR': 'frFR',
    'deDE': 'deDE',
    'zhCN': 'zhCN',
    'zhTW': 'zhTW',
    'esES': 'esES',
    'esMX': 'esMX',
    'ruRU': 'ruRU',
  };
}
