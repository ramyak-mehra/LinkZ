import 'package:envify/envify.dart';

part 'jwt_config.g.dart';

@Envify()
abstract class JWTConfig {
  static const jwtSecret = _JWTConfig.jwtSecret;
  static const jwtExpiryMinutes = _JWTConfig.jwtExpiryMinutes;
  static const jwtIss = _JWTConfig.jwtIss;
  static const jwtAud = _JWTConfig.jwtAud;
  static const tokenType = _JWTConfig.tokenType;
}
