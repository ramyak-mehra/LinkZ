// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// DBQueryGenerator
// **************************************************************************

class $Linkz {
  static Future<int> insertLinkz(
    PostgreSQLExecutionContext execContext, {
    required String id,
    required String account,
    required String title,
    required String url,
    required int index,
    required bool turned_on,
    required String? emoji,
    required int clicks,
  }) async {
    final result = await execContext.execute(
        'INSERT INTO links(id , account , title , url , index , turned_on , emoji , clicks , ) VALUES( @id, @account, @title, @url, @index, @turned_on, @emoji, @clicks)',
        substitutionValues: {
          'id': id,
          'account': account,
          'title': title,
          'url': url,
          'index': index,
          'turned_on': turned_on,
          'emoji': emoji,
          'clicks': clicks,
        });
    assert(result == 1);
    return result;
  }

  static Future<Linkz> getLinkzByPk(PostgreSQLExecutionContext execContext,
      {required String id}) async {
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result.length == 1);
    final map = result.first['links'];
    return Linkz.fromMap(map!);
  }

  static Future<List<Linkz>> getAllLinkzs(
      PostgreSQLExecutionContext execContext) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery('SELECT * FROM links;');
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<List<Linkz>> getLinkzByAccount(
      PostgreSQLExecutionContext execContext,
      {required String account}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE account = @account;',
        substitutionValues: {'account': account});
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<List<Linkz>> getLinkzByTitle(
      PostgreSQLExecutionContext execContext,
      {required String title}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE title = @title;',
        substitutionValues: {'title': title});
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<List<Linkz>> getLinkzByUrl(
      PostgreSQLExecutionContext execContext,
      {required String url}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE url = @url;',
        substitutionValues: {'url': url});
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<List<Linkz>> getLinkzByIndex(
      PostgreSQLExecutionContext execContext,
      {required int index}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE index = @index;',
        substitutionValues: {'index': index});
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<List<Linkz>> getLinkzByTurned_on(
      PostgreSQLExecutionContext execContext,
      {required bool turned_on}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE turned_on = @turned_on;',
        substitutionValues: {'turned_on': turned_on});
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<List<Linkz>> getLinkzByEmoji(
      PostgreSQLExecutionContext execContext,
      {required String? emoji}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE emoji = @emoji;',
        substitutionValues: {'emoji': emoji});
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<List<Linkz>> getLinkzByClicks(
      PostgreSQLExecutionContext execContext,
      {required int clicks}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE clicks = @clicks;',
        substitutionValues: {'clicks': clicks});
    for (var linkz in result) {
      final map = linkz['links'];
      linkzs.add(Linkz.fromMap(map!));
    }
    return linkzs;
  }

  static Future<int> updateLinkzId(PostgreSQLExecutionContext execContext,
      {required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET id = @id WHERE id = @id;',
        substitutionValues: {'id': id, 'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzAccount(PostgreSQLExecutionContext execContext,
      {required String account, required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET account = @account WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzTitle(PostgreSQLExecutionContext execContext,
      {required String title, required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET title = @title WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzUrl(PostgreSQLExecutionContext execContext,
      {required String url, required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET url = @url WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzIndex(PostgreSQLExecutionContext execContext,
      {required int index, required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET index = @index WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzTurned_on(
      PostgreSQLExecutionContext execContext,
      {required bool turned_on,
      required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET turned_on = @turned_on WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzEmoji(PostgreSQLExecutionContext execContext,
      {required String? emoji, required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET emoji = @emoji WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzClicks(PostgreSQLExecutionContext execContext,
      {required int clicks, required String id}) async {
    final result = await execContext.execute(
        'UPDATE links SET clicks = @clicks WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }

  static Future<int> deleteLinkzByPk(PostgreSQLExecutionContext execContext,
      {required String id}) async {
    final result = await execContext.execute(
        'DELETE FROM links WHERE id = @id;',
        substitutionValues: {'id': id});
    assert(result == 1);
    return result;
  }
}
