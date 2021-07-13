import 'package:db_annotations/db_annotations.dart' as db;
import 'package:postgres/postgres.dart';
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
  })  : clicks = 0,
        turnedOn = false;

  @db.DBColumn(columnName: 'account')
  final String account;
  @db.DBColumn(columnName: 'title')
  final String title;
  @db.PrimaryKey(columnName: 'url')
  final String url;
  @db.DBColumn(columnName: 'index')
  final int index;
  @db.DBColumn(columnName: 'turnedOn')
  final bool turnedOn;
  @db.DBColumn(columnName: 'emoji')
  final String? emoji;
  @db.DBColumn(columnName: 'clicks')
  final int clicks;
}
