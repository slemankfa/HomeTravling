part of 'fetch_countries_bloc.dart';

abstract class FetchCountriesEvent extends Equatable {
  const FetchCountriesEvent();

  @override
  List<Object> get props => [];
}

class GetCountriesListEvent extends FetchCountriesEvent {}
