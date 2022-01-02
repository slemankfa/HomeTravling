import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/failuer_message.dart';
import '../../domain/entites/activity_entity.dart';
import '../../domain/usecases/get_activites_list.dart';

part 'fetch_activities_event.dart';
part 'fetch_activities_state.dart';

class FetchActivitiesBloc
    extends Bloc<FetchActivitiesEvent, FetchActivitiesState> {
  final GetActivitesList getActivitesList;
  FetchActivitiesBloc({required this.getActivitesList}) : super(EmptyState()) {
    on<GetActivitiesEvent>(_onActivitesFitched);
  }

  FutureOr<void> _onActivitesFitched(
      GetActivitiesEvent event, Emitter<FetchActivitiesState> emit) async {
    emit(LoadingState());
    final failureOrGetActivites =
        await getActivitesList(Params(cityId: event.cityId));

    failureOrGetActivites.fold(
        (failure) => emit(ErrorState(message: mapFailureToMessage(failure))),
        (fetchActivites) => emit(LoadedState(loadedActivites: fetchActivites)));
  }
}
