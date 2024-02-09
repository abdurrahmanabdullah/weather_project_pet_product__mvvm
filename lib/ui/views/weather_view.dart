import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/models/weather_model.dart';
import 'package:weather_project_mvvm/core/view_models/weather_view_model.dart';
import 'package:weather_project_mvvm/ui/views/base_view.dart';
import 'package:weather_project_mvvm/ui/views/weather_view_extention.dart';

class WeatherData extends StatefulWidget {
  const WeatherData({super.key});

  @override
  State<WeatherData> createState() => _WeatherDataState();
}

class _WeatherDataState extends State<WeatherData> {
  List<WeatherModel> weather = [];
  @override
  Widget build(BuildContext context) {
    return BaseView<WeatherViewModel>(
      onModelReady: (model) async {
        await model.getCurrentWeather();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Weather App",
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    weather = model.temperature! as List<WeatherModel>;
                  });
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: SafeArea(
          child: Center(
              child: model.state == ViewState.idle
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: WeatherViewExtention(
                              icon: model.temperature!.list![0].main!
                                          .humidity! >
                                      50
                                  ? Icons
                                      .wb_sunny // Use a sunny icon if humidity is high
                                  : Icons.cloud,
                              label: '',
                              value: '',
                              // Use a cloud icon if humidity is low
                            ),
                          ),
                        ),
                        const Text(
                          'Hourly Forecast',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        // ListView.builder(
                        //     itemCount: 30,
                        //     itemBuilder: (context, index) {
                        //       return Card(
                        //         // elevation: 6,
                        //         child: Container(
                        //           width: 100,
                        //           padding: const EdgeInsets.all(8.0),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(18)),
                        //           child: Column(
                        //             children: [],
                        //           ),
                        //         ),
                        //       );
                        //     })
                      ],
                    )
                  : const CircularProgressIndicator()),
        ),
      ),
    );
  }
}

/*
Row(
children: [
WeatherViewExtention(
icon: model.temperature!.list![index].main!
    .humidity! >
50
? Icons
    .wb_sunny // Use a sunny icon if humidity is high
    : Icons
    .cloud, // Use a cloud icon if humidity is low
label: '',
value: '',
)
],
)

 */
