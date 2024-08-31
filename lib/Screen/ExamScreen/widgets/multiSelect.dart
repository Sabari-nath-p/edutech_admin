import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/controller.dart';
import 'package:dio/dio.dart' as Request;
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiSelectModel.dart';
import 'package:mathlab_admin/Screen/ExamScreen/widgets/multiOption.dart';
import '../../../Constants/inputField.dart';

class MultiSelect extends StatefulWidget {
  var Edata;
  MultiSelect({super.key, this.Edata = 1});

  @override
  State<MultiSelect> createState() => _MultiSelectState(Edata: Edata);
}

class _MultiSelectState extends State<MultiSelect> {
  var Edata;
  _MultiSelectState({required this.Edata});
  TextEditingController questionText = TextEditingController();

  TextEditingController questionImage = TextEditingController();

  TextEditingController Solution = TextEditingController();

  TextEditingController SoultionImage = TextEditingController();

  TextEditingController postiveMark = TextEditingController();

  TextEditingController negativeMark = TextEditingController();

  TextEditingController correctAnswer = TextEditingController();

  TextEditingController questionNo = TextEditingController();

  MultiSelectModel? md;

  bool Loading = false;
  ExamController Ectrl = Get.put(ExamController());

  @override
  void initState() {
    // TODO: implement initState

    if (Ectrl.QuestionEdit) {
      // loadNotifier();

      md = Ectrl.multiSelectModel!;
      Edata = md;
      questionNo.text = md!.questionNo.toString();
      questionText.text = md!.question.toString();
      if (md!.questionImage != null) questionImage.text = md!.questionImage!;

      Solution.text = md!.solutionText!;
      if (md!.solutionImage != null) SoultionImage.text = md!.solutionImage!;
      postiveMark.text = md!.positiveMarks.toString();
      negativeMark.text = md!.negetiveMark.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            height(20),
            tx700("Add Multiple Select Question", size: 24),
            height(10),
            Tfields("Question No", questionNo),
            height(10),
            ETLfields(
              "Question Text",
              questionText,
            ),
            height(10),
            fieldImage("Question Image", questionImage),
            height(10),
            ETLfields("Solution Text", Solution),
            height(10),
            fieldImage("Solution Image", SoultionImage),
            height(10),
            Tfields("Postive Mark", postiveMark),
            height(10),
            Tfields("Negative Mark", negativeMark),
            height(10),
            InkWell(
              onTap: () {
                setState(() {
                  Loading = true;
                });
                if ((Edata == 1))
                  addInput();
                else
                  updateInput();
                // else {
                //   updateInput();
                // }
              },
              child: ButtonContainer(
                (Loading)
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white, size: 22)
                    : tx600((Edata != 1) ? "Update Question" : "Add Question",
                        color: Colors.white),
                width: 150,
                radius: 10,
              ),
            ),
            if (md != null) MultiSelectOption()
          ],
        ),
      ),
    );
  }

  addInput() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "question": questionText.text,
      //  "option1_text": optionA.text,
      "exam_name": Ectrl.examID,
      "question_no": questionNo.text,
      // "option2_text": optionB.text,
      // "option3_text": optionC.text,
      // "option4_text": optionD.text,
      "section": Ectrl.selectedSectionID,
      "positive_marks": postiveMark.text,
      "negetive_mark": negativeMark.text,
      // "answer": correctAnswer.text,
      "solution_text": Solution.text,
      if (questionImage.text != "")
        'question_image': await Request.MultipartFile.fromFile(
            questionImage.text,
            filename: questionImage.text.split("/").last),

      if (SoultionImage.text != "")
        'solution_image': await Request.MultipartFile.fromFile(
            SoultionImage.text,
            filename: SoultionImage.text.split("/").last),
    });

    print(formData.toString());

    final response = await dio.post(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/multiselect/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) => true,
        ));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(title: "Question Added", body: "Exam is added succefully");
      setState(() {
        Loading = false;
      });
      Ectrl.multiSelectModel = MultiSelectModel.fromJson(response.data);
      // Ectrl.questionType = -1;
      md = Ectrl.multiSelectModel;

      Ectrl.loadExam();
      Ectrl.questionType =
          1; //int.parse(Ectrl.qmodel.questionType.toString()).toInt();
      Ectrl.QuestionEdit = true;
      Ectrl.update();
    } else {
      ShowToast(title: "Error occurred", body: response.data);
      setState(() {
        Loading = false;
      });
    }
  }

  updateInput() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "question": questionText.text,
      //  "option1_text": optionA.text,
      "exam_name": Ectrl.examID,
      "question_no": questionNo.text,
      // "option2_text": optionB.text,
      // "option3_text": optionC.text,
      // "option4_text": optionD.text,
      "positive_marks": postiveMark.text,
      "negetive_mark": negativeMark.text,
      // "answer": correctAnswer.text,
      "solution_text": Solution.text,
      if (questionImage.text != "" &&
          questionImage.text != md!.questionImage.toString())
        'question_image': await Request.MultipartFile.fromFile(
            questionImage.text,
            filename: questionImage.text.split("/").last),

      if (SoultionImage.text != "" &&
          SoultionImage.text != md!.solutionImage.toString())
        'solution_image': await Request.MultipartFile.fromFile(
            SoultionImage.text,
            filename: SoultionImage.text.split("/").last),
    });

    final response = await dio.patch(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/multiselect/${md!.msqId}/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) => true,
        ));

    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(
          title: "Question Updated", body: "Question is updated succefully");
      Ectrl.update();
      Ectrl.loadmSQ();
      Ectrl.loadExam();
      setState(() {
        Loading = false;
      });

      // Ectrl.questionType = -1;
    } else {
      print(response.data);
      print(response.statusCode);
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      setState(() {
        Loading = false;
      });
    }
  }
}
