import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:db_query_generator/src/utility.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:db_annotations/db_annotations.dart';
import 'package:logging/logging.dart';

var _log = Logger('metadata');

class DBQueryGenerator extends GeneratorForAnnotation<Table> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var buffer = StringBuffer();
    var visitor = ChildrenVisitor();

    element.visitChildren(visitor);
    buffer.writeln('classname : ${element.displayName};');
    if (annotation.instanceOf(TypeChecker.fromRuntime(Table))) {
      buffer.writeln('class Annotation Type : Table');
      buffer.writeln(
          'field tableName value : ${annotation.peek('tableName')!.stringValue}');
    }
    for (var field in visitor.fields.keys) {
      buffer.writeln('${visitor.fields[field]} $field;');
    }
    for (var field in visitor.metaData.keys) {
      buffer.writeln('$field = ${visitor.metaData[field]};');
    }
    return "/*\n" + buffer.toString() + "*/";
  }
}

class ChildrenVisitor extends SimpleElementVisitor {
  late DartType className;
  DartType? annotationType;
  Map<String, DartType> fields = {};
  Map<HelperClassDefination, dynamic> metaData = {};

  @override
  visitConstructorElement(ConstructorElement element) {
    // ignore: unnecessary_null_comparison
    assert(className == null);
    //gets the class name on which the top-level annotation is applied.
    className = element.type.returnType;
    return super.visitConstructorElement(element);
  }
//TODO: Map annotations to the proper fields of the class.

  //visits all the elements one by one.
  @override
  visitFieldElement(FieldElement element) {
    //adds the field names and its type of the top-level class.
    fields[element.name] = element.type;
    //Loops through the metadata of the top-level class.
    // Check for any annotations applied.
    for (var meta in element.metadata) {
      //Gets the constant value. It is used to find the values
      // inside the constructor.
      final constantValue = meta.computeConstantValue();
      //Class by source gen package. Used to find the passed values inside the top
      // level constructor.
      // All annotatiosn for the field are extends [Column]
      //which has 2 properties columnName and postgresType.
      final annotation = ConstantReader(constantValue);
      //Setting the value for the ColumnName if exists else null.
      //It can never be null but just to be sure null value is checked.
      if (annotation.peek('coulmnName') != null)
        metaData[HelperClassDefination(String, 'coulmnName')] =
            annotation.peek('coulmnName')!.stringValue;
      else
        metaData[HelperClassDefination(String, 'coulmnName')] = null;
      //Setting the value for the ColumnName if exists else null.
      if (annotation.peek('postgresType') != null)
        metaData[HelperClassDefination(String, 'postgresType')] =
            annotation.peek('postgresType')!.stringValue;
      else
        metaData[HelperClassDefination(String, 'postgresType')] = null;
      //Now it sets the fields value for the annotation class.

      if (meta.element != null) {
        //Type cast the anotted element as constructor elements
        //To extract data.
        final constructorElement = (meta.element as ConstructorElement);
        //Annotation type for the field is set here.
        annotationType = constructorElement.type.returnType;
        //Return the FieldElement for the Annotated Class.
        final classFields = constructorElement.enclosingElement.fields;

        //Loop through them and sets each field.
        for (var field in classFields) {
          metaData[HelperClassDefination(field.type, field.displayName)] =
              constantValue!.getField(field.displayName)!.toStringValue();
        }
      }
    }
    _log.info(fields);
    _log.info(annotationType);
    _log.info(metaData);
    return super.visitFieldElement(element);
  }
}
