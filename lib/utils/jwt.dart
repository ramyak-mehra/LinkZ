import 'package:alfred/alfred.dart';
import 'package:jose/jose.dart';
import 'package:linkz/models/models.dart';
import 'package:meta/meta.dart';
import 'package:linkz/env/env.dart';

@sealed
abstract class JWTUtil {
  static JsonWebKey jsonWebKey =
      JsonWebKey.fromJson({'kty': 'oct', 'k': EnvConfig.jwtSecret});

  static String generateJWTToken(
      {required JsonWebKey jsonWebKey,
      required UserTokenSubject userData,
      Duration? jwtExpiery}) {
    final claims = _generateClaims(userData,
        jwtExpiery ?? Duration(minutes: EnvConfig.jwtExpiryMinutes.toInt()));
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
        issuer: Uri.parse(EnvConfig.jwtIss), clientId: EnvConfig.jwtAud);

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

  static JsonWebTokenClaims _generateClaims(
      UserTokenSubject userData, Duration jwtExpirey) {
    //Generate JWt Claims.
    final claims = JsonWebTokenClaims.fromJson({
      'exp': DateTime.now().add(jwtExpirey).millisecondsSinceEpoch ~/ 1000,
      'iss': EnvConfig.jwtIss,
      'aud': EnvConfig.jwtAud,
      'sub': userData.toJson(),
      'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000
    });

    return claims;
  }
}

extension ToInt on String {
  int toInt() => int.parse(this);
}
