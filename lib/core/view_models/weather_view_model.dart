import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/models/weather_model.dart';
import 'package:weather_project_mvvm/core/services/weather_api.dart';
import 'package:weather_project_mvvm/core/view_models/base_view_model.dart';
import 'package:weather_project_mvvm/locator.dart';

class WeatherViewModel extends BaseViewModel {
  final WeatherApi _weatherAPI = locator<WeatherApi>();

  WeatherModel? temperature;

  Future<void> getCurrentWeather() async {
    setViewState(ViewState.busy);

    temperature = await _weatherAPI.getCurrentWeather();

    print('-----------------------------------------------');

    setViewState(ViewState.idle);
  }
}
