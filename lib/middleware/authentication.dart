import 'dart:async';
import 'package:jose/jose.dart';
import 'package:linkz/env/env.dart';
import 'package:linkz/models/models.dart';
import 'package:alfred/alfred.dart';
import 'package:linkz/extensions/extensions.dart';
import 'package:linkz/utils/jwt.dart';

FutureOr authenticatedOnly(HttpRequest request, HttpResponse response) async {
  var authorization = request.headers.value('Authorization');
  if (authorization == null) {
    throw AlfredException(401, {'error': 'You are not authenticated.'});
  }

  final jwtToken = _extractJWTToken(request);
  final claims =
      await JWTUtil.verifyJWTToken(jwtToken, JsonWebKey.fromJson({}));
  if (claims != null) {
    request.setUser(User.fromJson(claims.subject!));
    return null;
  } else {
    throw AlfredException(401, {'error': 'Token verification failed.'});
  }
}

String _extractJWTToken(HttpRequest request) {
  var authorization = request.headers.value('Authorization');
  if (authorization == null) {
    throw AlfredException(401, {'error': 'You are not authenticated.'});
  }
  if (!authorization.startsWith('${JWTConfig.tokenType} ')) {
    throw AlfredException(401, {'error': 'Invalid Token type'});
  }

  return authorization.replaceAll('${JWTConfig.tokenType} ', '');
}
