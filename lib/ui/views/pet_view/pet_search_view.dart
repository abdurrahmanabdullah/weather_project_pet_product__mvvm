import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/core/models/pet_model.dart';
import 'package:weather_project_mvvm/core/view_models/pet_view_model.dart';
import 'package:weather_project_mvvm/ui/route_navigation.dart';
import 'package:weather_project_mvvm/ui/views/base_view.dart';

class MySearchDelegate extends SearchDelegate<void> {
  PetModel petModel;

  MySearchDelegate({required this.petModel});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList =
        petModel.data?.map((item) => item.userName ?? '').toList() ?? [];
    List<bool>? friendly =
        petModel.data?.map((ite) => ite.isFriendly ?? false).toList();

    List<String> searchResult = suggestionList
        .where((suggestion) =>
            suggestion.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return BaseView<PetViwModel>(
      onModelReady: (model) {
        model.getpetapiData();
      },
      builder: (context, model, child) {
        return ListView.builder(
          itemCount: searchResult.length,
          itemBuilder: (context, index) {
            int originalText = petModel.data!
                .indexWhere((item) => item.userName == searchResult[index]);
            return ListTile(
              leading: CircleAvatar(
                radius: 22,
                child:
                    // Image.network('${model.petModel!.data![index].petImage}'),
                    Image.network(
                        '${model.petModel!.data![originalText].petImage}' ??
                            ''),
              ),
              title: InkWell(
                child: Text(
                    '${model.petModel!.data![originalText].userName}' ?? ' '),
                onTap: () {
                  ///can pass data in single  field
                  final selectedName =
                      model.petModel!.data![originalText].userName;

                  /// many data  pass by  class
                  final selectedPet = model.petModel!.data![originalText];
                  final arguments = PetDetailsArguments(
                    userName: selectedPet.userName ?? '',
                    petName: selectedPet.petName ?? '',
                    petImage: selectedPet.petImage ?? '',
                  );

                  Navigator.pushNamed(context, RouteNavigation.detailsPet,
                      arguments: arguments

                      /// for single data pass
                      //arguments: model.petModel!.data![index].userName,
                      );
                },
              ),
              trailing: Icon(
                friendly![originalText] ? Icons.pets : null,
                color: friendly[originalText] ? Colors.red : null,
              ),
            );
          },
        );
      },
    );
  }
}

class PetDetailsArguments {
  final String userName;
  final String petName;
  final String petImage;

  PetDetailsArguments({
    required this.userName,
    required this.petName,
    required this.petImage,
  });
}
