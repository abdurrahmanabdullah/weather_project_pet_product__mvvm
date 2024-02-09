import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/core/models/pet_model.dart';
import 'package:weather_project_mvvm/core/services/pet_api.dart';
import 'package:weather_project_mvvm/ui/views/pet_view/pet_search_view.dart';

class PetView extends StatefulWidget {
  const PetView({Key? key}) : super(key: key);

  @override
  _PetViewState createState() => _PetViewState();
}

class _PetViewState extends State<PetView> {
  PetModel? petModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    petModel = await petAPI().getPetData(); // Use your pet API service
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '!Click Search Icon To Find  which is friendly of Not!!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(petModel: petModel!),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
