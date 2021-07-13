import 'package:linkz/linkz.dart';

class AccountRoute {
  AccountRoute(this.app) : authMiddleware = getIt<AuthMiddleware>();
  final Alfred app;
  final AuthMiddleware authMiddleware;
  void initialize() {
    app.route('/account/')
      ..get('', details, middleware: [authMiddleware.middleware])
      ..all('*', (req, res) => 'not found');
  }
}
