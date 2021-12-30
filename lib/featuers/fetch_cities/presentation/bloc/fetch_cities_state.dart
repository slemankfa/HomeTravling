part of 'fetch_cities_bloc.dart';

abstract class FetchCitiesState extends Equatable {
  const FetchCitiesState();

  @override
  List<Object> get props => [];
}

class EmptyState extends FetchCitiesState {}

class LoadingState extends FetchCitiesState {}

class LoadedState extends FetchCitiesState {
  final List<CityEntity> loadedCitiesList;

  const LoadedState({required this.loadedCitiesList});

  @override
  List<Object> get props => [loadedCitiesList];
}

class ErrorState extends FetchCitiesState {
  final String message;

  const ErrorState({required this.message});
}
