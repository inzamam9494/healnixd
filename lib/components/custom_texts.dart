import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:healnixd/style/text_style.dart';

Widget appBarText({String? text}) {
  return Text(
    text??'',
    style: AppTextStyles.kBody20SemiBoldTextStyle.copyWith(color: Colors.blue)
  );
}

Widget authHeadingText({String? text}) {
  return Text(
    text??'',
    style: AppTextStyles.kBody15RegularTextStyle,
  ).marginOnly(top: 10.h, bottom: 5.h);
}