import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String countryEnglishName, countryArabicName, countryId, countryFlag;

  const CountryEntity(
      {required this.countryEnglishName,
      required this.countryArabicName,
      required this.countryId,
      required this.countryFlag});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [countryFlag, countryEnglishName, countryArabicName, countryId];
}
