import 'package:home_travling/featuers/get_activites/domain/entites/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  ActivityModel(
      {required String cityId,
      required String countryId,
      required String activityTypeId,
      required String activityId,
      required String activityDescription,
      required String activityImage,
      required String activityVideo,
      required String activityEnglishName,
      required String activityArbaicName})
      : super(
          cityId: cityId,
          countryId: countryId,
          activityArbaicName: activityArbaicName,
          activityDescription: activityDescription,
          activityEnglishName: activityEnglishName,
          activityId: activityId,
          activityVideo: activityVideo,
          activityImage: activityImage,
          activityTypeId: activityTypeId,
        );

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      cityId: json["city"]["city_id"].toString(),
      countryId: json["country"]["country_id"].toString(),
      activityTypeId: json["activity_type"]["activity_type_id"].toString(),
      activityId: json["activity_id"].toString(),
      activityDescription: json["activity_description"],
      activityImage: json["activity_image"],
      activityVideo: json["activity_video"],
      activityEnglishName: json["activity_name_en"],
      activityArbaicName: json["activity_name_ar"],
    );
  }
}
