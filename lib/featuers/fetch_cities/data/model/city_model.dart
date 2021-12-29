import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel({
    required String cityEnglishName,
    required String cityArabicName,
    required String cityId,
    required String cityImage,
    required String countryId,
  }) : super(
            cityEnaglishName: cityEnglishName,
            cityImage: cityImage,
            cityArabicName: cityArabicName,
            cityId: cityId,
            countryId: countryId);

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityEnglishName: json["city_name_en"],
      cityArabicName: json["city_name_ar"],
      cityId: json["city_id"].toString(),
      cityImage: json["city_image"],
      countryId: json["country_id"].toString(),
    );
  }
}
