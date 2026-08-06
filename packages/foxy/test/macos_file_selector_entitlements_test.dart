import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const entitlementKey =
      'com.apple.security.files.user-selected.read-write';

  for (final fileName in [
    'DebugProfile.entitlements',
    'Release.entitlements',
  ]) {
    test('$fileName 允许读写用户选择的 DBC 目录', () {
      final contents = File('macos/Runner/$fileName').readAsStringSync();

      expect(
        contents,
        contains(RegExp('<key>$entitlementKey</key>\\s*<true/>')),
      );
    });
  }
}
