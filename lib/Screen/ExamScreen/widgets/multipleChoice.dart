import 'package:dio/dio.dart' as Request;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/multiplechoice.dart';
import 'package:mathlab_admin/main.dart';

import '../../../Constants/AppHeaders.dart';
import '../../../Constants/Strings.dart';
import '../../../Constants/functionsupporter.dart';
import '../../../Constants/inputField.dart';
import '../Service/controller.dart';

class MultipleChoice extends StatefulWidget {
  var Edata;
  MultipleChoice({super.key, this.Edata = 1});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState(Edata: Edata);
}

class _MultipleChoiceState extends State<MultipleChoice> {
  var Edata;
  _MultipleChoiceState({this.Edata});
  TextEditingController questionText = TextEditingController();
  TextEditingController questionImage = TextEditingController();
  TextEditingController optionA = TextEditingController();
  TextEditingController optionAImage = TextEditingController();
  TextEditingController optionB = TextEditingController();
  TextEditingController optionBImage = TextEditingController();
  TextEditingController optionC = TextEditingController();
  TextEditingController optioncImage = TextEditingController();
  TextEditingController optionD = TextEditingController();
  TextEditingController optionDimage = TextEditingController();
  TextEditingController Solution = TextEditingController();
  TextEditingController SoultionImage = TextEditingController();
  TextEditingController postiveMark = TextEditingController();
  TextEditingController negativeMark = TextEditingController();
  TextEditingController correctAnswer = TextEditingController();
  TextEditingController questionNo = TextEditingController();
  bool Loading = false;
  ExamController Ectrl = Get.put(ExamController());
  late MultipleChoiceModel md;
  @override
  void initState() {
    // TODO: implement initState

    if (Ectrl.QuestionEdit) {
      loadNotifier();

      md = Ectrl.multipleChoiceModel!;
      Edata = md;
      questionNo.text = md.questionNo.toString();
      questionText.text = md.question.toString();
      if (md.questionImage != null) questionImage.text = md.questionImage!;
      optionA.text = md.option1Text.toString();
      if (md.option1Image != null) optionAImage.text = md.option1Image!;
      optionB.text = md.option2Text.toString();
      if (md.option2Image != null) optionBImage.text = md.option2Image!;
      optionC.text = md.option3Text.toString();
      if (md.option3Image != null) optioncImage.text = md.option3Image!;
      optionD.text = md.option4Text.toString();
      if (md.option4Image != null) optionDimage.text = md.option4Image!;
      Solution.text = md.solutionText!;
      if (md.solutionImage != null) SoultionImage.text = md.solutionImage!;
      postiveMark.text = md.positiveMarks.toString();
      negativeMark.text = md.negetiveMark.toString();
      correctAnswer.text = md.answer.toString();
    }
    super.initState();
  }

  loadNotifier() {
    Ectrl.notifier.addListener(() {
      md = Ectrl.multipleChoiceModel!;
      questionNo.text = md.questionNo.toString();
      questionText.text = md.question.toString();
      if (md.questionImage != null) questionImage.text = md.questionImage!;
      optionA.text = md.option1Text.toString();
      if (md.option1Image != null) optionAImage.text = md.option1Image!;
      optionB.text = md.option2Text.toString();
      if (md.option2Image != null) optionBImage.text = md.option2Image!;
      optionC.text = md.option3Text.toString();
      if (md.option3Image != null) optioncImage.text = md.option3Image!;
      optionD.text = md.option4Text.toString();
      if (md.option4Image != null) optionDimage.text = md.option4Image!;
      Solution.text = md.solutionText!;
      if (md.solutionImage != null) SoultionImage.text = md.solutionImage!;
      postiveMark.text = md.positiveMarks.toString();
      negativeMark.text = md.negetiveMark.toString();
      correctAnswer.text = md.answer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(token);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            height(20),
            tx700("Add Multiple Choice Question", size: 24),
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
            ETLfields("Option A", optionA),
            height(10),
            fieldImage("Option A Image", optionAImage),
            height(10),
            ETLfields("Option B", optionB),
            height(10),
            fieldImage("Option B Image", optionBImage),
            height(10),
            ETLfields("Option C", optionC),
            height(10),
            fieldImage("Option C Image", optioncImage),
            height(10),
            ETLfields("Option D", optionD),
            height(10),
            fieldImage("Option D Image", optionDimage),
            height(10),
            ETLfields("Solution Text", Solution),
            height(10),
            fieldImage("Solution Image", SoultionImage),
            height(10),
            Tfields("Postive Mark", postiveMark),
            height(10),
            Tfields("Negative Mark", negativeMark),
            height(10),
            Tfields("Correct Answer", correctAnswer),
            height(10),
            InkWell(
              onTap: () {
                setState(() {
                  Loading = true;
                });
                if ((Edata == 1))
                  addInput();
                else {
                  updateInput();
                }
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
            height(20)
          ],
        ),
      ),
    );
  }

  addInput() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "question": questionText.text,
      "option1_text": optionA.text,
      "exam_name": Ectrl.examID,
      "question_no": questionNo.text,
      "option2_text": optionB.text,
      "option3_text": optionC.text,
      "option4_text": optionD.text,
      "positive_marks": postiveMark.text,
      "negetive_mark": negativeMark.text,
      "answer": correctAnswer.text,
      "solution_text": Solution.text,
      if (questionImage.text != "")
        'question_image': await Request.MultipartFile.fromFile(
            questionImage.text,
            filename: questionImage.text.split("/").last),
      if (optionAImage.text != "")
        'option1_image': await Request.MultipartFile.fromFile(optionAImage.text,
            filename: optionAImage.text.split("/").last),
      if (optionBImage.text != "")
        'option2_image': await Request.MultipartFile.fromFile(optionB.text,
            filename: optionBImage.text.split("/").last),
      if (optioncImage.text != "")
        'option3_image': await Request.MultipartFile.fromFile(optioncImage.text,
            filename: optioncImage.text.split("/").last),
      if (optionDimage.text != "")
        'option4_image': await Request.MultipartFile.fromFile(optionDimage.text,
            filename: optionDimage.text.split("/").last),
      if (SoultionImage.text != "")
        'solution_image': await Request.MultipartFile.fromFile(
            SoultionImage.text,
            filename: SoultionImage.text.split("/").last),
    });

    final response = await dio.post(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/multiplechoice/", //users/fieldofstudy/${SelectedCourse}/subjects/",
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

      Ectrl.questionType = -1;
      Ectrl.update();
      Ectrl.loadExam();
    } else {
      print(response.data);
      print(response.statusCode);
      ShowToast(title: "Error occurred", body: "Something went to wrong");
      setState(() {
        Loading = false;
      });
    }
  }

  updateInput() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "question": questionText.text,
      "option1_text": optionA.text,
      "exam_name": Ectrl.examID,
      "question_no": questionNo.text,
      "option2_text": optionB.text,
      "option3_text": optionC.text,
      "option4_text": optionD.text,
      "positive_marks": postiveMark.text,
      "negetive_mark": negativeMark.text,
      "answer": correctAnswer.text,
      "solution_text": Solution.text,
      if (questionImage.text != "" && questionImage.text != md.questionImage)
        'question_image': await Request.MultipartFile.fromFile(
            questionImage.text,
            filename: questionImage.text.split("/").last),
      if (optionAImage.text != "" && optionAImage.text != md.option1Image)
        'option1_image': await Request.MultipartFile.fromFile(optionAImage.text,
            filename: optionAImage.text.split("/").last),
      if (optionBImage.text != "" && optionBImage.text != md.option2Image)
        'option2_image': await Request.MultipartFile.fromFile(optionB.text,
            filename: optionBImage.text.split("/").last),
      if (optioncImage.text != "" && optioncImage.text != md.option3Image)
        'option3_image': await Request.MultipartFile.fromFile(optioncImage.text,
            filename: optioncImage.text.split("/").last),
      if (optionDimage.text != "" && optionDimage.text != md.option4Image)
        'option4_image': await Request.MultipartFile.fromFile(optionDimage.text,
            filename: optionDimage.text.split("/").last),
      if (SoultionImage.text != "" && SoultionImage.text != md.solutionImage)
        'solution_image': await Request.MultipartFile.fromFile(
            SoultionImage.text,
            filename: SoultionImage.text.split("/").last),
    });

    final response = await dio.patch(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/multiplechoice/${md.mcqId}/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) => true,
        ));
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(
          title: "Question Updated", body: "Question is Updated succefully");
      setState(() {
        Loading = false;
      });

      Ectrl.questionType = -1;
      Ectrl.QuestionEdit = false;
      Ectrl.multipleChoiceModel = null;
      Ectrl.questionType = -1;
      Ectrl.update();
      Ectrl.loadExam();
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
