import 'models.dart';

class ImageField extends BaseModel {
  ImageField(
      {required String path,
      double? height,
      double? width,
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt})
      : _path = path,
        _height = height,
        _width = width,
        super(id, createdAt, updatedAt);

  final String _path;
  final double? _height;
  final double? _width;

  String get path => _path;
  double? get height => _height;
  double? get width => _width;
}
