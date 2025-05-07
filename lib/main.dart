import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr/services/location_simulator.dart' show LocationSimulator;
import 'package:signalr/services/signalr_service.dart';
import 'package:signalr/ui/home_page.dart';

import 'blocs/location_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationBloc(SignalRService(), LocationSimulator())..add(StartConnection()),
      child: MaterialApp(
        title: 'Flutter Signalr',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const HomePage(),
      ),
    );
  }
}
