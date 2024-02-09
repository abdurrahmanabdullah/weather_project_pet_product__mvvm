import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/view_models/product_view_model.dart';
import 'package:weather_project_mvvm/ui/views/base_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<productViewModel>(
      onModelReady: (model) => model.getProduct(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Product data"),
        ),
        body: Center(
          child: model.state == ViewState.idle
              ? ListView.builder(
                  itemCount: model.product.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Text('${model.product[index].title.toString()} }'),
                    ],
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
