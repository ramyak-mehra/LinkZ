import 'dart:convert';

import 'models.dart';

class User extends BaseModel {
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
  User(
      {required this.username,
      this.email,
      required this.hashedPassword,
      required this.salt,
      required this.account,
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt})
      : super(id, createdAt, updatedAt);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        username: map['username'],
        email: map['email'],
        hashedPassword: map['hashedPassword'],
        salt: map['salt'],
        account: map['account'],
        createdAt: map['createdAt'],
        id: map['id'],
        updatedAt: map['updatedAt']);
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

class UserTokenSubject {
  UserTokenSubject({
    required this.userId,
    required this.username,
  });

  factory UserTokenSubject.fromJson(String source) =>
      UserTokenSubject.fromMap(json.decode(source));

  factory UserTokenSubject.fromMap(Map<String, dynamic> map) {
    return UserTokenSubject(
      userId: map['userId'],
      username: map['username'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
    };
  }

  String toJson() => json.encode(toMap());

  String userId;
  String username;

  @override
  String toString() => 'UserTokenSubject(userId: $userId, username: $username)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserTokenSubject &&
        other.userId == userId &&
        other.username == username;
  }

  @override
  int get hashCode => userId.hashCode ^ username.hashCode;
}
