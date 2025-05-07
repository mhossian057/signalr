import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr/blocs/location_bloc.dart';
import 'package:signalr/models/location_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Real-Time Location Sharing')),
          body: Column(
            children: [
              Text('User A', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child:
                    state is LocationUpdate
                        ? Center(child: Text('Lat: ${state.location.lat}, Lon: ${state.location.lon}'))
                        : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text(
                                'Waiting for location change',
                                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.green.shade100,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('User B', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Column(
                        children: [
                          Text(
                            'Sending the change of location to User A',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          state is LocationSupposeToUpdate
                              ? Text(
                                'Lat: ${state.location.lat.toStringAsFixed(6)}\nLon: ${state.location.lon.toStringAsFixed(6)}',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              )
                              : Text(
                                'Updating location in 5 sec',
                                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<LocationBloc>().add(LocationSent(LocationModel(lat: 25.73736464, lon: 90.3644747)));
            },
            child: Icon(Icons.send),
          ),
        );
      },
    );
  }
}
