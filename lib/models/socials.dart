import 'package:linkz/models/base_model.dart';

class Socials extends BaseModel {
  Socials({
    String? facebook,
    String? instagram,
    String? twitter,
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : _facebook = facebook,
        _instagram = instagram,
        _twitter = twitter,
        super(id, createdAt, updatedAt);

  final String? _facebook;
  final String? _instagram;
  final String? _twitter;

  String? get facebook => _facebook;
  String? get twitter => _twitter;
  String? get instagram => _instagram;
}
