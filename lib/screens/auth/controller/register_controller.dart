import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  var registerNameController = TextEditingController().obs;
  var registerEmailController = TextEditingController().obs;
  var registerPasswordController = TextEditingController().obs;
  var isVisiblePassword = false.obs;
}