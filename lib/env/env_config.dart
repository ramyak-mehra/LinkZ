import 'package:envify/envify.dart';

part 'env_config.g.dart';

@Envify()
abstract class EnvConfig {
  static const jwtSecret = _EnvConfig.jwtSecret;
  static const jwtExpiryMinutes = _EnvConfig.jwtExpiryMinutes;
  static const jwtIss = _EnvConfig.jwtIss;
  static const jwtAud = _EnvConfig.jwtAud;
  static const tokenType = _EnvConfig.tokenType;
}
