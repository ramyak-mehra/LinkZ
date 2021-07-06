// import 'dart:convert';

// import 'package:authentication/authentication.dart';
// import 'package:http/http.dart' as http;
// import 'package:test/test.dart';

// void main() {
//   final userData = UserTokenSubject(userId: '123', username: 'alice');
//   final jsonWebKey = JWTUtil.jsonWebKey;
//   late http.Client httpClient;
//   late Alfred app;
//   late Uri url;
//   late JsonEncoder jsonEncoder;
//   setUp(() async {
//     jsonEncoder = const JsonEncoder();
//     httpClient = http.Client();
//     url = Uri.parse('http://localhost:8000');
//     app = Alfred()
//       ..all('*', (req, res) {}, middleware: [authenticatedMiddleware])
//       ..get('/', (req, res) {
//         return {'message': 'ok request'};
//       });
//     await app.listen(8000);
//   });
//   tearDown(() async {
//     httpClient.close();
//     await app.close(force: true);
//   });
//   group('Authentication Middleware', () {
//     test('verify jwt', () async {
//       var jwtToken =
//           JWTUtil.generateJWTToken(jsonWebKey: jsonWebKey, userData: userData);

//       final response = await httpClient.get(url.replace(path: '/'),
//           headers: {'Authorization': '${EnvConfig.tokenType} $jwtToken'});

//       expect(response.body, jsonEncoder.convert({'message': 'ok request'}));
//     });

//     test('token expired', () async {
//       var jwtToken = JWTUtil.generateJWTToken(
//           jsonWebKey: jsonWebKey,
//           userData: userData,
//           jwtExpiery: const Duration(seconds: 1));
//       await Future.delayed(const Duration(seconds: 5));
//       final response = await httpClient.get(url.replace(path: '/'),
//           headers: {'Authorization': '${EnvConfig.tokenType} $jwtToken'});

//       expect(response.statusCode, equals(401));
//       expect(response.body, contains('JWT expired.'));
//     });
//   });
// }
