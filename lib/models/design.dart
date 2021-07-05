import 'models.dart';

abstract class Design extends BaseModel {
  Design(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
  ) : super(id, createdAt, updatedAt);
}

enum Orientation { horizontal, vertical }

class GradientDesign extends Design {
  GradientDesign(
    this.colors,
    this.orientation, {
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(id, createdAt, updatedAt);

  final List<String> colors;
  final Orientation orientation;
}

class AnimatedDesign extends Design {
  AnimatedDesign(
    this.path, {
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(id, createdAt, updatedAt);
  final String path;
}

class EmojiDesign extends Design {
  EmojiDesign(
    this.emoji,
    this.bgColor, {
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(id, createdAt, updatedAt);

  final String emoji;
  final String bgColor;
}

class ImageBackground extends Design {
  ImageBackground(
    this.image, {
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(id, createdAt, updatedAt);
  final ImageField image;
}
