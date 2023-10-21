import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:service_app/screens/main_screen/dashboard_screen.dart';
import 'package:service_app/screens/onboard_pages/page1.dart';
import 'package:service_app/screens/onboard_pages/page2.dart';
import 'package:service_app/screens/onboard_pages/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController(initialPage: 0, keepPage: false);
  late int _pageIndex = 0;

  List<Widget> introPages = [
    const Page1Screen(),
    const Page2Screen(),
    const Page3Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            children: introPages,
            onPageChanged: (index) {
              setState(() {
                _pageIndex = index;
              });
            },
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: _pageIndex == 2
            ? MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const DashBoardScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashBoardScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const WormEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                    ),
                    onDotClicked: (index) {
                      controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
