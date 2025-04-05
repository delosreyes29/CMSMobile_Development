import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cmsystem/screens/launch_screen.dart';
import 'package:cmsystem/screens/home_screen.dart';
import 'package:cmsystem/screens/schedule_screen.dart';
import 'package:cmsystem/screens/history_screen.dart';
import 'package:cmsystem/screens/settings_screen.dart';
import 'package:cmsystem/screens/notification/notification_screen.dart';
import 'package:cmsystem/screens/forms/counselingform_consent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch',
      routes: {
        '/launch': (context) => const LaunchScreen(),
        '/home': (context) => const MainScreen(initialIndex: 0),
        '/notifications': (context) => const MainScreen(initialIndex: 1),
        '/schedule': (context) => const MainScreen(initialIndex: 3),
        '/history': (context) => const HistoryScreen(),
        '/settings': (context) => const MainScreen(initialIndex: 4),
        '/counseling_form': (context) => const CounselingFormConsent(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const Placeholder(), // Placeholder for + button
    const ScheduleScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      // Navigate to Counseling Form when clicking the + button
      Navigator.pushNamed(context, '/counseling_form');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notif'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, size: 40, color: Colors.pink),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
