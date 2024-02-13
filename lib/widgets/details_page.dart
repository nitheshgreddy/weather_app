import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants.dart';
import 'package:weatherapi/weatherapi.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(this.cityName, {super.key});

  final String cityName;

  @override
  State<DetailsPage> createState() {
    return _DetailsPage();
  }
}

class _DetailsPage extends State<DetailsPage> {
  final WeatherRequest _wr = WeatherRequest(weatherApiKey);
  ForecastWeather? _sevenDayForecast;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSevenDayForecast();
  }

  void _loadSevenDayForecast() {
    _wr.getForecastWeatherByCityName('Toronto', forecastDays: 7).then((value) {
      setState(() {
        _sevenDayForecast = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather App - Details'),
        ),
        body: Center(
          child: _isLoading || _sevenDayForecast == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          style: const TextStyle(fontSize: 24),
                          widget.cityName),
                      Image.network(
                        'https:${_sevenDayForecast!.forecast[0].day.condition.icon!}',
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                      Text(style: const TextStyle(fontSize: 20),
                          '${_sevenDayForecast!.forecast[0].day.mintempC.toString()}/${_sevenDayForecast!.forecast[0].day.maxtempC.toString()} C'),
                      const SizedBox(
                        height: 10,
                      ),
                      for (final forecast in _sevenDayForecast!.forecast)
                        Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            child: Row(
                              children: [
                                Text(DateFormat.EEEE()
                                    .format(DateTime.parse(forecast.date!))),
                                const Spacer(),
                                Text(
                                    '${forecast.day.mintempC.toString()}/${forecast.day.maxtempC.toString()} C'),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
        ));
  }
}
