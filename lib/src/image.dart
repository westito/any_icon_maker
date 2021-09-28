class Image {
  String size;
  String filename;
  String filepath;
  int scale;

  double get _width => double.parse(size.split('x')[0]);
  double get _height => double.parse(size.split('x')[1]);

  double get width => _width * scale;
  double get height => _height * scale;

  Image({
    required this.size,
    required this.filename,
    required this.filepath,
    required this.scale,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      size: json['size'],
      filename: json['filename'],
      filepath: json['filepath'] ?? '',
      scale: int.parse((json['scale'] ?? '1x').replaceFirst('x', '')),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'filename': filename,
      'filepath': filepath,
      'scale': '${scale}x',
    };
  }
}
