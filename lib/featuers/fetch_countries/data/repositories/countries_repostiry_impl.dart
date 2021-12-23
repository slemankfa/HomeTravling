import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/repositories/countries_repostiry.dart';
import '../datasources/countries_remote_data_source.dart';

typedef Future<List<CountryEntity>> _LoadCountriesOrLoadMoreList();

class CountryRepostiryImpl implements CountriesRepositry {
  final NetworkInfo networkInfo;
  final CountriesRemoteDataSource remoteDataSource;

  CountryRepostiryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountriesList() async {
    return _loadCountries(() {
      return remoteDataSource.getCountriesList();
    });
  }

  @override
  Future<Either<Failure, List<CountryEntity>>> loadMoreCountriesList(
      DocumentSnapshot lastDocumentSnapshot) async {
    return _loadCountries(() {
      return remoteDataSource.loadMoreCountriesList(lastDocumentSnapshot);
    });
  }

  Future<Either<Failure, List<CountryEntity>>> _loadCountries(
      _LoadCountriesOrLoadMoreList loadCountriesOrLoadMoreList) async {
    networkInfo.isConnected;
    if (await networkInfo.isConnected) {
      try {
        final remoreCounrtiesSource = await loadCountriesOrLoadMoreList();
        return Right(remoreCounrtiesSource);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
