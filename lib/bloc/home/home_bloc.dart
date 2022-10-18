import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/home/home_event.dart';
import 'package:weather/bloc/home/home_state.dart';
import 'package:weather/data/repository/repositories.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository weatherRepository;

  HomeBloc({required this.weatherRepository}) : super(HomeStateInitialized()) {
    on<HomeLoaded>((_, emit) => _onGetHomeData(emit));
  }

  void _onGetHomeData(Emitter<HomeState> emitter) async {
    emitter(HomeLoading());
    final response = await weatherRepository.getWeatherData("Hanoi");
    final currentConditions = response.currentConditions;
    final weathers = response.weathers;
    if (currentConditions.isEmpty || weathers.isEmpty) {
      emitter(HomeLoadFailed("Data load failed"));
    } else {
      emitter(HomeLoadSuccess(
        currentCondition: currentConditions.first,
        weathers: weathers,
      ));
    }
  }
}
