import 'package:cmsystem/screens/forms/counselingform_consent.dart';
import 'package:cmsystem/screens/home_screen.dart';
import 'package:cmsystem/screens/schedule_screen.dart';
import 'package:cmsystem/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String filter = 'Unread'; // Default filter
  List<Map<String, dynamic>> notifications = [
    {
      'name': 'Counselor John Doe',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'status': 'Unread',
    },
    {
      'name': 'Counselor Cindy Doe',
      'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'status': 'Read',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter notifications based on selected filter
    List<Map<String, dynamic>> filteredNotifications = notifications
        .where((notif) => filter == 'All' || notif['status'] == filter)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Greeting
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, color: Colors.grey[600]),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back !",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]),
                    ),
                    Text("User Name",
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Notifications Header with Filter Dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700]),
                ),
                DropdownButton<String>(
                  value: filter,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.brown[700]),
                  style: TextStyle(color: Colors.brown[700]),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      filter = newValue!;
                    });
                  },
                  items: ['All', 'Unread', 'Read']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Notifications List
            Expanded(
              child: ListView.builder(
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  final notif = filteredNotifications[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: notif['status'] == 'Unread'
                          ? Colors.pink[50]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person, color: Colors.grey[600]),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown[700]),
                              ),
                              Text(
                                notif['message'],
                                style: TextStyle(color: Colors.grey[600]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        notif['status'] == 'Unread'
                            ? Icon(Icons.circle, size: 10, color: Colors.red)
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Notifications is index 1
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              break; // Stay on Notifications screen
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CounselingFormConsent()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScheduleScreen()),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
