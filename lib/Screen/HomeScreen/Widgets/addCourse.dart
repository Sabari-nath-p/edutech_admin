import 'dart:convert' as convert;
import 'dart:io';
import 'package:dio/dio.dart' as Request;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/courseModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/functionsupporter.dart';
import '../../../Constants/inputField.dart';

class addCourse extends StatefulWidget {
  var Cdata;

  addCourse({super.key, this.Cdata = 1});

  @override
  State<addCourse> createState() => _addCourseState(Cdata: Cdata);
}

class _addCourseState extends State<addCourse> {
  var Cdata;
  _addCourseState({required this.Cdata});
  TextEditingController coursename = TextEditingController();
  TextEditingController coursedescription = TextEditingController();
  TextEditingController coursebenefits = TextEditingController();
  TextEditingController couresPrice = TextEditingController();
  TextEditingController CourseIcon = TextEditingController();
  TextEditingController CourseCover = TextEditingController();
  TextEditingController isPaidOnly = TextEditingController();
  TextEditingController isActive = TextEditingController();
  // bool isPaidOnly = false;

  bool isLoading = false;
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Cdata != 1) {
      coursename.text = Cdata["field_of_study"].toString();
      coursedescription.text = Cdata["Course_description"];
      coursebenefits.text = Cdata["user_benefit"];
      couresPrice.text = Cdata["price"].toString();
      if (Cdata["course_image"] != null)
        CourseIcon.text = Cdata["course_image"];
      if (Cdata["cover_image"] != null) CourseCover.text = Cdata["cover_image"];

      isPaidOnly.text = (Cdata["only_paid"]) ? "1" : "";
      isActive.text = (Cdata["is_active"]) ? "1" : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 800),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        tx700("Add Course", size: 24),
                        height(10),
                        Tfields("Course Name*", coursename),
                        height(10),
                        ETfields("Course Description", coursedescription),
                        height(10),
                        ETfields("Course Benefits", coursebenefits),
                        height(10),
                        Tfields("Course Price*", couresPrice),
                        height(10),
                        TBox("Only Paid", isPaidOnly),
                        height(10),
                        if (Cdata != 1) TBox("Visibility", isActive),
                        if (Cdata != 1) height(10),
                        fieldImage("Course Icon", CourseIcon),
                        height(10),
                        fieldImage("Course Cover Image", CourseCover)
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (coursename.text.isNotEmpty &&
                          couresPrice.text.isNotEmpty &&
                          coursebenefits.text.isNotEmpty &&
                          coursedescription.text.isNotEmpty) {
                        setState(() {
                          controller.CourseUploading = true;
                        });
                        if (Cdata == 1)
                          AddCousreData();
                        else
                          EditCourseData();
                      } else {}
                    },
                    child: ButtonContainer(
                      (controller.CourseUploading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600((Cdata != 1) ? "Update Course" : "Add Course",
                              color: Colors.white),
                      width: 150,
                      radius: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  EditCourseData() async {
    CourseModel cmodel = CourseModel();
    CourseModel Pmodel = CourseModel.fromJson(widget.Cdata);
    cmodel.fieldOfStudy = coursename.text.trim();
    cmodel.price = couresPrice.text.trim();
    cmodel.onlyPaid = (isPaidOnly.text == "1") ? true : false;
    cmodel.isActive = (isActive.text == "1") ? true : false;
    cmodel.courseDescription = coursedescription.text.toString();
    cmodel.userBenefit = coursebenefits.text.toString();
    //cmodel.isActive = true;
    cmodel.coverImage = CourseCover.text.toString();
    cmodel.courseImage = CourseIcon.text.toString();

    controller.updateCourse(cmodel, Pmodel, context);
  }

  AddCousreData() async {
    CourseModel cmodel = CourseModel();
    cmodel.fieldOfStudy = coursename.text.trim();
    cmodel.price = couresPrice.text.trim();
    cmodel.onlyPaid = (isPaidOnly.text == "1") ? true : false;
    cmodel.courseDescription = coursedescription.text.toString();
    cmodel.userBenefit = coursebenefits.text.toString();
    cmodel.isActive = true;
    cmodel.coverImage = CourseCover.text.toString();
    cmodel.courseImage = CourseIcon.text.toString();

    controller.AddCourse(cmodel, context);
  }
}
