import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/get_activites/data/model/activity_model.dart';
import 'package:home_travling/featuers/get_activites/domain/entites/activity_entity.dart';

import '../../../activites_list.dart';

void main() async {
  final instance = FakeFirebaseFirestore();

  test("should be a subclass of AcitivityEntity", () {
    // assert
    expect(tActivityModel, isA<ActivityEntity>());
  });

  group("from Json", () {
    test("should return a valid model from the document snapshot map",
        () async {
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

      final snapshot = await instance.collection("activities").get();
      final firstDocument = snapshot.docs[0];
      // arrange
      final Map<String, dynamic> json = firstDocument.data();
      // act
      final result = ActivityModel.fromJson(json);
      // assert
      expect(result, tActivityModel);
    });

    test(
        "should return a valid model when Json country_id,city_id, activityId and activityTypeId regarded as a int",
        () async {
      await instance.collection('activities').add({
        "activity_description":
            "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine.",
        "activity_id": 3,
        "activity_image":
            "https://i.pinimg.com/originals/dc/87/67/dc876709b8d32bb0b388af21dce7e755.jpg",
        "activity_name_ar": "زواج فلسطيني تقليدي",
        "activity_name_en":
            "Watch | A lovely traditional Palestinian wedding in Birzeit, north of Ramallah occupied Palestine",
        "activity_video":
            "https://www.youtube.com/watch?v=QzZWmBRzJbk&ab_channel=Gazadeserveslife",
        "activity_type": {
          "activity_type_id": 2,
        },
        "city": {
          "city_id": 2,
        },
        "country": {
          "country_id": 3,
        }
      });

      final snapshot = await instance.collection("activities").get();
      final secondDocument = snapshot.docs[0];

      // arrange
      final Map<String, dynamic> json = secondDocument.data();
      // act
      final result = ActivityModel.fromJson(json);
      // assert
      expect(result, tActivityModel);
    });
  });
}
