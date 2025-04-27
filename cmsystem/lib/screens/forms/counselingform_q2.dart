//yes

import 'package:cmsystem/screens/forms/counselingform_q3.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emergencyContactController =
      TextEditingController();
  final TextEditingController emergencyContactNoController =
      TextEditingController();

  String? selectedCollege;
  String? selectedSex;

  final List<String> collegeOptions = [
    'College of Accounting and Business Education',
    'College of Arts and Humanities',
    'College of Computer Studies',
    'College of Engineering and Architecture',
    'College of Human Environmental Sciences and Food Studies',
    'College of Music',
    'College of Medical and Biological Science',
    'College of Nursing',
    'College of Pharmacy and Chemistry',
    'College of Teacher Education',
  ];

  final List<String> sexOptions = ['Male', 'Female', 'Other'];

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
        ageController.text.isNotEmpty &&
        selectedSex != null &&
        selectedCollege != null &&
        _selectedDay != null &&
        selectedTime != null &&
        !_isTimeFullyBooked() &&
        dobController.text.isNotEmpty &&
        contactController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        emergencyContactController.text.isNotEmpty &&
        emergencyContactNoController.text.isNotEmpty;
  }

  bool _isTimeFullyBooked() {
    if (selectedTime == null) return false;
    final selected = selectedTime!.format(context);
    return fullyBookedTimes.contains(selected);
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
              _buildTextField('Age', ageController),
              _buildDropdown('Sex', sexOptions, selectedSex, (value) {
                setState(() {
                  selectedSex = value;
                });
              }),
              _buildDropdown(
                  'College Department', collegeOptions, selectedCollege,
                  (value) {
                setState(() {
                  selectedCollege = value;
                });
              }),
              _buildDateOfBirthField('Date of Birth', dobController),
              _buildTextField('Contact No.', contactController),
              _buildTextField('Present Address', addressController),
              _buildTextField(
                  'Emergency contact person', emergencyContactController),
              _buildTextField('Emergency contact person’s contact no.',
                  emergencyContactNoController),
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
              Center(
                child: ElevatedButton(
                  onPressed: _isFormValid()
                      ? () async {
                          try {
                            // Prepare data to store in Firestore
                            final formData = {
                              'fullName': fullNameController.text,
                              'uicId': uicIdController.text,
                              'email': emailController.text,
                              'age': ageController.text,
                              'sex': selectedSex,
                              'college': selectedCollege,
                              'selectedDate': _selectedDay != null
                                  ? "${_selectedDay!.year}-${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day.toString().padLeft(2, '0')}"
                                  : null,
                              'selectedTime': selectedTime?.format(context),
                              'dob': dobController.text,
                              'contact': contactController.text,
                              'address': addressController.text,
                              'emergencyContact':
                                  emergencyContactController.text,
                              'emergencyContactNo':
                                  emergencyContactNoController.text,
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
                                builder: (context) =>
                                    CounselingFormQ3(documentId: documentId),
                              ),
                            );

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Form updated successfully!')),
                            );
                          } catch (e) {
                            // Handle Firestore errors
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
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
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, String? value,
      void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        value: value,
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: onChanged,
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
              final selectedFormatted = picked.format(context);

              if (hour < 7 || hour >= 17) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Please choose a time between 7:00 AM and 5:00 PM'),
                  ),
                );
              } else if (fullyBookedTimes.contains(selectedFormatted)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Selected time is already fully booked'),
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

  Widget _buildDateOfBirthField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900), // Earliest selectable date
            lastDate: DateTime.now(), // Latest selectable date
          );

          if (pickedDate != null) {
            setState(() {
              controller.text =
                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
            });
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
