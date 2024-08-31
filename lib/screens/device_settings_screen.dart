import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/device_settings_bloc.dart';
import '../bloc/device_settings_event.dart';
import '../bloc/device_settings_state.dart';

class DeviceSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device settings"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<DeviceSettingsBloc, DeviceSettingsState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                _buildVacationTimeCard(context, state),
                SizedBox(height: 10),
                _buildMiddleSection(context, state),
                SizedBox(height: 10),
                _buildInfoCard(
                  context,
                  'Occupied cabinets',
                  '1, 2, 3, 4, 5',
                ),
                Divider(),
                _buildAlarmSettingsCard(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildVacationTimeCard(
      BuildContext context, DeviceSettingsState state) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color:
              state.isVacationTimeEnabled ? Colors.cyan : Colors.grey.shade300,
          width: 2.0,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            activeColor: Colors.cyan,
            title: Text('Set vacation time'),
            value: state.isVacationTimeEnabled,
            onChanged: (value) {
              context.read<DeviceSettingsBloc>().add(ToggleVacationTime(value));
            },
            contentPadding: EdgeInsets.zero,
          ),
          if (state.isVacationTimeEnabled) ...[
            SizedBox(height: 10),
            _buildDateTimePicker(
              context,
              'Start date & time',
              state.startDateTime,
              (value) {
                context
                    .read<DeviceSettingsBloc>()
                    .add(UpdateStartDateTime(value));
              },
            ),
            SizedBox(height: 10),
            _buildDateTimePicker(
              context,
              'End date & time',
              state.endDateTime,
              (value) {
                context
                    .read<DeviceSettingsBloc>()
                    .add(UpdateEndDateTime(value));
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMiddleSection(BuildContext context, DeviceSettingsState state) {
    return Column(
      children: [
        _buildSettingItem(
          context,
          'Show meds name',
          state.showMedsName,
          (value) {
            context.read<DeviceSettingsBloc>().add(ToggleShowMedsName(value));
          },
        ),
        _buildDivider(), // Use the existing _buildDivider here
        _buildSettingItem(
          context,
          'Notify pharma to autofill',
          state.notifyPharma,
          (value) {
            context.read<DeviceSettingsBloc>().add(ToggleNotifyPharma(value));
          },
        ),
        _buildDivider(), // Use the existing _buildDivider here
        _buildSettingItem(
          context,
          'Add sorry time',
          state.addSorryTime,
          (value) {
            context.read<DeviceSettingsBloc>().add(ToggleAddSorryTime(value));
          },
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: SwitchListTile(
        activeColor: Colors.cyan,
        title: Text(title),
        value: value,
        onChanged: onChanged,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String info,
  ) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(info),
      ),
    );
  }

  Widget _buildDateTimePicker(
    BuildContext context,
    String label,
    String initialValue,
    ValueChanged<String> onChanged,
  ) {
    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (selectedDate != null) {
          TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (selectedTime != null) {
            final formattedDate =
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ${selectedTime.format(context)}";
            onChanged(formattedDate);
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          initialValue.isEmpty ? 'Select Date & Time' : initialValue,
        ),
      ),
    );
  }

  Widget _buildAlarmSettingsCard(
      BuildContext context, DeviceSettingsState state) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alarm settings',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildDropDownMenu(
              context,
              'Alarm tune',
              state.alarmTune,
              (value) {
                context.read<DeviceSettingsBloc>().add(UpdateAlarmTune(value));
              },
              ['Rooster', 'Chimes', 'Sweet piano'],
            ),
            SizedBox(height: 16),
            _buildDropDownMenu(
              context,
              'Alarm strength',
              state.alarmStrength,
              (value) {
                showPickerPopup(
                  context,
                  'Select strength',
                  ['Low', 'Medium', 'Louder'],
                  value,
                  (newValue) {
                    context
                        .read<DeviceSettingsBloc>()
                        .add(UpdateAlarmStrength(newValue));
                  },
                );
              },
              ['Low', 'Medium', 'Louder'], // Missing items argument
            ),
            _buildDropDownMenu(
              context,
              'Snooze',
              state.snoozeDuration,
              (value) {
                showPickerPopup(
                  context,
                  'Select snooze',
                  ['5mins', '10mins', '15mins'],
                  value,
                  (newValue) {
                    context
                        .read<DeviceSettingsBloc>()
                        .add(UpdateSnoozeDuration(newValue));
                  },
                );
              },
              ['5mins', '10mins', '15mins'], // This is the missing argument
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownMenu(
    BuildContext context,
    String label,
    String selectedValue,
    ValueChanged<String> onChanged,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.0),
        GestureDetector(
          onTap: () async {
            if (label == "Alarm tune") {
              onChanged(await _showAlarmTunePopup(context, selectedValue) ??
                  selectedValue);
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedValue),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> _showAlarmTunePopup(
      BuildContext context, String currentTune) async {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPopupHeader(context, 'Select tune'),
              _buildDivider(),
              CupertinoPicker(
                itemExtent: 40.0,
                scrollController: FixedExtentScrollController(
                  initialItem:
                      ['Rooster', 'Chimes', 'Sweet piano'].indexOf(currentTune),
                ),
                onSelectedItemChanged: (int index) {
                  Navigator.pop(
                      context, ['Rooster', 'Chimes', 'Sweet piano'][index]);
                },
                children: [
                  Center(child: Text('Rooster')),
                  Center(child: Text('Chimes')),
                  Center(child: Text('Sweet piano')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showPickerPopup(BuildContext context, String title, List<String> options,
      String selectedValue, ValueChanged<String> onSelected) {
    showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPopupHeader(context, title),
              _buildDivider(),
              CupertinoPicker(
                itemExtent: 40.0,
                scrollController: FixedExtentScrollController(
                  initialItem: options.indexOf(selectedValue),
                ),
                onSelectedItemChanged: (int index) {
                  onSelected(options[index]);
                },
                children: options
                    .map((option) => Center(child: Text(option)))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPopupHeader(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 24),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade300,
      height: 1,
      thickness: 1,
    );
  }
}
