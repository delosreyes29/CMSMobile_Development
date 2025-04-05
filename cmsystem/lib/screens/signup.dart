// import 'package:flutter/material.dart';
// import 'home_screen.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for text fields
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _courseController = TextEditingController();
//   final TextEditingController _sectionController = TextEditingController();
//   final TextEditingController _yearLevelController = TextEditingController();

//   void _signUp() {
//     if (_formKey.currentState!.validate()) {
//       // If form is valid, navigate to Home Screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Sign Up',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.pink.shade100,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Create an Account",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),

//                 // Full Name
//                 TextFormField(
//                   controller: _fullNameController,
//                   decoration: const InputDecoration(
//                     labelText: "Full Name",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your full name";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 15),

//                 // Email
//                 TextFormField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: const InputDecoration(
//                     labelText: "Email",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         !value.contains('@')) {
//                       return "Please enter a valid email address";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 15),

//                 // Password
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: "Password",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.length < 6) {
//                       return "Password must be at least 6 characters";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 15),

//                 // Course
//                 TextFormField(
//                   controller: _courseController,
//                   decoration: const InputDecoration(
//                     labelText: "Course",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your course";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 15),

//                 // Section
//                 TextFormField(
//                   controller: _sectionController,
//                   decoration: const InputDecoration(
//                     labelText: "Section",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your section";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 15),

//                 // Year Level
//                 TextFormField(
//                   controller: _yearLevelController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: "Year Level",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter your year level";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Sign Up Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _signUp,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.pink.shade700,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _yearLevelController = TextEditingController();

  // Firebase Instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign-up function
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Register user with Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Get the user's UID
        String uid = userCredential.user!.uid;

        // Store additional user details in Firestore
        await _firestore.collection("users").doc(uid).set({
          "fullName": _fullNameController.text.trim(),
          "email": _emailController.text.trim(),
          "course": _courseController.text.trim(),
          "section": _sectionController.text.trim(),
          "yearLevel": _yearLevelController.text.trim(),
          "createdAt": Timestamp.now(),
        });

        // Navigate to Home Screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink.shade100,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Full Name
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Course
                TextFormField(
                  controller: _courseController,
                  decoration: const InputDecoration(
                    labelText: "Course",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your course";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Section
                TextFormField(
                  controller: _sectionController,
                  decoration: const InputDecoration(
                    labelText: "Section",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your section";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Year Level
                TextFormField(
                  controller: _yearLevelController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Year Level",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your year level";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
