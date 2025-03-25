import 'package:flutter/material.dart';

class CounselingFormQ10 extends StatelessWidget {
  const CounselingFormQ10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Preview & Submit',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please review your answers before submitting:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // TODO: Replace the placeholders below with actual data variables from Q1-Q9
            _buildPreviewSection(
                'Q1: Mode of Counseling', 'Walk-in / Referral / Online'),
            _buildPreviewSection(
                'Q2: Personal Information', 'Full Name, Age, Gender, etc.'),
            _buildPreviewSection(
                'Q3: Personal Concerns', 'Checked items + text field inputs'),
            _buildPreviewSection('Q4: Interpersonal Issues',
                'Checked items + text field inputs'),
            _buildPreviewSection(
                'Q5: Grief/Bereavement', 'Text field responses'),
            _buildPreviewSection(
                'Q6: Academics', 'Checked items + others text'),
            _buildPreviewSection(
                'Q7: Family Concerns', 'Checkbox selections + text inputs'),
            _buildPreviewSection('Q8: Other Issues', 'Summary of responses'),
            _buildPreviewSection('Q9: Gender & Identity',
                'Checked options + additional concerns'),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Form Submitted Successfully!'),
                    ),
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
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF7B1F3A),
        unselectedItemColor: Colors.pink[200],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notif"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Schedule"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildPreviewSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.pink[50],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF7B1F3A),
              )),
          const SizedBox(height: 5),
          Text(content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              )),
        ],
      ),
    );
  }
}
