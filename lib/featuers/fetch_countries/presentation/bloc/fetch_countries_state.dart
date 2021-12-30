part of 'fetch_countries_bloc.dart';

abstract class FetchCountriesState extends Equatable {
  const FetchCountriesState();

  @override
  List<Object> get props => [];
}
 
class EmptyState extends FetchCountriesState {}

class LoadingState extends FetchCountriesState {}

class LoadedState extends FetchCountriesState {
  final List<CountryEntity> loadedCountriesList;

  const LoadedState({required this.loadedCountriesList});

  LoadedState copyWith({
    List<CountryEntity>? countries,
  }) {
    return LoadedState(
      loadedCountriesList: countries ?? loadedCountriesList,
    );
  }

  @override
  List<Object> get props => [loadedCountriesList];
}

class ErrorState extends FetchCountriesState {
  final String message;

  const ErrorState({required this.message});
}
