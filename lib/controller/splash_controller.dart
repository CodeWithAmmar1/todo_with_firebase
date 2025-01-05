import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo/view/home_page/homepage.dart';
import 'package:todo/view/login/login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(const Homepage());
      } else {
        Get.offAll(() => Login());
      }
    });
  }
}
