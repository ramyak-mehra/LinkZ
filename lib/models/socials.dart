import 'package:linkz/models/base_model.dart';

class Socials {
  Socials({
    String? facebook,
    String? instagram,
    String? twitter,
  })  : _facebook = facebook,
        _instagram = instagram,
        _twitter = twitter;

  final String? _facebook;
  final String? _instagram;
  final String? _twitter;

  String? get facebook => _facebook;
  String? get twitter => _twitter;
  String? get instagram => _instagram;
}
