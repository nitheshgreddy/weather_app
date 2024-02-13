import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/widgets/add_city.dart';
import 'package:weather_app/widgets/city_card.dart';
import 'package:weatherapi/weatherapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherRequest _wr = WeatherRequest(weatherApiKey);
  final List<ForecastWeather> _forecastOfCities = [];
  var _isLoading = true;
  @override
  void initState() {
    super.initState();
    // Load Toronto by default.
    _loadWeather('Toronto');
  }

  void _loadWeather(String city) {
    _wr.getForecastWeatherByCityName(city).then((forecastWeather) {
      setState(() {
        _forecastOfCities.add(forecastWeather);
        _isLoading = false;
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input - $city'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    });
  }

  void _openAddCityOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddCity(
        onAddCity: _addCity,
      ),
    );
  }

  void _addCity(String city) {
    _loadWeather(city);
  }

  void _removeCity(ForecastWeather cityWeather) {
    setState(() {
      _forecastOfCities.remove(cityWeather);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('City Removed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No cities added yet'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_forecastOfCities.isNotEmpty) {
      content = ListView.builder(
        itemCount: _forecastOfCities.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeCity(_forecastOfCities[index]);
          },
          key: ValueKey(_forecastOfCities[index].location.name),
          child: CityCard(
            cityForecast: _forecastOfCities[index],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App - Home'),
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddCityOverlay,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
