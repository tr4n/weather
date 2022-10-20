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
            (day) =>
            day.hourlyWeathers.map((e) {
              return e
                ..dayValue = DateTime
                    .parse(day.date)
                    .day;
            }),
      )
          .toList()
        ..sort((a, b) => a.compareTo(b));
      final sortedWeathers = _getSortedHourlyWeatherList(hourlyWeathers).take(8).toList();
      print(sortedWeathers.map((e) => "${e.dayValue} ${e.time}"));
      emitter(
        HomeLoadSuccess(
            currentCondition: condition,
            dayWeathers: weathers,
            hourWeathers: sortedWeathers,
            area: areas.first,
            days: weathers.map((e) => DayWeather(e)).toList()
        ),
      );
    }
  }

  List<Hourly> _getSortedHourlyWeatherList(List<Hourly> weathers) {
    final currentHour = DateTime.now().hour;
    final currentDay = DateTime.now().day;
    return weathers
        .where((element) =>
            (element.dayValue == currentDay &&
                element.hourValue - currentHour > -3) ||
            (element.dayValue > currentDay))
        .toList()
      ..sort((a, b) => a.compareTo(b));
  }
}
