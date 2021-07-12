import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:authentication/authentication.dart';
import 'package:linkz/env/env.dart';
import 'package:linkz/models/models.dart';
import 'package:logger/logger.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

Future<PostgreSQLConnection> connect() async {
  var conntection = PostgreSQLConnection('localhost', 5432, 'db_testing',
      username: 'postgres', password: 'password');
  await conntection.open();
  return conntection;
}

var _log = Logger(
  printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true),
);

Future details(HttpRequest request, HttpResponse response) async {
  return request.getUser;
}

Future login(HttpRequest request, HttpResponse response) async {
  final jwtUtil = JWTUtil(JWTConfig(
      jwtSecret: EnvConfig.jwtSecret,
      jwtExpiryMinutes: EnvConfig.jwtExpiryMinutes,
      jwtIss: EnvConfig.jwtIss,
      jwtAud: EnvConfig.jwtAud));
  final body = await request.bodyAsJsonMap;
  try {
    final user = await _validateLoginRequest(body);
    final accessToken = jwtUtil.generateJWTToken(
        userData: UserTokenSubject(userId: user.id, username: user.username));
    return {'accessToken': accessToken};
  } catch (e) {
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
    _log.d(user);
    var connection = await connect();
    await connection.transaction((ctx) async {
      await $User.insertUser(ctx,
          email: user.email,
          hashed_password: user.hashedPassword,
          id: user.id,
          salt: user.salt,
          username: user.username);
    });
    return user.toJson();
  } catch (e) {
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
  //TODO: Check if the user already exsists.
  final salt = generateSalt();
  const uuid = Uuid();
  return User(
      id: uuid.v4(),
      username: username,
      email: email,
      hashedPassword: password.hashPassword(salt),
      salt: salt);
}

Future<User> _validateLoginRequest(Map<String, dynamic> body) async {
  var password = body['password'] as String?;
  if (password == null) {
    throw AlfredException(HttpStatus.badRequest, 'Password field is required.');
  }
  var email = body['email'] as String?;

  var username = body['username'];
  if (username == null || email == null) {
    username = username as String?;
    throw AlfredException(
        HttpStatus.badRequest, 'Username or Email field is required.');
  }
  var connection = await connect();
  late User dbUser;
  await connection.transaction((ctx) async {
    dbUser = await $User.getUserByPk(ctx, username: username);
  });
  final validatePassword =
      password.validatePassword(dbUser.salt, dbUser.hashedPassword);
  if (!validatePassword) {
    throw AlfredException(HttpStatus.unauthorized,
        'Incorrect Password. Please check your password and try again.');
  }
  return dbUser;
}
