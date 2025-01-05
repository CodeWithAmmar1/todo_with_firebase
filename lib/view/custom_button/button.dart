import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const Button({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: MediaQuery.sizeOf(context).height * 0.07,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(22),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffFF5A5F), Color(0xffC1839F)],
            ),
          ),
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xffF5F5F5),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
