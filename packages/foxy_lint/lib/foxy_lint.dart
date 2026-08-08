/// Foxy's custom_lint plugin entrypoint.
///
/// custom_lint generates a client that imports
/// `package:foxy_lint/foxy_lint.dart` and calls [createPlugin]; this file
/// must exist at the conventional location or plugin loading fails
/// silently (see `custom_lint.log`).
library;

export 'foxy_lint_plugin.dart' show createPlugin;
