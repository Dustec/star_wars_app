import 'package:hive/hive.dart';

import '../constants/db_constants.dart';

part 'user_favs_db.g.dart';

@HiveType(typeId: DbTypes.userFavs)
class UserFav extends HiveObject {
  UserFav({
    required this.url,
  });

  @HiveField(1)
  String? url;
}
