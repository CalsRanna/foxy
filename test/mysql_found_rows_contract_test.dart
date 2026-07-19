import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mysql_client/mysql_protocol.dart';

void main() {
  test('普通和 TLS 握手都声明 CLIENT_FOUND_ROWS', () {
    final initialHandshake = MySQLPacketInitialHandshake(
      protocolVersion: 10,
      serverVersion: '8.0-test',
      connectionID: 1,
      authPluginDataPart1: Uint8List(8),
      authPluginDataPart2: Uint8List(12),
      capabilityFlags:
          mysqlCapFlagClientProtocol41 |
          mysqlCapFlagClientSecureConnection |
          mysqlCapFlagClientPluginAuth,
      charset: 45,
      statusFlags: Uint8List(2),
      authPluginName: 'mysql_native_password',
    );

    final handshake = MySQLPacketHandshakeResponse41.createWithNativePassword(
      username: 'test',
      password: 'test',
      initialHandshakePayload: initialHandshake,
    );
    final sslRequest = MySQLPacketSSLRequest.createDefault(
      initialHandshakePayload: initialHandshake,
      connectWithDB: true,
    );

    expect(
      handshake.capabilityFlags & mysqlCapFlagClientFoundRows,
      mysqlCapFlagClientFoundRows,
    );
    expect(
      sslRequest.capabilityFlags & mysqlCapFlagClientFoundRows,
      mysqlCapFlagClientFoundRows,
    );
  });

  test('应用固定解析到带补丁的本地依赖', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final lockfile = File('pubspec.lock').readAsStringSync();
    final patchNotes = File(
      'third_party/mysql_client/PATCHES.md',
    ).readAsStringSync();

    expect(pubspec, contains('dependency_overrides:'));
    expect(pubspec, contains('path: third_party/mysql_client'));
    expect(lockfile, contains('version: "0.0.27+foxy.1"'));
    expect(lockfile, contains('path: "third_party/mysql_client"'));
    expect(patchNotes, contains('CLIENT_FOUND_ROWS'));
  });
}
