import 'package:cmsystem/screens/forms/counselingform_q1.dart';
import 'package:flutter/material.dart';
import 'package:cmsystem/main.dart'; // import MainScreen to navigate back

class CounselingFormConsent extends StatefulWidget {
  const CounselingFormConsent({super.key});

  @override
  _CounselingFormConsentState createState() => _CounselingFormConsentState();
}

class _CounselingFormConsentState extends State<CounselingFormConsent> {
  bool _isChecked = false;

  void _navigateToMainScreen(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(initialIndex: index),
      ),
    );
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Consent",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "I hereby give my consent to the University of the Immaculate Conception to collect my data and information by filling out and submitting the Counseling/Routine Interview form for purposes of processing my psychological test, counseling, and other purposes about my will to study at the University of the Immaculate Conception.\n\n"
              "All information I provide shall be treated in confidentiality and shall not be shared with third persons without my permission or consent, except as laws may provide.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "I consent to the collection, use, and disclosure of my Personal Information in the manner outlined in this form.",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _isChecked
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CounselingFormQ1(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Next",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notif"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 40, color: Colors.pink),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Schedule"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        selectedItemColor: Colors.pink.shade700,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          _navigateToMainScreen(index);
        },
      ),
    );
  }
}
