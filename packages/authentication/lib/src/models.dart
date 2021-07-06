import 'package:authentication/authentication.dart';

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

class JWTConfig {
  final String jwtSecret;
  final String jwtExpiryMinutes;
  final String jwtIss;
  final String jwtAud;
  final String tokenType;

  JWTConfig(
      {required this.jwtSecret,
      required this.jwtExpiryMinutes,
      required this.jwtIss,
      required this.jwtAud,
      required this.tokenType});
}
