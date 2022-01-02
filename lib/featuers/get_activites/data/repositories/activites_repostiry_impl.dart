import 'package:dartz/dartz.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/get_activites/data/datasource/activites_remote_data_source.dart';
import 'package:home_travling/featuers/get_activites/domain/entites/activity_entity.dart';
import 'package:home_travling/featuers/get_activites/domain/repositories/activites_repostiry.dart';

class ActivityRepostiryImpl implements ActivitiesRepostiry {
  final NetworkInfo networkInfo;
  final ActivitiesRemoteDataSource activitiesRemoteDataSource;

  ActivityRepostiryImpl({
    required this.networkInfo,
    required this.activitiesRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<ActivityEntity>>> getActivitesList(
      String cityId) async {
    // TODO: implement getActivitesList
    if (await networkInfo.isConnected) {
      try {
        final remoteActivitesSource =
            await activitiesRemoteDataSource.getActivitiesList(cityId);
        return Right(remoteActivitesSource);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
