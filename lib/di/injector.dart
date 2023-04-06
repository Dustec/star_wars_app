import 'package:get_it/get_it.dart';
import 'package:star_wars_app/core/domain/managers/http_manager.dart';
import 'package:star_wars_app/integrations/http_dio_manager.dart';

final GetIt injector = GetIt.asNewInstance();

void registerDependencies() {
  injector.registerFactory<HttpManager>(() => HttpDioManager());
}
