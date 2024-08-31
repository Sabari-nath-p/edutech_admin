import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Models/sectionModel.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Service/controller.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addModule.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Widgets/addSection.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class SectionView extends StatefulWidget {
  const SectionView({super.key});

  @override
  State<SectionView> createState() => _SectionViewState();
}

class _SectionViewState extends State<SectionView> {
  HomeController ctrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              ctrl.SetContent("");
              ;
              ctrl.update();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
          ),
          width(10),
          tx700(ctrl.SelectedContentModel.examModel!.examName!,
              size: 25, color: Colors.black54),
          Expanded(child: Container()),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => Container(
                      alignment: Alignment.center, child: Addsection()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: primaryColor),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  tx600("Add Section", color: Colors.white)
                ],
              ),
            ),
          ),
          width(10),
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
                    child: tx600("NO")),
              ),
              DataColumn(
                label: Container(
                    width: 200,
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(2),
                    color: Colors.grey.withOpacity(.1),
                    child: tx600("Section Name")),
              ),
              DataColumn(
                label: Container(
                    width: 150,
                    height: 40,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(2),
                    color: Colors.grey.withOpacity(.1),
                    child: tx600("Question")),
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
              for (SectionModel data in ctrl.SectionList)
                DataRow(cells: [
                  DataCell(Container(
                      width: 90,
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      child: tx600("${data.sectionNo}"))),
                  DataCell(InkWell(
                    onTap: () {
                      ctrl.selectedSection = data.id.toString();
                      ctrl.SelectedSectionModel = data;
                      ctrl.update();
                      //ctrl.SetModule(data.sectionName.toString(), cs: data);
                    },
                    child: Container(
                        width: 180,
                        margin: EdgeInsets.only(left: 20),
                        height: 40,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(2),
                        child: tx600("${data.sectionName}")),
                  )),
                  DataCell(Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      child: tx600(
                          "${data.noOfQuestions ?? 0}/${data.noOfQuesToBeValidated ?? 0}"))),
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Container(
                                    alignment: Alignment.center,
                                    child: Addsection(
                                      model: data,
                                    )));
                          },
                          child: Icon(Icons.edit)),
                      width(20),
                      InkWell(
                          onTap: () {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.confirm,
                                title: "Are you sure want to delete",
                                text:
                                    "Do you really want to delete your Section? You can't undo this action",
                                onConfirmBtnTap: () async {
                                  Navigator.of(context).pop();
                                  ctrl.deleteSection(data.id.toString());
                                });
                          },
                          child: Icon(Icons.delete))
                    ],
                  )),
                ])
            ]),
      ),
    ])));
  }
}
