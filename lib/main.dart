import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff08244f), Color(0xff134cb5), Color(0xff134cb5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
        left: 32,
        right: 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildLocationAndNotification(),
            _buildPrimaryWeather(),
            _buildIntroStatsChips(),
            _buildForecastToday(),
            _buildNextForecast(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationAndNotification() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/ic_map.svg'),
            const Padding(
                padding: EdgeInsets.only(left: 16),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  child: Text("Fortaleza"),
                )),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: SvgPicture.asset(
            'assets/ic_notification_alert.svg',
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryWeather() {
    return Column(
      children: [
        Image.asset("assets/images/img_sun_cloud.png"),
        const Padding(
          padding: EdgeInsets.only(top: 0),
          child: DefaultTextStyle(
            style: TextStyle(
                color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
            child: Text("28º"),
          ),
        ),
        const DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          child: Text("Precipitations"),
        ),
        const DefaultTextStyle(
          style: TextStyle(color: Colors.white, fontSize: 18),
          child: Text("Max.: 31º Min.: 25º"),
        ),
      ],
    );
  }

  Widget _buildIntroStatsChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        color: Colors.transparent,
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
          decoration: const BoxDecoration(
              color: Color(0x80001026),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: SvgPicture.asset("assets/ic_noun_rain.svg"),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    child: Text("6%"),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset("assets/ic_noun_humidity.svg"),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    child: Text("90%"),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset("assets/ic_noun_wind.svg"),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    child: Text("19km/h"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForecastToday() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        color: Colors.transparent,
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 16),
          decoration: const BoxDecoration(
              color: Color(0x80001026),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    child: Text("Today"),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    child: Text("Mar, 9"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHourWeatherItem(
                        "15:00", "assets/ic_wind_sunny.svg", "29°C", false),
                    _buildHourWeatherItem(
                        "15:00", "assets/ic_wind_sunny.svg", "29°C", false),
                    _buildHourWeatherItem(
                        "15:00", "assets/ic_wind_sunny.svg", "29°C", true),
                    _buildHourWeatherItem(
                        "15:00", "assets/ic_wind_sunny.svg", "29°C", false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHourWeatherItem(
      String hour, String icon, String tempura, bool isCurrent) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
      decoration: isCurrent
          ? BoxDecoration(
              border: Border.all(color: const Color(0xff2566a3)),
              color: const Color(0x332566a3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Column(
        children: [
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            child: Text(tempura),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            child: SvgPicture.asset(icon),
          ),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            child: Text(hour),
          ),
        ],
      ),
    );
  }

  Widget _buildNextForecast() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        color: Colors.transparent,
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 16),
          decoration: const BoxDecoration(
              color: Color(0x80001026),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    child: Text("Next Forecast"),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset("assets/ic_calendar.svg"),
                    ),
                  ),
                ],
              ),
              _buildDayOfWeekForecastItem(
                  "Monday", "assets/ic_big_rain_drops.svg", "13°C", "10°C"),
              _buildDayOfWeekForecastItem(
                  "Monday", "assets/ic_big_rain_drops.svg", "14°C", "9°C"),
              _buildDayOfWeekForecastItem(
                  "Monday", "assets/ic_big_rain_drops.svg", "15°C", "8°C"),
              _buildDayOfWeekForecastItem(
                  "Monday", "assets/ic_big_rain_drops.svg", "16°C", "7°C"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayOfWeekForecastItem(
      String dayOfWeek, String icon, String high, String low) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DefaultTextStyle(
            style: TextStyle(color: Colors.white, fontSize: 18),
            child: Text("Mar, 9"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SvgPicture.asset(icon),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  child: Text(high),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white54, fontSize: 18),
                  child: Text(low),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
