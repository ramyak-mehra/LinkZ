import 'package:/test/test.dart';
import 'package:jose/jose.dart';
import 'package:linkz/env/env.dart';
import 'package:linkz/utils/jwt.dart';

void main() {
  final jsonWebKey = JWTUtil.jsonWebKey;

  group('jwt testing', () {
    test('generate jwt token ', () {
      final jwtToken =
          JWTUtil.generateJWTToken(jsonWebKey: jsonWebKey, userData: {});
      expect(jwtToken, '');
    });

    test('verifyJWTToken', () {
      final userData = <String, String>{};
      final generatedClaims = JsonWebTokenClaims.fromJson({
        'exp': DateTime.now()
                .add(Duration(minutes: EnvConfig.jwtExpiryMinutes.toInt()))
                .millisecondsSinceEpoch ~/
            1000,
        'iss': EnvConfig.jwtIss,
        'aud': EnvConfig.jwtAud,
        'sub': userData,
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000
      });

      final jwtToken =
          JWTUtil.generateJWTToken(jsonWebKey: jsonWebKey, userData: userData);
      final extractedClaims = JWTUtil.verifyJWTToken(jwtToken, jsonWebKey);
      expect(extractedClaims, equals(generatedClaims));
    });
  });
}
