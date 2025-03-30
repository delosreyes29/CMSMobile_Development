import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q11.dart';

class CounselingFormQ12 extends StatefulWidget {
  @override
  _CounselingFormQ12State createState() => _CounselingFormQ12State();
}

class _CounselingFormQ12State extends State<CounselingFormQ12> {
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController courseYearController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
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

  void _submitReferral() {
    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Referral submitted successfully!")),
    );

    // Redirect to CounselingFormQ11
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CounselingFormQ11()),
    );
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
              TextField(
                controller: clientNameController,
                decoration: const InputDecoration(labelText: "Client's Name"),
              ),
              TextField(
                controller: courseYearController,
                decoration: const InputDecoration(labelText: "Course/Year"),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: "Date"),
              ),
              const SizedBox(height: 10),
              const Text("Personal/Social Concerns",
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
              }).toList(),
              const SizedBox(height: 10),
              const Text("Academic Concerns",
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
              }).toList(),
              TextField(
                controller: otherConcernsController,
                decoration: const InputDecoration(
                    labelText: "Other Concerns (Please specify)"),
              ),
              TextField(
                controller: remarksController,
                decoration:
                    const InputDecoration(labelText: "Observations/Remarks"),
              ),
              TextField(
                controller: referredByController,
                decoration: const InputDecoration(labelText: "Referred by"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitReferral,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
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
