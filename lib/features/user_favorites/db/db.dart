import 'package:hive/hive.dart';

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
    isInitialized = true;
  }

  Future<Box<T>> openDb<T>(String boxName) {
    return Hive.openBox(boxName);
  }

  Box<T> getDb<T>(String boxName) {
    return Hive.box(boxName);
  }
}
