import 'package:alfred/alfred.dart';
import 'package:linkz/models/models.dart';

extension UserStore on HttpRequest {
  User? get getUser {
    return store.get('user');
  }

  void setUser(UserTokenSubject user) {
    store.set('user', user);
  }
}
