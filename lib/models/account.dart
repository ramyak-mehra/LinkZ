import 'package:linkz/models/design.dart';
import 'package:linkz/models/images.dart';
import 'package:linkz/models/socials.dart';

import 'models.dart';

class Account {
  Account({
    required Design currentDesign,
  }) : _currentDesign = currentDesign;

//TODO: Create factory constructors for adding socials.

  List<Linkz>? _links;
  final Design _currentDesign;
  late ImageField _qrCode;
  late Socials _socials;
  Design get currentDesign => _currentDesign;
  List<Linkz>? get links => _links;
  ImageField get qrCode => _qrCode;
  Socials get socials => _socials;

  void addLink(List<Linkz> links) {
    if (_links != null) {
      _links!.addAll(links);
    } else {
      _links = [];
      _links!.addAll(links);
    }
  }
}
