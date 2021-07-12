// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// DBQueryGenerator
// **************************************************************************

class $User {
  static Future<int> insertUser(
    PostgreSQLExecutionContext execContext, {
    required String username,
    required String? email,
    required String id,
    required String hashed_password,
    required String salt,
  }) async {
    final result = await execContext.execute(
        'INSERT INTO users(username , email , id , hashed_password , salt , ) VALUES( @username, @email, @id, @hashed_password, @salt)',
        substitutionValues: {
          'username': username,
          'email': email,
          'id': id,
          'hashed_password': hashed_password,
          'salt': salt,
        });
    assert(result == 1);
    return result;
  }

  static Future<User> getUserByPk(PostgreSQLExecutionContext execContext,
      {required String username}) async {
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM users WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result.length == 1);
    final map = result.first['users'];
    return User.fromMap(map!);
  }

  static Future<List<User>> getAllUsers(
      PostgreSQLExecutionContext execContext) async {
    final users = <User>[];
    final result = await execContext.mappedResultsQuery('SELECT * FROM users;');
    for (var user in result) {
      final map = user['users'];
      users.add(User.fromMap(map!));
    }
    return users;
  }

  static Future<List<User>> getUserByEmail(
      PostgreSQLExecutionContext execContext,
      {required String? email}) async {
    final users = <User>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM users WHERE email = @email;',
        substitutionValues: {'email': email});
    for (var user in result) {
      final map = user['users'];
      users.add(User.fromMap(map!));
    }
    return users;
  }

  static Future<List<User>> getUserById(PostgreSQLExecutionContext execContext,
      {required String id}) async {
    final users = <User>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM users WHERE id = @id;',
        substitutionValues: {'id': id});
    for (var user in result) {
      final map = user['users'];
      users.add(User.fromMap(map!));
    }
    return users;
  }

  static Future<List<User>> getUserByHashed_password(
      PostgreSQLExecutionContext execContext,
      {required String hashed_password}) async {
    final users = <User>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM users WHERE hashed_password = @hashed_password;',
        substitutionValues: {'hashed_password': hashed_password});
    for (var user in result) {
      final map = user['users'];
      users.add(User.fromMap(map!));
    }
    return users;
  }

  static Future<List<User>> getUserBySalt(
      PostgreSQLExecutionContext execContext,
      {required String salt}) async {
    final users = <User>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM users WHERE salt = @salt;',
        substitutionValues: {'salt': salt});
    for (var user in result) {
      final map = user['users'];
      users.add(User.fromMap(map!));
    }
    return users;
  }

  static Future<int> updateUserUsername(PostgreSQLExecutionContext execContext,
      {required String username}) async {
    final result = await execContext.execute(
        'UPDATE users SET username = @username WHERE username = @username;',
        substitutionValues: {'username': username, 'username': username});
    assert(result == 1);
    return result;
  }

  static Future<int> updateUserEmail(PostgreSQLExecutionContext execContext,
      {required String? email, required String username}) async {
    final result = await execContext.execute(
        'UPDATE users SET email = @email WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result == 1);
    return result;
  }

  static Future<int> updateUserId(PostgreSQLExecutionContext execContext,
      {required String id, required String username}) async {
    final result = await execContext.execute(
        'UPDATE users SET id = @id WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result == 1);
    return result;
  }

  static Future<int> updateUserHashed_password(
      PostgreSQLExecutionContext execContext,
      {required String hashed_password,
      required String username}) async {
    final result = await execContext.execute(
        'UPDATE users SET hashed_password = @hashed_password WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result == 1);
    return result;
  }

  static Future<int> updateUserSalt(PostgreSQLExecutionContext execContext,
      {required String salt, required String username}) async {
    final result = await execContext.execute(
        'UPDATE users SET salt = @salt WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result == 1);
    return result;
  }

  static Future<int> deleteUserByPk(PostgreSQLExecutionContext execContext,
      {required String username}) async {
    final result = await execContext.execute(
        'DELETE FROM users WHERE username = @username;',
        substitutionValues: {'username': username});
    assert(result == 1);
    return result;
  }
}
