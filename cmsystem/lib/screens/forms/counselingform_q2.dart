import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cmsystem/screens/forms/counselingform_q3.dart';

class CounselingFormQ2 extends StatefulWidget {
  const CounselingFormQ2({super.key});

  @override
  _CounselingFormQ2State createState() => _CounselingFormQ2State();
}

class _CounselingFormQ2State extends State<CounselingFormQ2> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? selectedTime;
  List<String> fullyBookedTimes = ['15:00-16:00'];

  final List<DateTime> fullyBookedDates = [
    DateTime(2024, 10, 5),
    DateTime(2024, 10, 9),
    DateTime(2024, 10, 11),
    DateTime(2024, 10, 13),
    DateTime(2024, 10, 17),
    DateTime(2024, 10, 18),
    DateTime(2024, 10, 25),
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
              const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildCalendar(),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.brown),
                  SizedBox(width: 6),
                  Text("Fully Booked Dates", style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 20),
              _buildTimeSelection(),
              _buildTextField('Course & Year'),
              _buildTextField('College Department'),
              _buildTextField('Date of Birth'),
              _buildTextField('Age / Sex'),
              _buildTextField('Contact No.'),
              _buildTextField('Present Address'),
              _buildTextField('Emergency contact person'),
              _buildTextField('Emergency contact person’s contact no.'),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedDay == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CounselingFormQ3()),
                      );
                    }
                  },

                  // onPressed: () {
                  //   if (_selectedDay == null) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Please select a date')),
                  //     );
                  //   } else {
                  //     // Navigate to next screen or process form
                  //   }
                  // },
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

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.black),
        rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.black),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.pink.shade200,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.pink,
          shape: BoxShape.circle,
        ),
        markerDecoration: const BoxDecoration(
          color: Colors.brown,
          shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          final isFullyBooked = fullyBookedDates.any((d) =>
              d.year == day.year && d.month == day.month && d.day == day.day);
          if (isFullyBooked) {
            return Positioned(
              bottom: 1,
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.brown,
                ),
              ),
            );
          }
          return null;
        },
      ),
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
