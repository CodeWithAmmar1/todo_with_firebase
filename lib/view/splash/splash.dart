import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/splash_controller.dart';

class Splash extends StatelessWidget {
  Splash({super.key}) {
    Get.put(SplashController());
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(seconds: 1),
            child: Text(
              "T O D O",
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFF5A5F)),
            ),
          ),
        ],
      ),
    ));
  }
}
