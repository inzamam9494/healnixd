import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healnixd/components/custom_texts.dart';
import 'package:healnixd/components/medicine_stock_card.dart';
import 'package:healnixd/screens/profile/controller/profile_controller.dart';
import 'package:healnixd/style/color.dart';
import 'package:healnixd/style/text_style.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.lightBlueBg,
        centerTitle: true,
        title: appBarText(text: "My Profile"),
        actions: [
          Card(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(Icons.settings_outlined, color: Colors.blue),
              onPressed: () {
                // Handle settings button press
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(12),
          child: Column(
            children: [
              Obx(() => Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  title: Text(controller.userName.value, style: AppTextStyles.kCaption12SemiBoldTextStyle),
                  subtitle: Text(controller.userEmail.value, style: AppTextStyles.kSmall10RegularTextStyle,)
                ),
              )),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                color: Colors.blue,
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(CupertinoIcons.star_fill, color: Colors.yellow.shade700,),
                  ),
                  title: Text('Go to Premium', style: AppTextStyles.kCaption12SemiBoldTextStyle.copyWith(color: Colors.white),),
                  subtitle: Text('Unlock better sleep with premium', style: AppTextStyles.kSmall10RegularTextStyle.copyWith(color: Colors.white),),
                trailing:Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(CupertinoIcons.arrow_up_right,),
                ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(CupertinoIcons.person),
                      title: Text('Account Details', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      subtitle: Text('Manage your Account Details', style: AppTextStyles.kSmall8RegularTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.creditcard),
                      title: Text('Payment History', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.bell),
                      title: Text('Notifications', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.settings),
                      title: Text('Settings', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                  ],
                ),
              ),
               Card(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(CupertinoIcons.person_2_square_stack),
                      title: Text('Contact Us', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.exclamationmark_shield_fill),
                      title: Text('Privacy Policy', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.question_circle_fill),
                      title: Text('Get Help', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                     ListTile(
                      leading: Icon(Icons.logout, color: Colors.red,),
                      title: Text('Log out', style: AppTextStyles.kSmall10SemiBoldTextStyle,),
                      trailing: Icon(CupertinoIcons.forward),
                      onTap: (){
                        Get.dialog(
                        AlertDialog(
                          title: Text("Are you sure you want to log out?", style: AppTextStyles.kCaption12SemiBoldTextStyle,),
                          actions: [
                            dialogButton(
                              text: "Cancel",
                              color: Colors.white,
                              textColor: Colors.grey,
                              onPressed: () {
                                controller.logout();
                              },
                            ),
                            dialogButton(
                              text: "Log Out",
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: () {
                                controller.logout();
                              },
                            )
                          ],
                        ));
                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
