import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q7.dart';

class CounselingFormQ6 extends StatefulWidget {
  const CounselingFormQ6({Key? key}) : super(key: key);

  @override
  State<CounselingFormQ6> createState() => _CounselingFormQ6State();
}

class _CounselingFormQ6State extends State<CounselingFormQ6> {
  // Checkbox states
  bool isBullied = false;
  bool cannotHandlePressure = false;
  bool difficultyGettingAlong = false;
  bool cannotExpressFeelings = false;

  // Text controllers
  final TextEditingController discriminationController =
      TextEditingController();
  final TextEditingController grievingDeathOfController =
      TextEditingController();
  final TextEditingController griefExperienceController =
      TextEditingController();

  @override
  void dispose() {
    discriminationController.dispose();
    grievingDeathOfController.dispose();
    griefExperienceController.dispose();
    super.dispose();
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'III. Interpersonal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B0F1A),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text("I am being bullied."),
              value: isBullied,
              onChanged: (bool? value) {
                setState(() {
                  isBullied = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("I cannot handle peer pressure."),
              value: cannotHandlePressure,
              onChanged: (bool? value) {
                setState(() {
                  cannotHandlePressure = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("I have difficulty getting along with others."),
              value: difficultyGettingAlong,
              onChanged: (bool? value) {
                setState(() {
                  difficultyGettingAlong = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text(
                  "I can't express my feelings and thoughts to others."),
              value: cannotExpressFeelings,
              onChanged: (bool? value) {
                setState(() {
                  cannotExpressFeelings = value ?? false;
                });
              },
            ),
            const SizedBox(height: 10),
            const Text("I feel like others discriminate against me because of"),
            const SizedBox(height: 8),
            TextField(
              controller: discriminationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Grief/Bereavement',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text("I am grieving the death of my"),
            const SizedBox(height: 8),
            TextField(
              controller: grievingDeathOfController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            ),
            const SizedBox(height: 10),
            const Text("Because of the grief/bereavement, I am experiencing"),
            const SizedBox(height: 8),
            TextField(
              controller: griefExperienceController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CounselingFormQ7()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  backgroundColor: const Color(0xFF7B2D43),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF6B0F1A),
        unselectedItemColor: Colors.pink[100],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notif',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Add navigation logic here if needed
        },
      ),
    );
  }
}
