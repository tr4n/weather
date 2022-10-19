import 'package:equatable/equatable.dart';

import '../../data/model/models.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeStateInitialized extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final CurrentCondition currentCondition;

  // final List<Weather> weathers;
  final NearestArea area;
  final List<Hourly> hourWeathers;
  final List<Weather> dayWeathers;

  HomeLoadSuccess(
      {required this.currentCondition,
      required this.hourWeathers,
      required this.dayWeathers,
      required this.area});

  @override
  List<Object> get props => [currentCondition, area, hourWeathers, dayWeathers];
}

class HomeLoadFailed extends HomeState {
  final dynamic error;

  HomeLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
