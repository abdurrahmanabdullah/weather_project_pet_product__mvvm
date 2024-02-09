import 'package:http/http.dart' as http;
import 'package:weather_project_mvvm/core/models/weather_model.dart';

class WeatherApi {
  final weatherapi =
      "https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=90467acdf89d1cc5bcd32064be0800c3";

  Future<WeatherModel?> getCurrentWeather() async {
    try {
      http.Response response = await http.get(Uri.parse(weatherapi));

      WeatherModel weather = weatherModelFromJson(response.body);

      print(response.statusCode);
      // print(response.body);

      return weather;
    } catch (e) {
      print('---------------------');
      print(e);
      print('---------------------');
    }
  }
}
