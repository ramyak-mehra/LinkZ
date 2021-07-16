import 'package:db_annotations/db_annotations.dart' as db;
import 'package:linkz/linkz.dart';
import 'package:linkz/service_locator.dart';
import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';
part 'link.g.dart';

@db.Table(tableName: 'links')
class Linkz {
  factory Linkz.fromMap(Map<String, dynamic> map) {
    return Linkz(
      index: map['index'],
      title: map['title'],
      url: map['url'],
      account: map['account'],
      emoji: map['emoji'],
    );
  }
  Linkz({
    required this.account,
    required this.title,
    required this.url,
    required this.index,
    this.emoji,
    bool? tunrnedOn,
  })  : clicks = 0,
        id = getIt<Uuid>().v4(),
        turnedOn = tunrnedOn ?? false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'index': index,
      'account': account,
      'emoji': emoji,
      'clicks': clicks,
      'turnedOn': turnedOn,
    };
  }

  String toJson() => json.encode(toMap());

  @db.PrimaryKey(columnName: 'id')
  final String id;
  @db.DBColumn(columnName: 'account')
  final String account;
  @db.DBColumn(columnName: 'title')
  final String title;
  @db.PrimaryKey(columnName: 'url')
  final String url;
  @db.DBColumn(columnName: 'index')
  final int index;
  @db.DBColumn(columnName: 'turned_on')
  final bool turnedOn;
  @db.DBColumn(columnName: 'emoji')
  final String? emoji;
  @db.DBColumn(columnName: 'clicks')
  final int clicks;
}
