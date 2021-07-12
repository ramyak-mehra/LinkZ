import 'package:db_query_generator/db_query_generator.dart';

var _log = Logger('metadata');

class DBQueryGenerator extends GeneratorForAnnotation<Table> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var buffer = StringBuffer();
    var visitor = ChildrenVisitor();

    element.visitChildren(visitor);
    //buffer.writeln('classname : ${element.displayName};');
    if (annotation.instanceOf(TypeChecker.fromRuntime(Table))) {
      visitor.tableData.table = AnnotatedClass<Type>()
        ..type = Table
        ..fields = {
          Field<Type>(String, 'tableName'):
              annotation.peek('tableName')!.stringValue
        };
    }
    //buffer.writeln(visitor.tableData);

    //_log.warning(visitor.tableData.table!.fields.entries.first);
    //_log.warning(visitor.tableData.table!.fields[firstKey]);
    ModelQueryGenerator userModel = ModelQueryGenerator(visitor.tableData);
    userModel.generateData(buffer);

    return buffer.toString();
  }
}

class ChildrenVisitor extends SimpleElementVisitor {
  TableData tableData = TableData()..fields = [];

  @override
  visitConstructorElement(ConstructorElement element) {
    // ignore: unnecessary_null_comparison
    assert(tableData.className == null);
    //gets the class name of the model.
    tableData.className = element.type.returnType;
    return super.visitConstructorElement(element);
  }

  //visits all the elements one by one.
  @override
  visitFieldElement(FieldElement element) {
    //creates a field for the table i.e property of the class.
    final field = Field<DartType>(element.type, element.name);
    field.annotatedClassInfo = AnnotatedClass<DartType>()..fields = {};

    //Loops through the metadata of the annotation .
    // Check for any annotations applied.
    for (var meta in element.metadata) {
      //Gets the constant value. It is used to find the values
      // inside the super constructor.
      final constantValue = meta.computeConstantValue();
      if (field.name == 'hashedPassword') _log.severe(constantValue);
      ;

      //Class by source gen package. Used to find the passed values inside the top
      // level constructor.
      // All annotatiosn for the field are extends [Column]
      //which has 2 properties columnName and postgresType.
      final annotation = ConstantReader(constantValue);

      //Setting the value for the ColumnName if exists else null.
      //If null field name will be used as column name.
      if (annotation.peek('columnName') != null) {
        field.annotatedClassInfo!.fields[Field<Type>(String, 'columnName')] =
            annotation.peek('columnName')!.stringValue;
        _log.warning(annotation.peek('columnName')!.stringValue);
      } else {
        field.annotatedClassInfo!.fields[Field<Type>(String, 'columnName')] =
            null;
      }
      //Setting the value for the postgresFieldType if exists else null.
      if (annotation.peek('postgresType') != null) {
        field.annotatedClassInfo!.fields[Field<Type>(String, 'postgresType')] =
            annotation.peek('postgresType')!.stringValue;
      } else {
        field.annotatedClassInfo!.fields[Field<Type>(String, 'postgresType')] =
            null;
      }

      //Now it sets the fields value for the annotation class.
      if (meta.element != null) {
        //Type cast the anotted element as constructor elements
        //To extract data.
        final constructorElement = (meta.element as ConstructorElement);
        //Annotation type for the field is set here.
        field.annotatedClassInfo!.type = constructorElement.type.returnType;
        //Return the FieldElement for the Annotated Class.
        final classFields = constructorElement.enclosingElement.fields;

        //Loop through them and sets each field.
        for (var classfield in classFields) {
          field.annotatedClassInfo!.fields[
                  Field<DartType>(classfield.type, classfield.displayName)] =
              constantValue!.getField(classfield.displayName)!.toStringValue();
        }
      }
    }
    //Adding the field to the table object.
    tableData.fields.add(field);
    return super.visitFieldElement(element);
  }
}
