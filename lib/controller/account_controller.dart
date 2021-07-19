import 'package:linkz/linkz.dart';

Future createAccount(HttpRequest request, HttpResponse response) async {
  final body = await request.bodyAsJsonMap;
  try {
    final account = _validateInput(body, request);
    final pgPool = getIt<PgPool>();
    await $Account.insertAccount(pgPool, id: account.id, user: account.user);
    return account.toJson();
  } on PostgreSQLException catch (e) {
    throw AlfredException(HttpStatus.badRequest, e.toString());
  }
}

Account _validateInput(Map<String, dynamic> body, HttpRequest request) {
  final uuid = getIt<Uuid>();

  return Account(id: uuid.v4(), user: request.getUser!.userId);
}
