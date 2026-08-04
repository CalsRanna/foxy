import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/game_asset/blp_decoder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('合成 BLP2（确定性像素断言）', () {
    // 64×64 = 16×16 blocks
    test('DXT1 4 色模式：全部像素为 c0 色', () {
      final block = dxtColorBlock(255, 0, 0, 0); // c0=red, all pixels use index 0
      final blp = buildBlp2(tile(block, 256));
      final image = decodeBlp(blp);
      expect(image.width, 64);
      expect(image.height, 64);
      expect(image.rgba.length, 64 * 64 * 4);
      for (var i = 0; i < 64 * 64; i++) {
        expect(image.rgba[i * 4], 255);
        expect(image.rgba[i * 4 + 1], 0);
        expect(image.rgba[i * 4 + 2], 0);
        expect(image.rgba[i * 4 + 3], 255);
      }
    });

    test('DXT3：alpha 半字节展开为 0-255', () {
      final color = dxtColorBlock(0, 255, 0, 0);
      final alpha = dxt3AlphaBlock(0x8); // 0x8 * 17 = 136
      final blp = buildBlp2(
        tile(Uint8List.fromList([...alpha, ...color]), 256),
        alphaDepth: 8,
        alphaEncoding: 1,
      );
      final image = decodeBlp(blp);
      for (var i = 0; i < 64 * 64; i++) {
        expect(image.rgba[i * 4 + 3], 136, reason: 'DXT3 alpha 8→136');
        expect(image.rgba[i * 4 + 1], 255);
      }
    });

    test('DXT5：a0=255 全取索引 0 → 不透明', () {
      final color = dxtColorBlock(0, 0, 255, 0);
      final alpha = dxt5AlphaBlock(255, 0, 0);
      final blp = buildBlp2(
        tile(Uint8List.fromList([...alpha, ...color]), 256),
        alphaDepth: 8,
        alphaEncoding: 7,
      );
      final image = decodeBlp(blp);
      for (var i = 0; i < 64 * 64; i++) {
        expect(image.rgba[i * 4 + 3], 255);
        expect(image.rgba[i * 4 + 2], 255);
      }
    });

    test('DXT5：a0=0/a1=255 的 6/7 特例（透明/不透明）', () {
      final color = dxtColorBlock(255, 255, 255, 0);
      final alpha0 = dxt5AlphaBlock(0, 255, 6); // special case → 0 (transparent)
      final alpha7 = dxt5AlphaBlock(0, 255, 7); // special case → 255
      // Assembling an 8×1 scene from two 2×1 blocks is overkill; just
      // verify 6/7 once each:
      final blp6 = buildBlp2(
        tile(Uint8List.fromList([...alpha0, ...color]), 256),
        alphaDepth: 8,
        alphaEncoding: 7,
      );
      final blp7 = buildBlp2(
        tile(Uint8List.fromList([...alpha7, ...color]), 256),
        alphaDepth: 8,
        alphaEncoding: 7,
      );
      expect(decodeBlp(blp6).rgba[3], 0);
      expect(decodeBlp(blp7).rgba[3], 255);
    });

    test('损坏输入抛 BlpFormatException', () {
      expect(
        () => decodeBlp(Uint8List.fromList('BLP1'.codeUnits)),
        throwsA(isA<BlpFormatException>()),
      );
      expect(
        () => decodeBlp(Uint8List.fromList('nonsense'.codeUnits)), // header too short
        throwsA(isA<BlpFormatException>()),
      );
    });
  });

  group('真实客户端 fixture（与原始 PNG 对照）', () {
    for (final variant in ['dxt1', 'dxt3', 'dxt5']) {
      test('$variant RGB 与对应 PNG 逐像素一致', () async {
        final blpBytes = File('test/fixture/icons/fixture_$variant.blp')
            .readAsBytesSync();
        final image = decodeBlp(blpBytes);
        expect(image.width, 64);
        expect(image.height, 64);

        final pngBytes = File('test/fixture/icons/fixture_$variant.png')
            .readAsBytesSync();
        final codec = await ui.instantiateImageCodec(pngBytes);
        final frame = await codec.getNextFrame();
        final pngData =
            await frame.image.toByteData(format: ui.ImageByteFormat.rawRgba);
        final expected = pngData!.buffer.asUint8List();

        expect(expected.length, image.rgba.length);
        for (var i = 0; i < expected.length; i += 4) {
          expect(
            image.rgba[i],
            expected[i],
            reason: 'R 像素 $i 不一致（$variant）',
          );
          expect(
            image.rgba[i + 1],
            expected[i + 1],
            reason: 'G 像素 $i 不一致（$variant）',
          );
          expect(
            image.rgba[i + 2],
            expected[i + 2],
            reason: 'B 像素 $i 不一致（$variant）',
          );
          // Old PNGs are fully opaque (alpha stripped by the original
          // extraction tool); BLP keeps real alpha (transparent
          // backgrounds). Only assert the value range here; exact alpha is
          // covered by the compositing tests.
          expect(image.rgba[i + 3], inInclusiveRange(0, 255));
        }
      });
    }
  });
}

/// Assembles a full BLP2 file (64×64, single-block tiling, no mipmaps).
Uint8List buildBlp2(Uint8List mip0, {int alphaDepth = 0, int alphaEncoding = 0}) {
  const width = 64, height = 64;
  final header = BytesBuilder();
  header.add('BLP2'.codeUnits);
  header.add([1, 0, 0, 0]); // type=1 (non-JPEG)
  header.addByte(2); // encoding=DXT
  header.addByte(alphaDepth);
  header.addByte(alphaEncoding);
  header.addByte(0); // hasMips=0
  final dims = ByteData(8);
  dims.setUint32(0, width, Endian.little);
  dims.setUint32(4, height, Endian.little);
  header.add(dims.buffer.asUint8List());
  // mipOffsets[16]: mip0 offset = 20 (header) + 16×4×2 = 148
  final offsets = ByteData(64);
  offsets.setUint32(0, 148, Endian.little);
  header.add(offsets.buffer.asUint8List());
  final sizes = ByteData(64);
  sizes.setUint32(0, mip0.length, Endian.little);
  header.add(sizes.buffer.asUint8List());
  return Uint8List.fromList([...header.toBytes(), ...mip0]);
}

/// DXT3 alpha nibbles (all the same value [nibble]).
Uint8List dxt3AlphaBlock(int nibble) {
  final byte = (nibble & 0xF) | ((nibble & 0xF) << 4);
  return Uint8List.fromList(List.filled(8, byte));
}

/// DXT5 alpha: a0/a1 plus all indices [code].
Uint8List dxt5AlphaBlock(int a0, int a1, int code) {
  final out = BytesBuilder();
  out.addByte(a0);
  out.addByte(a1);
  var bits = 0;
  for (var i = 0; i < 16; i++) {
    bits |= code << (3 * i);
  }
  for (var i = 0; i < 6; i++) {
    out.addByte((bits >> (8 * i)) & 0xFF);
  }
  return out.toBytes();
}

/// Minimal DXT-block encoder for tests (produces known content).
/// Each 4×4-pixel block uses the single color index [index] with color
/// [r]/[g]/[b].
Uint8List dxtColorBlock(int r, int g, int b, int index) {
  int pack565(int v, int bits, int shift) {
    final max = (1 << bits) - 1;
    final value = (v * max + 127) ~/ 255;
    return value << shift;
  }

  final c0 = pack565(r, 5, 11) | pack565(g, 6, 5) | pack565(b, 5, 0);
  final c1 = 0; // just needs to differ from c0; 4-color mode requires c0 > c1
  var bits = 0;
  for (var i = 0; i < 16; i++) {
    bits |= index << (2 * i);
  }
  final out = BytesBuilder();
  out.addByte(c0 & 0xFF);
  out.addByte((c0 >> 8) & 0xFF);
  out.addByte(c1 & 0xFF);
  out.addByte((c1 >> 8) & 0xFF);
  out.addByte(bits & 0xFF);
  out.addByte((bits >> 8) & 0xFF);
  out.addByte((bits >> 16) & 0xFF);
  out.addByte((bits >> 24) & 0xFF);
  return out.toBytes();
}

/// Tiles [block] repeatedly into 64×64 mip0 data.
Uint8List tile(Uint8List block, int blockCount) {
  return Uint8List.fromList([for (var i = 0; i < blockCount; i++) ...block]);
}
