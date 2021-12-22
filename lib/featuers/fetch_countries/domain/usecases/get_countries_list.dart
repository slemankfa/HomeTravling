import 'package:home_travling/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/core/usecases/usecases.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/featuers/fetch_countries/domain/repositories/countries_repostiry.dart';

class GetCountriesList implements UseCase<List<CountryEntity>, NoParams> {
  final CountriesRepositry repositry;

  GetCountriesList(this.repositry);

  @override
  Future<Either<Failure, List<CountryEntity>>> call(NoParams parmas) async{
    // TODO: implement call
   return await repositry.getCountriesList();
  }
}
