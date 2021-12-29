import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/featuers/fetch_cities/domain/repositories/cities_repostiry.dart';
import 'package:home_travling/featuers/fetch_cities/domain/usecases/get_cities_list.dart';
import 'package:mocktail/mocktail.dart';

import '../../../cities_list.dart';

class MockCitiesRepositry extends Mock implements CitiesRepostiry {}

void main() {
  MockCitiesRepositry mockCitiesRepositry = MockCitiesRepositry();
  GetCistiesList usecase = GetCistiesList(mockCitiesRepositry);
  const tCountryId = "1";
  // List<CityEntity> tCitiesList = const [
  //   CityEntity(
  //       cityArabicName: "بارما",
  //       cityId: "1",
  //       countryId: "1",
  //       cityImage:
  //           "https://upload.wikimedia.org/wikipedia/commons/c/c5/Parma_dal_Duomo%2C_settembre_2014-1_%2815481932581%29.jpg",
  //       cityEnaglishName: "Parma")
  // ];

  test("should get ciities list from the repositry", () async {
    // arrange
    when(() => mockCitiesRepositry.getCitiesList(tCountryId))
        .thenAnswer((_) async => Right(tCitiesList));
    // act
    final result = await usecase(const Params(countryId: tCountryId));
    // assert
    expect(result, Right(tCitiesList));
    verify(() => mockCitiesRepositry.getCitiesList(tCountryId));
    verifyNoMoreInteractions(mockCitiesRepositry);
  });
}
