import 'models.dart';

class Link {
  Link({
    required Account account,
    required String title,
    required String url,
    required int index,
    String? emoji,
  })  : _account = account,
        _title = title,
        _url = url,
        _index = index,
        _emoji = emoji,
        _clicks = 0,
        _turnedOn = false;
  final Account _account;
  final String _title;
  final String _url;
  final int _index;
  final bool _turnedOn;
  final String? _emoji;
  final int _clicks;
//TODO: Make getters to do the database transaction

  Account get account => _account;
  String get title => _title;
  String get url => _url;
  int get index => _index;
  bool get turnedOn => _turnedOn;
  int get clicks => _clicks;
  String? get emoji => _emoji;
}
