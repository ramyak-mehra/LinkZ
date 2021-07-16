// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// DBQueryGenerator
// **************************************************************************

class $Account {
  static Future<int> insertAccount(
    PostgreSQLExecutionContext execContext, {
    required String id,
    required String user,
  }) async {
    final result = await execContext.execute(
        'INSERT INTO account(id , user , ) VALUES( @id, @user)',
        substitutionValues: {
          'id': id,
          'user': user,
        });
    assert(result == 1);
    return result;
  }

  static Future<Account> getAccountByPk(PostgreSQLExecutionContext execContext,
      {required String id}) async {
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM account WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result.length == 1);
    final map = result.first['account'];
    return Account.fromMap(map!);
  }

  static Future<List<Account>> getAllAccounts(
      PostgreSQLExecutionContext execContext) async {
    final accounts = <Account>[];
    final result =
        await execContext.mappedResultsQuery('SELECT * FROM account;');
    for (var account in result) {
      final map = account['account'];
      accounts.add(Account.fromMap(map!));
    }
    return accounts;
  }

  static Future<List<Account>> getAccountByUser(
      PostgreSQLExecutionContext execContext,
      {required String user}) async {
    final accounts = <Account>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM account WHERE user = @user;',
        substitutionValues: {'user': user});
    for (var account in result) {
      final map = account['account'];
      accounts.add(Account.fromMap(map!));
    }
    return accounts;
  }

  static Future<int> updateAccountId(PostgreSQLExecutionContext execContext,
      {required String id}) async {
    final result = await execContext.execute(
        'UPDATE account SET id = @id WHERE id = @id;',
        substitutionValues: {'id': id, 'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateAccountUser(PostgreSQLExecutionContext execContext,
      {required String user, required String id}) async {
    final result = await execContext.execute(
        'UPDATE account SET user = @user WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> deleteAccountByPk(PostgreSQLExecutionContext execContext,
      {required String id}) async {
    final result = await execContext.execute(
        'DELETE FROM account WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }
}
