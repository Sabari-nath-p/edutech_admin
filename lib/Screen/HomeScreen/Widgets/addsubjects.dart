import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/subjectModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

import '../../../Constants/functionsupporter.dart';
import '../../../Constants/inputField.dart';

class AddSubjects extends StatefulWidget {
  var Sdata;
  AddSubjects({super.key, this.Sdata = 1});

  @override
  State<AddSubjects> createState() => _AddSubjectsState(Sdata: Sdata);
}

class _AddSubjectsState extends State<AddSubjects> {
  var Sdata;
  _AddSubjectsState({required this.Sdata});

  TextEditingController subjectName = TextEditingController();
  TextEditingController isActive = TextEditingController();
  TextEditingController subjectImage = TextEditingController();
  HomeController ctrl = Get.put(HomeController());
  late SubjectModel subjectModel;
  @override
  void initState() {
    // TODO: implement initState
    if (Sdata != 1) {
      subjectModel = SubjectModel.fromJson(Sdata);
      if (subjectModel.subjectImage != null)
        subjectImage.text = subjectModel.subjectImage!;
      isActive.text = (Sdata["is_active"]) ? "1" : "";
      subjectName.text = subjectModel.subjects!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller;
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 500),
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
                        tx700("Add Subject", size: 24),
                        height(10),
                        Tfields("Subject Name", subjectName),
                        height(10),
                        if (Sdata != 1) TBox("Visibility", isActive),
                        if (Sdata != 1) height(10),
                        fieldImage("Subject Icon", subjectImage),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (subjectName.text.isNotEmpty) {
                        setState(() {
                          ctrl.CourseUploading = true;
                        });
                        if (Sdata == 1)
                          AddSubjectsData();
                        else
                          EditSubjectsData();
                      } else {}
                    },
                    child: ButtonContainer(
                      (ctrl.CourseUploading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600(
                              (Sdata != 1) ? "Update Subject" : "Add Subject",
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

  AddSubjectsData() {
    SubjectModel model = SubjectModel();
    model.fieldOfStudy = ctrl.SelectedCourseModel.courseUniqueId;
    model.subjects = subjectName.text.trim();
    model.subjectImage = subjectImage.text;
    model.isActive = false;
    ctrl.AddSubject(model, context);
  }

  EditSubjectsData() {
    SubjectModel model = SubjectModel();
    model.fieldOfStudy = ctrl.SelectedCourseModel.courseUniqueId;
    model.subjectId = subjectModel.subjectId;
    model.subjects = subjectName.text.trim();
    model.subjectImage = subjectImage.text;
    model.isActive = (isActive.text == "1") ? true : false;
    bool isupdate =
        (subjectModel.subjectImage == subjectImage.text) ? false : true;
    ctrl.UpdateSubject(model, isupdate, context);
  }
}
