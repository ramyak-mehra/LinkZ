class QueryTemplate {
  final String tableName;

  QueryTemplate(this.tableName);

  String insertQuery(String columns, dynamic values) {
    return "INSERT INTO $tableName($columns) VALUES($values)";
  }

  String allQuery() {
    return 'SELECT * from $tableName;';
  }

  String whereQuery(String columnName, dynamic value) {
    return "SELECT * from $tableName WHERE $columnName = '$value' ;";
  }

  String updateQuery(
      String columnName, dynamic value, String pk, dynamic pkValue) {
    return "UPDATE $tableName SET $columnName = '$value' WHERE $pk = '$pkValue';";
  }

  String deleteQuery(String pk, dynamic pkValue) {
    return "DELETE FROM $tableName  WHERE $pk = '$pkValue';";
  }
}
