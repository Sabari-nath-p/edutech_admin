import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ProfileView/Service/controller.dart';

class ExamResponseView extends StatelessWidget {
  ExamResponseView({super.key});
  ProfileController pctrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tx600("Attended Exams Result", size: 21),
        SizedBox(
          height: 10,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black12)),
          child: Column(
            children: [
              if (pctrl.individualUser!.examResponse != null)
                DataTable(
                    showBottomBorder: true,
                    columnSpacing: 0,
                    horizontalMargin: 0,
                    headingRowHeight: 50,
                    columns: [
                      DataColumn(
                        label: Container(
                            width: 140,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Exam Name")),
                      ),
                      DataColumn(
                        label: Container(
                            width: 200,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Mark Scored")),
                      ),
                      DataColumn(
                        label: Container(
                            width: 150,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            color: Colors.grey.withOpacity(.1),
                            child: tx600("Time Taken")),
                      ),
                    ],
                    rows: [
                      for (var data in pctrl.individualUser!.examResponse!)
                        DataRow(cells: [
                          DataCell(Container(
                              width: 140,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: tx600("${data["exam_name"]}"))),
                          DataCell(Container(
                              width: 180,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: tx600(
                                  "${data["marks_scored"]!}/${data["total_scored"]}"))),
                          DataCell(Container(
                              width: 150,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              child: tx600("${(data["time_taken"])}"))),
                        ])
                    ])
            ],
          ),
        ),
      ],
    );
  }
}
