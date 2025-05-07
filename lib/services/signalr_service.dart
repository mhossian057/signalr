import 'package:signalr_core/signalr_core.dart';

class SignalRService {
  late HubConnection connection;

  Future<void> initConnection() async {
    connection = HubConnectionBuilder()
        .withUrl('https://raintor-api.devdata.top/hub')
        .build();

    await connection.start();
  }

  Future<void> sendLatLon(double lat, double lon) async {
    await connection.invoke('SendLatLon', args: [lat, lon]);
  }

  void onReceiveLatLon(Function(double, double) callback) {
    connection.on('ReceiveLatLon', (message) {
      final lat = message?[0] as double;
      final lon = message?[1] as double;
      callback(lat, lon);
    });
  }

  Future<void> stopConnection() async {
    await connection.stop();
  }
}
