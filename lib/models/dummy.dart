import 'package:authentication/authentication.dart';
import 'package:linkz/models/models.dart';
import 'package:postgres/postgres.dart';
import 'package:db_annotations/db_annotations.dart' as db;

@mustCallSuper
class DummyModel {
  DummyModel();
  factory DummyModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return DummyModel();
  }
  @db.PrimaryKey(columnName: 'first_name')
  late final String username;
  @db.DBColumn()
  late final int id;

  late final String? password;
}
