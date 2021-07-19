import 'package:linkz/linkz.dart';
import 'package:db_annotations/db_annotations.dart' as db;

part 'account.g.dart';

@db.Table(tableName: 'account')
class Account {
  Account({required this.id, required this.user});
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(id: map['id'], user: map['user']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'user': user};
  }

  String toJson() => json.encode(toMap());

  @db.PrimaryKey()
  final String id;
  @db.DBColumn()
  final String user;
}
