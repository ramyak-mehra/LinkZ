import 'package:db_annotations/db_annotations.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests related to fields', () {
    test('In primary key column is required', () {
      final primaryKey = PrimaryKey(columnName: 'id');
      expect(primaryKey.columnName, isNotNull,
          reason: 'Primary key column name is null');
      expect(primaryKey.columnName, equals('id'),
          reason:
              'Primary key column name field doesn\'t matches the passed field.');
    });
  });
}
