import 'dart:io';
import 'package:image/image.dart' as img;

import 'image_set.dart';
import 'image.dart';

class AnyIconMaker {
  Future<void> make(
    String path,
    String outputPath,
    List<ImageSet> imageSetList,
  ) async {
    final originImage = img.decodePng(File(path).readAsBytesSync())!;

    for (ImageSet imageSet in imageSetList) {
      for (Image image in imageSet.images) {
        final resizedImage = img.copyResize(
          originImage,
          width: image.width.toInt(),
          height: image.height.toInt(),
          interpolation: img.Interpolation.average,
        );

        File outputFile = File(
          '$outputPath/${imageSet.path}${image.filepath}${image.filename}',
        );
        if (!outputFile.parent.existsSync()) {
          outputFile.parent.createSync(recursive: true);
        }
        List<int> resizedImageData;
        if (image.filename.contains('.ico')) {
          resizedImageData = img.encodeIco(resizedImage);
        } else {
          resizedImageData = img.encodePng(resizedImage);
        }
        outputFile.writeAsBytesSync(resizedImageData);
        print(outputFile);
      }
    }
  }
}
