part of 'fetch_cities_bloc.dart';

abstract class FetchCitiesEvent extends Equatable {
  const FetchCitiesEvent();

  @override
  List<Object> get props => [];
}

class GetCitiesListEvent extends FetchCitiesEvent {
  final String countryId;

  GetCitiesListEvent({required this.countryId});
}
