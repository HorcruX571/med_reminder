// device_settings_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'device_settings_event.dart';
import 'device_settings_state.dart';

class DeviceSettingsBloc
    extends Bloc<DeviceSettingsEvent, DeviceSettingsState> {
  DeviceSettingsBloc()
      : super(DeviceSettingsState(
          isVacationTimeEnabled: false,
          startDateTime: '',
          endDateTime: '',
          showMedsName: false,
          notifyPharma: false,
          addSorryTime: false,
          alarmTune: 'Rooster',
          alarmStrength: 'Louder',
          snoozeDuration: '5mins',
        )) {
    on<ToggleVacationTime>(_onToggleVacationTime);
    on<UpdateStartDateTime>(_onUpdateStartDateTime);
    on<UpdateEndDateTime>(_onUpdateEndDateTime);
    on<ToggleShowMedsName>(_onToggleShowMedsName);
    on<ToggleNotifyPharma>(_onToggleNotifyPharma);
    on<ToggleAddSorryTime>(_onToggleAddSorryTime);
    on<UpdateAlarmTune>(_onUpdateAlarmTune);
    on<UpdateAlarmStrength>(_onUpdateAlarmStrength);
    on<UpdateSnoozeDuration>(_onUpdateSnoozeDuration);
  }

  void _onToggleVacationTime(
      ToggleVacationTime event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(isVacationTimeEnabled: event.isEnabled));
  }

  void _onUpdateStartDateTime(
      UpdateStartDateTime event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(startDateTime: event.startDateTime));
  }

  void _onUpdateEndDateTime(
      UpdateEndDateTime event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(endDateTime: event.endDateTime));
  }

  void _onToggleShowMedsName(
      ToggleShowMedsName event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(showMedsName: event.showMedsName));
  }

  void _onToggleNotifyPharma(
      ToggleNotifyPharma event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(notifyPharma: event.notifyPharma));
  }

  void _onToggleAddSorryTime(
      ToggleAddSorryTime event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(addSorryTime: event.addSorryTime));
  }

  void _onUpdateAlarmTune(
      UpdateAlarmTune event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(alarmTune: event.alarmTune));
  }

  void _onUpdateAlarmStrength(
      UpdateAlarmStrength event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(alarmStrength: event.alarmStrength));
  }

  void _onUpdateSnoozeDuration(
      UpdateSnoozeDuration event, Emitter<DeviceSettingsState> emit) {
    emit(state.copyWith(snoozeDuration: event.snoozeDuration));
  }
}
