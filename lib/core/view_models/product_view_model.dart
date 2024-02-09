import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/models/product_model.dart';
import 'package:weather_project_mvvm/core/services/product_api.dart';
import 'package:weather_project_mvvm/core/view_models/base_view_model.dart';
import 'package:weather_project_mvvm/locator.dart';

class productViewModel extends BaseViewModel {
  final productApi _productApi = locator<productApi>();
  List<ProductModel> product = [];
  Future<void> getProduct() async {
    setViewState(ViewState.busy);

    product = await _productApi.getproductData();
    setViewState(ViewState.idle);
  }
}
