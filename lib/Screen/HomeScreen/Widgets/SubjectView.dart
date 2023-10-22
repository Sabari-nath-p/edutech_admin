import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/subjectModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addsubjects.dart';

import '../../../Constants/AppColor.dart';
import '../../../Constants/functionsupporter.dart';

class SubjectView extends StatefulWidget {
  const SubjectView({super.key});

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  String SubjectSearchText = "";
  HomeController ctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    ctrl.SetCourse("");
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                  ),
                ),
                width(10),
                tx700(ctrl.SelectedCourseModel.fieldOfStudy!,
                    size: 25, color: Colors.black54),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Container(
                            alignment: Alignment.center, child: AddSubjects()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        tx600("Add Subjects", color: Colors.white)
                      ],
                    ),
                  ),
                ),
                width(10),
                Container(
                  width: 250,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all()),
                  alignment: Alignment.center,
                  child: TextField(
                    // controller: CourseSearchText,
                    onChanged: (value) {
                      setState(() {
                        SubjectSearchText = value;
                      });
                    },
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //  isCollapsed: ,
                        hintText: "Search Subjects",
                        prefixIcon: Icon(Icons.search),
                        isDense: true),
                  ),
                ),
                width(20)
              ],
            ),
            Container(
              // width: 900,
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.topLeft,
              height: 1000,
              child: DataTable(
                  showBottomBorder: true,
                  columnSpacing: 0,
                  horizontalMargin: 0,
                  headingRowHeight: 50,
                  columns: [
                    DataColumn(
                      label: Container(
                          width: 90,
                          height: 40,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2),
                          color: Colors.grey.withOpacity(.1),
                          child: tx600("ID")),
                    ),
                    DataColumn(
                      label: Container(
                          width: 200,
                          height: 40,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2),
                          color: Colors.grey.withOpacity(.1),
                          child: tx600("Subject Names")),
                    ),
                    DataColumn(
                      label: Container(
                          width: 150,
                          height: 40,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2),
                          color: Colors.grey.withOpacity(.1),
                          child: tx600("Active")),
                    ),
                    DataColumn(
                      label: Container(
                          width: 150,
                          height: 40,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2),
                          color: Colors.grey.withOpacity(.1),
                          child: tx600("Actions")),
                    ),
                  ],
                  rows: [
                    for (SubjectModel data in ctrl.SubjectList)
                      if (SubjectSearchText == "" ||
                          data.subjects
                              .toString()
                              .toUpperCase()
                              .contains(SubjectSearchText.toUpperCase()))
                        DataRow(cells: [
                          DataCell(Container(
                              width: 90,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: tx600("${data.subjectId}"))),
                          DataCell(InkWell(
                            onTap: () {
                              
                              ctrl.SetSubject(data.subjectId.toString(),
                                  cs: data);
                            },
                            child: Container(
                                width: 180,
                                margin: EdgeInsets.only(left: 20),
                                height: 40,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(2),
                                child: tx600("${data.subjects}")),
                          )),
                          DataCell(Container(
                              width: 150,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: tx600("${data.isActive}"))),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Container(
                                            alignment: Alignment.center,
                                            child: AddSubjects(
                                              Sdata: data.toJson(),
                                            )));
                                  },
                                  child: Icon(Icons.edit)),
                              width(20),
                              InkWell(
                                  onTap: () {
                                    ctrl.DeleteSubject(
                                        data.subjectId.toString(), context);
                                  },
                                  child: Icon(Icons.delete))
                            ],
                          )),
                        ])
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
