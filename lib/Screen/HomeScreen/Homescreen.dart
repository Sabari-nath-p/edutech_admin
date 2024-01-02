import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ExamScreen/ExamMain.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/CourseView.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/ProfileView.dart';

import 'Widgets/SideBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController ctrl = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(builder: (context) {
        return Stack(
          children: [
            if (ctrl.CurrentMenu == 0)
              Positioned(
                  left: 270,
                  top: 30,
                  bottom: 20,
                  right: 0,
                  child: CourseView()),
            if (ctrl.CurrentMenu == 1)
              Positioned(
                  left: 270,
                  top: 30,
                  bottom: 20,
                  right: 0,
                  child: ProfileViewScreen()),
            Positioned(
                left: 0, top: 0, bottom: 0, width: 250, child: SideBar()),
            Positioned(
                left: 10,
                top: 10,
                child: tx600(
                  "MathLab Admin",
                  size: 24,
                  color: primaryColor,
                )),
          ],
        );
      }),
    );
  }
}
