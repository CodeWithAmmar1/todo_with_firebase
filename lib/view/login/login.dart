import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/login_controller.dart';
import 'package:todo/view/custom_button/button.dart';
import 'package:todo/view/sign_up/signup.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: const Text("Log in",
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff3C3C3C))),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1,
                  height: 1,
                  color: Color(0xff555555),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: _loginController.text,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffDEDEDE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide:
                            BorderSide(color: Color(0xffDEDEDE), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide:
                            BorderSide(color: Color(0xffDEDEDE), width: 2),
                      ),
                      labelText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: _loginController.pass,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffDEDEDE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide:
                            BorderSide(color: Color(0xffDEDEDE), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide:
                            BorderSide(color: Color(0xffDEDEDE), width: 2),
                      ),
                      labelText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
                    ),
                  ),
                ),
              ),
              Obx(
                () => _loginController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Color(0xffFF5A5F),
                      ))
                    : Button(
                        text: "Log in",
                        onTap: () => _loginController.loginFun(context)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(Signup());
                    },
                    child: Text(
                      " Sign up",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFF5A5F)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
