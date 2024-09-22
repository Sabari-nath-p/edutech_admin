import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/AppHeaders.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/sectionModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

class SectionChange {
  static changeMultiselect(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
            alignment: Alignment.center, child: _SectionChangeMultiselect()));
  }

  static changeMultiChoice(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
            alignment: Alignment.center, child: _SectionChangeMultichoice()));
  }

  static changeNumerical(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
            alignment: Alignment.center, child: _sectionCHangeNumerical()));
  }
}

class _SectionChangeMultiselect extends StatefulWidget {
  _SectionChangeMultiselect({super.key});

  @override
  State<_SectionChangeMultiselect> createState() =>
      _SectionChangeMultiselectState();
}

class _SectionChangeMultiselectState extends State<_SectionChangeMultiselect> {
  HomeController hctrl = Get.put(HomeController());
  int? SelectedItem;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: 800, maxHeight: 450),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
              child: Column(
                children: [
                  tx700("Change Question Section", size: 24),
                  height(20),
                  tx600("Select Section "),
                  tx500("From ${hctrl.SelectedSectionModel.sectionName} "),
                  height(10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButton(
                        isExpanded: true,
                        value: SelectedItem,
                        items: hctrl.SectionList.map((data) => DropdownMenuItem(
                              child: tx500(data.sectionName!),
                              value: data.id,
                            )).toList(),
                        onChanged: (value) {
                          SelectedItem = value;
                          setState(() {});
                        }),
                  ),
                  height(10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      ExamController ectrl = Get.put(ExamController());
                      final Response = await post(
                          Uri.parse(
                            endpoint + "exam/alter-multiselect-section/",
                          ),
                          body: json.encode({
                            "section_id": SelectedItem,
                            "question_id": ectrl.multiSelectModel!.msqId
                          }),
                          headers: AuthHeader);

                      print(Response.body);
                      print(Response.statusCode);
                      ectrl.questionType = -1;
                      ectrl.QuestionEdit = false;
                      ectrl.multipleChoiceModel = null;
                      ectrl.multiSelectModel = null;
                      ectrl.loadExam();
                      ectrl.update();

                      Navigator.of(context).pop();
                    },
                    child: InkWell(
                      child: ButtonContainer(
                        (loading)
                            ? LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.white, size: 24)
                            : tx600("Change Section", color: Colors.white),
                        width: 150,
                        radius: 10,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}

class _SectionChangeMultichoice extends StatefulWidget {
  _SectionChangeMultichoice({super.key});

  @override
  State<_SectionChangeMultichoice> createState() =>
      _SectionChangeMultichoiceState();
}

class _SectionChangeMultichoiceState extends State<_SectionChangeMultichoice> {
  HomeController hctrl = Get.put(HomeController());
  int? SelectedItem;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: 800, maxHeight: 450),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
              child: Column(
                children: [
                  tx700("Change Question Section", size: 24),
                  height(20),
                  tx600("Select Section "),
                  tx500("From ${hctrl.SelectedSectionModel.sectionName} "),
                  height(10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButton(
                        isExpanded: true,
                        value: SelectedItem,
                        items: hctrl.SectionList.map((data) => DropdownMenuItem(
                              child: tx500(data.sectionName!),
                              value: data.id,
                            )).toList(),
                        onChanged: (value) {
                          SelectedItem = value;
                          setState(() {});
                        }),
                  ),
                  height(10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      ExamController ectrl = Get.put(ExamController());
                      final Response = await post(
                          Uri.parse(
                            endpoint + "exam/alter-numerical-section/",
                          ),
                          body: json.encode({
                            "section_id": SelectedItem,
                            "question_id": ectrl.multipleChoiceModel!.mcqId
                          }),
                          headers: AuthHeader);

                      print(Response.body);
                      print(Response.statusCode);
                      ectrl.questionType = -1;
                      ectrl.QuestionEdit = false;
                      ectrl.multipleChoiceModel = null;
                      ectrl.multiSelectModel = null;
                      ectrl.loadExam();
                      ectrl.update();

                      Navigator.of(context).pop();
                    },
                    child: InkWell(
                      child: ButtonContainer(
                        (loading)
                            ? LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.white, size: 24)
                            : tx600("Change Section", color: Colors.white),
                        width: 150,
                        radius: 10,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}

class _sectionCHangeNumerical extends StatefulWidget {
  const _sectionCHangeNumerical({super.key});

  @override
  State<_sectionCHangeNumerical> createState() =>
      __sectionCHangeNumericalState();
}

class __sectionCHangeNumericalState extends State<_sectionCHangeNumerical> {
  HomeController hctrl = Get.put(HomeController());
  int? SelectedItem;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: 800, maxHeight: 450),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 90),
              child: Column(
                children: [
                  tx700("Change Question Section", size: 24),
                  height(20),
                  tx600("Select Section "),
                  tx500("From ${hctrl.SelectedSectionModel.sectionName} "),
                  height(10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButton(
                        isExpanded: true,
                        value: SelectedItem,
                        items: hctrl.SectionList.map((data) => DropdownMenuItem(
                              child: tx500(data.sectionName!),
                              value: data.id,
                            )).toList(),
                        onChanged: (value) {
                          SelectedItem = value;
                          setState(() {});
                        }),
                  ),
                  height(10),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      ExamController ectrl = Get.put(ExamController());
                      final Response = await post(
                          Uri.parse(
                            endpoint + "exam/alter-numerical-section/",
                          ),
                          body: json.encode({
                            "section_id": SelectedItem,
                            "question_id": ectrl.numericalsModel!.nqId
                          }),
                          headers: AuthHeader);

                      print(Response.body);
                      print(Response.statusCode);
                      ectrl.questionType = -1;
                      ectrl.QuestionEdit = false;
                      ectrl.multipleChoiceModel = null;
                      ectrl.multiSelectModel = null;
                      ectrl.loadExam();
                      ectrl.update();

                      Navigator.of(context).pop();
                    },
                    child: InkWell(
                      child: ButtonContainer(
                        (loading)
                            ? LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.white, size: 24)
                            : tx600("Change Section", color: Colors.white),
                        width: 150,
                        radius: 10,
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
