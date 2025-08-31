import 'package:flutter/material.dart';

import '../../components/custom_Text_field.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Enter Your OTP"),
            TextField(),
            CustomTextField()
          ],
        )
      ),
    );
  }
}
