import 'package:flutter/material.dart';
import 'device_settings_screen.dart';

class AddMedicineInfoScreen extends StatefulWidget {
  @override
  _AddMedicineInfoScreenState createState() => _AddMedicineInfoScreenState();
}

class _AddMedicineInfoScreenState extends State<AddMedicineInfoScreen> {
  String _selectedFrequency = "Daily"; // Track selected frequency
  List<Widget> _alarmWidgets = [];

  @override
  void initState() {
    super.initState();
    // Initialize with one alarm time & dose input
    _alarmWidgets.add(_buildTimeDoseCard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medicine Info"),
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to Device Settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeviceSettingsScreen()),
              );
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.cyan, fontSize: 16.0),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField("Medicine Name", "Enter Name"),
            SizedBox(height: 20),
            _buildFrequencyOptions(),
            SizedBox(height: 20),
            Column(
              children: _alarmWidgets,
            ),
          ],
        ),
      ),
      floatingActionButton: _buildAddMoreAlarmButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(
                255, 136, 136, 136), // Set the text color to grey
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Increased roundness
              borderSide: BorderSide(color: Colors.cyan), // Cyan accent
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.cyan, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFrequencyOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Frequency",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(
                255, 136, 136, 136), // Set the text color to grey
          ),
        ),
        SizedBox(height: 4),
        _buildRadioButton("Daily"),
        _buildRadioButton("Specific days"),
        _buildRadioButton("Interval"),
        _buildRadioButton("As needed"),
      ],
    );
  }

  Widget _buildRadioButton(String title) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 16.0), // Increase the text size
      ),
      value: title,
      groupValue: _selectedFrequency,
      onChanged: (value) {
        setState(() {
          _selectedFrequency = value.toString();
        });
      },
      dense: true,
      activeColor: Colors.cyan, // Cyan accent
    );
  }

  Widget _buildTimeDoseCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Set time & dose",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(
                255, 93, 93, 93), // Set the header text color to grey
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan), // Cyan accent
            borderRadius: BorderRadius.circular(30), // Increased roundness
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      // Handle the picked time
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "08:00",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "5 ml",
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddMoreAlarmButton() {
    return Container(
      width: 180,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // White background color
        borderRadius: BorderRadius.circular(30), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Soft shadow
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () {
          // Add more alarm
          setState(() {
            _alarmWidgets.add(_buildTimeDoseCard());
          });
        },
        icon: Icon(Icons.add_box_rounded,
            color: Colors.cyan, size: 24), // Bigger icon
        label: Text(
          "Add more alarm",
          style: TextStyle(
              color: Colors.cyan,
              fontSize: 16,
              fontWeight: FontWeight.bold), // Bigger text
        ),
      ),
    );
  }
}
