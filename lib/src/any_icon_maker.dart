import 'models/models.dart';
// import 'image_processor_adapter_imglib.dart';
import 'image_processor_adapter_magick.dart';
// import 'image_processor_adapter.dart';
import 'image_processor.dart';

class AnyIconMaker {
  ImageProcessor imageProcessor = ImageProcessor(
    // ImageProcessorAdapterImglib(),
    ImageProcessorAdapterMagick(),
  );

  Future<void> make(
    String path,
    String outputPath,
    List<ImageSet> imageSetList,
  ) async {
    for (ImageSet imageSet in imageSetList) {
      print('[any_icon_maker] imageSet: ${imageSet.name}');
      for (Image image in imageSet.images) {
        String outPath = '${imageSet.path}${image.path}${image.filename}';
        bool isSaved = imageProcessor
            .load(path)
            .resize(image.width.toInt(), image.height.toInt())
            .save(outPath);
        if (isSaved) {
          print('[any_icon_maker] Created $outPath');
        }
      }
    }
  }
}
