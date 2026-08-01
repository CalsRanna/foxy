import 'dart:typed_data';

/// 解码 BLP2 图片为 RGBA（仅主 mipmap）。
///
/// 3.3.5a 客户端图标全部为 BLP2 64×64，编码变体为 DXT1/DXT3/DXT5
/// （实测分布 DXT1 2210 / DXT3 1922 / DXT5 2175，无 JPEG、无调色板变体）。
/// 支持压缩纹理与原始 BGRA 两种 encoding；JPEG 变体抛 [BlpFormatException]。
BlpImage decodeBlp(Uint8List bytes) {
  if (bytes.length < 84 ||
      bytes[0] != 0x42 ||
      bytes[1] != 0x4C ||
      bytes[2] != 0x50 ||
      bytes[3] != 0x32) {
    throw const BlpFormatException('不是有效的 BLP2 文件');
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
    throw BlpFormatException('不支持的 BLP 类型（$type，JPEG 变体）');
  }
  if (width == 0 || height == 0) {
    throw const BlpFormatException('无效的图片尺寸');
  }
  if (mip0Offset + mip0Size > bytes.length) {
    throw const BlpFormatException('mip0 数据越界');
  }

  final rgba = Uint8List(width * height * 4);
  final src = Uint8List.sublistView(bytes, mip0Offset, mip0Offset + mip0Size);

  switch (encoding) {
    case 2:
      // DXT 压缩。alphaDepth<=1 → DXT1；alphaEncoding==7 → DXT5；否则 DXT3。
      final mode = alphaDepth <= 1 ? 1 : (alphaEncoding == 7 ? 5 : 3);
      _decodeDxt(src, width, height, mode, rgba);
    case 3:
      // 未压缩 BGRA。
      final expected = width * height * 4;
      if (src.length < expected) {
        throw const BlpFormatException('未压缩数据不足');
      }
      for (var i = 0; i < width * height; i++) {
        rgba[i * 4] = src[i * 4 + 2];
        rgba[i * 4 + 1] = src[i * 4 + 1];
        rgba[i * 4 + 2] = src[i * 4];
        rgba[i * 4 + 3] = src[i * 4 + 3];
      }
    default:
      throw BlpFormatException('不支持的编码方式（$encoding）');
  }
  return BlpImage(width: width, height: height, rgba: rgba);
}

/// DXT1/3/5 块解码到 [dst]（RGBA，未预乘 alpha）。
void _decodeDxt(Uint8List src, int w, int h, int mode, Uint8List dst) {
  final blocksX = (w + 3) >> 2;
  final blocksY = (h + 3) >> 2;
  final blockBytes = mode == 1 ? 8 : 16;
  final colors = Uint8List(16); // 4 个颜色 × RGBA
  var p = 0;
  for (var by = 0; by < blocksY; by++) {
    for (var bx = 0; bx < blocksX; bx++) {
      if (p + blockBytes > src.length) {
        throw const BlpFormatException('DXT 数据不足');
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
        // 4 色模式（或 DXT3/5 恒为 4 色）。
        for (var k = 0; k < 3; k++) {
          colors[8 + k] = (2 * colors[k] + colors[4 + k]) ~/ 3;
          colors[12 + k] = (colors[k] + 2 * colors[4 + k]) ~/ 3;
        }
        colors[11] = 255;
        colors[15] = 255;
      } else {
        // DXT1 1-bit alpha：c0<c1 时 2/3 色透明。
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

/// DXT5 8 值 alpha 插值查找。
int _dxt5Alpha(Uint8List src, int base, int index) {
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

void _unpack565(int v, Uint8List out, int at) {
  final r = (v >> 11) & 0x1F, g = (v >> 5) & 0x3F, b = v & 0x1F;
  out[at] = (r << 3) | (r >> 2);
  out[at + 1] = (g << 2) | (g >> 4);
  out[at + 2] = (b << 3) | (b >> 2);
  out[at + 3] = 255;
}

/// BLP 格式不支持或数据损坏。
final class BlpFormatException implements Exception {
  final String message;
  const BlpFormatException(this.message);

  @override
  String toString() => 'BlpFormatException: $message';
}

/// BLP2 解码结果：RGBA 像素（每像素 4 字节，未预乘 alpha）。
final class BlpImage {
  final int width;
  final int height;
  final Uint8List rgba;

  const BlpImage({required this.width, required this.height, required this.rgba});
}
