// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy.dart';

// **************************************************************************
// DBQueryGenerator
// **************************************************************************

class $DummyModel {
  static Future<DummyModel> getDummyModelByPk(
      PostgreSQLExecutionContext execContext,
      {required String username}) async {
    final result = await execContext.mappedResultsQuery(
        'SELECT * from dummy_table WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result.length == 1);
    final map = result.first['dummy_table'];
    return DummyModel.fromMap(map!);
  }

  static Future<List<DummyModel>> getAllDummyModels(
      PostgreSQLExecutionContext execContext) async {
    final dummymodels = <DummyModel>[];
    final result =
        await execContext.mappedResultsQuery('SELECT * from dummy_table;');
    for (var dummymodel in result) {
      final map = dummymodel['dummy_table'];
      dummymodels.add(DummyModel.fromMap(map!));
    }
    return dummymodels;
  }

  static Future<List<DummyModel>> getDummyModelById(
      PostgreSQLExecutionContext execContext,
      {required int id}) async {
    final dummymodels = <DummyModel>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * from dummy_table WHERE id = @id;',
        substitutionValues: {'id': id});
    for (var dummymodel in result) {
      final map = dummymodel['dummy_table'];
      dummymodels.add(DummyModel.fromMap(map!));
    }
    return dummymodels;
  }
}
