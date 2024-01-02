import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ProfileView/Service/controller.dart';

class EnrolledCourse extends StatelessWidget {
  EnrolledCourse({super.key});
  ProfileController pctrl = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tx600("Enrolled Course", size: 21),
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
                if (pctrl.selectedProfileModel!.purchaseList != null)
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
                              child: tx600("Course ID")),
                        ),
                        DataColumn(
                          label: Container(
                              width: 200,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              color: Colors.grey.withOpacity(.1),
                              child: tx600("Purchase Date")),
                        ),
                        DataColumn(
                          label: Container(
                              width: 150,
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(2),
                              color: Colors.grey.withOpacity(.1),
                              child: tx600("Expire Date")),
                        ),
                      ],
                      rows: [
                        for (var data in pctrl.selectedProfileModel!
                            .purchaseList!.purchasedCourses!)
                          DataRow(cells: [
                            DataCell(Container(
                                width: 140,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: tx600("${data.courseId}"))),
                            DataCell(Container(
                                width: 180,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: tx600(
                                    "${pctrl.DateView(data.dateOfPurchase!)}"))),
                            DataCell(Container(
                                width: 150,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(2),
                                child: tx600(
                                    "${pctrl.DateView(data.expirationDate!)}"))),
                          ])
                      ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
