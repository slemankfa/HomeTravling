import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/utils/failuer_message.dart';
import 'package:home_travling/featuers/get_activites/domain/usecases/get_activites_list.dart';
import 'package:home_travling/featuers/get_activites/presentation/bloc/fetch_activities_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../activites_list.dart';

class MockGetAcivitesList extends Mock implements GetActivitesList {}

void main() async {
  MockGetAcivitesList mockGetAcivitesList = MockGetAcivitesList();
  FakeFirebaseFirestore instance = FakeFirebaseFirestore();
  const tCityId = "1";

  FetchActivitiesBloc bloc =
      FetchActivitiesBloc(getActivitesList: mockGetAcivitesList);

  await instance.collection('activities').add({
    "activity_description":
        "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine.",
    "activity_id": "3",
    "activity_image":
        "https://i.pinimg.com/originals/dc/87/67/dc876709b8d32bb0b388af21dce7e755.jpg",
    "activity_name_ar": "زواج فلسطيني تقليدي",
    "activity_name_en":
        "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine",
    "activity_video":
        "https://www.youtube.com/watch?v=QzZWmBRzJbk&ab_channel=Gazadeserveslife",
    "activity_type": {
      "activity_type_id": "2",
    },
    "city": {
      "city_id": "2",
    },
    "country": {
      "country_id": "3",
    }
  });

  test("initialState should be empty", () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  group("getActivitesList", () {
    blocTest<FetchActivitiesBloc, FetchActivitiesState>(
        "Should emit [loading, loaded] when data is gotten successfully",
        build: () => FetchActivitiesBloc(getActivitesList: mockGetAcivitesList),
        setUp: () => when(() => mockGetAcivitesList(Params(cityId: tCityId)))
            .thenAnswer((_) async => Right(tAcitvitiesList)),
        act: (bloc) => bloc.add(const GetActivitiesEvent(cityId: tCityId)),
        expect: () => [
              LoadingState(),
              LoadedState(loadedActivites: tAcitvitiesList),
            ]);

    blocTest<FetchActivitiesBloc, FetchActivitiesState>(
        "Should emit [loading, Error] when data is gotten successfully",
        build: () => FetchActivitiesBloc(getActivitesList: mockGetAcivitesList),
        setUp: () => when(
              () => mockGetAcivitesList(
                Params(cityId: tCityId),
              ),
            ).thenAnswer((_) async => Left(ServerFailure())),
        act: (bloc) => bloc.add(const GetActivitiesEvent(cityId: tCityId)),
        expect: () => [
              LoadingState(),
              ErrorState(message: mapFailureToMessage(ServerFailure()))
            ]);
  });
}
