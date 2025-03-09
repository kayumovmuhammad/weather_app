import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
// import 'package:geolocator/geolocator.dart';
const String token = '2304d17f87a735eba65e0703c7e2debc';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {  
  String 
  appTitle = 'Погода', 
  inputCityText = 'Введите свою локацию(город, страна):';
  WeatherFactory wf = WeatherFactory(token, language: Language.RUSSIAN);
  double temp = 0;
  String currentCity = '';

  String getImagePath() {
    if (temp >= 0) {
      return 'assets/sun.png';
    }
    else {
      return 'assets/cloudy.png';
    }
  }

  Future<void> setData(value) async {
    Weather w;

    if (value == 'Anri meta' || value == 'anri meta') {
      showDialog(context: context, builder: (BuildContext content) {
        return AlertDialog(
          title: Text("5 Негров и Анри"),
          content: Image.asset('assets/Anri.png'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        );
      }
      );
    }
    else {
      try{
        w = await wf.currentWeatherByCityName(value);
        String stemp = w.temperature.toString();
        stemp = stemp.replaceRange(stemp.length-8, stemp.length, '');
        setState(() {
          temp = double.parse(stemp);
        });
      }
      on OpenWeatherAPIException {
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ошибка!"),
            content: Text("Неправильная локация"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SizedBox(
        child: Column(
          children: [
            Text(
              inputCityText,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  currentCity = value;
                },);
              },
              onSubmitted: setData,
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/12,
              width: MediaQuery.of(context).size.width/2,
              child: TextButton(
                  style: TextButton.styleFrom(
                  ),
                  onPressed: () => setData(currentCity),
                  child: Text(
                      "Поиск",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                  ),
              ),
            ),
            SizedBox(
              child: Text(
                '$temp℃',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
            ),
            Image.asset(
              getImagePath(), 
              width: 100, 
              height: 100,
            ),
          ],
        ),
      )
    );
  }
}
