import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/ExamModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/NoteModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/VideoModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/subjectModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

import '../../../Constants/functionsupporter.dart';
import '../../../Constants/inputField.dart';

class AddExam extends StatefulWidget {
  var Edata;
  AddExam({super.key, this.Edata = 1});

  @override
  State<AddExam> createState() => _AddExamState(Edata: Edata);
}

class _AddExamState extends State<AddExam> {
  var Edata;
  _AddExamState({required this.Edata});

  TextEditingController examName = TextEditingController();
  TextEditingController instruction = TextEditingController();
  TextEditingController durationOfExam = TextEditingController();
  TextEditingController totalMarks = TextEditingController();
  TextEditingController passmark = TextEditingController();
  TextEditingController isActive = TextEditingController();
  TextEditingController accessType = TextEditingController();

  HomeController ctrl = Get.put(HomeController());
  late ExamModel md;
  @override
  void initState() {
    // TODO: implement initState

    if (Edata != 1) {
      md = ExamModel.fromJson(Edata);
      examName.text = md.examName!;
      instruction.text = md.instruction!;
      durationOfExam.text = md.durationOfExam.toString();
      totalMarks.text = md.totalMarks.toString();
      passmark.text = (md.passmark != null) ? md.passmark!.toString() : "0";
      accessType.text = md.accessType.toString();
      isActive.text = (Edata["is_active"]) ? "1" : "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 700),
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
                        tx700("Add Exam", size: 24),
                        height(10),
                        Tfields("Exam Name", examName),
                        height(10),
                        ETfields("Exam Instruction", instruction),
                        height(10),
                        Tfields("Duration (HH:MM:SS)", durationOfExam),
                        height(10),
                        Tfields("Total Mark", totalMarks),
                        height(10),
                        Tfields("Pass Mark", passmark),
                        AField("Access Type", accessType),
                        height(10),
                        if (Edata != 1) TBox("Visibility", isActive),
                        if (Edata != 1) height(10),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (examName.text.isNotEmpty &&
                          instruction.text.isNotEmpty &&
                          accessType.text.isNotEmpty &&
                          durationOfExam.text.isNotEmpty &&
                          totalMarks.text.isNotEmpty &&
                          passmark.text.isNotEmpty) {
                        setState(() {
                          ctrl.CourseUploading = true;
                        });
                        if (Edata == 1)
                          AddVideoData();
                        else
                          EditVideoData();
                      } else {}
                    },
                    child: ButtonContainer(
                      (ctrl.CourseUploading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600((Edata != 1) ? "Update Exam" : "Add Exam",
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

  AddVideoData() {
    final DateFormat formatter = DateFormat('y-MM-ddThh:mm:ss');

    ExamModel model = ExamModel();
    model.module = ctrl.SelectedModuleModel.modulesId;
    model.examName = examName.text;
    model.instruction = instruction.text;
    model.durationOfExam = durationOfExam.text;
    model.totalMarks = int.parse(totalMarks.text).toInt();
    model.passmark = int.parse(passmark.text).toInt();
    model.isActive = true;
    model.accessType = int.parse(accessType.text).toInt();

    ctrl.AddExam(model, context);
  }

  EditVideoData() {
    final DateFormat formatter = DateFormat('y-MM-ddThh:mm:ss');

    ExamModel model = ExamModel();
    model.examUniqueId = md.examUniqueId;
    model.module = ctrl.SelectedModuleModel.modulesId;
    model.examName = examName.text;
    model.instruction = instruction.text;
    model.durationOfExam = durationOfExam.text;
    model.totalMarks = int.parse(totalMarks.text).toInt();
    model.passmark = int.parse(passmark.text).toInt();
    model.isActive = isActive.text == "1" ? true : false;
    model.accessType = int.parse(accessType.text).toInt();
    ctrl.UpdateExam(model, context);
  }
}
