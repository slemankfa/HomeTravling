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
import 'package:home_travling/featuers/get_activites/data/datasource/activites_remote_data_source.dart';
import 'package:home_travling/featuers/get_activites/data/repositories/activites_repostiry_impl.dart';
import 'package:home_travling/featuers/get_activites/domain/repositories/activites_repostiry.dart';
import 'package:home_travling/featuers/get_activites/domain/usecases/get_activites_list.dart';
import 'package:home_travling/featuers/get_activites/presentation/bloc/fetch_activities_bloc.dart';

// service locater
final sl = GetIt.instance;

Future<void> init() async {
  //! Featuers - Activities
  sl.registerFactory(() => FetchActivitiesBloc(getActivitesList: sl()));

  // usecase
  sl.registerLazySingleton(() => GetActivitesList(sl()));

  // Repostiry
  sl.registerLazySingleton<ActivitiesRepostiry>(
    () => ActivitiesRepostiryImpl(
        activitiesRemoteDataSource: sl(), networkInfo: sl()),
  );

  // Data Source
  sl.registerLazySingleton<ActivitiesRemoteDataSource>(
      () => ActivitiesRemoteDataSourceImpl(sl()));
  //! Featuers - Countries
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
