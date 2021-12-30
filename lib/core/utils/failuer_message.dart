import 'package:easy_localization/src/public_ext.dart';
import 'package:home_travling/core/error/failure.dart';

String mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return "SERVER_FAILURE_MESSAGE".tr();

    default:
      return "UNEXPECTED_ERROR_MESSAGE".tr();
  }
}
