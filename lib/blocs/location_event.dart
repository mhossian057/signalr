part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartConnection extends LocationEvent {}

class LocationSent extends LocationEvent {
  final LocationModel location;

  LocationSent(this.location);

  @override
  List<Object?> get props => [location];
}

class LocationReceived extends LocationEvent {
  final LocationModel location;

  LocationReceived(this.location);

  @override
  List<Object?> get props => [location];
}
