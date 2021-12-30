import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/fetch_cities/data/datasource/cities_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_cities/data/repositories/cities_repostiry_impl.dart';
import 'package:home_travling/featuers/fetch_cities/domain/repositories/cities_repostiry.dart';
import 'package:home_travling/featuers/fetch_cities/domain/usecases/get_cities_list.dart';
import 'package:home_travling/featuers/fetch_cities/presentation/bloc/fetch_cities_bloc.dart';
import 'package:home_travling/featuers/fetch_countries/data/datasources/countries_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_countries/data/repositories/countries_repostiry_impl.dart';
import 'package:home_travling/featuers/fetch_countries/domain/repositories/countries_repostiry.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/get_countries_list.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';

// service locater
final sl = GetIt.instance;

Future<void> init() async {
  //! Featuers - Countries
  // sl.registerFactory(() => CountriesProvider(
  //       getCountriesList: sl(),
  //       loadMoreCountriesList: sl(),
  //     ));

  sl.registerFactory(() => FetchCountriesBloc(
        getCountriesList: sl(),
      ));
  // use cases
  sl.registerLazySingleton(() => GetCountriesList(sl()));

  // Repostiry
  sl.registerLazySingleton<CountriesRepositry>(
      () => CountryRepostiryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<CountriesRemoteDataSource>(
      () => CountriesRemoteDataSourceImpl(sl()));

//! Featuers - Cities
  sl.registerFactory(() => FetchCitiesBloc(getCistiesList: sl()));
// use cases
  sl.registerLazySingleton(() => GetCistiesList(sl()));
// Repostiry
  sl.registerLazySingleton<CitiesRepostiry>(
      () => CitiesRepostiryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<CitiesRemoteDataSource>(
      () => CitiesRemoteDataSourceImpl(sl()));
  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //! Externals
  final firestore = FirebaseFirestore.instance;
  // sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => firestore);
}
