import 'package:authentication/authentication.dart';
import 'package:test/test.dart';

void main() {
  final jsonWebKey = JWTUtil.jsonWebKey;
  final userData = UserTokenSubject(userId: '123', username: 'alice');
  group('jwt testing', () {
//     test('generate jwt token ', () {
//       final jwtToken =
//           JWTUtil.generateJWTToken(jsonWebKey: jsonWebKey, userData: userData);
// //      print(jwtToken);

//       expect(jwtToken,
//           'eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjU1MTk2MjMsImlzcyI6InJhbXlhayIsImF1ZCI6ImxvY2FsaG9zdCIsInN1YiI6IntcInVzZXJJZFwiOlwiMTIzXCIsXCJ1c2VybmFtZVwiOlwiYWxpY2VcIn0iLCJpYXQiOjE2MjU1MTg3MjN9.vfUfx_ozYHAtwAy4RUAHI4USZ0h5MeOxMTowtL9wPcM');
//     });

    test('verifyJWTToken', () async {
      final generatedClaims = JsonWebTokenClaims.fromJson({
        'exp': DateTime.now()
                .add(Duration(minutes: EnvConfig.jwtExpiryMinutes.toInt()))
                .millisecondsSinceEpoch ~/
            1000,
        'iss': EnvConfig.jwtIss,
        'aud': EnvConfig.jwtAud,
        'sub': userData.toJson(),
        'iat': DateTime.now().millisecondsSinceEpoch ~/ 1000
      });

      final jwtToken =
          JWTUtil.generateJWTToken(jsonWebKey: jsonWebKey, userData: userData);
      final extractedClaims =
          await JWTUtil.verifyJWTToken(jwtToken, jsonWebKey);
      expect(extractedClaims, equals(generatedClaims));
    });
  });
}
