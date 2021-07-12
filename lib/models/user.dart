import 'dart:convert';
import 'package:postgres/postgres.dart';
import 'package:db_annotations/db_annotations.dart' as db;
part 'user.g.dart';

@db.Table(tableName: 'users')
class User {
  User({
    required this.username,
    this.email,
    required this.id,
    required this.hashedPassword,
    required this.salt,
    this.account,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      id: map['id'],
      hashedPassword: map['hashed_password'],
      salt: map['salt'],
      account: map['account'],
    );
  }

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  @db.PrimaryKey()
  final String username;
  @db.DBColumn()
  final String? email;
  @db.DBColumn()
  final String id;
  @db.DBColumn(columnName: 'hashed_password')
  final String hashedPassword;
  @db.DBColumn()
  final String salt;
  final String? account;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'hashedPassword': hashedPassword,
      'account': account,
      'id': id
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'User(username: $username, email: $email, hashedPassword: $hashedPassword, salt: $salt, account: $account , id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.username == username &&
        other.email == email &&
        other.hashedPassword == hashedPassword &&
        other.salt == salt &&
        other.id == id &&
        other.account == account;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        hashedPassword.hashCode ^
        salt.hashCode ^
        id.hashCode ^
        account.hashCode;
  }
}
