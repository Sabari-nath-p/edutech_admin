import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Constants/inputField.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/sectionModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

class Addsection extends StatefulWidget {
  SectionModel? model;
  Addsection({super.key, this.model});

  @override
  State<Addsection> createState() => _AddsectionState();
}

class _AddsectionState extends State<Addsection> {
  TextEditingController sectionName = TextEditingController();
  TextEditingController sectionNo = TextEditingController();
  TextEditingController ValidateQuestionCount = TextEditingController();
  TextEditingController positiveMark = TextEditingController();
  TextEditingController negativeMark = TextEditingController();

  bool sectionloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      sectionName.text = widget.model!.sectionName ?? "";
      sectionNo.text = widget.model!.sectionNo ?? "";
      ValidateQuestionCount.text =
          widget.model!.noOfQuesToBeValidated.toString() ?? "";
      positiveMark.text = widget.model!.positiveMarks.toString();
      negativeMark.text = widget.model!.negetiveMark.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 800, minHeight: 300),
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
                        tx700("Add Section", size: 24),
                        height(10),
                        Tfields("Section Name*", sectionName),
                        height(10),
                        Tfields("Section no", sectionNo),
                        height(10),
                        Tfields("No of Question to validate",
                            ValidateQuestionCount),
                        height(10),
                        Tfields("Positive Mark*", positiveMark),
                        height(10),
                        Tfields("Negative Mark", negativeMark),
                        height(10),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (sectionName.text.isNotEmpty &&
                          sectionNo.text.isNotEmpty &&
                          ValidateQuestionCount.text.isNotEmpty &&
                          positiveMark.text.isNotEmpty &&
                          negativeMark.text.isNotEmpty) {
                        setState(() {
                          sectionloading = true;
                        });
                        if (widget.model == null)
                          addSectionData();
                        else
                          editSectionData();
                      } else {
                        ShowToast(
                            title: "Missing Fields",
                            body: "Please enter missing field");
                      }
                    },
                    child: ButtonContainer(
                      (sectionloading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600(
                              (widget.model != null)
                                  ? "Update Section"
                                  : "Add Section",
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

  addSectionData() async {
    HomeController ctrl = Get.put(HomeController());
    SectionModel model = SectionModel(
        sectionName: sectionName.text,
        sectionNo: sectionNo.text,
        noOfQuesToBeValidated: int.parse(ValidateQuestionCount.text),
        positiveMarks: double.parse(positiveMark.text),
        negetiveMark: double.parse(negativeMark.text));

    final Response = await post(Uri.parse(endpoint + "exam/sections-add/"),
        headers: AuthHeader,
        body: json.encode({
          "exam_name": ctrl.SelectedContentModel.examModel!.examUniqueId!,
          "section_no": model.sectionNo,
          "section_name": model.sectionName,
          "no_of_ques_to_be_validated": model.noOfQuesToBeValidated,
          "positive_marks": model.positiveMarks,
          "negetive_mark": model.negetiveMark,
        }));

    print(Response.body);
    print(Response.statusCode);
    setState(() {
      sectionloading = false;
    });
    if (Response.statusCode == 200 || Response.statusCode == 201) {
      ShowToast(body: Response.body.toString(), title: "Operation Successfull");
      ctrl.loadSection();
      Navigator.of(context).pop();
    } else {
      ShowToast(body: Response.body.toString(), title: "Operation Failed");
    }
  }

  editSectionData() async {
    HomeController ctrl = Get.put(HomeController());
    SectionModel model = SectionModel(
        sectionName: sectionName.text,
        sectionNo: sectionNo.text,
        noOfQuesToBeValidated: int.parse(ValidateQuestionCount.text),
        positiveMarks: double.parse(positiveMark.text),
        negetiveMark: double.parse(negativeMark.text));

    final Response = await put(
        Uri.parse(endpoint + "exam/sections-add/${widget.model!.id}/"),
        headers: AuthHeader,
        body: json.encode({
          "exam_name": ctrl.SelectedContentModel.examModel!.examUniqueId!,
          "section_no": model.sectionNo,
          "section_name": model.sectionName,
          "no_of_ques_to_be_validated": model.noOfQuesToBeValidated,
          "positive_marks": model.positiveMarks,
          "negetive_mark": model.negetiveMark,
        }));
    print(Response.body);
    print(Response.statusCode);
    setState(() {
      sectionloading = false;
    });
    if (Response.statusCode == 200 || Response.statusCode == 201) {
      ShowToast(body: Response.body.toString(), title: "Operation Successfull");
      ctrl.loadSection();
      Navigator.of(context).pop();
    } else {
      ShowToast(body: Response.body.toString(), title: "Operation Failed");
    }
  }
}
