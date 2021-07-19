import 'package:linkz/linkz.dart';

class UserRoute {
  UserRoute(this.app) : authMiddleware = getIt<AuthMiddleware>();
  final Alfred app;
  final AuthMiddleware authMiddleware;
  void initialize() {
    app.route('/user/')
      ..get('', details, middleware: [authMiddleware.middleware])
      ..post('login', login)
      ..post('logout', logout, middleware: [authMiddleware.middleware])
      ..post('register', register)
      ..all('*', (req, res) => 'not found');
  }
}
