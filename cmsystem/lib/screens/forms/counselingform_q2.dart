import 'package:flutter/material.dart';

class CounselingFormQ2 extends StatefulWidget {
  @override
  _CounselingFormQ2State createState() => _CounselingFormQ2State();
}

class _CounselingFormQ2State extends State<CounselingFormQ2> {
  DateTime? selectedDate;
  String? selectedTime;
  List<String> fullyBookedTimes = ['15:00-16:00'];

  // ✅ Function to show the date picker when clicking "Select Date"
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024, 3, 1),
      lastDate: DateTime(2025, 12, 31),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.pink,
            hintColor: Colors.pink,
            colorScheme: ColorScheme.light(primary: Colors.pink),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        title: const Text('Student Initial/Routine Interview',
            style: TextStyle(fontWeight: FontWeight.bold)),
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

              // ✅ Date Picker Section (Now Responsive)
              _buildDatePicker(context),

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
                    if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date')),
                      );
                    } else {
                      // Navigate to next screen
                    }
                  },
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

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _selectDate(context), // ✅ Now triggers the calendar
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null
                      ? 'Select Date'
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  style: TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today, color: Colors.pink),
              ],
            ),
          ),
        ),
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
