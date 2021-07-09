import 'models.dart';

abstract class Design {}

enum Orientation { horizontal, vertical }

class GradientDesign extends Design {
  GradientDesign(this.colors, this.orientation);

  final List<String> colors;
  final Orientation orientation;
}

class AnimatedDesign extends Design {
  AnimatedDesign(this.path);
  final String path;
}

class EmojiDesign extends Design {
  EmojiDesign(this.emoji, this.bgColor);

  final String emoji;
  final String bgColor;
}

class ImageBackground extends Design {
  ImageBackground(this.image);
  final ImageField image;
}
