import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/bloc/home/home_bloc.dart';
import 'package:weather/bloc/home/home_event.dart';
import 'package:weather/bloc/home/home_state.dart';
import 'package:weather/di/injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeBloc(weatherRepository: getIt.get())..add(HomeLoaded()),
      child: Container(
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
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadSuccess:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildLocationAndNotification(),
                    _buildPrimaryWeather(),
                    _buildIntroStatsChips(),
                    _buildForecastToday(),
                    _buildNextForecast(),
                  ],
                );
              case HomeLoading:
                return Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              case HomeLoadFailed:
                return Row();
            }
            return Row();
          }),
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
        Image.asset("assets/images/img_sunny_1.png"),
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
                    _buildHourWeatherItem("15:00",
                        "assets/icons/ic_wind_sunny.svg", "29°C", false),
                    _buildHourWeatherItem(
                        "16:00", "assets/icons/ic_sunny.svg", "29°C", false),
                    _buildHourWeatherItem("17:00",
                        "assets/icons/ic_sunny_small_rain.svg", "29°C", true),
                    _buildHourWeatherItem(
                        "18:00",
                        "assets/icons/ic_sunny_small_rain_snow.svg",
                        "29°C",
                        false),
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
              _buildDayOfWeekForecastItem("Monday",
                  "assets/icons/ic_sunny_thunder.svg", "13°C", "10°C"),
              _buildDayOfWeekForecastItem(
                  "Tuesday", "assets/icons/ic_foggy.svg", "14°C", "9°C"),
              _buildDayOfWeekForecastItem(
                  "Wednesday", "assets/ic_big_rain_drops.svg", "15°C", "8°C"),
              _buildDayOfWeekForecastItem(
                  "Thursday", "assets/ic_big_rain_drops.svg", "16°C", "7°C"),
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
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            child: Text(dayOfWeek),
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
