import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/core/screens/dashboard/dashboard_screen.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/recommendations_screen.dart';
import 'package:filmtrack/src/features/core/screens/subscriptions/subscriptions_screen.dart';
import 'package:flutter/material.dart';

class AuthenticatedNavigationWidget extends StatefulWidget {
  const AuthenticatedNavigationWidget({Key? key}) : super(key: key);

  @override
  State<AuthenticatedNavigationWidget> createState() => _AuthenticatedNavigationWidgetState();
}

class _AuthenticatedNavigationWidgetState extends State<AuthenticatedNavigationWidget> {
  int _selectedIndex = 0;
  static const List<String> _navigationOptions = [tHome, tRecommendations, tSubscriptions];
  static const List<Widget> _navigationScreens = [DashboardScreen(),RecommendationScreen(),SubscriptionsScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title:  Text(_navigationOptions.elementAt(_selectedIndex))
          ),
          body: Container(
                // color: Colors.red,
                padding: const EdgeInsets.all(tDefaultSize),
                decoration: const BoxDecoration(color: tCardBgColor),
                child: _navigationScreens.elementAt(_selectedIndex),
              ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: tHome,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_rounded),
                label: tRecommendations,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_rounded),
                label: tSubscriptions,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: tPrimaryColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
