import 'package:linkz/controller/account_controller.dart';
import 'package:linkz/linkz.dart';

class AccountRoute {
  AccountRoute(this.app) : authMiddleware = getIt<AuthMiddleware>();
  final Alfred app;
  final AuthMiddleware authMiddleware;
  void initialize() {
    app.route('/account/', middleware: [authMiddleware.middleware])
      ..get('', accountDetails)
      ..post('create', createAccount)
      ..delete('delete', deleteAccount)
      ..all('*', (req, res) => 'not found');
  }
}
