// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Entry extends _Entry with RealmEntity, RealmObjectBase, RealmObject {
  Entry(
    String name,
    DateTime date,
    String location,
    double sentiment, {
    Iterable<Message> content = const [],
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'location', location);
    RealmObjectBase.set(this, 'sentiment', sentiment);
    RealmObjectBase.set<RealmList<Message>>(
        this, 'content', RealmList<Message>(content));
  }

  Entry._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => throw RealmUnsupportedSetError();

  @override
  RealmList<Message> get content =>
      RealmObjectBase.get<Message>(this, 'content') as RealmList<Message>;
  @override
  set content(covariant RealmList<Message> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get location =>
      RealmObjectBase.get<String>(this, 'location') as String;
  @override
  set location(String value) => RealmObjectBase.set(this, 'location', value);

  @override
  double get sentiment =>
      RealmObjectBase.get<double>(this, 'sentiment') as double;
  @override
  set sentiment(double value) => RealmObjectBase.set(this, 'sentiment', value);

  @override
  Stream<RealmObjectChanges<Entry>> get changes =>
      RealmObjectBase.getChanges<Entry>(this);

  @override
  Entry freeze() => RealmObjectBase.freezeObject<Entry>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Entry._);
    return const SchemaObject(ObjectType.realmObject, Entry, 'Entry', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('content', RealmPropertyType.object,
          linkTarget: 'Message', collectionType: RealmCollectionType.list),
      SchemaProperty('location', RealmPropertyType.string),
      SchemaProperty('sentiment', RealmPropertyType.double),
    ]);
  }
}

class Message extends _Message with RealmEntity, RealmObjectBase, RealmObject {
  Message(
    int id,
    String content,
    int speaker,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'content', content);
    RealmObjectBase.set(this, 'speaker', speaker);
  }

  Message._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get content => RealmObjectBase.get<String>(this, 'content') as String;
  @override
  set content(String value) => RealmObjectBase.set(this, 'content', value);

  @override
  int get speaker => RealmObjectBase.get<int>(this, 'speaker') as int;
  @override
  set speaker(int value) => RealmObjectBase.set(this, 'speaker', value);

  @override
  Stream<RealmObjectChanges<Message>> get changes =>
      RealmObjectBase.getChanges<Message>(this);

  @override
  Message freeze() => RealmObjectBase.freezeObject<Message>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Message._);
    return const SchemaObject(ObjectType.realmObject, Message, 'Message', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('content', RealmPropertyType.string),
      SchemaProperty('speaker', RealmPropertyType.int),
    ]);
  }
}
