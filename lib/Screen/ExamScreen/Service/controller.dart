import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiplechoice.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/questionsModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/ExamModel.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../Constants/AppHeaders.dart';
import '../../../Constants/Strings.dart';
import '../../../Constants/functionsupporter.dart';

class ExamController extends GetxController {
  int questionType = -1;
  int courseID = 0;
  int subjectID = 0;
  int moduleID = 0;
  int examID = 0;
  bool QuestionEdit = false;
  ValueNotifier notifier = ValueNotifier(10);
  MultipleChoiceModel? multipleChoiceModel;
  ExamModel? examModel;

  List<questionsModel> questionList = [];
  setController(int cid, int sid, int mid, int eid) {
    courseID = cid;
    subjectID = sid;
    moduleID = mid;
    examID = eid;
    questionType = -1;
    multipleChoiceModel = null;
    QuestionEdit = false;
    loadExam();
  }

  EditQuestion(questionsModel qmodel) async {
    QuestionEdit = true;
    multipleChoiceModel = qmodel.questionModel;
    questionType = 0;
    print("working");
    update();
    notifier.value++;
  }

  loadExam() async {
    questionList = [];
    final Response = await http.get(
        Uri.parse(endpoint +
            "users/fieldofstudy/${courseID}/subjects/${subjectID}/modules/$moduleID/exams/$examID"),
        headers: AuthHeader);

    if (Response.statusCode == 200 || Response.statusCode == 201) {
      var exam = json.decode(Response.body);
      //   print(Response.body);
      examModel = ExamModel.fromJson(exam);
      for (var data in exam["multiplechoice"]) {
        MultipleChoiceModel md = MultipleChoiceModel.fromJson(data);
        questionsModel model = questionsModel(md.mcqId, md.questionNo, "0", md);
        questionList.add(model);
        print(questionList);
        update();
      }
    }
  }

  DeleteMultiple(String mcqID, BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your Question? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(
              Uri.parse(
                  endpoint + "/exam/addexam/${examID}/multiplechoice/$mcqID/"),
              headers: AuthHeader);
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "Course deleted succefully");
            loadExam();
            update();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }
}
