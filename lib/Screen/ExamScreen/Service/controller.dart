import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/NumericalModel.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiSelectModel.dart';
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
  MultiSelectModel? multiSelectModel;
  NumericalsModel? numericalsModel;
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
    if (qmodel.questionType == "0") multipleChoiceModel = qmodel.questionModel;
    if (qmodel.questionType == "1") multiSelectModel = qmodel.multiSelectModel;
    if (qmodel.questionType == "2") numericalsModel = qmodel.numericalsModel;
    questionType = int.parse(qmodel.questionType.toString()).toInt();

    update();
    notifier.value++;
  }

  loadmSQ({int id = -1}) async {
    String mockQID;
    if (id != -1)
      mockQID = id.toString();
    else
      mockQID = multiSelectModel!.msqId.toString();
    final response = await get(
        Uri.parse(endpoint + "/exam/addexam/${examID}/multiselect/$mockQID/"),
        headers: AuthHeader);
    if (response.statusCode == 200) {
      multiSelectModel = MultiSelectModel.fromJson(json.decode(response.body));
      update();
      loadExam();
    }
  }

  loadExam() async {
    questionList = [];
    final Response = await http.get(
        Uri.parse(endpoint + "exam/addexam/$examID/"),
        headers: AuthHeader);

    // print("$endpoint/exam/addexam/$examID/");

    if (Response.statusCode == 200 || Response.statusCode == 201) {
      var exam = json.decode(Response.body);
      examModel = ExamModel.fromJson(exam);
      print(Response.body);
      examModel = ExamModel.fromJson(exam);
      for (var data in exam["multiplechoice"]) {
        MultipleChoiceModel md = MultipleChoiceModel.fromJson(data);
        questionsModel model =
            questionsModel(md.mcqId, md.questionNo, "0", md, null, null);
        questionList.add(model);
        //  print(questionList);
        update();
      }

      for (var data in exam["multiselect"]) {
        MultiSelectModel md = MultiSelectModel.fromJson(data);
        questionsModel model =
            questionsModel(md.msqId, md.questionNo, "1", null, md, null);
        questionList.add(model);
        //  print(questionList);
        update();
      }

      for (var data in exam["numericals"]) {
        NumericalsModel md = NumericalsModel.fromJson(data);
        questionsModel model =
            questionsModel(md.nqId, md.questionNo, "2", null, null, md);
        questionList.add(model);
        //  print(questionList);
        update();
      }
    }
  }

  DeleteMultiple(String mcqID, int type, BuildContext context) {
    String balance = "/exam/addexam/${examID}/";
    if (type == 0)
      balance = balance + "multiplechoice/$mcqID/";
    else if (type == 1)
      balance = balance + "multiselect/$mcqID/";
    else
      balance = balance + "numericals/$mcqID/";

    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        title: "Are you sure want to delete",
        text:
            "Do you really want to delete your Question? You can't undo this action",
        onConfirmBtnTap: () async {
          final response = await http.delete(Uri.parse(endpoint + balance),
              headers: AuthHeader);
          print(response.body);
          print(response.statusCode);

          if (response.statusCode == 204) {
            ShowToast(title: "Successful", body: "Question deleted succefully");
            loadExam();
            update();
            Navigator.of(context).pop();
          } else {
            ShowToast(title: "Error occurred", body: "Something went to wrong");
          }
        });
  }
}
