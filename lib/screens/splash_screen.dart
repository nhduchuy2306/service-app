import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:service_app/screens/login_screen.dart';
import 'package:service_app/screens/main_screen/dashboard_screen.dart';
import 'package:service_app/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setupPageTransition();
  }

  setupPageTransition() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? seen = prefs.getBool('seen');
    final bool? loggedIn = prefs.getBool('loggedIn');
    if (seen == null || seen == false) {
      prefs.setBool('seen', true);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const OnBoardingScreen(),
          ),
        );
      });
    } else if (loggedIn == null || loggedIn == false) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const LoginScreen(),
          ),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const DashBoardScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image(
                image: const AssetImage('assets/cleaning-service.png'),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: Column(
                children: [
                  Text(
                    "Ant Chores",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We clean your house, office, \nand everything you want!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
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
