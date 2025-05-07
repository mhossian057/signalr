import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRService {
  late HubConnection connection;

  Future<void> initConnection() async {
    connection = HubConnectionBuilder().withUrl('https://raintor-api.devdata.top/hub').build();

    await connection.start();
  }

  Future<void> sendLatLon(double lat, double lon) async {
    await connection.invoke('SendLatLon', args: [lat, lon]);
  }

  void onReceiveLatLon(Function(double, double) callback) {
    connection.on('ReceiveLatLon', (message) {
      double lat = 0.0;
      double lon = 0.0;
      if (message is List && message.isNotEmpty) {
        final firstItem = message.first;

        if (firstItem is Map && firstItem.containsKey('lat') && firstItem.containsKey('lon')) {
          lat = firstItem['lat'] as double;
          lon = firstItem['lon'] as double;
        } else {
          debugPrint('Unexpected list item format: $firstItem');
          return;
        }
      } else {
        debugPrint('Unexpected message format: $message');
        return;
      }
      callback(lat, lon);
    });
  }

  Future<void> stopConnection() async {
    await connection.stop();
  }
}
