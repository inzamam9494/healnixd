import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_buttons.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _checkingAuth = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkAuthentication();
    });
  }

  Future<void> _checkAuthentication() async {
    try{
      final user = FirebaseAuth.instance.currentUser;
      if(user != null){
        Get.offAllNamed(ApplicationRoutes.bottomNavigationMenu);
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('email') ?? "";
      final savedPassword = prefs.getString('password') ?? "";

      if(savedEmail.isNotEmpty && savedPassword.isNotEmpty){
        try{
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: savedEmail, password: savedPassword);
          Get.offAllNamed(ApplicationRoutes.bottomNavigationMenu);
          return;
        }catch(err){
          // Failed to login with saved credentials
          await prefs.clear();
        }
      }
    }catch(err){
      _error = err.toString();
    } finally {
      if(mounted){
        setState(() {
          _checkingAuth = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: _checkingAuth ? Center(child: CircularProgressIndicator(color: Colors.blue,),) : Container(
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
