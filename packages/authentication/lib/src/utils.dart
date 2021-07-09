import 'dart:math';

import 'package:authentication/authentication.dart';
import 'package:crypto/crypto.dart';

String generateSalt([int length = 32]) {
  final random = Random.secure();
  final saltBytes = List<int>.generate(length, (index) => random.nextInt(256));
  return base64Encode(saltBytes);
}

extension PasswordValidators on String {
  String hashPassword(String salt) {
    return _hashPassword(this, salt);
  }

  bool validatePassword(String storedSalt, String storedPassword) {
    return this.hashPassword(storedSalt) == storedPassword;
  }
}

String _hashPassword(String password, String salt) {
  final codec = Utf8Codec();
  final key = codec.encode(password);
  final saltBytes = codec.encode(salt);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(saltBytes);
  return digest.toString();
}

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
