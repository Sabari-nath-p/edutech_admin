import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Constants/inputField.dart';
import 'package:mathlab_admin/Screen/ProfileView/Service/controller.dart';

class IndividualCoureseAdd extends StatelessWidget {
  IndividualCoureseAdd({super.key});

  TextEditingController CourseIDController = TextEditingController();
  TextEditingController DurationController = TextEditingController();
  TextEditingController isExamController = TextEditingController();
  ProfileController pctrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (ctx) {
      return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 700, maxHeight: 550),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
            child: Column(
              children: [
                tx700("Add Course", size: 24),
                SizedBox(
                  height: 25,
                ),
                Tfields("Course ID*", CourseIDController),
                SizedBox(
                  height: 25,
                ),
                Tfields("Durations (in Days)*", DurationController),
                SizedBox(
                  height: 25,
                ),
                TBox("Is Exam", isExamController),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    if (CourseIDController.text.isEmpty ||
                        DurationController.text.isEmpty) {
                      ShowToast(
                          title: "Invalid Entry",
                          body: "Please enter id and duration");
                      return;
                    } else if (pctrl.loading) {
                      return;
                    } else {
                      AddtoProfile();
                    }
                  },
                  child: ButtonContainer(
                    (pctrl.loading)
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white, size: 22)
                        : tx600("Add to Profile", color: Colors.white),
                    width: 150,
                    radius: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  AddtoProfile() async {
    pctrl.loading = true;
    pctrl.update();
    String selectedEndpoint = (isExamController.text == "1")
        ? "users/assignexam/"
        : "users/assigncourse/";
    final Response = await post(Uri.parse(endpoint + selectedEndpoint),
        headers: AuthHeader,
        body: json.encode({
          "username": pctrl.selectedProfileModel!.username.toString(),
          if (isExamController.text != "1")
            "course_unique_id": CourseIDController.text.toString(),
          if (isExamController.text == "1")
            "exam_unique_id": CourseIDController.text.toString(),
          "duration": DurationController.text.toString(),
        }));
    print(Response.body);
    print(Response.statusCode);
    if (Response.statusCode == 200 || Response.statusCode == 200) {
      pctrl.loading = false;
      pctrl.update();
      pctrl.loadProfiles();
      Get.back();
    } else {
      ShowToast(title: "Invalid Entry", body: Response.body);
      pctrl.loading = false;
      pctrl.update();
    }
  }
}
