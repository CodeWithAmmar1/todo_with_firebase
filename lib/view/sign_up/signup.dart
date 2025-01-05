import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo/controller/signup_controller.dart';
import 'package:todo/view/custom_button/button.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final SignupController _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff3C3C3C),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Sign up with one of the following options",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff828282),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: _signupController.nameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffDEDEDE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: Color(0xffDEDEDE),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: Color(0xffDEDEDE),
                          width: 2,
                        ),
                      ),
                      labelText: "Name",
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: _signupController.emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffDEDEDE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: Color(0xffDEDEDE),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: Color(0xffDEDEDE),
                          width: 2,
                        ),
                      ),
                      labelText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: _signupController.passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xffDEDEDE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: Color(0xffDEDEDE),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: Color(0xffDEDEDE),
                          width: 2,
                        ),
                      ),
                      labelText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 24,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => _signupController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Color(0xffFF5A5F),
                    ))
                  : Button(
                      text: "Create account",
                      onTap: () => _signupController.signupFun(context),
                    )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        _signupController.gologin();
                      },
                      child: const Text(
                        " Log in",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFF5A5F),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
