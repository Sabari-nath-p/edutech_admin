import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Constants/inputField.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/models/NumericalModel.dart';
import 'package:dio/dio.dart' as Request;

class NumericalQuestionView extends StatefulWidget {
  NumericalsModel? model;
  NumericalQuestionView({super.key, this.model});

  @override
  State<NumericalQuestionView> createState() => _NumericalQuestionViewState();
}

class _NumericalQuestionViewState extends State<NumericalQuestionView> {
  TextEditingController questionText = TextEditingController();

  TextEditingController questionImage = TextEditingController();

  TextEditingController maxRange = TextEditingController();

  TextEditingController minRange = TextEditingController();

  TextEditingController Solution = TextEditingController();

  TextEditingController SoultionImage = TextEditingController();

  TextEditingController postiveMark = TextEditingController();

  TextEditingController negativeMark = TextEditingController();

  TextEditingController correctAnswer = TextEditingController();

  TextEditingController questionNo = TextEditingController();

  bool Loading = false;

  ExamController Ectrl = Get.put(ExamController());

  late NumericalsModel md;

  @override
  void initState() {
    // TODO: implement initState
    if (Ectrl.QuestionEdit) {
      widget.model = Ectrl.numericalsModel;
      md = widget.model!;
      questionNo.text = widget.model!.questionNo.toString();
      questionNo.text = widget.model!.questionNo!.toString();
      questionText.text = widget.model!.question.toString();
      maxRange.text = widget.model!.ansMaxRange!;
      minRange.text = widget.model!.ansMinRange!;
      correctAnswer.text = widget.model!.answer!;
      Solution.text = widget.model!.solutionText!;
      postiveMark.text = widget.model!.positiveMarks!.toString();
      negativeMark.text = widget.model!.negetiveMark!.toString();
      if (md.solutionImage != null) SoultionImage.text = md.solutionImage!;
      if (md.questionImage != null) questionImage.text = md.questionImage!;
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
          tx700("Add Numerical Question", size: 24),
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
          Tfields("Max Range", maxRange),
          height(10),
          Tfields("Min Range", minRange),
          height(10),
          Tfields("Correct Answer", correctAnswer),
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
              if ((widget.model == null)) {
                AddInput();
              } else {
                UpdateQuestion();
              }
            },
            child: ButtonContainer(
              (Loading)
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white, size: 22)
                  : tx600(
                      (widget.model != null)
                          ? "Update Question"
                          : "Add Question",
                      color: Colors.white),
              width: 150,
              radius: 10,
            ),
          ),
          height(20)
        ],
      ),
    ));
  }

  AddInput() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "question": questionText.text,
      "ans_max_range": maxRange.text,
      "exam_name": Ectrl.examID,
      "question_no": questionNo.text,
      "ans_min_range": minRange.text,
      "positive_marks": postiveMark.text,
      "negetive_mark": negativeMark.text,
      "answer": correctAnswer.text,
      "section": Ectrl.selectedSectionID,
      "question_type": 3,
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

    final response = await dio.post(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/numericals/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) => true,
        ));
    //  print(response.data);
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

  UpdateQuestion() async {
    final dio = Request.Dio();

    Request.FormData formData = Request.FormData.fromMap({
      "question": questionText.text,
      "ans_max_range": maxRange.text,
      "exam_name": Ectrl.examID,
      "question_no": questionNo.text,
      "ans_min_range": minRange.text,
      "positive_marks": postiveMark.text,
      "negetive_mark": negativeMark.text,
      "answer": correctAnswer.text,
      "question_type": 3,
      "solution_text": Solution.text,
      if (questionImage.text != "" && questionImage.text != md.questionImage)
        'question_image': await Request.MultipartFile.fromFile(
            questionImage.text,
            filename: questionImage.text.split("/").last),
      if (SoultionImage.text != "" && SoultionImage.text != md.solutionImage)
        'solution_image': await Request.MultipartFile.fromFile(
            SoultionImage.text,
            filename: SoultionImage.text.split("/").last),
    });

    final response = await dio.patch(
        endpoint +
            "/exam/addexam/${Ectrl.examID}/numericals/${md.nqId}/", //users/fieldofstudy/${SelectedCourse}/subjects/",
        data: formData,
        options: Request.Options(
          headers: AuthHeader,
          validateStatus: (status) => true,
        ));
    //  print(response.data);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ShowToast(title: "Question updated", body: "Exam is updated succefully");
      setState(() {
        Loading = false;
      });

      Ectrl.questionType = -1;
      Ectrl.update();
      Ectrl.loadExam();
    } else {
      print(response.data);
      print(response.statusCode);
      ShowToast(title: "Error occurred", body: response.data);
      setState(() {
        Loading = false;
      });
    }
  }
}
