import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/home/home_bloc.dart';
import 'package:weather/bloc/home/home_event.dart';
import 'package:weather/bloc/home/home_state.dart';
import 'package:weather/common/type/weather_type.dart';
import 'package:weather/data/model/models.dart';
import 'package:weather/di/injection.dart';
import 'package:weather/extension/list_ext.dart';

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
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
            left: 32,
            right: 32,
            bottom: 32,
          ),
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadSuccess:
                final successState = state as HomeLoadSuccess;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildLocationAndNotification(successState.area),
                    const SizedBox(height: 20),
                    _buildPrimaryWeather(successState.currentCondition),
                    const SizedBox(height: 20),
                    _buildIntroStatsChips(successState.currentCondition),
                    const SizedBox(height: 20),
                    _buildForecastToday(
                        successState.dayWeathers.firstOrNull() ??
                            Weather.initDefault(),
                        successState.hourWeathers),
                    const SizedBox(height: 20),
                    _buildNextForecast(successState.days),
                    const SizedBox(height: 20),
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
            const SizedBox(width: 16),
            DefaultTextStyle(
              style: const TextStyle(color: Colors.white, fontSize: 18),
              child: Text(name),
            ),
            const SizedBox(width: 16),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 24,
              color: Colors.white,
            ),
          ],
        ),
        Image.asset(
          'assets/images/ic_notification_alert.png',
          width: 28,
          height: 28,
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
        DefaultTextStyle(
          style: const TextStyle(
              color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
          child: Text("${condition.tempC}º"),
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

    return Container(
      padding: const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
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
    );
  }

  Widget _buildForecastToday(Weather weather, List<Hourly> hourlyWeathers) {
    final dateFormat = DateFormat("MMM, d");
    final date = dateFormat.format(DateTime.parse(weather.date));
    // final hourlyWeathers = _getSortedHourlyWeatherList(weather.hourlyWeathers);
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 16),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: hourlyWeathers
                    .map((e) => _buildHourWeatherItem(e))
                    .toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildHourWeatherItem(Hourly hourlyWeather) {
    final temperate = hourlyWeather.tempC + "°C";
    final icon =
        "assets/icons/${WeatherType.fromDescription(hourlyWeather.weatherDesc.firstOrNull()?.value ?? "").iconPath}";
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
            child:
                Image.asset(icon, width: 40, height: 40),
          ),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white, fontSize: 18),
            child: Text("${hourlyWeather.hourValue}:00"),
          ),
        ],
      ),
    );
  }

  Widget _buildNextForecast(List<DayWeather> dayWeathers) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 16),
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
                  child: Image.asset("assets/icons/ic_calendar.png",
                      width: 24, height: 24),
                ),
              ),
            ],
          ),
          Column(
            children: dayWeathers.map(_buildDayOfWeekForecastItem).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDayOfWeekForecastItem(DayWeather dayWeather) {
    final icon =
        "assets/icons/${WeatherType.fromDescription(dayWeather.description).iconPath}";
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white, fontSize: 18),
              child: Text(dayWeather.title),
            ),
          ),
          const SizedBox(width: 32),
          Image.asset(
            icon,
            width: 50,
            height: 50,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  child: Text(dayWeather.maxTemperateC),
                ),
                const SizedBox(width: 2),
                const DefaultTextStyle(
                  style: TextStyle(color: Colors.white54, fontSize: 18),
                  child: Text("/"),
                ),
                const SizedBox(width: 2),
                DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  child: Text(dayWeather.minTemperateC + "°C"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
