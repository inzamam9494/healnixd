import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/style/text_style.dart';

import '../../components/custom_Text_field.dart';
import '../../components/custom_buttons.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarText(text: "Create account"),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                authHeadingText(text: "Enter full name"),
                CustomTextField(),
                authHeadingText(text: "Enter email address"),
                CustomTextField(),
                authHeadingText(text: "Enter new password"),
                CustomTextField(),
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.8, // 👈 make checkbox smaller
                      child: Checkbox(
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        value: true,
                        onChanged: (value) {},
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Text(
                      "Remember me",
                      style: AppTextStyles.kSmall10RegularTextStyle.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                authButton(
                  text: "Sign Up",
                  onPressed: () {},
                ).marginOnly(top: 70.0, bottom: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: Text("or sign up with", textAlign: TextAlign.center),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/images/google.png",
                        height: 35,
                        width: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.apple, color: Colors.black, size: 35),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.facebook, color: Colors.blue, size: 35),
                    ),
                  ],
                ).paddingOnly(top: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
