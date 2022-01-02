import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/fetch_cities/data/datasource/cities_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_cities/domain/entities/city_entity.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:home_travling/featuers/fetch_cities/domain/repositories/cities_repostiry.dart';
 
class CitiesRepostiryImpl implements CitiesRepostiry {
  final CitiesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CitiesRepostiryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<CityEntity>>> getCitiesList(
      String countryId) async {
    // TODO: implement getCitiesList
    // networkInfo.isConnected;
    if (await networkInfo.isConnected) {
      try {
        final remoteCitiesSource =
            await remoteDataSource.getCitiesList(countryId);
        return Right(remoteCitiesSource);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
