import 'dart:async';
import 'dart:math';
import 'package:signalr/models/location_model.dart';

class LocationSimulator {
  final _random = Random();
  final _controller = StreamController<LocationModel>();
  final double baseLat = 25.73736464;
  final double baseLon = 90.3644747;

  Stream<LocationModel> get locationStream => _controller.stream;

  void start() {
    Timer.periodic(Duration(seconds: 10), (_) {
      final latOffset = (_random.nextDouble() - 0.5) / 500;
      final lonOffset = (_random.nextDouble() - 0.5) / 500;

      final lat = baseLat + latOffset;
      final lon = baseLon + lonOffset;

      final location = LocationModel(lat: lat, lon: lon);
      _controller.add(location);
    });
  }

  void stop() {
    _controller.close();
  }
}
