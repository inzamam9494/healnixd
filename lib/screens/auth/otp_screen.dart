import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_buttons.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/routes/routes.dart';
import 'package:healnixd/screens/auth/controller/register_controller.dart';
import 'package:healnixd/utils/custom_snack_bar.dart';

import '../../components/custom_Text_field.dart';

class OtpScreen extends StatefulWidget {
   OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final RegisterController controller = Get.put<RegisterController>(RegisterController());
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  String? verificationId;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    verificationId = args['verificationId'] as String?;
    phoneNumber = args['phoneNumber'] as String?;
    _otpControllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
    // auto focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for(final controller in _otpControllers) {
      controller.dispose();
    }
    for(final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String _getSmsCode() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  void _onChanged(String value, int index){
    if(value.length == 1 && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if(value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _verifyOtp() async {
    final smsCode = _getSmsCode();
    if(smsCode.length < 4) {
      CustomSnackBar.error("Please enter the 4-digit code");
      return;
    }
    if(verificationId == null) {
      CustomSnackBar.error("Verification ID is missing Request a new code");
      return;
    }
    await controller.linkWithOtp(smsCode, verificationId!, phoneNumber!);
    // Implement OTP verification logic here using verificationId and smsCode
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          children: [
            appBarText(text: "Enter your OTP").marginOnly(top: 20.0, bottom: 20.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    height: 50,
                    width: 50,
                    child: CustomTextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (v) => _onChanged(v, index)
                    ),
                  );
                }),
              ),
            ),
           Obx(() => authButton(
               text: controller.isLoading.value ? "Verifying..." : "Verify OTP",
               isLoading: controller.isLoading.value,
               onPressed: controller.isLoading.value ? null : _verifyOtp).marginOnly(top: 20.0)),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Didn't received code? ",
            style: const TextStyle(color: Colors.black, fontSize: 14),
            children: [
              TextSpan(
                text: "Resend.",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (kDebugMode) {
                      print(
                      "Sign up clicked!",
                    );
                    } // 👈 Navigate or do something
                  },
              ),
            ],
          ),
        ).marginOnly(top: 20.0),

          ],
        )
      ),
    );
  }
}
