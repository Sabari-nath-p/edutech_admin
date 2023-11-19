import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/LoginScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';

import '../../../Constants/functionsupporter.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int SelectedOption = 0;

  HomeController ctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xffF4F4F4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(40),
            homebarElements(
                "Dashboard",
                SvgPicture.asset(
                  "assets/icons/class.svg",
                  color: Colors.black54,
                ),
                0),
            // homebarElements(
            //     "Courses",
            //     SvgPicture.asset(
            //       "assets/icons/class.svg",
            //       color: Colors.black54,
            //     ),
            //     1),
            homebarElements(
                "Users info",
                SvgPicture.asset(
                  "assets/icons/profile.svg",
                  color: Colors.black54,
                ),
                1),
            // homebarElements(
            //     "Question Bank",
            //     SvgPicture.asset(
            //       "assets/icons/exam.svg",
            //       color: Colors.black54,
            //     ),
            //     3),
            // homebarElements(
            //     "Payment Info",
            //     SvgPicture.asset(
            //       "assets/icons/progess_icon.svg",
            //       color: Colors.black54,
            //     ),
            //     4),
            // homebarElements(
            //     "App Setting",
            //     SvgPicture.asset(
            //       "assets/icons/progess_icon.svg",
            //       color: Colors.black54,
            //     ),
            //     2),
            Expanded(child: Container()),
            InkWell(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("LOGIN", "OUT");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("    Logout",
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.red)),
            ),
            height(20),
          ],
        ));
  }

  homebarElements(String title, SvgPicture svg, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          ctrl.CurrentMenu = index;
          ctrl.loadCourse();
          ctrl.update();
          //  PageControlNotifer.value++;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            width(5),
            Container(
                width: 30,
                alignment: Alignment.center,
                child: svg), // SvgPicture.asset("assets/icons/home.svg"),
            width(10),
            tx500(title, color: Colors.black87, size: 20),
            Expanded(child: Container()),
            if (index == ctrl.CurrentMenu)
              Container(
                width: 5,
                height: 22,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
              )
          ],
        ),
      ),
    );
  }
}
