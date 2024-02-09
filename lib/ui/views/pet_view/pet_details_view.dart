import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/core/view_models/pet_view_model.dart';

import '../base_view.dart';

class PetDetailsView extends StatelessWidget {
  final String userName;
  final String petName;
  final String petImage;
  const PetDetailsView(
      {Key? key,
      required this.userName,
      required this.petName,
      required this.petImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PetViwModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    petImage ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                petName ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(userName,
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        );
      },
    );
  }
}
