import 'dart:io';

import 'image_processor_adapter.dart';

class ImageProcessorAdapterMagick extends ImageProcessorAdapter {
  @override
  bool save(String outPath) {
    File outputFile = File(outPath);
    if (!outputFile.parent.existsSync()) {
      outputFile.parent.createSync(recursive: true);
    }
    ProcessResult processResult = Process.runSync(
      'magick',
      [
        originImageFile!.path,
        '-resize',
        '${resizeWidth}x$resizeHeight',
        outPath,
      ],
      runInShell: true,
    );
    return processResult.exitCode == 0;
  }
}
