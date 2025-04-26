import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsystem/screens/forms/counselingform_q3.dart';

class CounselingFormQ2 extends StatefulWidget {
  const CounselingFormQ2({super.key});

  @override
  _CounselingFormQ2State createState() => _CounselingFormQ2State();
}

class _CounselingFormQ2State extends State<CounselingFormQ2> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? selectedTime;

  List<String> fullyBookedTimes = [];
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController uicIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController courseYearController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageSexController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emergencyContactController =
      TextEditingController();
  final TextEditingController emergencyContactNoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchFullyBookedTimes(_focusedDay);
  }

  void _fetchFullyBookedTimes(DateTime date) async {
    String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final snapshot = await FirebaseFirestore.instance
        .collection('fully_booked')
        .doc(formattedDate)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      List<String> times = List<String>.from(snapshot.data()!['times'] ?? []);
      setState(() {
        fullyBookedTimes = times;
      });
    } else {
      setState(() {
        fullyBookedTimes = [];
      });
    }
  }

  bool _isFormValid() {
    return fullNameController.text.isNotEmpty &&
        uicIdController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        _selectedDay != null &&
        selectedTime != null &&
        courseYearController.text.isNotEmpty &&
        departmentController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        ageSexController.text.isNotEmpty &&
        contactController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        emergencyContactController.text.isNotEmpty &&
        emergencyContactNoController.text.isNotEmpty;
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
              _buildTextField('Full Name', fullNameController),
              _buildTextField('UIC ID No.', uicIdController),
              _buildTextField('UIC Email Address', emailController),
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
              _buildTimeDropdown(),
              const SizedBox(height: 20),
              _buildFullyBookedTable(),
              const SizedBox(height: 20),
              _buildTextField('Course & Year', courseYearController),
              _buildTextField('College Department', departmentController),
              _buildTextField('Date of Birth', dobController),
              _buildTextField('Age / Sex', ageSexController),
              _buildTextField('Contact No.', contactController),
              _buildTextField('Present Address', addressController),
              _buildTextField(
                  'Emergency contact person', emergencyContactController),
              _buildTextField('Emergency contact person’s contact no.',
                  emergencyContactNoController),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _isFormValid()
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CounselingFormQ3()),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 16),
                    backgroundColor: Colors.pink.shade700,
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
      firstDay: DateTime.now(), // ⛔ prevents past date selection
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        _fetchFullyBookedTimes(selectedDay);
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
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          final isFullyBooked = fullyBookedTimes.isNotEmpty &&
              _selectedDay != null &&
              isSameDay(_selectedDay!, day);
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
              final int hour = picked.hour;
              // ⛔ Block time before 6am or after 8pm
              if (hour < 7 || hour >= 17) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Please choose a time between 7:00 AM and 5:00 PM'),
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

  Widget _buildFullyBookedTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.pink.shade100,
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Fully Booked Time Slots',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              if (fullyBookedTimes.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('No fully booked time'),
                )
              else
                ...fullyBookedTimes.map((time) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(time)),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ],
    );
  }
}
