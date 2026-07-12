/// Bootstrap 端口解析与校验（与 UI / Dialog 解耦，便于单测）。
///
/// 合法端口：整数 `1..65535`。非法输入返回 `null`。
int? parseMysqlPort(String raw) {
  final port = int.tryParse(raw.trim());
  if (port == null || port < 1 || port > 65535) return null;
  return port;
}
