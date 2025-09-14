import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_texts.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarText(text: "Choose Your Plan"),
        centerTitle: true,
        leading: IconButton(icon: Icon( Icons.arrow_back_ios), onPressed: () { Get.back(); },),
      ),
      body: Container(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
