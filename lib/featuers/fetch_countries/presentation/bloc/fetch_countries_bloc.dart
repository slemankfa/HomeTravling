import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/usecases/get_countries_list.dart';

part 'fetch_countries_event.dart';
part 'fetch_countries_state.dart';

///https://bloclibrary.dev/#/flutterinfinitelisttutorial

class FetchCountriesBloc
    extends Bloc<FetchCountriesEvent, FetchCountriesState> {
  final GetCountriesList getCountriesList;

  List<CountryEntity> loadedCountries = [];

  FetchCountriesBloc({
    required this.getCountriesList,
  }) : super(EmptyState()) {
    on<GetCountriesListEvent>(_onCountriesFetched);
  }

  Future<void> _onCountriesFetched(
      FetchCountriesEvent event, Emitter<FetchCountriesState> emit) async {
    emit(LoadingState());
    final failureOrGetCountries = await getCountriesList(NoParams());
    failureOrGetCountries.fold(
        (failure) => emit(ErrorState(message: _mapFailureToMessage(failure))),
        (fetchedCountries) {
      loadedCountries = fetchedCountries;
      emit(LoadedState(loadedCountriesList: loadedCountries));
    });
  }

/* 
we will move it to the core because it can be in all featuers 
 */
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
