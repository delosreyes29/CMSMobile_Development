import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q2.dart';
import 'counselingform_q2_1.dart';

class CounselingFormQ1 extends StatelessWidget {
  const CounselingFormQ1({super.key});

  void _navigateToQ2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CounselingFormQ2()),
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
              "Is this your first time requesting a counseling appointment?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Letting us know helps prevent data duplication.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, // Ensures full width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CounselingFormQ2()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade700,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12), // Ensures same height
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Yes',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity, // Ensures full width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CounselingFormQ2_1()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade700,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12), // Ensures same height
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("No",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
