//V. Academics

import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q9.dart';

class CounselingFormQ8 extends StatefulWidget {
  const CounselingFormQ8({super.key});

  @override
  State<CounselingFormQ8> createState() => _CounselingFormQ8State();
}

class _CounselingFormQ8State extends State<CounselingFormQ8> {
  // Checkbox states
  bool academicPerformance = false;
  bool homesickness = false;
  bool teacherIssue = false;
  bool notInterested = false;
  bool notHappy = false;
  bool othersSpecify = false;
  bool lateInClass = false;
  bool lessonDifficulty = false;

  final TextEditingController courseField = TextEditingController();
  final TextEditingController othersField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Initial/Routine Interview',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("V. Academics",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B0D1D))),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              value: academicPerformance,
              onChanged: (val) => setState(() => academicPerformance = val!),
              title: const Text(
                  "I am overly worried about my academic performance."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 10),
            const Text("I am not motivated to study because of"),
            CheckboxListTile(
              value: homesickness,
              onChanged: (val) => setState(() => homesickness = val!),
              title: const Text("Homesickness"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: teacherIssue,
              onChanged: (val) => setState(() => teacherIssue = val!),
              title: const Text("An issue with a teacher"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: notInterested,
              onChanged: (val) => setState(() => notInterested = val!),
              title: const Text("Not being prepared/interested in school"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: notHappy,
              onChanged: (val) => setState(() => notHappy = val!),
              title: const Text(
                  "Not being happy/interested in the course/school I am currently enrolling in"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: courseField,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "(Others, please specify)",
              ),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              value: lateInClass,
              onChanged: (val) => setState(() => lateInClass = val!),
              title: const Text("I have a problem being on time in class."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              value: lessonDifficulty,
              onChanged: (val) => setState(() => lessonDifficulty = val!),
              title: const Text(
                  "I have difficulty understanding the class lesson/s."),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CounselingFormQ9()), // next screen
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
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
    );
  }
}
