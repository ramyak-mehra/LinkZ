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

Future accountDetails(HttpRequest request, HttpResponse response) async {
  final userId = request.getUser!.userId;

  try {
    final account =
        await $Account.getAccountByUser(getIt<PgPool>(), user: userId);
    return account.first.toJson();
  } on PostgreSQLException catch (e) {
    return AlfredException(HttpStatus.badRequest, e.toString());
  }
}

Future deleteAccount(HttpRequest request, HttpResponse response) async {
  final body = await request.bodyAsJsonMap;
  final accountId = body['account'];
  final userId = request.getUser!.userId;
  final pgPool = getIt<PgPool>();
  try {
    await pgPool.runTx((c) async {
      final account = await $Account.getAccountByPk(c, id: accountId);
      if (account.user != userId) {
        c.cancelTransaction(
            reason: 'You are not authorized to perform this action.');
      }
      await $Account.deleteAccountByPk(c, id: accountId);
    });
  } on PostgreSQLException catch (e) {
    return AlfredException(HttpStatus.badRequest, e.toString());
  }
  return {'response': 'success'};
}
