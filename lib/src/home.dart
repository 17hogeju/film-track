import 'package:filmtrack/src/recommendations.dart';
import 'package:filmtrack/src/subscription.dart';
import 'package:flutter/material.dart';

class HomePageTemp extends StatefulWidget {
  const HomePageTemp({Key? key}) : super(key: key);

  @override
  State<HomePageTemp> createState() => _HomePageTempState();
}

class _HomePageTempState extends State<HomePageTemp> {
  int pageIndex = 0;

  final pages = [
    const HomePageTemp(),
    Recommendations(),
    const SubscriptionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
      body: pages[pageIndex],
      bottomNavigationBar: buildNavBar(context)
    );
  }

  Container buildNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xfff9f9f9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home_rounded,
              color: Color(0xff7884f8),
              size: 35,
            )
                : const Icon(
              Icons.home_rounded,
              color: Colors.black,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.lightbulb_rounded,
              color: Color(0xff7884f8),
              size: 35,
            )
                : const Icon(
              Icons.lightbulb_rounded,
              color: Colors.black,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.paid_rounded,
              color: Color(0xff7884f8),
              size: 35,
            )
                : const Icon(
              Icons.paid_rounded,
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}