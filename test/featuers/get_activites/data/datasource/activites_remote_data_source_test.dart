import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/get_activites/data/datasource/activites_remote_data_source.dart';
import 'package:home_travling/featuers/get_activites/data/model/activity_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../activites_list.dart';

class MockQuerySnapShot extends Mock implements QuerySnapshot {}

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() async {
  FakeFirebaseFirestore instance = FakeFirebaseFirestore();
  MockFirestore mockFirestore = MockFirestore();

  ActivitiesRemoteDataSourceImpl dataSource =
      ActivitiesRemoteDataSourceImpl(instance);

  const tCityId = "2";
  List<ActivityModel> tActivitesList = [
    ActivityModel(
        cityId: "2",
        countryId: "3",
        activityTypeId: "2",
        activityId: "3",
        activityDescription:
            "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine.",
        activityImage:
            "https://i.pinimg.com/originals/dc/87/67/dc876709b8d32bb0b388af21dce7e755.jpg",
        activityEnglishName:
            "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine",
        activityArbaicName: "زواج فلسطيني تقليدي")
  ];

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

  void setUpGetActivities() async {
    QuerySnapshot<Map<String, dynamic>> snapshots = await instance
        .collection("activities")
        .where("city.city_id", isEqualTo: tCityId)
        .get();

    when(() => mockFirestore
        .collection("activities")
        .where("city.city_id", isEqualTo: tCityId)
        .get()).thenAnswer((_) async => snapshots);
  }

  group("GetActivitesList", () {
    test("should perform a query to get activites from the firestore", () {
      // arrange
      setUpGetActivities();
      // act
      dataSource.getActivitiesList(tCityId);
    });

    //-----
    test("should return activites list when  the query done successfully",
        () async {
      // arrange
      setUpGetActivities();
      // act
      final result = await dataSource.getActivitiesList(tCityId);
      // assert 
      expect(result, equals(tActivitesList));
    });
  });
}
