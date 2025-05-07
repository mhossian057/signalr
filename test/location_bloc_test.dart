import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:signalr/blocs/location_bloc.dart';
import 'package:signalr/models/location_model.dart';
import 'package:signalr/services/location_simulator.dart';
import 'package:signalr/services/signalr_service.dart';
import 'package:mocktail/mocktail.dart';

class MockSignalRService extends Mock implements SignalRService {}

class MockLocationSimulator extends Mock implements LocationSimulator {}

void main() {
  late MockSignalRService mockService;
  late MockLocationSimulator mockLocationSimulator;

  setUp(() {
    mockService = MockSignalRService();
    mockLocationSimulator = MockLocationSimulator();
  });

  blocTest<LocationBloc, LocationState>(
    'emits LocationUpdate when LocationReceived is added',
    build: () => LocationBloc(mockService, mockLocationSimulator),
    act: (bloc) => bloc.add(LocationReceived(LocationModel(lat: 1.0, lon: 2.0))),
    expect: () => [isA<LocationUpdate>()],
  );
}
