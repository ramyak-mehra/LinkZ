import 'package:linkz/controller/links.dart';
import 'package:linkz/linkz.dart';

class LinkRouter {
  LinkRouter(this.app) : authMiddleware = getIt<AuthMiddleware>();
  final Alfred app;
  final AuthMiddleware authMiddleware;

  void initialise() {
    app.route('/link/', middleware: [authMiddleware.middleware])
      ..get('', getAllLinks)
      ..post('create', addLink)
      ..all('*', (req, res) => 'not found');
  }
}
