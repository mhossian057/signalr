import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/location_model.dart';
import '../services/signalr_service.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final SignalRService signalRService;

  LocationBloc(this.signalRService) : super(LocationInitial()) {
    on<StartConnection>((event, emit) async {
      await signalRService.initConnection();
      signalRService.onReceiveLatLon((lat, lon) {
        add(LocationReceived(LocationModel(lat: lat, lon: lon)));
      });
    });

    on<LocationSent>((event, emit) async {
      await signalRService.sendLatLon(event.location.lat, event.location.lon);
    });

    on<LocationReceived>((event, emit) {
      emit(LocationUpdate(event.location));
    });
  }
}
