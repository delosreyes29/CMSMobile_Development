import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q10.dart';

class CounselingFormQ9 extends StatefulWidget {
  const CounselingFormQ9({super.key});

  @override
  State<CounselingFormQ9> createState() => _CounselingFormQ9State();
}

class _CounselingFormQ9State extends State<CounselingFormQ9> {
  Map<String, bool> concerns = {
    'I cannot accept that my parents are separated.': false,
    'I have a hard time dealing with my parents/guardian’s expectations and demands.':
        false,
    'I have experienced frequent argument/s with family member/s or relatives.':
        false,
    'Our family is having financial concerns.': false,
    'I have a hard time telling my family about my gender preference (e.g., Gay/Lesbian/LGBTQ).':
        false,
    'I am worried/troubled by a family member’s illness.': false,
  };

  Map<String, bool> violence = {
    'Physical': false,
    'Emotional': false,
    'Psychological': false,
    'Verbal': false,
  };

  TextEditingController openUpController = TextEditingController();

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
            const Text("IV. Family",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B0D1D))),
            const SizedBox(height: 10),
            const Text(
              'Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),

            // checkboxes
            ...concerns.entries.map((entry) {
              return CheckboxListTile(
                title: Text(entry.key),
                value: entry.value,
                onChanged: (val) {
                  setState(() {
                    concerns[entry.key] = val!;
                  });
                },
              );
            }),

            const SizedBox(height: 10),
            const Text("I have difficulty opening up to family member/s."),
            const SizedBox(height: 5),
            TextField(
              controller: openUpController,
              decoration: const InputDecoration(
                hintText: '(Please specify)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'I have experienced frequent violence with family member/s',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            Wrap(
              spacing: 10,
              children: violence.entries.map((entry) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: entry.value,
                      onChanged: (val) {
                        setState(() {
                          violence[entry.key] = val!;
                        });
                      },
                    ),
                    Text(entry.key),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // next button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7A1D42),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CounselingFormQ10()),
                  );
                },
                child: const Text('Next', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink.shade300,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notif'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
