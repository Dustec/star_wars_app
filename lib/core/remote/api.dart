import 'package:star_wars_app/core/domain/managers/http_manager.dart';
import 'package:star_wars_app/di/injector.dart';

mixin Api {
  HttpManager get http => injector.get();
  String get baseUrl => 'https://swapi.dev/api/';
}
