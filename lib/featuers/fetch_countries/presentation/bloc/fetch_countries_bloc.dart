import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/get_countries_list.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/load_more_countries_list.dart';

part 'fetch_countries_event.dart';
part 'fetch_countries_state.dart';

class FetchCountriesBloc
    extends Bloc<FetchCountriesEvent, FetchCountriesState> {
  final GetCountriesList getCountriesList;
  final LoadMoreCountriesList loadCountriesList;
  FetchCountriesBloc({
    required this.getCountriesList,
    required this.loadCountriesList,
  }) : super(EmptyState()) {
    on<GetCountriesListEvent>(
        (event, emit) async => emit(await _getCountriesList(emit)));
    on<LoadMoreCountriesListEvent>((event, emit) async => emit(
          await _loadCountriesList(
            event,
            emit,
          ),
        ));
  }

  _getCountriesList(Emitter eventEmitter) async {
    eventEmitter(LoadingState());
    final failureOrGetCountries = await getCountriesList(NoParams());
    failureOrGetCountries.fold(
        (failure) =>
            eventEmitter(ErrorState(message: _mapFailureToMessage(failure))),
        (loadedCountries) =>
            eventEmitter(LoadedState(loadedCountriesList: loadedCountries)));
  }

  _loadCountriesList(
      LoadMoreCountriesListEvent event, Emitter eventEmitter) async {
    eventEmitter(LoadingState());
    final failureOrGetCountries = await loadCountriesList(
        Params(lastDocumentSnapShot: event.documentSnapshot));
    failureOrGetCountries.fold(
        (failure) =>
            eventEmitter(ErrorState(message: _mapFailureToMessage(failure))),
        (loadedCountries) =>
            eventEmitter(LoadedState(loadedCountriesList: loadedCountries)));
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return "SERVER_FAILURE_MESSAGE".tr();

      default:
        return "UNEXPECTED_ERROR_MESSAGE".tr();
    }
  }
}
