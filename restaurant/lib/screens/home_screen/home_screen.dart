import 'package:flutter/material.dart';
import 'package:restaurant/screens/home_screen/body_wrapper.dart';
import 'package:restaurant/services/database_service.dart';

import 'components/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    DatabaseService().onMessageRecived();
    DatabaseService().saveDeviceToken();
    DatabaseService().subscribeToRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWrapper(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
