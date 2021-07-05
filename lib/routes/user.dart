import 'package:linkz/controller/user.dart';

import 'package:alfred/alfred.dart';
import 'package:linkz/middleware/middleware.dart';

class UserRoute {
  UserRoute(this.app);
  final Alfred app;
  NestedRoute get router {
    var userRouter =
        NestedRoute(alfred: app, basePath: '/user/', baseMiddleware: [])
          ..get('', details, middleware: [authenticatedOnly])
          ..post('login', login)
          ..post('logout', logout, middleware: [authenticatedOnly])
          ..post('register', register)
          ..all('*', (req, res) => '');

    return userRouter;
  }
}
