import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_app/widgets/banner_card_widget.dart';
import 'package:service_app/widgets/service_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final flagList = [
  //   const DropdownMenuItem(
  //     value: 1,
  //     child: Row(
  //       children: [
  //         Image(
  //           image: AssetImage("assets/flags/vietnam.png"),
  //           height: 20,
  //           width: 20,
  //           fit: BoxFit.cover,
  //         ),
  //         SizedBox(width: 10),
  //         Text("Vn", style: TextStyle(color: Colors.black, fontSize: 12)),
  //       ],
  //     ),
  //   ),
  //   const DropdownMenuItem(
  //     value: 2,
  //     child: Row(
  //       children: [
  //         Image(
  //           image: AssetImage("assets/flags/united-kingdom.png"),
  //           height: 20,
  //           width: 20,
  //           fit: BoxFit.cover,
  //         ),
  //         SizedBox(width: 10),
  //         Text("En", style: TextStyle(color: Colors.black, fontSize: 12)),
  //       ],
  //     ),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: const AssetImage("assets/services/background.jpg"),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(.3),
                ),
                Positioned(
                  top: 40,
                  left: 15,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "How can we help you?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tell us everything you need, we will help you",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              height: 20,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Your point",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      FontAwesomeIcons.coins,
                                      color: Colors.orangeAccent,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                "Discounts",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            /*
            * This is show list of banner and this is show horizontal
            * and this is using widget BannerCardWidget
            * */
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return BannerCardWidget(
                    imageUrl: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                    title: "Title",
                    description: "Description",
                    onPressed: () {
                      print("Banner $index");
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                "Services",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ServiceCardWidget(
                    serviceName: "Cleaning",
                    icon: FontAwesomeIcons.broom,
                    backgroundColor: Colors.yellow,
                  ),
                  ServiceCardWidget(
                    serviceName: "Repairing",
                    icon: FontAwesomeIcons.broom,
                    backgroundColor: Colors.pink,
                  ),
                  ServiceCardWidget(
                    serviceName: "Cooking",
                    icon: FontAwesomeIcons.utensils,
                    backgroundColor: Colors.lightBlue,
                  ),
                  ServiceCardWidget(
                    serviceName: "Cleaning",
                    icon: FontAwesomeIcons.broom,
                    backgroundColor: Colors.green,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ServiceCardWidget(
                    serviceName: "Cleaning",
                    icon: FontAwesomeIcons.broom,
                    backgroundColor: Colors.deepOrange,
                  ),
                  const ServiceCardWidget(
                    serviceName: "Repairing",
                    icon: FontAwesomeIcons.broom,
                    backgroundColor: Colors.cyan,
                  ),
                  const ServiceCardWidget(
                    serviceName: "Cooking",
                    icon: FontAwesomeIcons.utensils,
                    backgroundColor: Colors.lightBlue,
                  ),
                  ServiceCardWidget(
                    serviceName: "More",
                    backgroundColor: Colors.grey[200],
                    icon: FontAwesomeIcons.compress,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const CustomBottomSheet();
                        },
                      );
                    },
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

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: BottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        builder: (BuildContext context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Text(
                'This is a custom bottom sheet',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              const Text('You can put your content here.'),
            ],
          );
        },
        onClosing: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
