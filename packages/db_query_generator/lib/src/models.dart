import 'package:collection/collection.dart';
import 'package:db_query_generator/db_query_generator.dart';

typedef AnnotatedField = Map<Field, dynamic>;

/*
example:-
Fields-> DartType and name.
AnnotatedClass ->Fields->values
User class -> AnnotatedClass
user class fields -> AnnotatedClass + Fields.
*/

///Information about a single table.
class TableData {
  AnnotatedClass? table;
  late DartType className;
  late List<Field> fields;

  @override
  String toString() =>
      'TableData(table: $table, className: $className, fields: $fields)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TableData &&
        other.table == table &&
        other.className == className &&
        listEquals(other.fields, fields);
  }

  @override
  int get hashCode => table.hashCode ^ className.hashCode ^ fields.hashCode;
}

///This contains the type of annotation class i.e name
///and Annotated fields. AnnotatedField is a map of field
///and its value.
class AnnotatedClass<T> {
  T? type;
  late AnnotatedField fields;

  @override
  String toString() => 'AnnotatedClass(type: $type,\n fields: $fields)\n';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnnotatedClass &&
        other.type == type &&
        other.fields == fields;
  }

  @override
  int get hashCode => type.hashCode ^ fields.hashCode;
}

///This indicates a single property of a class.
///example - String username;
///where String is type and username is name;
class Field<T> {
  T type;
  String name;
  AnnotatedClass? annotatedClassInfo;
  Field(this.type, this.name);

  @override
  String toString() =>
      'Field(type: $type, name: $name, \n annotatedClassInfo: $annotatedClassInfo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Field<T> && other.type == type && other.name == name;
  }
}

@deprecated
class HelperClassDefination {
  final dynamic dartType;
  final String fieldName;

  HelperClassDefination(
    this.dartType,
    this.fieldName,
  );

  @override
  String toString() => '$dartType  $fieldName\n';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HelperClassDefination &&
        other.dartType == dartType &&
        other.fieldName == fieldName;
  }

  @override
  int get hashCode => dartType.hashCode ^ fieldName.hashCode;
}
