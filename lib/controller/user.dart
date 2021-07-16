import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:authentication/authentication.dart';
import 'package:linkz/linkz.dart';
import 'package:linkz/models/models.dart';
import 'package:linkz/service_locator.dart';
import 'package:uuid/uuid.dart';

Future details(HttpRequest request, HttpResponse response) async {
  return request.getUser;
}

Future login(HttpRequest request, HttpResponse response) async {
  final jwtUtil = getIt<JWTUtil>();
  final body = await request.bodyAsJsonMap;
  try {
    final user = await _validateLoginRequest(body);
    final accessToken = jwtUtil.generateJWTToken(
        userData: UserTokenSubject(userId: user.id, username: user.username));
    return {'accessToken': accessToken};
  } on PostgreSQLException catch (e) {
    throw AlfredException(HttpStatus.badRequest, e.toString());
  }
}

Future logout(HttpRequest request, HttpResponse response) async {
  //TODO: delete the cookie. When set.
  //TODO: invalidate the accessToken.
  return '';
}

Future register(HttpRequest request, HttpResponse response) async {
  final body = await request.bodyAsJsonMap;
  try {
    final user = _validateRegisterRequest(body);
    var pgPool = getIt<PgPool>();
    await pgPool.runTx((ctx) async {
      await $User.insertUser(ctx,
          email: user.email,
          hashed_password: user.hashedPassword,
          id: user.id,
          salt: user.salt,
          username: user.username);
    });

    return user.toJson();
  } on PostgreSQLException catch (e) {
    throw AlfredException(HttpStatus.badRequest, e.toString());
  }
}

User _validateRegisterRequest(Map<String, dynamic> body) {
  var email = body['email'] as String?;
  if (email == null) {
    throw AlfredException(HttpStatus.badRequest, 'Email field is required.');
  }

  var password = body['password'] as String?;
  if (password == null) {
    throw AlfredException(HttpStatus.badRequest, 'Password field is required.');
  }

  var username = body['username'];
  if (username == null) {
    username = username as String?;
    throw AlfredException(HttpStatus.badRequest, 'Username field is required.');
  }
  final salt = generateSalt();
  final uuid = getIt<Uuid>();
  return User(
      id: uuid.v4(),
      username: username,
      email: email,
      hashedPassword: password.hashPassword(salt),
      salt: salt);
}

//Check if the user credentials are valid from a database.
Future<User> _validateLoginRequest(Map<String, dynamic> body) async {
  var password = body['password'] as String?;
  if (password == null) {
    throw AlfredException(HttpStatus.badRequest, 'Password field is required.');
  }
  var email = body['email'] as String?;

  var username = body['username'];
  if (username == null && email == null) {
    throw AlfredException(
        HttpStatus.badRequest, 'Username or Email field is required.');
  }
  var pgPool = getIt<PgPool>();
  final dbUser = await $User.getUserByPk(pgPool, username: username as String);
  final validatePassword =
      password.validatePassword(dbUser.salt, dbUser.hashedPassword);
  if (!validatePassword) {
    throw AlfredException(HttpStatus.unauthorized,
        'Incorrect Password. Please check your password and try again.');
  }
  return dbUser;
}
