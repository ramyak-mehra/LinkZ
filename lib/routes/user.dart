import 'package:linkz/controller/user.dart';

import 'package:alfred/alfred.dart';
import 'package:authentication/authentication.dart';

class UserRoute {
  UserRoute(this.app, this.authMiddleware);
  final Alfred app;
  final AuthMiddleware authMiddleware;
  NestedRoute get router {
    var userRouter =
        NestedRoute(alfred: app, basePath: '/user/', baseMiddleware: [])
          ..get('', details, middleware: [authMiddleware.middleware])
          ..post('login', login)
          ..post('logout', logout, middleware: [authMiddleware.middleware])
          ..post('register', register)
          ..all('*', (req, res) => '');

    return userRouter;
  }
}
