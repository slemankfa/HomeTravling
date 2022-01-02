import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_travling/featuers/get_activites/domain/repositories/activites_repostiry.dart';
import 'package:home_travling/featuers/get_activites/domain/usecases/get_activites_list.dart';
import 'package:mocktail/mocktail.dart';

import '../../../activites_list.dart';

class MockAcitivesRepositry extends Mock implements ActivitiesRepostiry {}

void main() {
  MockAcitivesRepositry mockAcitivesRepositry = MockAcitivesRepositry();
  GetActivitesList useCase = GetActivitesList(mockAcitivesRepositry);

  const tCityId = "2";

  test("Should get Activites list from the repostiry", () async {
    //arrange
    when(() => mockAcitivesRepositry.getActivitesList(tCityId))
        .thenAnswer((_) async => Right(tAcitvitiesList));
    // act
    final result = await useCase(Params(cityId: tCityId));

    // assert
    expect(result, Right(tAcitvitiesList));
    verify(() => mockAcitivesRepositry.getActivitesList(tCityId));
    verifyNoMoreInteractions(mockAcitivesRepositry);
  });
}
