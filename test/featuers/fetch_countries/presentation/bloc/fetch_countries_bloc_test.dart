import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/get_countries_list.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/load_more_countries_list.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCountriesList extends Mock implements GetCountriesList {}

class MockLoadMoreCountriesList extends Mock implements LoadMoreCountriesList {}

void main() async {
  MockGetCountriesList mockGetCountriesList = MockGetCountriesList();
  FakeFirebaseFirestore instance = FakeFirebaseFirestore();

  MockLoadMoreCountriesList mockLoadMoreCountriesList =
      MockLoadMoreCountriesList();
  FetchCountriesBloc bloc = FetchCountriesBloc(
      loadCountriesList: mockLoadMoreCountriesList,
      getCountriesList: mockGetCountriesList);

  List<CountryEntity> tCountriesList = const [
    CountryEntity(
      countryEnglishName: "Italy",
      countryArabicName: "إيطاليا",
      countryId: "1",
      countryFlag:
          "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
    ),
  ];

  await instance.collection('countries').add(
    {
      'country_flag':
          'https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg',
      "country_id": "1",
      "country_name_ar": "إيطاليا",
      "country_name_en": "Italy"
    },
  );

  final snapshot = await instance.collection('countries').get();
  final lastDocument = snapshot.docs.first;

  List<CountryEntity> tLoadtCountriesList = const [
    CountryEntity(
      countryEnglishName: "Japan",
      countryArabicName: "اليايان",
      countryId: "2",
      countryFlag:
          "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
    ),
  ];

  test("initialState should be Empty", () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  group("loadCountriesList", () {
    blocTest<FetchCountriesBloc, FetchCountriesState>(
        "should emit [Loading, Loaded] when data is gotten successfully'",
        build: () => FetchCountriesBloc(
            getCountriesList: mockGetCountriesList,
            loadCountriesList: mockLoadMoreCountriesList),
        setUp: () => when(() => mockLoadMoreCountriesList(
                Params(lastDocumentSnapShot: lastDocument))).thenAnswer(
              (_) async => Right(tLoadtCountriesList),
            ),
        act: (bloc) => bloc.add(LoadMoreCountriesListEvent(lastDocument)),
        expect: () => [
              LoadingState(),
              LoadedState(loadedCountriesList: tLoadtCountriesList),
            ]);

    blocTest<FetchCountriesBloc, FetchCountriesState>(
        'should emit [Loading, Error] when getting data fails',
        build: () => FetchCountriesBloc(
            getCountriesList: mockGetCountriesList,
            loadCountriesList: mockLoadMoreCountriesList),
        setUp: () => when(() => mockLoadMoreCountriesList(
                Params(lastDocumentSnapShot: lastDocument))).thenAnswer(
              (_) async => Left(ServerFailure()),
            ),
        act: (bloc) => bloc.add(LoadMoreCountriesListEvent(lastDocument)),
        expect: () => [
              LoadingState(),
              ErrorState(message: "UNEXPECTED_ERROR_MESSAGE".tr()),
            ]);
  });

  group("GetCountriesList", () {
    blocTest<FetchCountriesBloc, FetchCountriesState>(
        "should emit [Loading, Loaded] when data is gotten successfully'",
        build: () => FetchCountriesBloc(
            getCountriesList: mockGetCountriesList,
            loadCountriesList: mockLoadMoreCountriesList),
        setUp: () => when(() => mockGetCountriesList(NoParams())).thenAnswer(
              (_) async => Right(tCountriesList),
            ),
        act: (bloc) => bloc.add(GetCountriesListEvent()),
        expect: () => [
              LoadingState(),
              LoadedState(loadedCountriesList: tCountriesList),
            ]);

    blocTest<FetchCountriesBloc, FetchCountriesState>(
        'should emit [Loading, Error] when getting data fails',
        build: () => FetchCountriesBloc(
            getCountriesList: mockGetCountriesList,
            loadCountriesList: mockLoadMoreCountriesList),
        setUp: () => when(() => mockGetCountriesList(NoParams())).thenAnswer(
              (_) async => Left(ServerFailure()),
            ),
        act: (bloc) => bloc.add(GetCountriesListEvent()),
        expect: () => [
              LoadingState(),
              ErrorState(message: "UNEXPECTED_ERROR_MESSAGE".tr()),
            ]);
  });
}
