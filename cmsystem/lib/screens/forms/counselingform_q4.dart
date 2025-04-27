import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cmsystem/screens/forms/counselingform_q9.dart';

class CounselingFormQ4 extends StatefulWidget {
  final String documentId;

  const CounselingFormQ4({super.key, required this.documentId});

  @override
  State<CounselingFormQ4> createState() => _CounselingFormQ4State();
}

class _CounselingFormQ4State extends State<CounselingFormQ4> {
  // I. Getting to Know You controllers
  final TextEditingController _q1Controller = TextEditingController();
  final TextEditingController _q2Controller = TextEditingController();
  final TextEditingController _q3Controller = TextEditingController();
  final TextEditingController _q4Controller = TextEditingController();
  final TextEditingController _q5Controller = TextEditingController();
  final TextEditingController _q6Controller = TextEditingController();
  final TextEditingController _q7Controller = TextEditingController();

  // II. Personal variables
  bool confident = false;
  bool time = false;
  bool stress = false;
  bool emotion = false;
  bool decision = false;
  bool sleeping = false;
  bool mood = false;
  bool worry = false;
  bool engagement = false;
  bool selfHarm = false;
  bool suicide = false;
  TextEditingController usageController = TextEditingController();
  TextEditingController disorderController = TextEditingController();
  TextEditingController drugController = TextEditingController();
  bool abusePhysical = false;
  bool abuseEmotional = false;
  bool abuseVerbal = false;
  bool abusePsychological = false;
  bool abuseSexual = false;

  // III. Interpersonal variables
  bool isBullied = false;
  bool cannotHandlePressure = false;
  bool difficultyGettingAlong = false;
  bool cannotExpressFeelings = false;
  TextEditingController discriminationController = TextEditingController();

  // IV. Grief/Bereavement
  TextEditingController grievingDeathOfController = TextEditingController();
  TextEditingController griefExperienceController = TextEditingController();

  // V. Academics
  bool overlyWorried = false;
  bool homesickness = false;
  bool issueWithTeacher = false;
  bool notPrepared = false;
  bool notHappyWithCourse = false;
  bool problemBeingOnTime = false;
  bool difficultyUnderstanding = false;
  TextEditingController academicOthersController = TextEditingController();

  // VI. Family
  bool cannotAcceptSeparation = false;
  bool hardTimeWithParents = false;
  bool frequentArguments = false;
  bool familyFinancialConcern = false;
  bool familyGenderPreference = false;
  bool familyMemberIllness = false;
  bool physicalViolence = false;
  bool emotionalViolence = false;
  bool psychologicalViolence = false;
  bool verbalViolence = false;
  TextEditingController familyOpeningUpController = TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers
    _q1Controller.dispose();
    _q2Controller.dispose();
    _q3Controller.dispose();
    _q4Controller.dispose();
    _q5Controller.dispose();
    _q6Controller.dispose();
    _q7Controller.dispose();
    usageController.dispose();
    disorderController.dispose();
    drugController.dispose();
    discriminationController.dispose();
    grievingDeathOfController.dispose();
    griefExperienceController.dispose();
    academicOthersController.dispose();
    familyOpeningUpController.dispose();
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section I
            _sectionTitle(
                'I. Getting to Know You: Thoughts, Relationships, and Well-Being',
                color: const Color(0xFF55182C)),
            _buildQuestion(
                'What do you think of yourself? How do you describe yourself?',
                _q1Controller),
            _buildQuestion(
                'What are the most important things to you?', _q2Controller),
            _buildQuestion(
                'Tell me about your friends. What are the things you like or dislike doing with them?',
                _q3Controller),
            _buildQuestion(
                'What do you like or dislike about your class? Describe your participation in class activities.',
                _q4Controller),
            _buildQuestion(
                'Tell me about your family. How is your relationship with each member of the family? Who do you like or dislike among them? Why?',
                _q5Controller),
            _buildQuestion(
                'To whom do you feel comfortable sharing your problems? Why?',
                _q6Controller),
            _buildQuestion(
                'Is there anything I haven’t asked that you like to tell me?',
                _q7Controller),

            const SizedBox(height: 20),

            // Section II
            _sectionTitle('II. Personal', color: const Color(0xFF601C4F)),
            _instruction(),
            CheckboxListTile(
                value: confident,
                onChanged: (val) => setState(() => confident = val!),
                title: const Text("I do not feel confident about myself.")),
            const Text('I struggle to manage my:'),
            _buildThreeCheckboxRow(
                'Time',
                time,
                (val) => setState(() => time = val!),
                'Stress',
                stress,
                (val) => setState(() => stress = val!),
                'Emotion',
                emotion,
                (val) => setState(() => emotion = val!)),
            CheckboxListTile(
                value: decision,
                onChanged: (val) => setState(() => decision = val!),
                title: const Text("I have a hard time making decisions.")),
            CheckboxListTile(
                value: sleeping,
                onChanged: (val) => setState(() => sleeping = val!),
                title: const Text("I have a problem with sleeping.")),
            CheckboxListTile(
                value: mood,
                onChanged: (val) => setState(() => mood = val!),
                title:
                    const Text("I have noticed that my mood is not stable.")),
            CheckboxListTile(
                value: worry,
                onChanged: (val) => setState(() => worry = val!),
                title: const Text("I easily get worried or overthink.")),
            CheckboxListTile(
                value: engagement,
                onChanged: (val) => setState(() => engagement = val!),
                title: const Text("I have too much engagement.")),
            const Text('I cannot stop myself from using or doing:'),
            _buildTextField(usageController),
            CheckboxListTile(
                value: selfHarm,
                onChanged: (val) => setState(() => selfHarm = val!),
                title:
                    const Text("I am committing to self-harming activities.")),
            CheckboxListTile(
                value: suicide,
                onChanged: (val) => setState(() => suicide = val!),
                title: const Text("I think about committing suicide.")),
            const Text(
                'I am diagnosed with a mental/behavioral disorder (Please specify)'),
            _buildTextField(disorderController),
            const Text('My drug prescription is/are:'),
            _buildTextField(drugController),
            const Text('I have experienced abuse:'),
            _buildChips(),

            const SizedBox(height: 20),

            // Section III
            _sectionTitle('III. Interpersonal', color: const Color(0xFF6B0F1A)),
            _instruction(),
            CheckboxListTile(
                value: isBullied,
                onChanged: (val) => setState(() => isBullied = val!),
                title: const Text("I am being bullied.")),
            CheckboxListTile(
                value: cannotHandlePressure,
                onChanged: (val) => setState(() => cannotHandlePressure = val!),
                title: const Text("I cannot handle peer pressure.")),
            CheckboxListTile(
                value: difficultyGettingAlong,
                onChanged: (val) =>
                    setState(() => difficultyGettingAlong = val!),
                title:
                    const Text("I have difficulty getting along with others.")),
            CheckboxListTile(
                value: cannotExpressFeelings,
                onChanged: (val) =>
                    setState(() => cannotExpressFeelings = val!),
                title: const Text(
                    "I can't express my feelings and thoughts to others.")),
            const Text(
                'I feel like others discriminate against me because of:'),
            _buildTextField(discriminationController),

            const SizedBox(height: 20),

            // Section IV
            _sectionTitle('IV. Grief/Bereavement',
                color: const Color(0xFF6B0D1D)),
            _instruction(),
            const Text('I am grieving the death of my:'),
            _buildTextField(grievingDeathOfController),
            const Text('Because of the grief/bereavement, I am experiencing:'),
            _buildTextField(griefExperienceController),

            const SizedBox(height: 20),

            // Section V
            _sectionTitle('V. Academics', color: const Color(0xFF6B0F1A)),
            _instruction(),
            CheckboxListTile(
                value: overlyWorried,
                onChanged: (val) => setState(() => overlyWorried = val!),
                title: const Text(
                    "I am overly worried about my academic performance.")),
            const Text('I am not motivated to study because of:'),
            CheckboxListTile(
                value: homesickness,
                onChanged: (val) => setState(() => homesickness = val!),
                title: const Text("Homesickness")),
            CheckboxListTile(
                value: issueWithTeacher,
                onChanged: (val) => setState(() => issueWithTeacher = val!),
                title: const Text("An issue with a teacher")),
            CheckboxListTile(
                value: notPrepared,
                onChanged: (val) => setState(() => notPrepared = val!),
                title: const Text("Not being prepared/interested in school")),
            CheckboxListTile(
                value: notHappyWithCourse,
                onChanged: (val) => setState(() => notHappyWithCourse = val!),
                title: const Text(
                    "Not being happy/interested in the course/school I am currently enrolled in")),
            _buildTextField(academicOthersController,
                hint: '(Others, please specify)'),
            CheckboxListTile(
                value: problemBeingOnTime,
                onChanged: (val) => setState(() => problemBeingOnTime = val!),
                title: const Text("I have a problem being on time in class.")),
            CheckboxListTile(
                value: difficultyUnderstanding,
                onChanged: (val) =>
                    setState(() => difficultyUnderstanding = val!),
                title: const Text(
                    "I have difficulty understanding the class lesson/s.")),

            const SizedBox(height: 20),

            // Section VI
            _sectionTitle('VI. Family', color: const Color(0xFF6B0F1A)),
            _instruction(),
            CheckboxListTile(
                value: cannotAcceptSeparation,
                onChanged: (val) =>
                    setState(() => cannotAcceptSeparation = val!),
                title: const Text(
                    "I cannot accept that my parents are separated.")),
            CheckboxListTile(
                value: hardTimeWithParents,
                onChanged: (val) => setState(() => hardTimeWithParents = val!),
                title: const Text(
                    "I have a hard time dealing with my parents/guardian's expectations and demands.")),
            CheckboxListTile(
                value: frequentArguments,
                onChanged: (val) => setState(() => frequentArguments = val!),
                title: const Text(
                    "I have experienced frequent argument/s with family member/s or relatives.")),
            CheckboxListTile(
                value: familyFinancialConcern,
                onChanged: (val) =>
                    setState(() => familyFinancialConcern = val!),
                title: const Text("Our family is having financial concerns.")),
            CheckboxListTile(
                value: familyGenderPreference,
                onChanged: (val) =>
                    setState(() => familyGenderPreference = val!),
                title: const Text(
                    "I have a hard time telling my family about my gender preference (e.g., Gay/Lesbian/LGBTQ).")),
            CheckboxListTile(
                value: familyMemberIllness,
                onChanged: (val) => setState(() => familyMemberIllness = val!),
                title: const Text(
                    "I am worried/troubled by a family member's illness.")),
            const Text('I have difficulty opening up to family member/s:'),
            _buildTextField(familyOpeningUpController),
            const Text(
                'I have experienced frequent violence with family member/s:'),
            _buildViolenceCheckboxes(),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    // Collect form data
                    final formData = {
                      'gettingToKnowYou': {
                        'q1': _q1Controller.text,
                        'q2': _q2Controller.text,
                        'q3': _q3Controller.text,
                        'q4': _q4Controller.text,
                        'q5': _q5Controller.text,
                        'q6': _q6Controller.text,
                        'q7': _q7Controller.text,
                      },
                      'personal': {
                        'confident': confident,
                        'time': time,
                        'stress': stress,
                        'emotion': emotion,
                        'decision': decision,
                        'sleeping': sleeping,
                        'mood': mood,
                        'worry': worry,
                        'engagement': engagement,
                        'selfHarm': selfHarm,
                        'suicide': suicide,
                        'usage': usageController.text,
                        'disorder': disorderController.text,
                        'drug': drugController.text,
                        'abuse': {
                          'physical': abusePhysical,
                          'emotional': abuseEmotional,
                          'verbal': abuseVerbal,
                          'psychological': abusePsychological,
                          'sexual': abuseSexual,
                        },
                      },
                      'interpersonal': {
                        'isBullied': isBullied,
                        'cannotHandlePressure': cannotHandlePressure,
                        'difficultyGettingAlong': difficultyGettingAlong,
                        'cannotExpressFeelings': cannotExpressFeelings,
                        'discrimination': discriminationController.text,
                      },
                      'griefBereavement': {
                        'grievingDeathOf': grievingDeathOfController.text,
                        'griefExperience': griefExperienceController.text,
                      },
                      'academics': {
                        'overlyWorried': overlyWorried,
                        'homesickness': homesickness,
                        'issueWithTeacher': issueWithTeacher,
                        'notPrepared': notPrepared,
                        'notHappyWithCourse': notHappyWithCourse,
                        'problemBeingOnTime': problemBeingOnTime,
                        'difficultyUnderstanding': difficultyUnderstanding,
                        'academicOthers': academicOthersController.text,
                      },
                      'family': {
                        'cannotAcceptSeparation': cannotAcceptSeparation,
                        'hardTimeWithParents': hardTimeWithParents,
                        'frequentArguments': frequentArguments,
                        'familyFinancialConcern': familyFinancialConcern,
                        'familyGenderPreference': familyGenderPreference,
                        'familyMemberIllness': familyMemberIllness,
                        'familyOpeningUp': familyOpeningUpController.text,
                        'violence': {
                          'physical': physicalViolence,
                          'emotional': emotionalViolence,
                          'psychological': psychologicalViolence,
                          'verbal': verbalViolence,
                        },
                      },
                    };

                    // Update the existing document in Firestore
                    await FirebaseFirestore.instance
                        .collection('counselingForms')
                        .doc(widget.documentId)
                        .update(formData);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Form updated successfully!')),
                    );

                    // Navigate to the next form
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CounselingFormQ9()),
                    );
                  } catch (e) {
                    // Handle errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  backgroundColor: Colors.pink.shade700,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: color)),
    );
  }

  Widget _instruction() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
          "Instruction: Check only the box of the statement/s you consider your concern for the past four (4) weeks.",
          style: TextStyle(fontSize: 14)),
    );
  }

  Widget _buildQuestion(String question, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {String hint = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildThreeCheckboxRow(
      String title1,
      bool value1,
      Function(bool?) onChanged1,
      String title2,
      bool value2,
      Function(bool?) onChanged2,
      String title3,
      bool value3,
      Function(bool?) onChanged3) {
    return Row(
      children: [
        Expanded(
            child: CheckboxListTile(
                title: Text(title1), value: value1, onChanged: onChanged1)),
        Expanded(
            child: CheckboxListTile(
                title: Text(title2), value: value2, onChanged: onChanged2)),
        Expanded(
            child: CheckboxListTile(
                title: Text(title3), value: value3, onChanged: onChanged3)),
      ],
    );
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 10,
      children: [
        FilterChip(
            label: const Text("Physical"),
            selected: abusePhysical,
            onSelected: (val) => setState(() => abusePhysical = val)),
        FilterChip(
            label: const Text("Emotional"),
            selected: abuseEmotional,
            onSelected: (val) => setState(() => abuseEmotional = val)),
        FilterChip(
            label: const Text("Verbal"),
            selected: abuseVerbal,
            onSelected: (val) => setState(() => abuseVerbal = val)),
        FilterChip(
            label: const Text("Psychological"),
            selected: abusePsychological,
            onSelected: (val) => setState(() => abusePsychological = val)),
        FilterChip(
            label: const Text("Sexual"),
            selected: abuseSexual,
            onSelected: (val) => setState(() => abuseSexual = val)),
      ],
    );
  }

  Widget _buildViolenceCheckboxes() {
    return Column(
      children: [
        Row(children: [
          Expanded(
              child: CheckboxListTile(
                  title: const Text('Physical'),
                  value: physicalViolence,
                  onChanged: (val) => setState(() => physicalViolence = val!))),
          Expanded(
              child: CheckboxListTile(
                  title: const Text('Emotional'),
                  value: emotionalViolence,
                  onChanged: (val) =>
                      setState(() => emotionalViolence = val!))),
        ]),
        Row(children: [
          Expanded(
              child: CheckboxListTile(
                  title: const Text('Psychological'),
                  value: psychologicalViolence,
                  onChanged: (val) =>
                      setState(() => psychologicalViolence = val!))),
          Expanded(
              child: CheckboxListTile(
                  title: const Text('Verbal'),
                  value: verbalViolence,
                  onChanged: (val) => setState(() => verbalViolence = val!))),
        ]),
      ],
    );
  }
}
