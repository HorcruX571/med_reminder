import 'package:flutter/material.dart';
import 'screens/add_medicine_info_screen.dart';
import 'screens/device_settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/device_settings_bloc.dart';
import 'bloc/device_settings_event.dart';
import 'bloc/device_settings_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeviceSettingsBloc>(
          create: (context) => DeviceSettingsBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddMedicineInfoScreen(),
      ),
    );
  }
}
