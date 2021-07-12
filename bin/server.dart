import 'dart:io';
import 'package:alfred/alfred.dart';
import 'package:args/args.dart';
import 'package:authentication/authentication.dart';
import 'package:linkz/env/env.dart';
import 'package:linkz/routes/user.dart';

// For Google Cloud Run, set _hostname to '0.0.0.0'.
const _hostname = 'localhost';

void main(List<String> args) async {
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
