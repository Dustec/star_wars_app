abstract class UserFavSource {
  List<String> getFavorites();
  void saveFavorite(String url);
  void removeFavorite(String url);
}
