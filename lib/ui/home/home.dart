import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/home/home_bloc.dart';
import 'package:weather/bloc/home/home_event.dart';
import 'package:weather/bloc/home/home_state.dart';
import 'package:weather/data/model/hourly.dart';
import 'package:weather/di/injection.dart';
import 'package:weather/extension/list_ext.dart';

import '../../data/model/models.dart';

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
                final successState = state as HomeLoadSuccess;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildLocationAndNotification(successState.area),
                    _buildPrimaryWeather(successState.currentCondition),
                    _buildIntroStatsChips(successState.currentCondition),
                    _buildForecastToday(successState.weathers.firstOrNull() ??
                        Weather("", "", List.empty())),
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

  Widget _buildLocationAndNotification(NearestArea area) {
    final name = area.areaNames.isNotEmpty ? area.areaNames.first.value : "";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_map.png', width: 28, height: 28),
            Padding(
                padding: const EdgeInsets.only(left: 16),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  child: Text(name),
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
          child: Image.asset(
            'assets/images/ic_notification_alert.png',
            width: 28,
            height: 28,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryWeather(CurrentCondition condition) {
    final weatherDescription = condition.weatherDesc.firstOrNull()?.value ?? "";
    final description =
        "$weatherDescription, feels like ${condition.feelsLikeC}ºC";
    return Column(
      children: [
        Image.asset("assets/images/img_sunny_1.png", height: 200),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: DefaultTextStyle(
            style: const TextStyle(
                color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
            child: Text("${condition.tempC}º"),
          ),
        ),
        DefaultTextStyle(
          style: const TextStyle(color: Colors.white, fontSize: 18),
          child: Text(description),
        ),
      ],
    );
  }

  Widget _buildIntroStatsChips(CurrentCondition condition) {
    final windSpeed = "${condition.windSpeedKmPh} km/h";
    final humidity = "${condition.humidity}%";

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
                    child: Image.asset("assets/images/ic_noun_rain.png",
                        width: 24, height: 24),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    child: Text("6%"),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset("assets/images/ic_noun_humidity.png",
                        width: 24, height: 24),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    child: Text(humidity),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset("assets/images/ic_noun_wind.png",
                        width: 24, height: 24),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    child: Text(windSpeed),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForecastToday(Weather weather) {
    final dateFormat = DateFormat("MMM, d");
    final date = dateFormat.format(DateTime.parse(weather.date));
    final hourlyWeathers = _getSortedHourlyWeatherList(weather.hourlyWeathers);
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    child: Text("Today"),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    child: Text(date),
                  ),
                ],
              ),
              // ScrollablePositionedList.builder(
              //   itemCount: hourlyWeathers.length,
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (context, index) =>
              //       _buildHourWeatherItem(hourlyWeathers[index]),
              //   itemScrollController: itemScrollController,
              // ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: hourlyWeathers
                        .map((e) => _buildHourWeatherItem(e))
                        .toList()),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Hourly> _getSortedHourlyWeatherList(List<Hourly> weathers) {
    final currentHour = DateTime.now().hour;
    final sortedList = weathers..sort((a, b) => a.hourValue - b.hourValue);

    int selectHour = 0;
    for (Hourly weather in sortedList) {
      if (currentHour < weather.hourValue) {
        break;
      }
      selectHour = weather.hourValue;
    }
    return sortedList
        .map((e) => e..isCurrent = e.hourValue == selectHour)
        .toList();
  }

  Widget _buildHourWeatherItem(Hourly hourlyWeather) {
    final temperate = hourlyWeather.tempC + "°C";

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 8, right: 8),
      decoration: hourlyWeather.isCurrent
          ? BoxDecoration(
              border: Border.all(color: const Color(0xff2566a3)),
              color: const Color(0x332566a3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            child: Text(temperate),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            child: Image.asset("assets/icons/ic_sunny_cloud.png",
                width: 40, height: 40),
          ),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            child: Text("${hourlyWeather.hourValue}:00"),
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
