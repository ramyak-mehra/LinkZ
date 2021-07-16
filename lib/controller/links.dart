import 'package:linkz/linkz.dart';
import 'package:logger/logger.dart';

final _log = Logger();

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
      : super(HttpStatus.badRequest, '$field is required');
}
