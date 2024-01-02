import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ProfileView/Service/controller.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/EnrolledCourse.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/EnrolledExam.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/ExamResponseView.dart';

class IndividualProfileView extends StatelessWidget {
  IndividualProfileView({super.key});
  ProfileController pctrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        tx600("Personal Details", size: 21),
        SizedBox(
          height: 10,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black12)),
          child: Column(
            children: [
              Row(
                children: [
                  tx500("Name  :   ", size: 18),
                  tx600(pctrl.selectedProfileModel!.name!, size: 20)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  tx500("Email :   ", size: 18),
                  tx600(pctrl.selectedProfileModel!.username!, size: 20)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  tx500("Contact Number  :   ", size: 18),
                  tx600(pctrl.selectedProfileModel!.phoneNumber!, size: 20)
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        EnrolledCourse(),
        SizedBox(
          height: 25,
        ),
        EnrolledExam(),
        SizedBox(
          height: 25,
        ),
        ExamResponseView()
      ],
    );
  }
}
