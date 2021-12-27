// import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  /// [InternetConnectionChecker] dose not support flutter web  :(
  // final InternetConnectionChecker internetConnectionChecker ;

  // NetworkInfoImpl(this.internetConnectionChecker);

  @override
  // TODO: implement isConnected
  // Future<bool> get isConnected => internetConnectionChecker.hasConnection;
  /// The temporary value will be true until we find a solution for all platforms
  Future<bool> get isConnected => Future.value(true);
}
