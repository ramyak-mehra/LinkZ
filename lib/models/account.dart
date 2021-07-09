import 'package:linkz/models/design.dart';
import 'package:linkz/models/images.dart';
import 'package:linkz/models/socials.dart';

import 'models.dart';

class Account {
  Account({
    required Design currentDesign,
  }) : _currentDesign = currentDesign;

//TODO: Create factory constructors for adding socials.

  List<Link>? _links;
  final Design _currentDesign;
  late ImageField _qrCode;
  late Socials _socials;
  Design get currentDesign => _currentDesign;
  List<Link>? get links => _links;
  ImageField get qrCode => _qrCode;
  Socials get socials => _socials;

  void addLink(List<Link> links) {
    if (_links != null) {
      _links!.addAll(links);
    } else {
      _links = [];
      _links!.addAll(links);
    }
  }

  void _addLink(List<Link> links) {
    //TODO: Do the database transaction of attaching stuff.
  }
}
