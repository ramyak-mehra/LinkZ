import 'package:linkz/linkz.dart';

Future addLink(HttpRequest request, HttpResponse response) async {
  final body = await request.bodyAsJsonList;
  final pgPool = getIt<PgPool>();
  final links = <Linkz>[];
  for (var url in body) {
    links.add(_validateRequest(url));
  }
  await pgPool.runTx((ctx) async {
    for (var link in links) {
      await $Linkz.insertLinkz(ctx,
          account: link.account,
          title: link.title,
          url: link.url,
          index: link.index,
          turnedOn: link.turnedOn,
          emoji: link.emoji,
          clicks: link.clicks);
    }
  });
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

  return Linkz(
    account: account,
    index: index,
    title: title,
    url: url,
    emoji: emoji,
  );
}

class BadFieldLinkException extends AlfredException {
  BadFieldLinkException(String field)
      : super(HttpStatus.badRequest, '$field is required');
}