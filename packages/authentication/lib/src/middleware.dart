import 'package:authentication/authentication.dart';

@sealed
class AuthMiddleware {
  final JWTUtil jwtUtil;

  AuthMiddleware(this.jwtUtil);

  FutureOr middleware(HttpRequest request, HttpResponse response) async {
    var authorization = request.headers.value('Authorization');
    if (authorization == null) {
      throw AlfredException(401, {'error': 'You are not authenticated.'});
    }

    final jwtToken = _extractJWTToken(request, jwtUtil.tokenType ?? 'Bearer');
    final claims = await jwtUtil.verifyJWTToken(jwtToken);

    if (claims != null) {
      request.setUser(UserTokenSubject.fromJson(claims.subject!));
      return null;
    }
  }

  String _extractJWTToken(HttpRequest request, String tokenType) {
    var authorization = request.headers.value('Authorization');
    if (authorization == null) {
      throw AlfredException(401, {'error': 'You are not authenticated.'});
    }
    if (!authorization.startsWith('${tokenType} ')) {
      throw AlfredException(401, {'error': 'Invalid Token type'});
    }

    return authorization.replaceFirst('${tokenType} ', '');
  }
}
