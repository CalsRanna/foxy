import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/update/update_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('UpdateManifestInfo.fromMap', () {
    test('Parses all manifest fields', () {
      final update = _manifest(_releaseMap());
      expect(update.version, '1.1.0');
      expect(update.buildNumber, '630');
      expect(update.isPrerelease, isFalse);
      expect(update.zipUrl.toString(), 'https://example.com/foxy-1.1.0.zip');
      expect(update.sizeBytes, 42);
      expect(update.sha256, 'a' * 64);
      expect(update.notes, '更新说明');
    });

    test('Normalizes uppercase SHA-256 to lowercase', () {
      final map = _releaseMap()..['sha256'] = 'A' * 64;
      expect(_manifest(map).sha256, 'a' * 64);
    });

    test('Missing isPrerelease defaults to a stable release', () {
      expect(_manifest(_releaseMap()).isPrerelease, isFalse);
    });

    test('Reads isPrerelease when true', () {
      expect(_manifest(_releaseMap(isPrerelease: true)).isPrerelease, isTrue);
    });

    test('Missing fields throw FormatException', () {
      final map = _releaseMap()..remove('notes');
      expect(() => _manifest(map), throwsFormatException);
    });

    test('Unexpected field types throw FormatException', () {
      final map = _releaseMap()..['sizeBytes'] = '42';
      expect(() => _manifest(map), throwsFormatException);
    });
  });

  group('checkForUpdates', () {
    test('A newer manifest version returns UpdateAvailable', () async {
      final service = UpdateService(client: _clientReturning(_manifestYaml()));
      final result = await service.checkForUpdates(
        installedVersion: '1.0.0',
        installedBuildNumber: '628',
      );
      expect(result, isA<UpdateAvailable>());
      final update = (result as UpdateAvailable).update;
      expect(update.version, '1.1.0');
    });

    test(
      'Chinese release notes decode as UTF-8 without a charset header',
      () async {
        // GitHub serves release assets as `application/octet-stream` (no
        // charset); the http package would fall back to latin-1 and garble
        // the Chinese notes if bodyBytes were not decoded as UTF-8.
        final service = UpdateService(
          client: _clientReturning(
            _manifestYaml(releases: [_releaseMap(notes: '新增自动更新功能')]),
          ),
        );
        final result = await service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        );
        expect(result, isA<UpdateAvailable>());
        final update = (result as UpdateAvailable).update;
        expect(update.notes, '新增自动更新功能');
      },
    );

    test(
      'A higher build number for the same version returns UpdateAvailable',
      () async {
        final service = UpdateService(
          client: _clientReturning(
            _manifestYaml(version: '1.0.0', buildNumber: '700'),
          ),
        );
        final result = await service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        );
        expect(result, isA<UpdateAvailable>());
      },
    );

    test('Matching version and build numbers return UpToDate', () async {
      final service = UpdateService(
        client: _clientReturning(
          _manifestYaml(version: '1.0.0', buildNumber: '628'),
        ),
      );
      final result = await service.checkForUpdates(
        installedVersion: '1.0.0',
        installedBuildNumber: '628',
      );
      expect(result, isA<UpToDate>());
    });

    test('A newer installed version returns UpToDate', () async {
      final service = UpdateService(
        client: _clientReturning(_manifestYaml(version: '1.0.0')),
      );
      final result = await service.checkForUpdates(
        installedVersion: '1.1.0',
        installedBuildNumber: '630',
      );
      expect(result, isA<UpToDate>());
    });

    test('Prerelease manifests are excluded from update selection', () async {
      final service = UpdateService(
        client: _clientReturning(_manifestYaml(isPrerelease: true)),
      );
      final result = await service.checkForUpdates(
        installedVersion: '1.0.0',
        installedBuildNumber: '628',
      );
      expect(result, isA<UpToDate>());
    });

    test(
      'An installed prerelease is never downgraded to an older stable release',
      () async {
        // User runs the 1.1.3-alpha build itself; the manifest holds that
        // alpha and the older 1.1.2 stable — neither is an update.
        final service = UpdateService(
          client: _clientReturning(
            _manifestYaml(
              releases: [
                _releaseMap(
                  version: '1.1.3',
                  buildNumber: '691',
                  isPrerelease: true,
                ),
                _releaseMap(version: '1.1.2', buildNumber: '690'),
              ],
            ),
          ),
        );
        final result = await service.checkForUpdates(
          installedVersion: '1.1.3',
          installedBuildNumber: '691',
        );
        expect(result, isA<UpToDate>());
      },
    );

    test('A stable manifest is eligible for updates', () async {
      final service = UpdateService(
        client: _clientReturning(_manifestYaml(isPrerelease: false)),
      );
      final result = await service.checkForUpdates(
        installedVersion: '1.0.0',
        installedBuildNumber: '628',
      );
      expect(result, isA<UpdateAvailable>());
    });

    test(
      'Legacy manifests without isPrerelease are treated as stable',
      () async {
        final service = UpdateService(
          client: _clientReturning(_manifestYaml()),
        );
        final result = await service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        );
        expect(result, isA<UpdateAvailable>());
      },
    );

    test('An invalid isPrerelease type returns invalidManifest', () async {
      final map = _releaseMap()..['isPrerelease'] = 'yes';
      final service = UpdateService(
        client: _clientReturning(_manifestYaml(releases: [map])),
      );
      await expectLater(
        service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.invalidManifest,
          ),
        ),
      );
    });

    test('Skips the release matching the current version and selects the next newer entry', () async {
      final service = UpdateService(
        client: _clientReturning(
          _manifestYaml(
            releases: [
              _releaseMap(version: '1.0.0', buildNumber: '628'),
              _releaseMap(version: '2.0.0', buildNumber: '700'),
            ],
          ),
        ),
      );
      final result = await service.checkForUpdates(
        installedVersion: '1.0.0',
        installedBuildNumber: '628',
      );
      expect(result, isA<UpdateAvailable>());
      expect((result as UpdateAvailable).update.version, '2.0.0');
    });

    test(
      'Skips a newer prerelease and selects the following stable release',
      () async {
        // A prerelease at the top of the manifest (the CI published an alpha
        // after a stable) must not shadow the stable release below it.
        final service = UpdateService(
          client: _clientReturning(
            _manifestYaml(
              releases: [
                _releaseMap(
                  version: '1.2.0',
                  buildNumber: '700',
                  isPrerelease: true,
                ),
                _releaseMap(version: '1.1.2', buildNumber: '690'),
              ],
            ),
          ),
        );
        final result = await service.checkForUpdates(
          installedVersion: '1.1.0',
          installedBuildNumber: '664',
        );
        expect(result, isA<UpdateAvailable>());
        final update = (result as UpdateAvailable).update;
        expect(update.version, '1.1.2');
        expect(update.isPrerelease, isFalse);
      },
    );

    test('A list containing only prereleases returns UpToDate', () async {
      final service = UpdateService(
        client: _clientReturning(
          _manifestYaml(
            releases: [
              _releaseMap(version: '2.0.0', isPrerelease: true),
              _releaseMap(version: '1.5.0', isPrerelease: true),
            ],
          ),
        ),
      );
      final result = await service.checkForUpdates(
        installedVersion: '1.0.0',
        installedBuildNumber: '628',
      );
      expect(result, isA<UpToDate>());
    });

    test('A mismatched appId returns invalidManifest', () async {
      final service = UpdateService(
        client: _clientReturning(_manifestYaml(appId: 'com.other.app')),
      );
      await expectLater(
        service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.invalidManifest,
          ),
        ),
      );
    });

    test('An empty releases list returns invalidManifest', () async {
      final service = UpdateService(
        client: _clientReturning(
          _manifestYaml(releases: <Map<String, Object?>>[]),
        ),
      );
      await expectLater(
        service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.invalidManifest,
          ),
        ),
      );
    });

    test('A non-200 HTTP response throws UpdateException.network', () async {
      final service = UpdateService(
        client: _clientReturning('not found', status: 404),
      );
      await expectLater(
        service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.network,
          ),
        ),
      );
    });

    test('Malformed YAML throws UpdateException.invalidManifest', () async {
      final service = UpdateService(client: _clientReturning('{oops: ['));
      await expectLater(
        service.checkForUpdates(
          installedVersion: '1.0.0',
          installedBuildNumber: '628',
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.invalidManifest,
          ),
        ),
      );
    });

    test(
      'A non-object YAML root throws UpdateException.invalidManifest',
      () async {
        final service = UpdateService(client: _clientReturning('- a\n- b'));
        await expectLater(
          service.checkForUpdates(
            installedVersion: '1.0.0',
            installedBuildNumber: '628',
          ),
          throwsA(
            isA<UpdateException>().having(
              (e) => e.code,
              'code',
              UpdateErrorKind.invalidManifest,
            ),
          ),
        );
      },
    );
  });

  group('downloadZip', () {
    final bytes = _zipBytes({
      'foxy.exe': 'new-binary',
      'data/flutter_assets/asset.png': 'png',
    });
    final manifest = _manifest(_releaseMap()..['sizeBytes'] = bytes.length);

    test('Downloads the file and verifies size and SHA-256', () async {
      final zipService = UpdateService(
        client: MockClient((request) async => http.Response.bytes(bytes, 200)),
      );
      final file = await zipService.downloadZip(
        UpdateManifestInfo(
          version: manifest.version,
          buildNumber: manifest.buildNumber,
          zipUrl: manifest.zipUrl,
          sizeBytes: bytes.length,
          sha256: _sha256Hex(bytes),
          notes: manifest.notes,
        ),
      );
      expect(file.existsSync(), isTrue);
      expect(await file.length(), bytes.length);
      file.deleteSync();
    });

    test('A size mismatch throws UpdateException.verification and deletes the partial file', () async {
      final service = UpdateService(
        client: MockClient((request) async => http.Response.bytes(bytes, 200)),
      );
      await expectLater(
        service.downloadZip(
          UpdateManifestInfo(
            version: '9.9.9',
            buildNumber: '1',
            zipUrl: Uri.parse('https://example.com/x.zip'),
            sizeBytes: bytes.length + 1,
            sha256: _sha256Hex(bytes),
            notes: '',
          ),
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.verification,
          ),
        ),
      );
      expect(
        File(p.join(Directory.systemTemp.path, 'foxy_update_9.9.9.zip'))
            .existsSync(),
        isFalse,
      );
    });

    test('A SHA-256 mismatch throws UpdateException.verification', () async {
      final service = UpdateService(
        client: MockClient((request) async => http.Response.bytes(bytes, 200)),
      );
      await expectLater(
        service.downloadZip(
          UpdateManifestInfo(
            version: '9.9.8',
            buildNumber: '1',
            zipUrl: Uri.parse('https://example.com/x.zip'),
            sizeBytes: bytes.length,
            sha256: 'f' * 64,
            notes: '',
          ),
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.verification,
          ),
        ),
      );
    });

    test('Cancellation throws UpdateException.canceled and deletes the partial file', () async {
      final service = UpdateService(
        client: MockClient((request) async => http.Response.bytes(bytes, 200)),
      );
      final token = UpdateCancelToken()..cancel();
      await expectLater(
        service.downloadZip(
          UpdateManifestInfo(
            version: '9.9.7',
            buildNumber: '1',
            zipUrl: Uri.parse('https://example.com/x.zip'),
            sizeBytes: bytes.length,
            sha256: _sha256Hex(bytes),
            notes: '',
          ),
          cancelToken: token,
        ),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.canceled,
          ),
        ),
      );
      expect(
        File(p.join(Directory.systemTemp.path, 'foxy_update_9.9.7.zip'))
            .existsSync(),
        isFalse,
      );
    });

    test('A non-200 response throws UpdateException.network', () async {
      final service = UpdateService(
        client: MockClient((request) async => http.Response('oops', 403)),
      );
      await expectLater(
        service.downloadZip(manifest),
        throwsA(
          isA<UpdateException>().having(
            (e) => e.code,
            'code',
            UpdateErrorKind.network,
          ),
        ),
      );
    });
  });

  group('prepareUpdate', () {
    late Directory appDir;

    setUp(() {
      appDir = Directory.systemTemp.createTempSync('foxy_update_test_');
    });

    tearDown(() {
      if (appDir.existsSync()) appDir.deleteSync(recursive: true);
    });

    UpdateManifestInfo zipManifest(
      List<int> zipBytes, {
      String version = '9.9.6',
    }) {
      return UpdateManifestInfo(
        version: version,
        buildNumber: '1',
        zipUrl: Uri.parse('https://example.com/foxy-$version.zip'),
        sizeBytes: zipBytes.length,
        sha256: _sha256Hex(zipBytes),
        notes: '',
      );
    }

    test(
      'Extracts the archive to .update_tmp and returns the payload root',
      () async {
        final zipBytes = _zipBytes({
          'foxy.exe': 'new-binary',
          'data/flutter_assets/asset.png': 'png',
          'data/icudtl.dat': 'icu',
        });
        final service = UpdateService(
          client: MockClient(
            (request) async => http.Response.bytes(zipBytes, 200),
          ),
        );
        final payloadRoot = await service.prepareUpdate(
          zipManifest(zipBytes),
          appDir: appDir,
        );
        expect(payloadRoot.path, p.join(appDir.path, '.update_tmp'));
        expect(
          File(p.join(payloadRoot.path, 'foxy.exe')).readAsStringSync(),
          'new-binary',
        );
        expect(
          File(p.join(payloadRoot.path, 'data', 'flutter_assets', 'asset.png'))
              .existsSync(),
          isTrue,
        );
        // The zip is cleaned up after extraction.
        expect(
          File(p.join(Directory.systemTemp.path, 'foxy_update_9.9.6.zip'))
              .existsSync(),
          isFalse,
        );
      },
    );

    test('An archive with one top-level directory uses that directory as the payload root', () async {
      final zipBytes = _zipBytes({
        'Foxy/foxy.exe': 'new-binary',
        'Foxy/data/flutter_assets/asset.png': 'png',
      });
      final service = UpdateService(
        client: MockClient(
          (request) async => http.Response.bytes(zipBytes, 200),
        ),
      );
      final payloadRoot = await service.prepareUpdate(
        zipManifest(zipBytes),
        appDir: appDir,
      );
      expect(payloadRoot.path, p.join(appDir.path, '.update_tmp', 'Foxy'));
    });

    test(
      'Zip-slip entries are discarded without writing outside the destination',
      () async {
        final zipBytes = _zipBytes({
          'foxy.exe': 'new-binary',
          '../evil.txt': 'evil',
        });
        final service = UpdateService(
          client: MockClient(
            (request) async => http.Response.bytes(zipBytes, 200),
          ),
        );
        await service.prepareUpdate(zipManifest(zipBytes), appDir: appDir);
        expect(
          File(p.join(appDir.parent.path, 'evil.txt')).existsSync(),
          isFalse,
        );
        expect(
          File(p.join(appDir.path, '.update_tmp', 'foxy.exe')).existsSync(),
          isTrue,
        );
      },
    );
  });

  group('resolvePayloadRoot', () {
    late Directory dir;

    setUp(() {
      dir = Directory.systemTemp.createTempSync('foxy_payload_test_');
    });

    tearDown(() {
      if (dir.existsSync()) dir.deleteSync(recursive: true);
    });

    test('A root containing files is returned as the payload root', () {
      File(p.join(dir.path, 'a.txt')).writeAsStringSync('x');
      expect(UpdateService.resolvePayloadRoot(dir).path, dir.path);
    });

    test('Multiple top-level directories keep the extraction root', () {
      Directory(p.join(dir.path, 'd1')).createSync();
      Directory(p.join(dir.path, 'd2')).createSync();
      expect(UpdateService.resolvePayloadRoot(dir).path, dir.path);
    });

    test('A single top-level directory with no root files becomes the payload root', () {
      final sub = Directory(p.join(dir.path, 'Foxy'))..createSync();
      File(p.join(sub.path, 'foxy.exe')).writeAsStringSync('x');
      expect(
        UpdateService.resolvePayloadRoot(dir).path,
        p.join(dir.path, 'Foxy'),
      );
    });
  });
}

/// Builds a MockClient response for [body] (UTF-8 encoded; the manifest
/// carries Chinese notes).
http.Client _clientReturning(String body, {int status = 200}) {
  return MockClient(
    (request) async => http.Response.bytes(utf8.encode(body), status),
  );
}

UpdateManifestInfo _manifest(Map<dynamic, dynamic> map) =>
    UpdateManifestInfo.fromMap(map);

/// Builds `latest.yaml` manifest text (releases array, newest first).
String _manifestYaml({
  String version = '1.1.0',
  String buildNumber = '630',
  bool? isPrerelease,
  String appId = UpdateService.expectedAppId,
  List<Map<String, Object?>>? extraReleases,
  List<Map<String, Object?>>? releases,
}) {
  final all =
      releases ??
      [
        _releaseMap(
          version: version,
          buildNumber: buildNumber,
          isPrerelease: isPrerelease,
        ),
        ...?extraReleases,
      ];
  final buffer = StringBuffer()
    ..writeln('schemaVersion: 1')
    ..writeln('appId: $appId')
    ..writeln('releases:');
  for (final release in all) {
    buffer
      ..writeln('  - version: "${release['version']}"')
      ..writeln('    buildNumber: "${release['buildNumber']}"')
      ..writeln('    isPrerelease: ${release['isPrerelease'] ?? false}')
      ..writeln('    zipUrl: ${release['zipUrl']}')
      ..writeln('    sizeBytes: ${release['sizeBytes']}')
      ..writeln('    sha256: ${release['sha256']}')
      ..writeln('    notes: |-')
      ..writeln('      ${release['notes']}');
  }
  return buffer.toString();
}

/// Builds a release-entry Map (fields matching the generator's output).
Map<String, Object?> _releaseMap({
  String version = '1.1.0',
  String buildNumber = '630',
  bool? isPrerelease,
  int sizeBytes = 42,
  String notes = '更新说明',
}) {
  return {
    'version': version,
    'buildNumber': buildNumber,
    'isPrerelease': ?isPrerelease,
    'zipUrl': 'https://example.com/foxy-$version.zip',
    'sizeBytes': sizeBytes,
    'sha256': 'a' * 64,
    'notes': notes,
  };
}

String _sha256Hex(List<int> bytes) => sha256.convert(bytes).toString();

/// Builds zip bytes containing the given files (packed with archive).
List<int> _zipBytes(Map<String, String> files) {
  final archive = Archive();
  for (final entry in files.entries) {
    archive.add(ArchiveFile.bytes(entry.key, utf8.encode(entry.value)));
  }
  return ZipEncoder().encode(archive);
}
