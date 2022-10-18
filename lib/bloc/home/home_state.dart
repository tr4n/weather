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
  final List<Weather> weathers;

  HomeLoadSuccess({required this.currentCondition, required this.weathers});

  @override
  List<Object> get props => [currentCondition, weathers];
}

class HomeLoadFailed extends HomeState {
  final dynamic error;

  HomeLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
