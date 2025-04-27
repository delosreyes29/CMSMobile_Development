//Referral form

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q9.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselingFormQ10 extends StatefulWidget {
  const CounselingFormQ10({super.key});

  @override
  _CounselingFormQ12State createState() => _CounselingFormQ12State();
}

class _CounselingFormQ12State extends State<CounselingFormQ10> {
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController courseYearController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController otherConcernsController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController referredByController = TextEditingController();

  final List<String> personalConcerns = [
    "Adjustment to college life",
    "Attitudes toward studies",
    "Financial problems",
    "Health",
    "Lack of self-confidence/Self-esteem",
    "Relationship with family/friends/BF/GF"
  ];
  final List<String> academicConcerns = [
    "Unmet Subject requirements/projects",
    "Attendance: absences/tardiness",
    "Course choice: own/somebody else",
    "Failing grade",
    "School choice",
    "Study habit",
    "Time management/schedule"
  ];
  Map<String, bool> personalSelected = {};
  Map<String, bool> academicSelected = {};

  @override
  void initState() {
    super.initState();
    personalSelected = {for (var concern in personalConcerns) concern: false};
    academicSelected = {for (var concern in academicConcerns) concern: false};
  }

  void _submitReferral() async {
    try {
      // Collect referral data
      final referralData = {
        'clientName': clientNameController.text,
        'courseYear': courseYearController.text,
        'date': dateController.text,
        'time': timeController.text,
        'personalConcerns': personalSelected.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList(),
        'academicConcerns': academicSelected.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList(),
        'otherConcerns': otherConcernsController.text,
        'remarks': remarksController.text,
        'referredBy': referredByController.text,
      };

      // Submit to Firestore
      await FirebaseFirestore.instance
          .collection('referrals')
          .add(referralData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Referral submitted successfully!")),
      );

      // Navigate to CounselingFormQ9
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CounselingFormQ9()),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text =
            "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    clientNameController.dispose();
    courseYearController.dispose();
    dateController.dispose();
    timeController.dispose();
    otherConcernsController.dispose();
    remarksController.dispose();
    referredByController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Referral Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client Information Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Client Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: clientNameController,
                        decoration: const InputDecoration(
                          labelText: "Client's Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: courseYearController,
                        decoration: const InputDecoration(
                          labelText: "Course/Year",
                          prefixIcon: Icon(Icons.school),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "College",
                          prefixIcon: Icon(Icons.account_balance),
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          "College of Accounting and Business Education",
                          "College of Arts and Humanities",
                          "College of Computer Studies",
                          "College of Engineering and Architecture",
                          "College of Human Environmental Sciences and Food Studies",
                          "College of Music",
                          "College of Medical and Biological Science",
                          "College of Nursing",
                          "College of Pharmacy and Chemistry",
                          "College of Teacher Education"
                        ].map((college) {
                          return DropdownMenuItem<String>(
                            value: college,
                            child: Text(college),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            // Handle selected college
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: dateController,
                            decoration: const InputDecoration(
                              labelText: "Date",
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: timeController,
                            decoration: const InputDecoration(
                              labelText: "Time",
                              prefixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Personal/Social Concerns Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Personal/Social Concerns",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...personalConcerns.map((concern) {
                        return CheckboxListTile(
                          title: Text(concern),
                          value: personalSelected[concern],
                          onChanged: (value) {
                            setState(() {
                              personalSelected[concern] = value!;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Academic Concerns Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Academic Concerns",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...academicConcerns.map((concern) {
                        return CheckboxListTile(
                          title: Text(concern),
                          value: academicSelected[concern],
                          onChanged: (value) {
                            setState(() {
                              academicSelected[concern] = value!;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Other Concerns Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Other Concerns",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: otherConcernsController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: "Other Concerns (Please specify)",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: remarksController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: "Observations/Remarks",
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: referredByController,
                        decoration: const InputDecoration(
                          labelText: "Referred by",
                          prefixIcon: Icon(Icons.person_add),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _submitReferral,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Submit Referral',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
