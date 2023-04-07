import 'package:hive/hive.dart';
import 'package:star_wars_app/features/user_favorites/db/constants/db_constants.dart';
import 'package:star_wars_app/features/user_favorites/db/db.dart';
import 'adapters/user_favs_db.dart';
import '../domain/sources/user_favs_source.dart';

class UserFavDbSource implements UserFavSource {
  UserFavDbSource() {
    _dbBox = Db.instance.getDb<UserFav>(DbBoxes.userFavs);
    final List<String> savedFavs =
        _dbBox.values.map((e) => e.url ?? '').toList();
    _favsList.addAll(savedFavs);
  }

  late Box<UserFav> _dbBox;
  final List<String> _favsList = List.empty(growable: true);

  @override
  List<String> getFavorites() {
    return [..._favsList];
  }

  @override
  void removeFavorite(String url) {
    _dbBox.delete(url);
    _favsList.remove(url);
  }

  @override
  void saveFavorite(String url) {
    _dbBox.put(url, UserFav(url: url));
    _favsList.add(url);
  }
}
