import 'dart:async';
import 'package:jose/jose.dart';
import 'package:linkz/env/env.dart';
import 'package:linkz/models/models.dart';
import 'package:alfred/alfred.dart';
import 'package:linkz/extensions/extensions.dart';
import 'package:linkz/utils/jwt.dart';

FutureOr authenticatedMiddleware(
    HttpRequest request, HttpResponse response) async {
  var authorization = request.headers.value('Authorization');
  if (authorization == null) {
    throw AlfredException(401, {'error': 'You are not authenticated.'});
  }

  final jwtToken = _extractJWTToken(request);
  final claims = await JWTUtil.verifyJWTToken(
      jwtToken, JsonWebKey.fromJson({'kty': 'oct', 'k': EnvConfig.jwtSecret}));
  if (claims != null) {
    request.setUser(UserTokenSubject.fromJson(claims.subject!));
    return null;
  }
}

String _extractJWTToken(HttpRequest request) {
  var authorization = request.headers.value('Authorization');
  if (authorization == null) {
    throw AlfredException(401, {'error': 'You are not authenticated.'});
  }
  if (!authorization.startsWith('${EnvConfig.tokenType} ')) {
    throw AlfredException(401, {'error': 'Invalid Token type'});
  }

  return authorization.replaceFirst('${EnvConfig.tokenType} ', '');
}
