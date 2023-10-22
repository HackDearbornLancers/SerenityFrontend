import 'package:realm/realm.dart';
part 'entry.g.dart';

@RealmModel()
class _Entry {
  @PrimaryKey()
  late final String name;
  late final DateTime date;
  late List<_Message> content;
  late String location;
  late double sentiment;
}

//0 = User, 1 = AI
@RealmModel()
class _Message {
  @PrimaryKey()
  late int id;
  late String content;
  late int speaker;
}
