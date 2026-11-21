enum SettingSection {
  environment('游戏环境'),
  data('数据工具'),
  preferences('编辑偏好'),
  about('关于 Foxy');

  final String label;

  const SettingSection(this.label);
}
