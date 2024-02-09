import 'dart:convert';

import 'package:weather_project_mvvm/core/models/product_model.dart';
import 'package:http/http.dart' as http;

class productApi {
  Future<List<ProductModel>> getproductData() async {
    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    List<ProductModel> product = jsonDecode(response.body);
    print(response.statusCode);
    return product;
  }
}