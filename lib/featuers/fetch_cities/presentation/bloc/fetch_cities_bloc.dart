import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/utils/failuer_message.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/fetch_cities/domain/usecases/get_cities_list.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';

part 'fetch_cities_event.dart';
part 'fetch_cities_state.dart';

class FetchCitiesBloc extends Bloc<FetchCitiesEvent, FetchCitiesState> {
  final GetCistiesList getCistiesList;
  // List<CityEntity> loadedCities = [];
  FetchCitiesBloc({
    required this.getCistiesList,
  }) : super(EmptyState()) {
    on<GetCitiesListEvent>(_onCitiesFetched);
  }

  FutureOr<void> _onCitiesFetched(
      GetCitiesListEvent event, Emitter<FetchCitiesState> emit) async {
    emit(LoadingState());
    final failureOrGetCities =
        await getCistiesList(Params(countryId: event.countryId));
    failureOrGetCities.fold(
        (failure) => emit(ErrorState(message: mapFailureToMessage(failure))),
        (fetchCities) => emit(LoadedState(loadedCitiesList: fetchCities)));
    // emit(LoadedState(loadedCitiesList: loadedCities));
  }

 
}
