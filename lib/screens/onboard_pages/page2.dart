import 'package:flutter/material.dart';

class Page2Screen extends StatelessWidget {
  const Page2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('assets/cleaning-service-1.png'),
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "This is the second page of the onboarding screen.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
