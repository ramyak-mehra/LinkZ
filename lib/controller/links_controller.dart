import 'package:linkz/linkz.dart';

Future addLink(HttpRequest request, HttpResponse response) async {
  final body = await request.bodyAsJsonList;
  final pgPool = getIt<PgPool>();
  final links = <Linkz>[];
  try {
    for (var url in body) {
      links.add(_validateRequest(url));
    }
    await pgPool.runTx((ctx) async {
      for (var link in links) {
        await $Linkz.insertLinkz(ctx,
            id: link.id,
            account: link.account,
            title: link.title,
            url: link.url,
            index: link.index,
            turned_on: link.turnedOn,
            emoji: link.emoji,
            clicks: link.clicks);
      }
    });

    return links;
  } on PostgreSQLException catch (e) {
    throw AlfredException(HttpStatus.badRequest, e.toString());
  }
}

Future getAllLinks(HttpRequest request, HttpResponse response) async {
  final accountId = request.uri.queryParameters['account'];
  final user = request.getUser;
  if (accountId != null) {
    final pgPool = getIt<PgPool>();
    final result = await _verifyAccount(accountId, user!.userId);
    if (!result) {
      throw AlfredException(
          HttpStatus.forbidden, 'Account doesn\'t belongs to you.');
    }
    final links = await $Linkz.getLinkzByAccount(pgPool, account: accountId);
    return links;
  } else {
    throw BadFieldLinkException('Account');
  }
}

Future deleteLink(HttpRequest request, HttpResponse response) async {
  final body = await request.bodyAsJsonMap;
  final linkId = body['id'];
  try {
    await _authorizeAndDelete(linkId, request.getUser!.userId);
  } on PostgreSQLException catch (e) {
    throw AlfredException(HttpStatus.badRequest, e.toString());
  } catch (e) {
    throw AlfredException(HttpStatus.internalServerError, e.toString());
  }
  return {'response': 'success'};
}

Future<void> _authorizeAndDelete(String linkId, String userId) async {
  final pgPool = getIt<PgPool>();
  await pgPool.runTx((ctx) async {
    final account = await $Account.getAccountByUser(ctx, user: userId);
    final link = await $Linkz.getLinkzByPk(ctx, id: linkId);
    if (link.account != account.first.id) {
      ctx.cancelTransaction(
          reason: 'You are not authorized to perform this action.');
    }
    await $Linkz.deleteLinkzByPk(ctx, id: linkId);
  });
}

Future<bool> _verifyAccount(String accountId, String userid) async {
  try {
    final pgPool = getIt<PgPool>();
    final account = await $Account.getAccountByPk(pgPool, id: accountId);
    if (account.user == userid) {
      return true;
    } else {
      return false;
    }
  } on PostgreSQLException catch (e) {
    throw AlfredException(HttpStatus.forbidden, e.toString());
  }
}

Linkz _validateRequest(Map<String, dynamic> body) {
  var title = body['title'];
  if (title == null) {
    throw BadFieldLinkException('Title');
  }
  var url = body['url'];
  if (url == null) {
    throw BadFieldLinkException('Url');
  }
  var account = body['account'];
  if (account == null) {
    throw BadFieldLinkException('Account');
  }
  var index = body['index'];
  if (index == null) {
    throw BadFieldLinkException('Index');
  }
  var emoji = body['emoji'];
  var turnedOn = body['turnedOn'];

  return Linkz(
      account: account,
      index: index,
      title: title,
      url: url,
      emoji: emoji,
      tunrnedOn: turnedOn);
}

class BadFieldLinkException extends AlfredException {
  BadFieldLinkException(String field)
      : super(HttpStatus.unprocessableEntity, '$field is required');
}
