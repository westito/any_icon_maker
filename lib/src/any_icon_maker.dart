import 'models/models.dart';
// import 'image_processor_adapter_imglib.dart';
import 'image_processor_adapter_magick.dart';
import 'image_processor.dart';

class AnyIconMaker {
  ImageProcessor imageProcessor = ImageProcessor(
    // ImageProcessorAdapterImglib(),
    ImageProcessorAdapterMagick(),
  );

  Future<void> make(
    String iconPath,
    String outputPath,
    List<ImageSet> imageSetList,
  ) async {
    for (ImageSet imageSet in imageSetList) {
      for (Image image in imageSet.images) {
        String imagePath = [
          outputPath,
          imageSet.path,
          image.path,
          image.filename,
        ].join('');

        bool isSaved = imageProcessor
            .load(iconPath)
            .resize(image.width.toInt(), image.height.toInt())
            .save(imagePath);
        if (isSaved) {
          print('Maked: $imagePath');
        }
      }
    }
  }
}
