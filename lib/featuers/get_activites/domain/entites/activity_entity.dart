import 'package:equatable/equatable.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';

class ActivityEntity extends Equatable {
  final String activityTypeId,
      activityId,
      cityId,
      countryId,
      activityDescription,
      activityImage,
      activityEnglishName,
      activityArbaicName;

  ActivityEntity(
      {required this.cityId,
      required this.countryId,
      required this.activityTypeId,
      required this.activityId,
      required this.activityDescription,
      required this.activityImage,
      required this.activityEnglishName,
      required this.activityArbaicName});

  @override
  // TODO: implement props
  List<Object?> get props => [
        cityId,
        countryId,
        activityTypeId,
        activityId,
        activityDescription,
        activityImage,
        activityEnglishName,
        activityArbaicName
      ];
}
