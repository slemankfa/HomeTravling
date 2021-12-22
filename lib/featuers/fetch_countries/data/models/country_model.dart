import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  final String countryEnglishName, countryArabicName, countryId, countryFlag;

  const CountryModel(
      {required this.countryEnglishName,
      required this.countryArabicName,
      required this.countryId,
      required this.countryFlag})
      : super(
            countryArabicName: countryArabicName,
            countryEnglishName: countryEnglishName,
            countryFlag: countryFlag,
            countryId: countryId);

  factory CountryModel.fromJson(Map<String, dynamic> map) {
    return CountryModel(
      countryId: map["country_id"].toString(),
      countryArabicName: map["country_name_ar"],
      countryEnglishName: map["country_name_en"],
      countryFlag: map["country_flag"],
    );
  }
}
