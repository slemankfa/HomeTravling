part of 'fetch_activities_bloc.dart';

abstract class FetchActivitiesEvent extends Equatable {
  const FetchActivitiesEvent();

  @override
  List<Object> get props => [];
}

class GetActivitiesEvent extends FetchActivitiesEvent {
  final String cityId;

  const GetActivitiesEvent({required this.cityId});
}
