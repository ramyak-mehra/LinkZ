class QueryTemplate {
  final String tableName;

  QueryTemplate(this.tableName);

  String insertQuery(String columns, String value) {
    return "INSERT INTO $tableName($columns) VALUES($value)";
  }

  String allQuery() {
    return 'SELECT * FROM $tableName;';
  }

  String whereQuery(String columnName) {
    return "SELECT * FROM $tableName WHERE $columnName = @$columnName;";
  }

  String updateQuery(String columnName, String pk) {
    return "UPDATE $tableName SET $columnName = @$columnName WHERE $pk = @$pk;";
  }

  String deleteQuery(String pk) {
    return "DELETE FROM $tableName WHERE $pk = @$pk;";
  }
}
