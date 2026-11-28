import 'package:foxy/router/setting_section.dart';

enum SettingEntry {
  combinedExport(SettingSection.data, '一键导出 DBC 与 MPQ', '一键导出'),
  dbcImport(SettingSection.data, '导入 DBC 文件', '导入 DBC'),
  dbcExport(SettingSection.data, '导出 DBC 文件', '导出 DBC'),
  mpqExport(SettingSection.data, '导出 MPQ 补丁', '导出 MPQ'),
  databaseConnection(SettingSection.environment, '数据库连接', '退出连接'),
  iconExtract(SettingSection.environment, '提取游戏图标', '提取'),
  localeTables(SettingSection.preferences, '使用独立本地化表'),
  aiModel(SettingSection.preferences, 'AI 模型', '配置'),
  appUpdates(SettingSection.about, 'Foxy', '检查更新'),
  projectPage(SettingSection.about, '项目主页', '打开');

  final SettingSection section;
  final String title;
  final String? _buttonLabel;

  const SettingEntry(this.section, this.title, [this._buttonLabel]);

  String get actionLabel => _buttonLabel ?? title;
}
