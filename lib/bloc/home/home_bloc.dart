import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/home/home_event.dart';
import 'package:weather/bloc/home/home_state.dart';
import 'package:weather/data/repository/repositories.dart';

import '../../data/model/models.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository weatherRepository;

  HomeBloc({required this.weatherRepository}) : super(HomeStateInitialized()) {
    on<HomeLoaded>((_, emit) => _onGetHomeData(emit));
  }

  void _onGetHomeData(Emitter<HomeState> emitter) async {
    emitter(HomeLoading());
    final response = await weatherRepository.getWeatherData("");
    final currentConditions = response.currentConditions;
    final weathers = response.weathers;
    final areas = response.nearestAreas;
    if (currentConditions.isEmpty || weathers.isEmpty || areas.isEmpty) {
      emitter(HomeLoadFailed("Data load failed"));
    } else {
      final condition = currentConditions.first;
      final hourlyWeathers = weathers
          .expand(
            (day) => day.hourlyWeathers.map((e) {
              return e..dayValue = DateTime.parse(day.date).day;
            }),
          )
          .toList()
        ..sort((a, b) =>
            (a.dayValue * 10 + a.hourValue) - (b.dayValue * 10 + b.hourValue));
      emitter(
        HomeLoadSuccess(
          currentCondition: condition,
          dayWeathers: weathers,
          hourWeathers: _getSortedHourlyWeatherList(hourlyWeathers),
          area: areas.first,
        ),
      );
    }
  }

  List<Hourly> _getSortedHourlyWeatherList(List<Hourly> weathers) {
    final currentHour = DateTime.now().hour;
    final currentDay = DateTime.now().day;
    final sortedList = weathers
      ..sort((a, b) =>
          (a.dayValue * 10 + a.hourValue) - (b.dayValue * 10 + b.hourValue));
    int selectedIndex = 0;
    for (int index = 0; index < sortedList.length; index++) {
      final weather = sortedList[index];
      if (currentHour < weather.hourValue && currentDay == weather.dayValue) {
        break;
      }
      selectedIndex = index;
    }
    return sortedList.sublist(
        selectedIndex, min(weathers.length, selectedIndex + 5));
  }
}
