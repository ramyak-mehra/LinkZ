///This is the archive code.
///The code here was written when researching about source gen.
///Maybe usefull in future.
///Don't delete this

// import 'package:analyzer/dart/element/element.dart';
// import 'package:analyzer/dart/element/type.dart';
// import 'package:analyzer/dart/element/visitor.dart';
// import 'package:source_gen/source_gen.dart';
// import 'package:build/build.dart';
// import 'package:db_annotations/db_annotations.dart';
// import 'package:logging/logging.dart';

// var _log = Logger('metadata');
// var _primaryKeyChecker = TypeChecker.fromRuntime(ForiegnKey);

// class DBQueryGenerator extends GeneratorForAnnotation<Table> {
//   @override
//   String generateForAnnotatedElement(
//       Element element, ConstantReader annotation, BuildStep buildStep) {
//     var buffer = StringBuffer();
//     var visitor = ChildrenVisitor();

//     element.visitChildren(visitor);
//     buffer.writeln('classname : ${element.displayName};');
//     if (annotation.instanceOf(TypeChecker.fromRuntime(Table))) {
//       buffer.writeln('class Annotation Type : Table');
//       buffer.writeln(
//           'field tableName value : ${annotation.peek('tableName')!.stringValue}');
//     }
//     for (var field in visitor.fields.keys) {
//       buffer.writeln('${visitor.fields[field]} $field;');
//     }
//     for (var field in visitor.metaData.keys) {
//       buffer.writeln('metadata : ${visitor.metaData[field]};');
//     }

//     return "/*\n" + buffer.toString() + "*/";
//   }
// }

// class ChildrenVisitor extends SimpleElementVisitor {
//   late DartType className;
//   DartType? annotationType;
//   Map<String, DartType> fields = {};
//   Map<String, dynamic> metaData = {};

//   @override
//   visitConstructorElement(ConstructorElement element) {
//     // ignore: unnecessary_null_comparison
//     assert(className == null);
//     className = element.type.returnType;
//     return super.visitConstructorElement(element);
//   }

//   @override
//   visitFieldElement(FieldElement element) {
//     fields[element.name] = element.type;
//     for (var meta in element.metadata) {
//       var childrenVisitor = ChildrenVisitor();
//       final constantValue = meta.computeConstantValue();
//       final annotation = ConstantReader(constantValue);
//       if (annotation.peek('coulmnName') != null)
//         metaData['columnName'] = annotation.peek('coulmnName')!.stringValue;
//       else
//         metaData['columnName'] = null;
//       if (annotation.peek('postgresType') != null)
//         metaData['postgresType'] = annotation.peek('postgresType')!.stringValue;
//       else
//         metaData['columnName'] = null;
//       if (meta.element != null) {
//         final classFields =
//             (meta.element as ConstructorElement).enclosingElement.fields;
//         meta.element!.visitChildren(childrenVisitor);
//         annotationType = (meta.element as ConstructorElement).type.returnType;
//         //meta.element!.visitChildren(childrenVisitor);

//         for (var field in classFields) {
//           _log.info(field.displayName);
//           field.displayName;
//           metaData[field.displayName] =
//               constantValue!.getField(field.displayName);
//         }
//       }
//     }
//     _log.warning(metaData);
    // metaData[element.name] = '';

    // _log.warning(
    //     element.metadata.first.computeConstantValue()!.getField('columnName'));
    // _log.warning(element.metadata.first.computeConstantValue());
    // _log.warning(element.metadata.first.computeConstantValue()!.isNull);

    // _log.warning(element.metadata.first.element.);
    // for (var f in element.metadata) {
    //   _log.warning(f.);
    //   var c = f.computeConstantValue();
    //   var childrenVisitor = ChildrenVisitor();
    //      _log.warning(c.displayName);
    //   _log.warning(ConstantReader(c).read('coulmnName').stringValue);

    //   var con = f.element as ConstructorElement;
    //   _log.warning(con.enclosingElement.supertype!.element);
    //   con.enclosingElement.supertype!.element.visitChildren(childrenVisitor);
    //   for (var field in childrenVisitor.fields.keys) {
    //     if (ConstantReader(c).instanceOf(_primaryKeyChecker)) {
    //       _log.severe('primary checker');
    //     }
    //     //_log.shout(ConstantReader(c).);
    //     _log.shout('${childrenVisitor.fields[field]} $field;');
    //     _log.shout(ConstantReader(c).read(field).stringValue);
    //   }
    //   childrenVisitor.fields;
    //   _log.warning(f
    //       .computeConstantValue()!
    //       .getField('referencedTable')!
    //       .toStringValue());
    //   _log.warning(f.computeConstantValue()!.getField('coulmnName'));
    // }
//     return super.visitFieldElement(element);
//   }
// }
    // metaData[element.name] = '';

    // _log.warning(
    //     element.metadata.first.computeConstantValue()!.getField('columnName'));
    // _log.warning(element.metadata.first.computeConstantValue());
    // _log.warning(element.metadata.first.computeConstantValue()!.isNull);

    // _log.warning(element.metadata.first.element.);
    // for (var f in element.metadata) {
    //   _log.warning(f.);
    //   var c = f.computeConstantValue();
    //   var childrenVisitor = ChildrenVisitor();
    //      _log.warning(c.displayName);
    //   _log.warning(ConstantReader(c).read('coulmnName').stringValue);

    //   var con = f.element as ConstructorElement;
    //   _log.warning(con.enclosingElement.supertype!.element);
    //   con.enclosingElement.supertype!.element.visitChildren(childrenVisitor);
    //   for (var field in childrenVisitor.fields.keys) {
    //     if (ConstantReader(c).instanceOf(_primaryKeyChecker)) {
    //       _log.severe('primary checker');
    //     }
    //     //_log.shout(ConstantReader(c).);
    //     _log.shout('${childrenVisitor.fields[field]} $field;');
    //     _log.shout(ConstantReader(c).read(field).stringValue);
    //   }
    //   childrenVisitor.fields;
    //   _log.warning(f
    //       .computeConstantValue()!
    //       .getField('referencedTable')!
    //       .toStringValue());
    //   _log.warning(f.computeConstantValue()!.getField('coulmnName'));
    // }