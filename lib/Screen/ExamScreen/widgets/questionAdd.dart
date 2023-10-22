import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/ExamScreen/widgets/multipleChoice.dart';

import '../../../Constants/AppColor.dart';
import '../../../Constants/functionsupporter.dart';

class QuestionAdd extends StatefulWidget {
  QuestionAdd({super.key});

  @override
  State<QuestionAdd> createState() => _QuestionAddState();
}

class _QuestionAddState extends State<QuestionAdd> {
  @override
  ExamController ctrl = Get.put(ExamController());

  List QuestionType = ["Multiple", "MultiChoice", "Numerical"];

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          height(20),
          Row(
            children: [
              for (int i = 0; i < QuestionType.length; i++)
                InkWell(
                  onTap: () {
                    ctrl.questionType = i;
                    ctrl.update();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: (ctrl.questionType == i)
                            ? primaryColor
                            : Colors.grey.withOpacity(.7)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        tx600(QuestionType[i], color: Colors.white)
                      ],
                    ),
                  ),
                ),
              Expanded(child: Container()),
              InkWell(
                  onTap: () {
                    ctrl.questionType = -1;
                    ctrl.QuestionEdit = false;
                    ctrl.multipleChoiceModel = null;
                    ctrl.update();
                  },
                  child: Icon(Icons.close)),
              width(20)
            ],
          ),
          if (ctrl.questionType == 0) MultipleChoice()
        ],
      ),
    );
  }
}
