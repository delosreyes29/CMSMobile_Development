import 'package:flutter/material.dart';

class CounselingFormQ2_1 extends StatefulWidget {
  @override
  _CounselingFormQ2_1State createState() => _CounselingFormQ2_1State();
}

class _CounselingFormQ2_1State extends State<CounselingFormQ2_1> {
  DateTime? selectedDate;
  String? selectedTime;
  List<String> fullyBookedTimes = [
    '9:00-10:00',
    '12:00-13:00',
    '13:00-14:00',
    '14:00-15:00',
    '15:00-16:00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: const Text(
          'Student Initial/Routine Interview',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Request a counseling session',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildTextField('Full Name'),
              _buildTextField('UIC ID No.'),
              _buildTextField('UIC Email Address'),
              const SizedBox(height: 20),
              _buildDateCalendarWidget(),
              const SizedBox(height: 20),
              _buildTimeSelection(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade700,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Next',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildDateCalendarWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Center(
          child: CalendarDatePicker(
            initialDate: selectedDate ?? DateTime(2024, 10, 10),
            firstDate: DateTime(2024, 10, 1),
            lastDate: DateTime(2024, 10, 31),
            onDateChanged: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
        ),
        const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Icon(Icons.circle, size: 8, color: Colors.red),
              SizedBox(width: 5),
              Text('Fully Booked Dates', style: TextStyle(fontSize: 12)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Column(
          children: [
            _buildTimeCheckbox('9:00-10:00'),
            _buildTimeCheckbox('10:00-11:00'),
            _buildTimeCheckbox('11:00-12:00'),
            _buildTimeCheckbox('12:00-13:00'),
            _buildTimeCheckbox('13:00-14:00'),
            _buildTimeCheckbox('14:00-15:00'),
            _buildTimeCheckbox('15:00-16:00'),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeCheckbox(String time) {
    bool isBooked = fullyBookedTimes.contains(time);
    return Row(
      children: [
        Checkbox(
          value: selectedTime == time && !isBooked,
          onChanged: isBooked
              ? null
              : (bool? value) {
                  setState(() {
                    selectedTime = value == true ? time : null;
                  });
                },
        ),
        Text(time),
        if (isBooked)
          const Text(
            '  Fully Booked',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.pink.shade100,
      selectedItemColor: Colors.pink.shade700,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notif'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: 'Schedule'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
