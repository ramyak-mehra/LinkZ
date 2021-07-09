import 'dart:convert';

import 'models.dart';

class User {
  // factory User.fromUsername(String username, String password, String salt) {
  //   //TODO: When added to the database get base model's field
  //   const id = '';

  //   return User(
  //       username: username,
  //       hashedPassword: password,
  //       salt: salt,
  //       id: id,
  //       createdAt: DateTime.now(),
  //       updatedAt: DateTime.now());
  // }
  User({
    required this.username,
    this.email,
    required this.hashedPassword,
    required this.salt,
    required this.account,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      hashedPassword: map['hashedPassword'],
      salt: map['salt'],
      account: map['account'],
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  final String username;
  final String? email;
  final String hashedPassword;
  final String salt;
  final String account;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'hashedPassword': hashedPassword,
      'salt': salt,
      'account': account,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'User(username: $username, email: $email, hashedPassword: $hashedPassword, salt: $salt, account: $account)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.username == username &&
        other.email == email &&
        other.hashedPassword == hashedPassword &&
        other.salt == salt &&
        other.account == account;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        hashedPassword.hashCode ^
        salt.hashCode ^
        account.hashCode;
  }
}
