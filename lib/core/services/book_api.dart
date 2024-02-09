import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_project_mvvm/core/models/book_model.dart';

class BookApi {
  ///model should have .fromjson  formate ////BookModel.fromJson(Map<String, dynamic> json) {
  Future<BookModel> bookapi() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.hidayahbooks.hidayahsmart.solutions/v1/user/book/all/no'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      BookModel bookmodel = BookModel.fromJson(responseData);
      // List<Premium?> premiumBooks = bookmodel.output!
      //     .where((output) => output?.premium != null)
      //     .map((output) => output?.premium)
      //     .toList();

      //print(premiumBooks[1]!.imageNameF);
      return bookmodel;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }
}
