// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy.dart';

// **************************************************************************
// DBQueryGenerator
// **************************************************************************

class $DummyModel {
  static Future<int> insertDummyModel(
    PostgreSQLExecutionContext execContext, {
    required String username,
    required int id,
  }) async {
    final result = await execContext.execute(
        'INSERT INTO dummy_table(username , id , ) VALUES( @username @id)',
        substitutionValues: {
          'username': username,
          'id': id,
        });
    assert(result == 1);
    return result;
  }

  static Future<DummyModel> getDummyModelByPk(
      PostgreSQLExecutionContext execContext,
      {required String username}) async {
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM dummy_table WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result.length == 1);
    final map = result.first['dummy_table'];
    return DummyModel.fromMap(map!);
  }

  static Future<List<DummyModel>> getAllDummyModels(
      PostgreSQLExecutionContext execContext) async {
    final dummymodels = <DummyModel>[];
    final result =
        await execContext.mappedResultsQuery('SELECT * FROM dummy_table;');
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
        'SELECT * FROM dummy_table WHERE id = @id;',
        substitutionValues: {'id': id});
    for (var dummymodel in result) {
      final map = dummymodel['dummy_table'];
      dummymodels.add(DummyModel.fromMap(map!));
    }
    return dummymodels;
  }

  static updateDummyModelUsername(PostgreSQLExecutionContext execContext,
      {required String username}) async {
    final result = await execContext.execute(
        'UPDATE dummy_table SET username = @username WHERE username = @username;',
        substitutionValues: {'username': username, 'username': username});
    assert(result == 1);
  }

  static updateDummyModelId(PostgreSQLExecutionContext execContext,
      {required int id, required String username}) async {
    final result = await execContext.execute(
        'UPDATE dummy_table SET id = @id WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result == 1);
  }

  static Future<void> deleteDummyModelByPk(
      PostgreSQLExecutionContext execContext,
      {required String username}) async {
    final result = await execContext.execute(
        'DELETE FROM dummy_table WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result == 1);
  }
}
