import 'package:http/http.dart' as http;
import 'package:weather_project_mvvm/core/models/pet_model.dart';

class petAPI {
  var apiurl = 'https://jatinderji.github.io/users_pets_api/users_pets.json';
  Future<PetModel> getPetData() async {
    http.Response response;
    response = await http.get(Uri.parse(apiurl));
    PetModel petModel = petModelFromJson(response.body);
    print(response.statusCode);
    print(response.body);
    return petModel;
  }
}