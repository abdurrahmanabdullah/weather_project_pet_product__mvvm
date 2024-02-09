import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/ui/views/To_Do_App/home.dart';
import 'package:weather_project_mvvm/ui/views/book_view/book_view.dart';
import 'package:weather_project_mvvm/ui/views/list_search_view.dart';
import 'package:weather_project_mvvm/ui/views/pet_view/pet_details_view.dart';
import 'package:weather_project_mvvm/ui/views/pet_view/pet_search_view.dart';
import 'package:weather_project_mvvm/ui/views/pet_view/pet_view.dart';
import 'package:weather_project_mvvm/ui/views/product_view.dart';
import 'package:weather_project_mvvm/ui/views/sign_in_view.dart';
import 'package:weather_project_mvvm/ui/views/weather_view.dart';

class RouteNavigation {
  static const String signIn = 'signIn';
  static const String petApi = 'petApi';
  static const String weatherData = 'weatherData';
  static const String listSearch = 'listSearch';

  static const String detailsPet = 'detailsPet';
  static const String book = 'book';
  static const String bookExtension = 'bookExtension';
  static const String todo = 'todo';
  static const String product = 'product';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case petApi:
        return MaterialPageRoute(builder: (context) => const PetView());

      case weatherData:
        return MaterialPageRoute(builder: (context) => const WeatherData());
      case listSearch:
        return MaterialPageRoute(builder: (context) => const ListSearch());
      case signIn:
        return MaterialPageRoute(builder: (context) => const SignInView());
      case book:
        return MaterialPageRoute(builder: (context) => const BookView());
      case product:
        return MaterialPageRoute(builder: (context) => const ProductView());
      case todo:
        return MaterialPageRoute(builder: (context) => TodoApp());
      case detailsPet:
        PetDetailsArguments arguments =
            settings.arguments as PetDetailsArguments;
        return MaterialPageRoute(builder: (context) {
          ///for single dataPass
          // String userName = settings.arguments as String;

          return PetDetailsView(
            userName: arguments.userName,
            petName: arguments.petName,
            petImage: arguments.petImage,

            ///for single dataPass
            // userName: userName,
          );
        });

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
