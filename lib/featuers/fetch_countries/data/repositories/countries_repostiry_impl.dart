import 'package:home_travling/core/error/exceptions.dart';
import 'package:home_travling/core/platform/network_info.dart';
import 'package:home_travling/featuers/fetch_countries/data/datasources/countries_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_countries/domain/entities/country_entity.dart';
import 'package:home_travling/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_travling/featuers/fetch_countries/domain/repositories/countries_repostiry.dart';

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
