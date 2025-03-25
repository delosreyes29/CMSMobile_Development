import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.pink.shade50,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back !",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  fontSize: 16),
            ),
            Text(
              "Student Name",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.pink,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Settings",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            const SizedBox(height: 20),
            const Text("Account",
                style: TextStyle(fontWeight: FontWeight.bold)),
            _buildSettingsItem("Change Display Icon"),
            const Divider(),
            const Text("Support",
                style: TextStyle(fontWeight: FontWeight.bold)),
            _buildSettingsItem("Help center"),
            _buildSettingsItem("App feedback"),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add logout functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildSettingsItem(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: const Icon(Icons.arrow_outward),
      onTap: () {
        // nav
      },
    );
  }
}
