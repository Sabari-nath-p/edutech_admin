import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Constants/inputField.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/ProfileView/Service/controller.dart';

class Advancefilterview extends StatelessWidget {
  Advancefilterview({super.key});
  HomeController hctrl = Get.put(HomeController());
  ProfileController pctrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext contedxt) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.black12))),
      child: GetBuilder<ProfileController>(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tx600("Advance Filter"),
              SizedBox(
                height: 10,
              ),
              _textbox(
                  "Course",
                  [for (var data in hctrl.CourseList) data.fieldOfStudy],
                  pctrl.courseText),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    pctrl.loadProfiles();
                  },
                  child: ButtonContainer(
                      tx500("Apply Filter", color: Colors.white),
                      width: 200),
                ),
              ),
              height(5),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      pctrl.courseText.text = "";
                      pctrl.update();
                    },
                    child: tx400("Clear Filter",
                        size: 13, textAlign: TextAlign.center)),
              ),
              SizedBox(
                height: 20,
              ),
              tx600("Export  User List"),
              SizedBox(
                height: 10,
              ),
              _textbox(
                  "Select Course",
                  ["All", for (var data in hctrl.CourseList) data.fieldOfStudy],
                  pctrl.exportCourseText),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    pctrl.exportToExcel(pctrl.exportCourseText.text);
                  },
                  child: ButtonContainer(
                      tx500("Export Now", color: Colors.white),
                      width: 200),
                ),
              ),
              height(10),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    pctrl.exportToExcel(pctrl.exportCourseText.text,
                        expired: true);
                  },
                  child: ButtonContainer(
                      tx500("Expired User", color: Colors.white),
                      width: 200),
                ),
              ),
              height(20),
              tx600("Notifications"),
              SizedBox(
                height: 10,
              ),
              _textfield("Notification Title", pctrl.NotificationMessage,
                  h: 100),
              _textfield(
                "Notification Body",
                pctrl.NotificationBody,
                h: 100,
              ),
              _textbox(
                  "Select Course",
                  ["All", for (var data in hctrl.CourseList) data.fieldOfStudy],
                  pctrl.notificationCourseText),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    pctrl.sendNotificationActiveCourse();
                  },
                  child: ButtonContainer(
                      tx500("Send Active Course", color: Colors.white),
                      width: 200),
                ),
              ),
              height(10),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    pctrl.sendNotificationActiveCourse(isexpired: true);
                  },
                  child: ButtonContainer(
                      tx500("Renewable", color: Colors.white),
                      width: 200),
                ),
              ),
              height(20),
            ],
          ),
        );
      }),
    );
  }
}

Widget _textbox(
  String text,
  List type,
  TextEditingController CurrentValue,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 10),
      Container(
          alignment: Alignment.centerLeft,
          height: 40,
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFCBCBCB)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton<String>(
              value: CurrentValue.text == "" ? null : CurrentValue.text,
              isExpanded: true,
              underline: Container(),
              // hint: Text(
              //   "$text",
              //   style: GoogleFonts.poppins(
              //       fontSize: 10.sp, fontWeight: FontWeight.w500),
              // ),
              items: type
                  .map((e) => DropdownMenuItem<String>(
                        child: tx600(
                          e,
                          size: 14,
                        ),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) {
                CurrentValue.text = value!;
                ProfileController pctrl = Get.put(ProfileController());
                pctrl.update();
              })),
      SizedBox(height: 20),
    ],
  );
}

_textfield(String text, TextEditingController value,
    {double h = 45, TextAlignVertical align = TextAlignVertical.top}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 6),
      Container(
        alignment: (align == TextAlignVertical.center)
            ? Alignment.centerLeft
            : Alignment.topLeft,
        height: h,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: value,
          maxLines: null,
          textAlignVertical: align,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              isCollapsed: true,
              //   hintText: "$text",
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
          style: GoogleFonts.poppins(
              //   color: Color(0xFF1F41BA),
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}
