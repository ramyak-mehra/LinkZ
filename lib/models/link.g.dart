// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// DBQueryGenerator
// **************************************************************************

class $Linkz {
  static Future<int> insertLinkz(
    PostgreSQLExecutionContext execContext, {
    required String account,
    required String title,
    required String url,
    required int index,
    required bool turnedOn,
    required String? emoji,
    required int clicks,
  }) async {
    final result = await execContext.execute(
        'INSERT INTO links(account , title , url , index , turnedOn , emoji , clicks , ) VALUES( @account, @title, @url, @index, @turnedOn, @emoji, @clicks)',
        substitutionValues: {
          'account': account,
          'title': title,
          'url': url,
          'index': index,
          'turnedOn': turnedOn,
          'emoji': emoji,
          'clicks': clicks,
        });
    assert(result == 1);
    return result;
  }

  static Future<Linkz> getLinkzByPk(PostgreSQLExecutionContext execContext,
      {required String url}) async {
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE url = @url;',
        substitutionValues: {'url': url});
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

  static Future<List<Linkz>> getLinkzByTurnedon(
      PostgreSQLExecutionContext execContext,
      {required bool turnedOn}) async {
    final linkzs = <Linkz>[];
    final result = await execContext.mappedResultsQuery(
        'SELECT * FROM links WHERE turnedOn = @turnedOn;',
        substitutionValues: {'turnedOn': turnedOn});
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

  static Future<int> updateLinkzAccount(PostgreSQLExecutionContext execContext,
      {required String account, required String url}) async {
    final result = await execContext.execute(
        'UPDATE links SET account = @account WHERE url = @url;',
        substitutionValues: {'url': url});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzTitle(PostgreSQLExecutionContext execContext,
      {required String title, required String url}) async {
    final result = await execContext.execute(
        'UPDATE links SET title = @title WHERE url = @url;',
        substitutionValues: {'url': url});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzUrl(PostgreSQLExecutionContext execContext,
      {required String url}) async {
    final result = await execContext.execute(
        'UPDATE links SET url = @url WHERE url = @url;',
        substitutionValues: {'url': url, 'url': url});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzIndex(PostgreSQLExecutionContext execContext,
      {required int index, required String url}) async {
    final result = await execContext.execute(
        'UPDATE links SET index = @index WHERE url = @url;',
        substitutionValues: {'url': url});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzTurnedon(PostgreSQLExecutionContext execContext,
      {required bool turnedOn, required String url}) async {
    final result = await execContext.execute(
        'UPDATE links SET turnedOn = @turnedOn WHERE url = @url;',
        substitutionValues: {'url': url});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzEmoji(PostgreSQLExecutionContext execContext,
      {required String? emoji, required String url}) async {
    final result = await execContext.execute(
        'UPDATE links SET emoji = @emoji WHERE url = @url;',
        substitutionValues: {'url': url});
    assert(result == 1);
    return result;
  }

  static Future<int> updateLinkzClicks(PostgreSQLExecutionContext execContext,
      {required int clicks, required String url}) async {
    final result = await execContext.execute(
        'UPDATE links SET clicks = @clicks WHERE url = @url;',
        substitutionValues: {'url': url});
    assert(result == 1);
    return result;
  }

  static Future<int> deleteLinkzByPk(PostgreSQLExecutionContext execContext,
      {required String url}) async {
    final result = await execContext.execute(
        'DELETE FROM links WHERE url = @url;',
        substitutionValues: {'url': url});
    assert(result == 1);
    return result;
  }
}
