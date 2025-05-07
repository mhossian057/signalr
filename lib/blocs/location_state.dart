part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationUpdate extends LocationState {
  final LocationModel location;

  LocationUpdate(this.location);

  @override
  List<Object?> get props => [location];
}
