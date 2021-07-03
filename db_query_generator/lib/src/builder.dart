import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:db_query_generator/db_query_generator.dart';

Builder dbQueryGenerator(BuilderOptions options) =>
    SharedPartBuilder([DBQueryGenerator()], 'db_query_generator');
