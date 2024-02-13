import 'package:flutter/material.dart';
import 'package:weather_app/widgets/details_page.dart';
import 'package:weatherapi/weatherapi.dart';

class CityCard extends StatelessWidget {
  const CityCard({super.key, required this.cityForecast});

  final ForecastWeather cityForecast;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DetailsPage(cityForecast.location.name!)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Text(cityForecast.location.name!),
              const Spacer(),
              Text(
                  '${cityForecast.forecast[0].day.mintempC.toString()}/${cityForecast.forecast[0].day.maxtempC.toString()} C'),
            ],
          ),
        ),
      ),
    );
  }
}
