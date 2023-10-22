import 'package:realm/realm.dart';
part 'entry.g.dart';

@RealmModel()
class _Entry {
  @PrimaryKey()
  late final String name;
  late final DateTime date;
  late String content;
  late String location;
  late double sentiment;
}
