import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:home_travling/core/network/network_info.dart';
import 'package:home_travling/featuers/fetch_countries/data/datasources/countries_remote_data_source.dart';
import 'package:home_travling/featuers/fetch_countries/data/repositories/countries_repostiry_impl.dart';
import 'package:home_travling/featuers/fetch_countries/domain/repositories/countries_repostiry.dart';
import 'package:home_travling/featuers/fetch_countries/domain/usecases/get_countries_list.dart';
import 'package:home_travling/featuers/fetch_countries/presentation/bloc/fetch_countries_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// service locater
final sl = GetIt.instance;

Future<void> init() async {
  //! Featuers - Countries
  // sl.registerFactory(() => CountriesProvider(
  //       getCountriesList: sl(),
  //       loadMoreCountriesList: sl(),
  //     ));

  sl.registerFactory(() =>
      FetchCountriesBloc(getCountriesList: sl(), ));
  // use cases
  sl.registerLazySingleton(() => GetCountriesList(sl()));

  // Repostiry
  sl.registerLazySingleton<CountriesRepositry>(
      () => CountryRepostiryImpl(networkInfo: sl(), remoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<CountriesRemoteDataSource>(
      () => CountriesRemoteDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! Externals
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => firestore);
}