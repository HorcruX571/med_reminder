// device_settings_event.dart

import 'package:equatable/equatable.dart';

abstract class DeviceSettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleVacationTime extends DeviceSettingsEvent {
  final bool isEnabled;

  ToggleVacationTime(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}

class UpdateStartDateTime extends DeviceSettingsEvent {
  final String startDateTime;

  UpdateStartDateTime(this.startDateTime);

  @override
  List<Object> get props => [startDateTime];
}

class UpdateEndDateTime extends DeviceSettingsEvent {
  final String endDateTime;

  UpdateEndDateTime(this.endDateTime);

  @override
  List<Object> get props => [endDateTime];
}

class ToggleShowMedsName extends DeviceSettingsEvent {
  final bool showMedsName;

  ToggleShowMedsName(this.showMedsName);

  @override
  List<Object> get props => [showMedsName];
}

class ToggleNotifyPharma extends DeviceSettingsEvent {
  final bool notifyPharma;

  ToggleNotifyPharma(this.notifyPharma);

  @override
  List<Object> get props => [notifyPharma];
}

class ToggleAddSorryTime extends DeviceSettingsEvent {
  final bool addSorryTime;

  ToggleAddSorryTime(this.addSorryTime);

  @override
  List<Object> get props => [addSorryTime];
}

class UpdateAlarmTune extends DeviceSettingsEvent {
  final String alarmTune;

  UpdateAlarmTune(this.alarmTune);

  @override
  List<Object> get props => [alarmTune];
}

class UpdateAlarmStrength extends DeviceSettingsEvent {
  final String alarmStrength;

  UpdateAlarmStrength(this.alarmStrength);

  @override
  List<Object> get props => [alarmStrength];
}

class UpdateSnoozeDuration extends DeviceSettingsEvent {
  final String snoozeDuration;

  UpdateSnoozeDuration(this.snoozeDuration);

  @override
  List<Object> get props => [snoozeDuration];
}
