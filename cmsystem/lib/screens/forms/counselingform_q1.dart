import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q2.dart';
import 'package:cmsystem/screens/forms/counselingform_q2_1.dart';
import 'package:cmsystem/screens/forms/counselingform_q10.dart';

class CounselingFormQ1 extends StatefulWidget {
  const CounselingFormQ1({super.key});

  @override
  State<CounselingFormQ1> createState() => _CounselingFormQ1State();
}

class _CounselingFormQ1State extends State<CounselingFormQ1> {
  String? selectedRole;

  void _navigateBasedOnSelection(String answer) {
    if (selectedRole == 'Faculty') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CounselingFormQ10()),
      );
    } else if (selectedRole == 'Student') {
      if (answer == 'Yes') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CounselingFormQ2()),
        );
      } else if (answer == 'No') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CounselingFormQ2_1()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select Student or Faculty member'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getButtonColor(String role) {
      return selectedRole == role ? Colors.pink.shade400 : Colors.pink.shade700;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Initial/Routine Interview',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kindly indicate whether you are a student or a faculty member.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedRole = 'Student';
                      });
                    },
                    icon: const Icon(Icons.school, color: Colors.white),
                    label: const Text(
                      "Student",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 16),
                      backgroundColor: getButtonColor('Student'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: selectedRole == 'Student' ? 10 : 2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedRole = 'Faculty';
                      });
                    },
                    icon: const Icon(Icons.person, color: Colors.white),
                    label: const Text(
                      "Faculty member",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 16),
                      backgroundColor: getButtonColor('Faculty'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: selectedRole == 'Faculty' ? 10 : 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
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
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _navigateBasedOnSelection('Yes'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 16),
                        backgroundColor: Colors.pink.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _navigateBasedOnSelection('No'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 16),
                        backgroundColor: Colors.pink.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'No',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
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
