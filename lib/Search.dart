import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Weather? weather;
  final openweather = WeatherFactory('167b417f461e79f1ee656aacab5ff551');
  String cityname = '';

  getweather() async {
    try {
      weather = await openweather.currentWeatherByCityName(cityname);
      setState(() {});
    } catch (e) {
      print('the error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: const Text('Search by city name'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(22.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  cityname = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'Seach by City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        getweather();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.cyan,
                      ))),
            ),
          ),
          Expanded(
              child: weather != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${weather!.temperature!.celsius!.round()} °C',
                          style: TextStyle(fontSize: 55.0),
                        ),
                        Text(
                          '${weather!.weatherDescription}',
                          style: TextStyle(fontSize: 25),
                        )
                      ],
                    )
                  : const SizedBox())
        ],
      ),
    );
  }
}
