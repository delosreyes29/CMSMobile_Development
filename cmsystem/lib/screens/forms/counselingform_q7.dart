import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q8.dart';

class CounselingFormQ7 extends StatefulWidget {
  const CounselingFormQ7({super.key});

  @override
  State<CounselingFormQ7> createState() => _CounselingFormQ7State();
}

class _CounselingFormQ7State extends State<CounselingFormQ7> {
  final TextEditingController grievingController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  int _currentIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // nav
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("IV. Grief/Bereavement",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B0D1D))),
            const SizedBox(height: 10),
            const Text(
              'Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text('I am grieving the death of my'),
            const SizedBox(height: 8),
            TextField(
              controller: grievingController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Because of the grief/bereavement, I am experiencing'),
            const SizedBox(height: 8),
            TextField(
              controller: experienceController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CounselingFormQ8()),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
