// device_settings_state.dart

import 'package:equatable/equatable.dart';

class DeviceSettingsState extends Equatable {
  final bool isVacationTimeEnabled;
  final String startDateTime;
  final String endDateTime;
  final bool showMedsName;
  final bool notifyPharma;
  final bool addSorryTime;
  final String alarmTune;
  final String alarmStrength;
  final String snoozeDuration;

  const DeviceSettingsState({
    required this.isVacationTimeEnabled,
    required this.startDateTime,
    required this.endDateTime,
    required this.showMedsName,
    required this.notifyPharma,
    required this.addSorryTime,
    required this.alarmTune,
    required this.alarmStrength,
    required this.snoozeDuration,
  });

  DeviceSettingsState copyWith({
    bool? isVacationTimeEnabled,
    String? startDateTime,
    String? endDateTime,
    bool? showMedsName,
    bool? notifyPharma,
    bool? addSorryTime,
    String? alarmTune,
    String? alarmStrength,
    String? snoozeDuration,
  }) {
    return DeviceSettingsState(
      isVacationTimeEnabled:
          isVacationTimeEnabled ?? this.isVacationTimeEnabled,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      showMedsName: showMedsName ?? this.showMedsName,
      notifyPharma: notifyPharma ?? this.notifyPharma,
      addSorryTime: addSorryTime ?? this.addSorryTime,
      alarmTune: alarmTune ?? this.alarmTune,
      alarmStrength: alarmStrength ?? this.alarmStrength,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
    );
  }

  @override
  List<Object?> get props => [
        isVacationTimeEnabled,
        startDateTime,
        endDateTime,
        showMedsName,
        notifyPharma,
        addSorryTime,
        alarmTune,
        alarmStrength,
        snoozeDuration,
      ];
}
