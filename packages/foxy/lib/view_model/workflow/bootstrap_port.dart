/// Bootstrap port parsing and validation (decoupled from UI/Dialog for
/// easy unit testing).
///
/// Valid ports: integers `1..65535`. Invalid input returns `null`.
abstract final class BootstrapPort {
  static int? parse(String raw) {
    final port = int.tryParse(raw.trim());
    if (port == null || port < 1 || port > 65535) return null;
    return port;
  }
}
