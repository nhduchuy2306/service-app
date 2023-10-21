import 'package:flutter/material.dart';
import 'package:service_app/screens/profile_screen/account_screen.dart';
import 'package:service_app/screens/action_screen/action_screen.dart';
import 'package:service_app/screens/home_screen/home_screen.dart';
import 'package:service_app/screens/message_screen/message_screen.dart';
import 'package:service_app/utils/app_colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentIndex = 0;

  final mainScreens = [
    const HomeScreen(),
    const ActionScreen(),
    const MessageScreen(),
    const AccountScreen(),
  ];

  final navigatorItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.paste),
      label: "Action",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: "Message",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: navigatorItems,
        selectedItemColor: AppColors().primaryColor,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
      ),
    );
  }
}
