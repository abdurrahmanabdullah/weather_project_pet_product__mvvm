import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/models/pet_model.dart';
import 'package:weather_project_mvvm/core/services/pet_api.dart';
import 'package:weather_project_mvvm/core/view_models/base_view_model.dart';
import 'package:weather_project_mvvm/locator.dart';

class PetViwModel extends BaseViewModel {
  final petAPI _petAPi = locator<petAPI>();
  PetModel? petModel;

  Future<void> getpetapiData() async {
    setViewState(ViewState.busy);
    petModel = await _petAPi.getPetData();
    setViewState(ViewState.idle);
  }
}
