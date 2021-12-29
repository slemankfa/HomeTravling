import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String cityEnaglishName, cityId, cityImage, cityArabicName, countryId;

  const CityEntity(
      {required this.cityEnaglishName,
      required this.cityId,
      required this.cityImage,
      required this.cityArabicName,
      required this.countryId});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [cityArabicName, cityArabicName, cityId, cityImage, countryId];
}
