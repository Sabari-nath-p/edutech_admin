import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

ShowToast({
  title = "",
  body = "",
}) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: body,
      icon: null, //const Icon(Icons.refresh),
      duration: const Duration(seconds: 2),
    ),
  );
}

height(double h) => SizedBox(
      height: h,
    );
width(double w) => SizedBox(
      width: w,
    );

Widget ButtonContainer(Widget child,
    {double radius = 20,
    double width = 0,
    double height = 0,
    Color color = const Color(0xffBB2828)}) {
  return Container(
    width: (width > 0) ? width : null,
    height: (height > 0) ? height : null,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius), color: color),
    child: child,
  );
}

Text tx500(String text,
        {double size = 16,
        Color color = Colors.black54,
        TextAlign textAlign = TextAlign.start,
        String family = "raleway"}) =>
    Text(text,
        textAlign: textAlign,
        softWrap: true,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontFamily: family,
            fontWeight: FontWeight.w500));
Text tx400(String text,
        {double size = 16,
        Color color = Colors.black54,
        TextAlign textAlign = TextAlign.start,
        String family = "raleway"}) =>
    Text(text,
        textAlign: textAlign,
        softWrap: true,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontFamily: family,
            fontWeight: FontWeight.w400));
Text tx600(String text,
        {double size = 16,
        Color color = Colors.black54,
        TextAlign textAlign = TextAlign.start,
        String family = "raleway"}) =>
    Text(text,
        textAlign: textAlign,
        softWrap: true,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontFamily: family,
            fontWeight: FontWeight.w600));
Text tx700(String text,
        {double size = 16,
        Color color = Colors.black54,
        TextAlign textAlign = TextAlign.start,
        String family = "raleway"}) =>
    Text(text,
        textAlign: textAlign,
        softWrap: true,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontFamily: family,
            fontWeight: FontWeight.w700));
