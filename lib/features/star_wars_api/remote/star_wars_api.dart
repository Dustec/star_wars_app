import '../../../core/domain/managers/http_manager.dart';
import '../../../di/injector.dart';

mixin StarWarsApi {
  HttpManager get http => injector.get();
  String get baseUrl => 'https://swapi.dev/api/';
  String endpointParse(String endpoint) =>
      Uri.parse('$baseUrl$endpoint').toString();
}
