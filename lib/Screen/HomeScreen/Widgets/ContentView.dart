import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/contentModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addExam.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addNote.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addVideo.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/player.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/AppColor.dart';
import '../../../Constants/functionsupporter.dart';
import '../Service/controller.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  String SearchContent = "";
  HomeController ctrl = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          ctrl.SetModule("");
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                        ),
                      ),
                      width(10),
                      tx700(ctrl.SelectedCourseModel.fieldOfStudy!,
                          size: 25, color: Colors.black54),
                      Container(
                        width: 100,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Container(
                              alignment: Alignment.center, child: AddExam()));
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
                          tx600("Add Exam", color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                  width(10),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Container(
                              alignment: Alignment.center, child: AddVideo()));
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
                          tx600("Add Video", color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                  width(10),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Container(
                              alignment: Alignment.center, child: AddNote()));
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
                          tx600("Add Note", color: Colors.white)
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
                          SearchContent = value;
                        });
                      },
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          //  isCollapsed: ,
                          hintText: "Search Modules",
                          prefixIcon: Icon(Icons.search),
                          isDense: true),
                    ),
                  ),
                  width(20)
                ],
              ),
            ),
            Container(
              // width: 900,
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.topLeft,
              // height: 1000,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                            width: 250,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Content Title")),
                      ),
                      DataColumn(
                        label: Container(
                            width: 150,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Content Type")),
                      ),
                      DataColumn(
                        label: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Active")),
                      ),
                      DataColumn(
                        label: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Actions")),
                      ),
                      DataColumn(
                        label: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Preview")),
                      ),
                    ],
                    rows: [
                      for (contentModel data in ctrl.ContentList)
                        if (SearchContent == "" ||
                            data.title
                                .toString()
                                .toUpperCase()
                                .contains(SearchContent.toUpperCase()))
                          DataRow(cells: [
                            DataCell(Container(
                                width: 90,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: tx600("${data.content_id}"))),
                            DataCell(InkWell(
                              onTap: () {
                                // ctrl.SetCourse(data.courseUniqueId.toString(),
                                //     cs: data);
                              },
                              child: Container(
                                  width: 230,
                                  margin: EdgeInsets.only(left: 20),
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.all(2),
                                  child: tx600("${data.title}")),
                            )),
                            DataCell(Container(
                                width: 150,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: tx600("${data.type}"))),
                            DataCell(Container(
                                width: 100,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: tx600("${data.isVisible}"))),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      if (data.type == "VIDEO")
                                        showDialog(
                                            context: context,
                                            builder: (context) => Container(
                                                alignment: Alignment.center,
                                                child: AddVideo(
                                                  Vdata: data.video!.toJson(),
                                                )));
                                      if (data.type == "NOTE")
                                        showDialog(
                                            context: context,
                                            builder: (context) => Container(
                                                alignment: Alignment.center,
                                                child: AddNote(
                                                  Vdata:
                                                      data.noteModel!.toJson(),
                                                )));
                                      if (data.type == "EXAM")
                                        showDialog(
                                            context: context,
                                            builder: (context) => Container(
                                                alignment: Alignment.center,
                                                child: AddExam(
                                                  Edata:
                                                      data.examModel!.toJson(),
                                                )));
                                    },
                                    child: Icon(Icons.edit)),
                                width(20),
                                InkWell(
                                    onTap: () {
                                      if (data.type == "VIDEO")
                                        ctrl.DeleteVideo(
                                            data.video!.videoUniqueId!
                                                .toString(),
                                            context);

                                      if (data.type == "NOTE")
                                        ctrl.DeleteNote(
                                            data.noteModel!.notesId!.toString(),
                                            context);
                                      if (data.type == "EXAM")
                                        ctrl.DeleteExam(
                                            data.examModel!.examUniqueId!
                                                .toString(),
                                            context);
                                    },
                                    child: Icon(Icons.delete))
                              ],
                            )),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (data.type == "EXAM")
                                        ctrl.SetContent(
                                            data.content_id.toString(),
                                            cs: data);

                                      if (data.type == "VIDEO") {
                                        List option =
                                            data.video!.videoId!.split("/");
                                        launchUrl(Uri.parse(
                                            'https://player.vimeo.com/video/${option[0]}?h=${option[1]}'));
                                      }

                                      if (data.type == "NOTE") {
                                        launchUrl(
                                            Uri.parse(data.noteModel!.pdf!));
                                      }
                                    },
                                    child: Container(
                                        //width: 100,
                                        height: 40,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(2),
                                        child: Icon(Icons.preview)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      int i = ctrl.ContentList.indexOf(data);
                                      if (i > 0) {
                                        DateTime sdate = DateTime.parse(
                                            data.created_date.toString());
                                        DateTime fdate = DateTime.parse(ctrl
                                            .ContentList[i - 1].created_date!);

                                        DateTime middleDate =
                                            calculateMiddleDate(fdate, sdate);
                                        ctrl.SelectedDate = middleDate;

                                        print(sdate);
                                        print(middleDate);
                                        print(fdate);
                                      }
                                    },
                                    child: Container(
                                        // width: 100,
                                        height: 40,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(2),
                                        child: RotatedBox(
                                            quarterTurns: 1,
                                            child: Icon(
                                                Icons.arrow_back_ios_rounded))),
                                  ),
                                ],
                              ),
                            )
                          ])
                    ]),
              ),
            ),
            height(100)
          ],
        ),
      ),
    );
  }
}

DateTime calculateMiddleDate(DateTime date1, DateTime date2) {
  // Calculate the difference in days between the two dates
  Duration difference = date2.difference(date1);

  // Calculate the middle date by adding half of the difference to the first date
  DateTime middleDate =
      date1.add(Duration(microseconds: difference.inMicroseconds ~/ 2));

  return middleDate;
}
