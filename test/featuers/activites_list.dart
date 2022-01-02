import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/get_activites/data/model/activity_model.dart';
import 'package:home_travling/featuers/get_activites/domain/entites/activity_entity.dart';

List<ActivityEntity> tAcitvitiesList = [
  ActivityEntity(
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

ActivityModel tActivityModel = ActivityModel(
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
    activityArbaicName: "زواج فلسطيني تقليدي");
