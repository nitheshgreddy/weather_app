import 'package:flutter/material.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key, required this.onAddCity});
  final void Function(String city) onAddCity;

  @override
  State<AddCity> createState() {
    return _AddCityState();
  }
}

class _AddCityState extends State<AddCity> {
  final _cityNameController = TextEditingController();

  @override
  void dispose() {
    _cityNameController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please center a city name.'),
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
  }

  void _addCity() {
    final cityName = _cityNameController.text.trim();
    if (cityName.isEmpty) {
      _showDialog();
      return;
    }

    widget.onAddCity(cityName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              maxLength: 20,
              controller: _cityNameController,
              decoration: const InputDecoration(
                label: Text('Enter City Name'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: _addCity,
                  child: const Text('Add City'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
