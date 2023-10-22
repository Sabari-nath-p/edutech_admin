import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Homescreen.dart';
import 'package:mathlab_admin/Screen/LoginScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/Strings.dart';

String token = "";
String log = "";
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  log = pref.getString("LOGIN").toString();
  if (log == "IN") {
    String email = pref.getString("EMAIL").toString();
    token = pref.getString("TOKEN").toString();
    print(token);
    final response = await get(
        Uri.parse("$endpoint/applicationview/userlist/$email/"),
        headers: ({"Authorization": "token $token"}));
    //   print(response.body);
    if (response.statusCode == 401) {
      ShowToast(
          title: "Authentication Failed",
          body: "Please reauthenticate to continue");
      log = "out";
      pref.setString("LOGIN", "OUT");
    } else if (response.statusCode == 200) {
      //Fluttertoast.showToast(msg: msg)
    } else {
      log = "error";
    }
  }
  runApp(MathLabAdmin());
}

class MathLabAdmin extends StatelessWidget {
  const MathLabAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: (log == "IN") ? HomeScreen() : LoginScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
