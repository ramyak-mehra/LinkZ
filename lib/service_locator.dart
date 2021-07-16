import 'package:linkz/linkz.dart';
import 'package:uuid/uuid.dart';

final getIt = GetIt.instance;

void setupDL() {
  getIt.registerSingleton<JWTUtil>((JWTUtil(JWTConfig(
      jwtSecret: EnvConfig.jwtSecret,
      jwtExpiryMinutes: EnvConfig.jwtExpiryMinutes,
      jwtIss: EnvConfig.jwtIss,
      jwtAud: EnvConfig.jwtAud))));

  // ignore: cascade_invocations
  getIt.registerSingleton<PgPool>(
    PgPool(
      PgEndpoint(
          host: 'localhost',
          port: 5432,
          database: 'db_testing',
          password: 'password',
          username: 'postgres'),
    ),
  );

  // ignore: cascade_invocations
  getIt.registerSingleton<Uuid>(const Uuid());
  // ignore: cascade_invocations
  getIt.registerLazySingleton<AuthMiddleware>(
      () => AuthMiddleware(getIt<JWTUtil>()));
}
