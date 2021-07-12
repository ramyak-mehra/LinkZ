class Table {
  final String tableName;

  const Table({required this.tableName});
}

abstract class Column {
  final String? columnName;
  final String? postgresType;
  const Column(this.columnName, this.postgresType);
}

class PrimaryKey extends Column {
  const PrimaryKey({String? columnName, String? postgresType})
      : super(columnName, postgresType);
}

class ForiegnKey extends Column {
  const ForiegnKey(
      {required this.referencedTable,
      this.referencedColumn,
      required String columnName,
      String? postgresType})
      : super(columnName, postgresType);
  final String referencedTable;
  final String? referencedColumn;
}

class DBColumn extends Column {
  const DBColumn({String? columnName, String? postgresType})
      : super(columnName, postgresType);
}
