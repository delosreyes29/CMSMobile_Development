//no

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cmsystem/screens/forms/counselingform_q3.dart';

class CounselingFormQ2_1 extends StatefulWidget {
  const CounselingFormQ2_1({super.key});

  @override
  State<CounselingFormQ2_1> createState() => _CounselingFormQ2_1State();
}

class _CounselingFormQ2_1State extends State<CounselingFormQ2_1> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? selectedTime;
  List<String> fullyBookedTimes = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchFullyBookedTimes(_focusedDay);
  }

  Future<void> _fetchFullyBookedTimes(DateTime date) async {
    final formattedDate =
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    final snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .doc(formattedDate)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      final data = snapshot.data();
      if (data != null && data.containsKey('times')) {
        setState(() {
          fullyBookedTimes = List<String>.from(data['times']);
        });
      } else {
        setState(() {
          fullyBookedTimes = [];
        });
      }
    } else {
      setState(() {
        fullyBookedTimes = [];
      });
    }
  }

  void _onNextPressed() async {
    if (nameController.text.isEmpty ||
        idController.text.isEmpty ||
        emailController.text.isEmpty ||
        _selectedDay == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields before proceeding."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Prepare data to store in Firestore
      final formData = {
        'fullName': nameController.text,
        'uicId': idController.text,
        'email': emailController.text,
        'selectedDate': _selectedDay != null
            ? "${_selectedDay!.year}-${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day.toString().padLeft(2, '0')}"
            : null,
        'selectedTime': selectedTime?.format(context),
      };

      // Store data in Firestore and get the document ID
      final docRef = await FirebaseFirestore.instance
          .collection('counselingForms')
          .add(formData);

      final documentId = docRef.id; // Get the document ID

      // Navigate to CounselingFormQ3 and pass the document ID
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CounselingFormQ3(documentId: documentId),
        ),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    } catch (e) {
      // Handle Firestore errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!selectedDay.isBefore(DateTime.now())) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          _fetchFullyBookedTimes(selectedDay);
        }
      },
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.pink.shade200,
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: Colors.pink,
          shape: BoxShape.circle,
        ),
        markerDecoration: const BoxDecoration(
          color: Colors.brown,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildTimeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              final hour = picked.hour;
              if (hour >= 17 || hour < 7) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please select a time between 7:00 AM and 5:00 PM.",
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                setState(() {
                  selectedTime = picked;
                });
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTime != null
                      ? selectedTime!.format(context)
                      : 'Select Time',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.access_time),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _isFormValid() {
    return nameController.text.isNotEmpty &&
        idController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        _selectedDay != null &&
        selectedTime != null;
  }

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
              _buildTextField('Full Name', nameController),
              _buildTextField('UIC ID No.', idController),
              _buildTextField('UIC Email Address', emailController),
              const SizedBox(height: 20),
              const Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildCalendar(),
              const SizedBox(height: 20),
              _buildTimeDropdown(),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _isFormValid() ? _onNextPressed : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 16),
                    backgroundColor: _isFormValid()
                        ? Colors.pink.shade700
                        : Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
