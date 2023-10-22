import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/ModulesModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/subjectModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';

import '../../../Constants/functionsupporter.dart';
import '../../../Constants/inputField.dart';

class AddModule extends StatefulWidget {
  var Mdata;
  AddModule({super.key, this.Mdata = 1});

  @override
  State<AddModule> createState() => _AddModuleState(Mdata: Mdata);
}

class _AddModuleState extends State<AddModule> {
  var Mdata;
  _AddModuleState({required this.Mdata});

  TextEditingController moduleName = TextEditingController();
  TextEditingController isActive = TextEditingController();

  HomeController ctrl = Get.put(HomeController());
  late ModuleModel moduleModel;
  @override
  void initState() {
    // TODO: implement initState
    if (Mdata != 1) {
      moduleModel = ModuleModel.fromJson(Mdata);

      isActive.text = (Mdata["is_active"]) ? "1" : "";
      moduleName.text = moduleModel.moduleName!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller;
    return Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
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
                        tx700("Add Module", size: 24),
                        height(10),
                        Tfields("Module Name", moduleName),
                        height(10),
                        if (Mdata != 1) TBox("Visibility", isActive),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (moduleName.text.isNotEmpty) {
                        setState(() {
                          ctrl.CourseUploading = true;
                        });
                        if (Mdata == 1)
                          AddSubjectsData();
                        else
                          EditSubjectsData();
                      } else {}
                    },
                    child: ButtonContainer(
                      (ctrl.CourseUploading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 22)
                          : tx600((Mdata != 1) ? "Update Module" : "Add Module",
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

  AddSubjectsData() {
    ModuleModel model = ModuleModel();
    // model.subjects = ctrl.SelectedCourseModel.courseUniqueId;
    model.subjects = ctrl.SelectedSubjectModel.subjectId;
    model.moduleName = moduleName.text;

    model.isActive = false;
    ctrl.AddModule(model, context);
  }

  EditSubjectsData() {
    ModuleModel model = ModuleModel();
    // model.subjects = ctrl.SelectedCourseModel.courseUniqueId;
    model.modulesId = moduleModel.modulesId;
    model.subjects = ctrl.SelectedSubjectModel.subjectId;
    model.moduleName = moduleName.text;

    model.isActive = (isActive.text == "1") ? true : false;

    ctrl.UpdateModule(model, context);
  }
}
