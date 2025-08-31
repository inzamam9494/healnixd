import 'package:flutter/material.dart';

import '../../components/custom_Text_field.dart';
import '../../components/custom_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Container(
        child: Column(
          children: [
              Text("Enter email Address"),
              CustomTextField(),
            Text("Enter Password"),
            CustomTextField(),
            authButton(text: "Login Screen", onPressed: (){})
          ],
        ),
      ),
    );
  }
}
