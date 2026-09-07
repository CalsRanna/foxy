import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/cover/cover_selector.dart';
import 'package:path/path.dart' as p;

/// Minimal 1x1 transparent PNG (standard 67-byte file, valid header).
const kPngBytes = [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, //
  0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, //
  0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, //
  0x0D, 0x0A, 0x2D, 0xB4, //
  0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, //
  0xAE, 0x42, 0x60, 0x82,
];

/// 12-byte WebP header: 'RIFF' + size + 'WEBP'.
const kWebpBytes = [
  0x52, 0x49, 0x46, 0x46, 0x0C, 0x00, 0x00, 0x00, //
  0x57, 0x45, 0x42, 0x50, //
];

/// GIF header; must never be accepted (animated images are excluded).
const kGifBytes = [0x47, 0x49, 0x46, 0x38, 0x39, 0x61, 0x00, 0x00];

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_cover_test_');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  File writeBytes(String name, List<int> bytes) =>
      File(p.join(tempDir.path, name))..writeAsBytesSync(bytes);

  test('目录不存在或为空时返回空候选,pick 返回 null', () {
    expect(CoverSelector.listCandidates(p.join(tempDir.path, 'missing')),
        isEmpty);
    expect(CoverSelector.pick(p.join(tempDir.path, 'missing')), isNull);
    expect(CoverSelector.pick(tempDir.path), isNull);
  });

  test('只保留支持扩展名的文件:大小写不敏感,gif 与隐藏文件排除', () {
    writeBytes('a.png', kPngBytes);
    writeBytes('b.PNG', kPngBytes);
    writeBytes('c.Jpg', kPngBytes);
    writeBytes('d.webp', kWebpBytes);
    writeBytes('e.gif', kGifBytes);
    writeBytes('f.bmp', kPngBytes);
    writeBytes('g.txt', kPngBytes);
    writeBytes('h.DS_Store', kPngBytes);
    writeBytes('Thumbs.db', kPngBytes);

    final names = CoverSelector.listCandidates(tempDir.path)
        .map((file) => p.basename(file.path))
        .toList();
    expect(names, ['a.png', 'b.PNG', 'c.Jpg', 'd.webp']);
  });

  test('魔数校验:伪装扩展名的非图片被排除', () {
    writeBytes('fake.png', 'this is plain text, not an image'.codeUnits);
    writeBytes('fake.jpg', [0x00, 0x01, 0x02, 0x03, 0x04, 0x05]);

    expect(CoverSelector.listCandidates(tempDir.path), isEmpty);
  });

  test('魔数识别:png/jpg/webp 通过,gif/文本/短 header 拒绝', () {
    expect(CoverSelector.isSupportedImageHeader(kPngBytes), isTrue);
    expect(CoverSelector.isSupportedImageHeader([0xFF, 0xD8, 0xFF, 0xE0]),
        isTrue);
    expect(CoverSelector.isSupportedImageHeader(kWebpBytes), isTrue);
    expect(CoverSelector.isSupportedImageHeader(kGifBytes), isFalse);
    expect(CoverSelector.isSupportedImageHeader('text'.codeUnits), isFalse);
    expect(CoverSelector.isSupportedImageHeader(const []), isFalse);
    expect(CoverSelector.isSupportedImageHeader('RIFF'.codeUnits), isFalse);
    expect(
        CoverSelector.isSupportedImageHeader(
            [...'RIFF'.codeUnits, 0x00, 0x00, 0x00, 0x00, 0x57, 0x45, 0x42]),
        isFalse);
  });

  test('子目录不递归收集', () {
    writeBytes('root.png', kPngBytes);
    final sub = Directory(p.join(tempDir.path, 'sub'))..createSync();
    File(p.join(sub.path, 'nested.png')).writeAsBytesSync(kPngBytes);

    final names = CoverSelector.listCandidates(tempDir.path)
        .map((file) => p.relative(file.path, from: tempDir.path))
        .toList();
    expect(names, ['root.png']);
  });

  test('pick 返回候选之一,相同种子结果稳定', () {
    writeBytes('a.png', kPngBytes);
    writeBytes('b.png', kPngBytes);
    writeBytes('c.png', kPngBytes);

    final first = CoverSelector.pick(tempDir.path, random: Random(42));
    final second = CoverSelector.pick(tempDir.path, random: Random(42));

    expect(first, isNotNull);
    expect(first!.path, second!.path);
    expect(
      CoverSelector.listCandidates(tempDir.path)
          .any((file) => file.path == first.path),
      isTrue,
    );
  });
}
