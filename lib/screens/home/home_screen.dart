import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/pie_chart.dart';
import 'package:healnixd/style/text_style.dart';
import 'package:healnixd/components/quick_action_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello", style: AppTextStyles.kBody15RegularTextStyle),
            Text("Mohd Shakeel", style: AppTextStyles.kBody17SemiBoldTextStyle),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.all(8.0),
              width: 115,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                  CupertinoIcons.bell,
                    size: 30,
                  ).paddingOnly(left: 10),
                  CircleAvatar(backgroundColor: Colors.blue, radius: 25),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 250.sp,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: MedicinePieChart(
                  centerText: "Total\n100", // 👈 dynamic center text
                  data: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 50,
                      title: '50%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.green,
                      value: 30,
                      title: '30%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: 20,
                      title: '20',
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  indicators: [
                    Indicator(color: Colors.blue, text: 'Painkillers'),
                    SizedBox(height: 4),
                    Indicator(color: Colors.green, text: 'Vitamins'),
                    SizedBox(height: 4),
                    Indicator(color: Colors.orange, text: 'Antibiotics'),
                  ],
                ),
              ),
            ),
            Container(
              height: 160.sp,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions!",
                    style: AppTextStyles.kBody15SemiBoldTextStyle,
                  ).paddingOnly(top: 10, left: 10, bottom: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      quickActionCard(
                        icon: Icons.qr_code_scanner,
                        label: "Scan \n to Add",
                        onTap: () {
                          // Handle tap
                        },
                      ),
                      quickActionCard(
                        icon: Icons.medical_services_outlined,
                        label: "Add \n Manually",
                        onTap: () {
                          // Handle tap
                        },
                      ),
                      quickActionCard(
                        icon: Icons.upcoming_outlined,
                        label: "Update \n Stock",
                        onTap: () {
                          // Handle tap
                        },
                      ),
                      quickActionCard(
                        icon: Icons.inventory_2_outlined,
                        label: "View \n Stock",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
