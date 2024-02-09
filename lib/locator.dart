import 'package:get_it/get_it.dart';
import 'package:weather_project_mvvm/core/services/authentication_api.dart';
import 'package:weather_project_mvvm/core/view_models/book_view_model.dart';

import 'core/services/book_api.dart';
import 'core/services/pet_api.dart';
import 'core/services/weather_api.dart';
import 'core/view_models/base_view_model.dart';
import 'core/view_models/pet_view_model.dart';
import 'core/view_models/sign_in_view_model.dart';
import 'core/view_models/weather_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => BaseViewModel());
  locator.registerFactory(() => WeatherViewModel());
  locator.registerFactory(() => PetViwModel());
  locator.registerFactory(() => BookViewModel());
  locator.registerFactory(() => SignInViewModel());
  locator.registerLazySingleton(() => AuthenticationAPI());
  locator.registerLazySingleton(() => WeatherApi());
  locator.registerLazySingleton(() => petAPI());
  locator.registerLazySingleton(() => BookApi());
}