import 'dart:typed_data';

/// BLP2 image decoder (main mipmap only).
abstract final class BlpDecoder {
/// Decodes a BLP2 image to RGBA (main mipmap only).
///
/// All 3.3.5a client icons are BLP2 64×64, encoded as DXT1/DXT3/DXT5
/// (measured distribution DXT1 2210 / DXT3 1922 / DXT5 2175; no JPEG, no
/// palette variants). Supports both compressed-texture and raw-BGRA
/// encodings; the JPEG variant throws [BlpFormatException].
  static BlpImage decode(Uint8List bytes) {
  if (bytes.length < 84 ||
      bytes[0] != 0x42 ||
      bytes[1] != 0x4C ||
      bytes[2] != 0x50 ||
      bytes[3] != 0x32) {
    throw const BlpFormatException('not a valid BLP2 file');
  }
  final bd = ByteData.sublistView(bytes);
  final type = bd.getUint32(4, Endian.little);
  final encoding = bytes[8];
  final alphaDepth = bytes[9];
  final alphaEncoding = bytes[10];
  final width = bd.getUint32(12, Endian.little);
  final height = bd.getUint32(16, Endian.little);
  final mip0Offset = bd.getUint32(20, Endian.little);
  final mip0Size = bd.getUint32(20 + 64, Endian.little);

  if (type != 1) {
    throw BlpFormatException('unsupported BLP type ($type, JPEG variant)');
  }
  if (width == 0 || height == 0) {
    throw const BlpFormatException('invalid image dimensions');
  }
  // The width/height declared in the header is untrustworthy (game icons
  // are always 64×64): an oversized declaration would blow up memory during
  // the `width * height * 4` allocation, so cap it at a sane bound first.
  if (width > 4096 || height > 4096) {
    throw const BlpFormatException('image dimensions out of range');
  }
  if (mip0Offset + mip0Size > bytes.length) {
    throw const BlpFormatException('mip0 data out of bounds');
  }

  final rgba = Uint8List(width * height * 4);
  final src = Uint8List.sublistView(bytes, mip0Offset, mip0Offset + mip0Size);

  switch (encoding) {
    case 2:
      // DXT compression. alphaDepth<=1 → DXT1; alphaEncoding==7 → DXT5;
      // otherwise DXT3.
      final mode = alphaDepth <= 1 ? 1 : (alphaEncoding == 7 ? 5 : 3);
      _decodeDxt(src, width, height, mode, rgba);
    case 3:
      // Uncompressed BGRA.
      final expected = width * height * 4;
      if (src.length < expected) {
        throw const BlpFormatException('insufficient uncompressed data');
      }
      for (var i = 0; i < width * height; i++) {
        rgba[i * 4] = src[i * 4 + 2];
        rgba[i * 4 + 1] = src[i * 4 + 1];
        rgba[i * 4 + 2] = src[i * 4];
        rgba[i * 4 + 3] = src[i * 4 + 3];
      }
    default:
      throw BlpFormatException('unsupported encoding ($encoding)');
  }
  return BlpImage(width: width, height: height, rgba: rgba);
}

/// Decodes a DXT1/3/5 block into [dst] (RGBA, non-premultiplied alpha).
  static void _decodeDxt(Uint8List src, int w, int h, int mode, Uint8List dst) {
  final blocksX = (w + 3) >> 2;
  final blocksY = (h + 3) >> 2;
  final blockBytes = mode == 1 ? 8 : 16;
  final colors = Uint8List(16); // 4 colors × RGBA
  var p = 0;
  for (var by = 0; by < blocksY; by++) {
    for (var bx = 0; bx < blocksX; bx++) {
      if (p + blockBytes > src.length) {
        throw const BlpFormatException('insufficient DXT data');
      }
      var alphaBase = -1;
      final colorBase = mode == 1 ? p : p + 8;
      if (mode != 1) alphaBase = p;
      p += blockBytes;

      final c0 = src[colorBase] | (src[colorBase + 1] << 8);
      final c1 = src[colorBase + 2] | (src[colorBase + 3] << 8);
      _unpack565(c0, colors, 0);
      _unpack565(c1, colors, 4);
      if (c0 > c1 || mode != 1) {
        // 4-color mode (DXT3/5 are always 4-color).
        for (var k = 0; k < 3; k++) {
          colors[8 + k] = (2 * colors[k] + colors[4 + k]) ~/ 3;
          colors[12 + k] = (colors[k] + 2 * colors[4 + k]) ~/ 3;
        }
        colors[11] = 255;
        colors[15] = 255;
      } else {
        // DXT1 1-bit alpha: colors 2/3 are transparent when c0 < c1.
        for (var k = 0; k < 3; k++) {
          colors[8 + k] = (colors[k] + colors[4 + k]) ~/ 2;
          colors[12 + k] = 0;
        }
        colors[11] = 255;
        colors[15] = 0;
      }

      final bits =
          src[colorBase + 4] |
          (src[colorBase + 5] << 8) |
          (src[colorBase + 6] << 16) |
          (src[colorBase + 7] << 24);
      for (var py = 0; py < 4; py++) {
        for (var px = 0; px < 4; px++) {
          final x = bx * 4 + px, y = by * 4 + py;
          if (x >= w || y >= h) continue;
          final idx = ((bits >> (2 * (py * 4 + px))) & 0x3) * 4;
          final o = (y * w + x) * 4;
          dst[o] = colors[idx];
          dst[o + 1] = colors[idx + 1];
          dst[o + 2] = colors[idx + 2];
          var a = colors[idx + 3];
          if (mode == 3) {
            final nib = src[alphaBase + (py * 4 + px) ~/ 2];
            a = ((py * 4 + px) & 1 == 0 ? nib & 0xF : nib >> 4) * 17;
          } else if (mode == 5) {
            a = _dxt5Alpha(src, alphaBase, py * 4 + px);
          }
          dst[o + 3] = a;
        }
      }
    }
  }
}

/// DXT5 8-value alpha interpolation lookup.
  static int _dxt5Alpha(Uint8List src, int base, int index) {
  final a0 = src[base], a1 = src[base + 1];
  var bits = 0;
  for (var k = 0; k < 6; k++) {
    bits |= src[base + 2 + k] << (8 * k);
  }
  final code = (bits >> (3 * index)) & 0x7;
  if (code == 0) return a0;
  if (code == 1) return a1;
  if (a0 > a1) return ((8 - code) * a0 + (code - 1) * a1) ~/ 7;
  if (code == 6) return 0;
  if (code == 7) return 255;
  return ((6 - code) * a0 + (code - 1) * a1) ~/ 5;
}


  static void _unpack565(int v, Uint8List out, int at) {
  final r = (v >> 11) & 0x1F, g = (v >> 5) & 0x3F, b = v & 0x1F;
  out[at] = (r << 3) | (r >> 2);
  out[at + 1] = (g << 2) | (g >> 4);
  out[at + 2] = (b << 3) | (b >> 2);
  out[at + 3] = 255;
}
}










/// Unsupported BLP format or corrupted data.
final class BlpFormatException implements Exception {
  final String message;
  const BlpFormatException(this.message);

  @override
  String toString() => 'BlpFormatException: $message';
}

/// BLP2 decode result: RGBA pixels (4 bytes per pixel, non-premultiplied
/// alpha).
final class BlpImage {
  final int width;
  final int height;
  final Uint8List rgba;

  const BlpImage({
    required this.width,
    required this.height,
    required this.rgba,
  });
}
