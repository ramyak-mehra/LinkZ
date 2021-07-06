import 'package:db_query_generator/db_query_generator.dart';

class ModelQueryGenerator {
  final TableData tableData;
  late final QueryTemplate _template;
  ModelQueryGenerator(this.tableData)
      : _template = QueryTemplate(
            (tableData.table!.fields[Field(String, 'tableName')] as String));

  String _insertInto(List<Field> fields, List<String> values) {
    final allColumnNames = [];
    for (var field in fields) {
      allColumnNames.add(_extractColumnName(field));
    }
    return _template.insertQuery(allColumnNames.join(', '), values.join(', '));
  }

  String _getByPk(String value) {
    return _template.whereQuery(_extractColumnName(_getPkField()), value);
  }

  String _getAll() {
    return _template.allQuery();
  }

  String _getAnyField(Field field, String value) {
    return _template.whereQuery(_extractColumnName(field), value);
  }

  String _update(Field field, String value, String pkValue) {
    return _template.updateQuery(_extractColumnName(field), value,
        _extractColumnName(_getPkField()), pkValue);
  }

  String _deleteObject(String pkValue) {
    return _template.deleteQuery(_extractColumnName(_getPkField()), pkValue);
  }

  Field _getPkField() {
    return tableData.fields.firstWhere((element) =>
        (element.annotatedClassInfo!.type as DartType).runtimeType ==
        PrimaryKey);
  }

  String _extractColumnName(Field field) {
    String columnName;
    if (field.annotatedClassInfo != null) {
      if (field.annotatedClassInfo!.fields[Field(String, 'columnName')] !=
          null) {
        columnName = field
            .annotatedClassInfo!.fields[Field(String, 'columnName')] as String;
      } else
        columnName = field.name;
    } else {
      columnName = field.name;
    }
    return columnName;
  }
}
