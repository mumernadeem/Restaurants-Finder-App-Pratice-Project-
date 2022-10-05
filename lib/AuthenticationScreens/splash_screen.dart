import 'dart:async';

import 'package:restaurants_finder_app/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    statusCheck();
  }

  statusCheck() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushNamed(context, catalogueScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                width: constraints.maxWidth * 0.4,
                height: constraints.maxHeight * 0.2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/splash_logo.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
