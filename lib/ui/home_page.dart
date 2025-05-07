import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr/blocs/location_bloc.dart';
import 'package:signalr/models/location_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationBloc(context.read())..add(StartConnection()),
      child: Scaffold(
        appBar: AppBar(title: Text('Real-Time Location Sharing')),
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationUpdate) {
              return Center(
                child: Text('Lat: ${state.location.lat}, Lon: ${state.location.lon}'),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<LocationBloc>().add(LocationSent(
              LocationModel(lat: 25.73736464, lon: 90.3644747),
            ));
          },
          child: Icon(Icons.send),
        ),
      ),
    );
  }
}
