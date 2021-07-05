class Table {
  final String tableName;

  const Table({required this.tableName});
}

abstract class Column {
  final String coulmnName;
  final String? postgresType;
  const Column(this.coulmnName, this.postgresType);
}

class PrimaryKey extends Column {
  const PrimaryKey({required String columnName, String? postgresType})
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
  const DBColumn({required String columnName, String? postgresType})
      : super(columnName, postgresType);
}