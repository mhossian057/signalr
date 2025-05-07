import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:signalr/services/location_simulator.dart';
import '../models/location_model.dart';
import '../services/signalr_service.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final SignalRService signalRService;
  final LocationSimulator simulator;

  LocationBloc(this.signalRService, this.simulator) : super(LocationInitial()) {
    on<StartConnection>((event, emit) async {
      await signalRService.initConnection();
      simulator.start();
      simulator.locationStream.listen((location) {
        add(LocationSent(location));
      });
      signalRService.onReceiveLatLon((lat, lon) {
        add(LocationReceived(LocationModel(lat: lat, lon: lon)));
      });
    });

    on<LocationSent>((event, emit) async {
      await signalRService.sendLatLon(event.location.lat, event.location.lon);
      emit(LocationSupposeToUpdate(event.location));
    });

    on<LocationReceived>((event, emit) {
      emit(LocationUpdate(event.location));
    });
  }

  @override
  Future<void> close() {
    simulator.stop();
    return super.close();
  }
}
