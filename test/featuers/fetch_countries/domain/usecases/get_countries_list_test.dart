import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/repositories/countries_repostiry.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/get_countries_list.dart';
import 'package:mocktail/mocktail.dart';

class MockCountriesRepositry extends Mock implements CountriesRepositry {}

void main() {
  MockCountriesRepositry mockCountriesRepositry = MockCountriesRepositry();
  GetCountriesList usecase = GetCountriesList(mockCountriesRepositry);

  List<CountryEntity> tCountriesList = const [
    CountryEntity(
      countryEnglishName: "Italy",
      countryArabicName: "ايطاليا",
      countryId: "1",
      countryFlag:
          "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg",
    ),
  ];

  test("Should get countries list from the repositry", () async {
    // arange
    when(() => mockCountriesRepositry.getCountriesList())
        .thenAnswer((_) async => Right(tCountriesList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tCountriesList));
    verify(() => mockCountriesRepositry.getCountriesList());
    verifyNoMoreInteractions(mockCountriesRepositry);
  });
}
