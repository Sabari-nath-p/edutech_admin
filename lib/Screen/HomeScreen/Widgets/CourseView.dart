import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Screen/ExamScreen/ExamMain.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/courseModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/ContentView.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/ModuleView.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/SubjectView.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addCourse.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/sectionView.dart';

import '../../../Constants/AppColor.dart';
import '../../../Constants/functionsupporter.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  //TextEditingController CourseSearchText = TextEditingController();
  String CourseSearchText = "";
  HomeController ctrl = Get.put(HomeController());

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  //   ctrl.loadCourse();
  // }

  @override
  Widget build(BuildContext context) {
    return (ctrl.SelectedCourse != "")
        ? (ctrl.SelectedSubject != "")
            ? (ctrl.SelectedModule != "")
                ? ctrl.SelectedCotent != ""
                    ? ctrl.selectedSection == ""
                        ? SectionView()
                        : ExamMainScreen(
                            selectedSectionID: ctrl.selectedSection,
                          )
                    : ContentView()
                : ModuleView()
            : SubjectView()
        : Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      tx700("Our Courses ", size: 25, color: Colors.black54),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => Container(
                                  alignment: Alignment.center,
                                  child: addCourse()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: primaryColor),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              tx600("Add Course", color: Colors.white)
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
                              CourseSearchText = value;
                            });
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              //  isCollapsed: ,
                              hintText: "Search Course",
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
                    // height: 1000,
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
                                child: tx600("Course Names")),
                          ),
                          DataColumn(
                            label: Container(
                                width: 150,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                color: Colors.grey.withOpacity(.1),
                                child: tx600("Course Price")),
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
                                child: tx600("Is Paid")),
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
                          for (CourseModel data in ctrl.CourseList)
                            if (CourseSearchText == "" ||
                                data.fieldOfStudy
                                    .toString()
                                    .toUpperCase()
                                    .contains(CourseSearchText.toUpperCase()))
                              DataRow(cells: [
                                DataCell(Container(
                                    width: 90,
                                    height: 40,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    child: tx600("${data.courseUniqueId}"))),
                                DataCell(InkWell(
                                  onTap: () {
                                    print("working");
                                    ctrl.SetCourse(
                                        data.courseUniqueId.toString(),
                                        cs: data);
                                  },
                                  child: Container(
                                      width: 180,
                                      margin: EdgeInsets.only(left: 20),
                                      height: 40,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(2),
                                      child: tx600("${data.fieldOfStudy}")),
                                )),
                                DataCell(Container(
                                    width: 150,
                                    height: 40,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    child: tx600("${data.price}"))),
                                DataCell(Container(
                                    width: 150,
                                    height: 40,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    child: tx600("${data.isActive}"))),
                                DataCell(Container(
                                    width: 150,
                                    height: 40,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    child: tx600("${data.onlyPaid}"))),
                                DataCell(Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Container(
                                                  alignment: Alignment.center,
                                                  child: addCourse(
                                                    Cdata: data.toJson(),
                                                  )));
                                        },
                                        child: Icon(Icons.edit)),
                                    width(20),
                                    InkWell(
                                        onTap: () {
                                          ctrl.DeleteCourse(
                                              data.courseUniqueId.toString(),
                                              context);
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

CourseCard(CourseModel model) {
  return Container(
    width: 180,
    height: 140,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Column(
      children: [Image.network("")],
    ),
  );
}
