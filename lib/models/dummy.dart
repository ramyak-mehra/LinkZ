import 'package:linkz/models/models.dart';
import 'package:db_annotations/db_annotations.dart' as db;

part 'dummy.g.dart';

@db.Table(tableName: 'dummy_table')
class DummyModel extends BaseModel {
  DummyModel(String id, DateTime createdAt, DateTime updatedAt)
      : super(id, createdAt, updatedAt);
  @db.ForiegnKey(
      columnName: 'testField', postgresType: 'Boolean', referencedTable: 'cool')
  final bool testField = true;
}
