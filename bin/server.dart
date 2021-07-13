import 'package:linkz/linkz.dart';

void main(List<String> args) async {
  setupDL();
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);

  // For Google Cloud Run, we respect the PORT environment variable
  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }
  final jwtUtil = JWTUtil(JWTConfig(
      jwtSecret: EnvConfig.jwtSecret,
      jwtExpiryMinutes: EnvConfig.jwtExpiryMinutes,
      jwtIss: EnvConfig.jwtIss,
      jwtAud: EnvConfig.jwtAud));
  var app = Alfred(logLevel: LogType.debug);
  final userRouter = UserRoute(app, AuthMiddleware(jwtUtil))..initialize();

  app.printRoutes();

  await app.listen();
}
