import 'package:alfred/alfred.dart';
import 'package:logger/logger.dart';
import 'package:linkz/extensions/extensions.dart';

var _logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true),
);

Future details(HttpRequest request, HttpResponse response) async {
  return request.getUser;
}

Future login(HttpRequest request, HttpResponse response) async {
  return '';
}

Future logout(HttpRequest request, HttpResponse response) async {
  return '';
}

Future register(HttpRequest request, HttpResponse response) async {
  //final payload = request.readAsString();
  //_logger.i('user logs $payload');
  return '';
}
