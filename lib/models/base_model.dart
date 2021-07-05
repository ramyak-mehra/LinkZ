///Add common functionality like [id] ,
///[createdAt] , [_updatedAt] to all the models.
abstract class BaseModel {
  BaseModel(
    String id,
    DateTime createdAt,
    DateTime updatedAt,
  )   : _id = id,
        _createdAt = createdAt,
        _updatedAt = updatedAt;
  final String _id;
  final DateTime _createdAt;
  DateTime _updatedAt;

  String get id => _id;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  DateTime set(DateTime updatedAt) => _updatedAt = updatedAt;
}
