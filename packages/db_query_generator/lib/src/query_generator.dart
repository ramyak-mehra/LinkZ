import 'package:db_query_generator/db_query_generator.dart';

final _log = Logger('query-generator');

class ModelQueryGenerator {
  final TableData tableData;
  late final QueryTemplate _template;
  late final List<Field> _usableFields;
  ModelQueryGenerator(this.tableData)
      : _template = QueryTemplate(
            (tableData.table!.fields.entries.first.value as String)),
        _usableFields = _filterNonDBFields(tableData);

  ///Filter out those fields which do not have any db annotation.
  static List<Field> _filterNonDBFields(TableData tableData) {
    return tableData.fields.where((element) {
      //why type little hack to test if annotatedClassInfo is null or not.
      //directly annotatedClassInfo field was never null for some
      return element.annotatedClassInfo?.type != null;
    }).toList();
  }

  void generateData(StringBuffer buffer) {
    final className =
        tableData.className.getDisplayString(withNullability: false);
    final tableName = tableData.table!.fields.entries.first.value;
    final pkField = _getPkField();
    final pkColumn = _extractColumnName(pkField);
    buffer.writeln('class \$$className{');
    _getObjectByPk(buffer,
        className: className,
        tableName: tableName,
        pkField: pkField,
        pkColumn: pkColumn);
    _getAllObjects(buffer, className: className, tableName: tableName);
    for (var field in _usableFields) {
      var columName = _extractColumnName(field);
      if (columName == pkColumn) {
        continue;
      }
      _getObjectByColumn(buffer,
          className: className,
          tableName: tableName,
          field: field,
          columnName: columName);
    }
    buffer.writeln('}');
  }

  void _getAllObjects(StringBuffer buffer,
      {required String className, required String tableName}) {
    String lowerClassName = className.toLowerCase();
    buffer.writeln(
        'static Future<List<$className>> getAll${className}s(PostgreSQLExecutionContext execContext) async {');
    buffer.writeln('final ${lowerClassName}s = <$className>[];');
    buffer.writeln(
        "final result = await execContext.mappedResultsQuery(\'${_getAll()}\');");
    buffer.writeln('for ( var $lowerClassName in result  ) {');

    buffer.writeln("final map = $lowerClassName['$tableName'];");
    buffer.writeln('${lowerClassName}s.add($className.fromMap(map!));');

    buffer.writeln('}');
    buffer.writeln('return ${lowerClassName}s;');
    buffer.writeln('}');
  }

  void _getObjectByPk(StringBuffer buffer,
      {required String className,
      required String tableName,
      required Field pkField,
      required String pkColumn}) {
    buffer.writeln(
        'static Future<$className> get${className}ByPk(PostgreSQLExecutionContext execContext , {required ${pkField.type} $pkColumn}) async {');
    buffer.writeln(
        "final result = await execContext.mappedResultsQuery(\'${_getAnyField(pkColumn)}\' , substitutionValues : {'$pkColumn' : $pkColumn});");
    buffer.writeln('assert(result.length == 1);');
    buffer.writeln("final map = result.first['$tableName'];");
    buffer.writeln('return $className.fromMap(map!);');
    buffer.writeln('}');
  }

  void _getObjectByColumn(StringBuffer buffer,
      {required String className,
      required String tableName,
      required Field field,
      required String columnName}) {
    String lowerClassName = className.toLowerCase();
    buffer.writeln(
        'static Future<List<$className>> get${className}By${columnName.firstCapital}(PostgreSQLExecutionContext execContext , {required ${field.type} $columnName}) async {');
    buffer.writeln('final ${lowerClassName}s = <$className>[];');
    buffer.writeln(
        "final result = await execContext.mappedResultsQuery(\'${_getAnyField(columnName)}\' , substitutionValues : {'$columnName' : $columnName});");
    buffer.writeln('for ( var $lowerClassName in result  ) {');

    buffer.writeln("final map = $lowerClassName['$tableName'];");
    buffer.writeln('${lowerClassName}s.add($className.fromMap(map!));');

    buffer.writeln('}');
    buffer.writeln('return ${lowerClassName}s;');
    buffer.writeln('}');
  }

  String _insertInto(List<Field> fields, List<String> values) {
    final allColumnNames = [];
    for (var field in fields) {
      allColumnNames.add(_extractColumnName(field));
    }
    return _template.insertQuery(allColumnNames.join(', '), values.join(', '));
  }

  String _getAll() {
    return _template.allQuery();
  }

  String _getAnyField(String columName) {
    return _template.whereQuery(columName);
  }

  String _update(Field field, String value, String pkValue) {
    return _template.updateQuery(
        _extractColumnName(field), _extractColumnName(_getPkField()));
  }

  String _deleteObject(String pkValue) {
    return _template.deleteQuery(_extractColumnName(_getPkField()));
  }

  Field _getPkField() {
    final field = _usableFields.firstWhere((element) =>
        (element.annotatedClassInfo!.type).toString() == 'PrimaryKey');

    return field;
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

extension capital on String {
  String get firstCapital =>
      this[0].toUpperCase() + this.substring(1).toLowerCase();
}
