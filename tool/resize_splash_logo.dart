import 'dart:io';

import 'package:image/image.dart' as img;

void main() {
  const sourcePath = 'lib/core/assets/logo.png';
  const targetPath = 'lib/core/assets/logo_splash.png';
  const targetWidth = 256;

  final sourceFile = File(sourcePath);
  if (!sourceFile.existsSync()) {
    stderr.writeln('Source image not found at $sourcePath');
    exit(1);
  }

  final bytes = sourceFile.readAsBytesSync();
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    stderr.writeln('Failed to decode PNG bytes.');
    exit(1);
  }

  final resized = decoded.width <= targetWidth
      ? decoded
      : img.copyResize(decoded, width: targetWidth);

  File(targetPath).writeAsBytesSync(img.encodePng(resized));
  stdout.writeln(
    'Wrote $targetPath with size ${resized.width}x${resized.height}.',
  );
}
