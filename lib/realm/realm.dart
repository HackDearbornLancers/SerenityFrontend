import 'package:realm/realm.dart';
import 'package:serenity/realm/entry.dart';

final config = Configuration.local([Entry.schema]);

final realm = Realm(config);
void deleteRealmDatabase() async {
  final config = Configuration.local(
    [Entry.schema],
  );

  try {

    // Use the `deleteRealm` method to delete the entire Realm.
    Realm.deleteRealm(config.path);

    print('Realm database deleted successfully');
  } catch (e) {
    print('Error deleting Realm database: $e');
  }
}
