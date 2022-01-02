import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/utils/failuer_message.dart';
import 'package:home_travling/featuers/fetch_cities/domain/usecases/get_cities_list.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/bloc/fetch_cities_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../cities_list.dart';
 
class MockGetCitiesList extends Mock implements GetCistiesList {}

class MockFaluier extends Mock implements Failure {}

void main() async {
  MockGetCitiesList mockGetCitiesList = MockGetCitiesList();
  MockFaluier mockFaluier = MockFaluier();

  FakeFirebaseFirestore instance = FakeFirebaseFirestore();
  const tCountryId = "1";

  FetchCitiesBloc bloc = FetchCitiesBloc(
    getCistiesList: mockGetCitiesList,
  );

  await instance.collection('cities').add({
    'city_image':
        "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
    "country_id": "1",
    "city_id": "1",
    "city_name_ar": "بارما",
    "city_name_en": "Parma"
  });

  test("initialState should be Empty", () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  group("GetCitiesList", () {
    blocTest<FetchCitiesBloc, FetchCitiesState>(
        "Should emit [loading, loaded] when data is gotten successfully",
        build: () => FetchCitiesBloc(getCistiesList: mockGetCitiesList),
        setUp: () =>
            when(() => mockGetCitiesList(const Params(countryId: tCountryId)))
                .thenAnswer((_) async => Right(tCitiesList)),
        act: (bloc) => bloc.add(GetCitiesListEvent(countryId: tCountryId)),
        expect: () => [
              LoadingState(),
              LoadedState(loadedCitiesList: tCitiesList),
            ]);

    blocTest<FetchCitiesBloc, FetchCitiesState>(
        "Should emit [loading, Error] when data is gotten successfully",
        build: () => FetchCitiesBloc(getCistiesList: mockGetCitiesList),
        setUp: () =>
            when(() => mockGetCitiesList(const Params(countryId: tCountryId)))
                .thenAnswer((_) async => Left(ServerFailure())),
        act: (bloc) => bloc.add(GetCitiesListEvent(countryId: tCountryId)),
        // verify: (fetchCitiesBloc)=> mockMapFailuerToMessage.mapFailureToMessage(ServerFailure()),

        expect: () => [
              LoadingState(),
              // ErrorState(message: "UNEXPECTED_ERROR_MESSAGE".tr()),

              ErrorState(message: mapFailureToMessage(ServerFailure()))
            ]);
  });
}
