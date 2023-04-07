import 'package:hive/hive.dart';
import 'package:star_wars_app/features/user_favorites/db/constants/db_constants.dart';

import 'adapters/user_favs_db.dart';

class Db {
  Db._();

  static Db? _instance;

  static Db get instance {
    _instance ??= Db._();
    return _instance!;
  }

  bool isInitialized = false;

  Future<void> init(String path) async {
    if (isInitialized) {
      return;
    }
    Hive
      ..init(path)
      ..registerAdapter(UserFavAdapter());

    await openDb(DbBoxes.userFavs);
    isInitialized = true;
  }

  Future<Box<T>> openDb<T>(String boxName) {
    return Hive.openBox(boxName);
  }

  Box<T> getDb<T>(String boxName) {
    return Hive.box(boxName);
  }
}
