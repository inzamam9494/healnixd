import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_buttons.dart';
import 'package:healnixd/routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Healnixd", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue)),
              Image.asset("assets/images/healnixd.jpg",
              height: 200, width: 200, fit: BoxFit.cover,),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  authButton(text: "Login", onPressed: (){
                    Get.toNamed(ApplicationRoutes.loginScreen);
                  }).marginOnly(bottom: 20.0),
                  authButton(text: "Sign up", onPressed: (){
                    Get.toNamed(ApplicationRoutes.registerScreen);
                  })
                ],
              ),

            ],
          ),
        )
      ),
    );
  }
}
