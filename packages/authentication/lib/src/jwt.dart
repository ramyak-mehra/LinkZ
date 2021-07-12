import 'package:authentication/authentication.dart';

@sealed
class JWTUtil {
  final JWTConfig jwtConfig;
  final String? tokenType;
  late final JsonWebKey _jsonWebKey;

  JWTUtil(this.jwtConfig)
      : _jsonWebKey =
            JsonWebKey.fromJson({'kty': 'oct', 'k': jwtConfig.jwtSecret}),
        tokenType = jwtConfig.tokenType;

  String generateJWTToken(
      {required UserTokenSubject userData, Duration? jwtExpiery}) {
    final claims = _generateClaims(userData,
        jwtExpiery ?? Duration(minutes: jwtConfig.jwtExpiryMinutes.toInt()));
    final jsonWebSignatureBuilder = JsonWebSignatureBuilder()
      ..jsonContent = claims.toJson()
      ..addRecipient(_jsonWebKey, algorithm: 'HS256')
      ..build();
    final jws = jsonWebSignatureBuilder.build();
    return jws.toCompactSerialization();
  }

  Future<JsonWebTokenClaims?> verifyJWTToken(String jwtToken) async {
    final keyStore = JsonWebKeyStore()..addKey(_jsonWebKey);

    final jwt = await JsonWebToken.decodeAndVerify(jwtToken, keyStore);

    var violations = jwt.claims.validate(
        issuer: Uri.parse(jwtConfig.jwtIss), clientId: jwtConfig.jwtAud);

    if (jwt.isVerified == true && violations.isEmpty) {
      return jwt.claims;
    } else if (violations.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      violations.forEach((exception) {
        throw AlfredException(
            401, {'error': (exception as JoseException).message});
      });
    } else {
      throw AlfredException(401, {'error': 'JWT token verification failed.'});
    }

    return null;
  }

  JsonWebTokenClaims _generateClaims(
      UserTokenSubject userData, Duration jwtExpirey) {
    //Generate JWt Claims.
    final claims = JsonWebTokenClaims.fromJson({
      'exp': DateTime.now().add(jwtExpirey).millisecondsSinceEpoch ~/ 1000,
      'iss': jwtConfig.jwtIss,
      'aud': jwtConfig.jwtAud,
      'sub': userData.toJson(),
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000
    });

    return claims;
  }
}
