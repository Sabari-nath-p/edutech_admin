import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:tex_text/tex_text.dart';

import '../Service/controller.dart';

class QuestionListView extends StatefulWidget {
  const QuestionListView({super.key});

  @override
  State<QuestionListView> createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  ExamController Ectrl = Get.put(ExamController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var data in Ectrl.questionList)
            Container(
              height: 70,
              margin: EdgeInsets.symmetric(vertical: 5),
              constraints: BoxConstraints(
                maxHeight: 150,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primaryColor.withOpacity(.8)),
              child: Row(
                children: [
                  width(5),
                  Container(
                    width: 60,
                    alignment: Alignment.center,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: tx600(data.questionNumber.toString(), size: 20),
                  ),
                  width(5),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      alignment: Alignment.topLeft,
                      child: TexText(
                        data.questionModel!.question!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Ectrl.EditQuestion(data);
                        },
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Ectrl.DeleteMultiple(
                              data.questionID.toString(), context);
                        },
                        child: Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  width(20)
                ],
              ),
            )
        ],
      ),
    );
  }
}
