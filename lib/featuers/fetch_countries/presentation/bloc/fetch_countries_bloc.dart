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

///https://bloclibrary.dev/#/flutterinfinitelisttutorial

class FetchCountriesBloc
    extends Bloc<FetchCountriesEvent, FetchCountriesState> {
  final GetCountriesList getCountriesList;
  final LoadMoreCountriesList loadCountriesList;

  List<CountryEntity> loadedCountries = [];
  late DocumentSnapshot theLastDocumentSnapShot ;

  FetchCountriesBloc({
    required this.getCountriesList,
    required this.loadCountriesList,
  }) : super(EmptyState()) {
    on<GetCountriesListEvent>(_onCountriesFetched);
    on<LoadMoreCountriesListEvent>(_loadMoreCountriesList);

    // on<GetCountriesListEvent>(
    //     (event, emit) async => emit(await _getCountriesList(emit)));
    // on<LoadMoreCountriesListEvent>((event, emit) async => emit(
    //       await _loadCountriesList(
    //         event,
    //         emit,
    //       ),
    //     ));
  }

  Future<void> _onCountriesFetched(
      FetchCountriesEvent event, Emitter<FetchCountriesState> emit) async {
    final failureOrGetCountries = await getCountriesList(NoParams());
    failureOrGetCountries.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (fetchedCountries) {
      loadedCountries = fetchedCountries;
      emit(LoadedState(loadedCountriesList: loadedCountries));
    });
  }

  Future<void> _loadMoreCountriesList(LoadMoreCountriesListEvent event,
      Emitter<FetchCountriesState> emit) async {
    final failureOrLoadCountries = await loadCountriesList(
        Params(lastDocumentSnapShot: event.documentSnapshot));
    failureOrLoadCountries.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (loadedMoreCountries) {
      loadedCountries.addAll(loadedMoreCountries);
      emit(LoadedState(loadedCountriesList: loadedCountries));
    });
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
