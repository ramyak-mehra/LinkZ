import 'package:alfred/alfred.dart';
import 'package:jose/jose.dart';
import 'package:meta/meta.dart';
import 'package:linkz/env/env.dart';

@sealed
abstract class JWTUtil {
  static JsonWebKey jsonWebKey =
      JsonWebKey.fromJson({'kty': 'oct', 'k': JWTConfig.jwtSecret});

  static String generateJWTToken(
      {required JsonWebKey jsonWebKey, required Map<String, String> userData}) {
    final claims = _generateClaims(userData);
    final jsonWebSignatureBuilder = JsonWebSignatureBuilder()
      ..jsonContent = claims.toJson()
      ..addRecipient(jsonWebKey, algorithm: 'HS256')
      ..build();
    final jws = jsonWebSignatureBuilder.build();
    return jws.toCompactSerialization();
  }

  static Future<JsonWebTokenClaims?> verifyJWTToken(
      String jwtToken, JsonWebKey jsonWebKey) async {
    final keyStore = JsonWebKeyStore()..addKey(jsonWebKey);

    final jwt = await JsonWebToken.decodeAndVerify(jwtToken, keyStore);

    var violations = jwt.claims.validate(
        issuer: Uri.parse(JWTConfig.jwtIss), clientId: JWTConfig.jwtAud);

    if (jwt.isVerified == true && violations.isEmpty) {
      return jwt.claims;
    } else if (jwt.isVerified ?? false) {
      throw AlfredException(401, {'message': 'JWT token verification failed.'});
    }
    violations.map((exception) {
      throw AlfredException(
          401, {'message': (exception as JoseException).message});
    });
    return null;
  }

  static JsonWebTokenClaims _generateClaims(Map<String, String> userData) {
    //Generate JWt Claims.
    final claims = JsonWebTokenClaims.fromJson({
      'exp': DateTime.now()
              .add(Duration(minutes: JWTConfig.jwtExpiryMinutes.toInt()))
              .millisecondsSinceEpoch ~/
          1000,
      'iss': JWTConfig.jwtIss,
      'aud': JWTConfig.jwtAud,
      'sub': userData,
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000
    });

    return claims;
  }
}

extension ToInt on String {
  int toInt() => int.parse(this);
}
