import 'package:authentication/authentication.dart';

extension UserStore on HttpRequest {
  UserTokenSubject? get getUser {
    return store.get('user');
  }

  void setUser(UserTokenSubject user) {
    store.set('user', user);
  }
}

extension ToInt on String {
  int toInt() => int.parse(this);
}
