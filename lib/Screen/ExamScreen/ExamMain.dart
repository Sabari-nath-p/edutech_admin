import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Screen/ExamScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/ExamScreen/widgets/questionAdd.dart';
import 'package:mathlab_admin/Screen/ExamScreen/widgets/questionList.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

import '../../Constants/functionsupporter.dart';

class ExamMainScreen extends StatefulWidget {
  String selectedSectionID;
  ExamMainScreen({super.key, required this.selectedSectionID});

  @override
  State<ExamMainScreen> createState() => _ExamMainScreenState();
}

class _ExamMainScreenState extends State<ExamMainScreen> {
  HomeController ctrl = Get.put(HomeController());
  ExamController Ectrl = Get.put(ExamController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ectrl.selectedSectionID = widget.selectedSectionID;
    Ectrl.setController(
        ctrl.SelectedCourseModel.courseUniqueId!,
        ctrl.SelectedSubjectModel.subjectId!,
        ctrl.SelectedModuleModel.modulesId!,
        ctrl.SelectedContentModel.examModel!.examUniqueId!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<ExamController>(builder: (_) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ctrl.selectedSection = "";
                    ctrl.update();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                ),
                width(10),
                //  if (Ectrl.examModel != null)
                tx700(ctrl.SelectedContentModel!.examModel!.examName!,
                    size: 25, color: Colors.black54),
                Expanded(child: Container()),
                width(20)
              ],
            ),
            Container(
              //width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 83,
              child: Row(
                children: [
                  Container(
                    width: 703,
                    child: QuestionAdd(),
                  ),
                  width(10),
                  Expanded(
                    child: Container(
                      //   width: 420,
                      child: QuestionListView(),
                    ),
                  ),
                  width(20),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
