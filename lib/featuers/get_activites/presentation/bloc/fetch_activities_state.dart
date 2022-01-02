part of 'fetch_activities_bloc.dart';

abstract class FetchActivitiesState extends Equatable {
  const FetchActivitiesState();

  @override
  List<Object> get props => [];
}

class EmptyState extends FetchActivitiesState {}

class LoadingState extends FetchActivitiesState {}

class LoadedState extends FetchActivitiesState {
  final List<ActivityEntity> loadedActivites;

  LoadedState({required this.loadedActivites});
}

class ErrorState extends FetchActivitiesState {
  final String message;

  const ErrorState({required this.message});
}
