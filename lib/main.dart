import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restaurants_finder_app/AuthenticationScreens/catalogue_screen.dart';
import 'package:restaurants_finder_app/AuthenticationScreens/splash_screen.dart';
import 'package:restaurants_finder_app/HomeScreens/home_screen.dart';
import 'package:restaurants_finder_app/HomeScreens/map_screen.dart';
import 'package:restaurants_finder_app/constants.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: splashScreen,
      title: "Restaurants Finder App",
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      routes: {
        splashScreen: (context) => const SplashScreen(),
        catalogueScreen: (context) => const CatalogueScreen(),
        homeScreen: (context) => const HomeScreen(),
        mapScreen: (context) => const MapScreen(),
      },
    );
  }
}
