import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab_admin/Constants/AppColor.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/ProfileView/Model/UserListModel.dart';
import 'package:mathlab_admin/Screen/ProfileView/Model/UserProfileModel.dart';
import 'package:mathlab_admin/Screen/ProfileView/Service/controller.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/AdvanceFilterView.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/IndividualCourseAdd.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/IndividualProfileView.dart';
import 'package:mathlab_admin/Screen/ProfileView/View/MultiStudentCourseAdd.dart';

class ProfileViewScreen extends StatefulWidget {
  ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  TextEditingController usernameController = TextEditingController();

  ProfileController pctrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (pctrl.selectedProfileModel != null)
                  InkWell(
                    onTap: () {
                      pctrl.selectedProfileModel = null;
                      pctrl.update();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),
                if (pctrl.selectedProfileModel != null)
                  SizedBox(
                    width: 10,
                  ),
                tx700("Users ", size: 25, color: Colors.black54),
                Expanded(child: Container()),
                // InkWell(
                //     onTap: () {
                //       pctrl.loadProfiles();
                //     },
                //     child: Icon(Icons.replay_outlined)),
                width(10),
                if (pctrl.selectedProfileModel != null)
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => Container(
                              alignment: Alignment.center,
                              child: IndividualCoureseAdd()));
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
                          tx600("Add Course", color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                // if (pctrl.selectedProfileModel == null)
                //   InkWell(
                //     onTap: () {
                //       showDialog(
                //           context: context,
                //           builder: (context) => Container(
                //               alignment: Alignment.center,
                //               child: MultiStudentCourseAdd()));
                //     },
                //     child: Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           color: primaryColor),
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.add,
                //             color: Colors.white,
                //           ),
                //           tx600("Group Add", color: Colors.white)
                //         ],
                //       ),
                //     ),
                //   ),
                width(10),
                Container(
                  width: 250,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all()),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: usernameController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //  isCollapsed: ,
                        hintText: "Search username",
                        prefixIcon: Icon(Icons.search),
                        isDense: true),
                  ),
                ),
                width(20),
                InkWell(
                  onTap: () {
                    pctrl.loadProfiles(search: usernameController.text);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryColor),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        tx600("search", color: Colors.white)
                      ],
                    ),
                  ),
                ),
                width(20)
              ],
            ),
            height(30),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (pctrl.selectedProfileModel != null)
                            ? IndividualProfileView()
                            : DataTable(
                                showBottomBorder: true,
                                columnSpacing: 0,
                                horizontalMargin: 0,
                                headingRowHeight: 50,
                                columns: [
                                    // DataColumn(
                                    //   label: Container(
                                    //       width: 90,
                                    //       height: 40,
                                    //       alignment: Alignment.center,
                                    //       padding: EdgeInsets.all(2),
                                    //       color: Colors.grey.withOpacity(.1),
                                    //       child: tx600("ID")),
                                    // ),
                                    DataColumn(
                                      label: Container(
                                          width: 200,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          color: Colors.grey.withOpacity(.1),
                                          child: tx600("Student Names")),
                                    ),
                                    DataColumn(
                                      label: Container(
                                          width: 150,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          color: Colors.grey.withOpacity(.1),
                                          child: tx600("Contact Number")),
                                    ),
                                    DataColumn(
                                      label: Container(
                                          width: 200,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          color: Colors.grey.withOpacity(.1),
                                          child: tx600("Enrolled")),
                                    ),
                                    DataColumn(
                                      label: Container(
                                          width: 300,
                                          height: 40,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          color: Colors.grey.withOpacity(.1),
                                          child: tx600("Email ID")),
                                    ),
                                  ],
                                rows: [
                                    for (UserListModel data
                                        in pctrl.SearchStudentList)
                                      DataRow(cells: [
                                        DataCell(InkWell(
                                          onTap: () {
                                            pctrl.selectedProfileModel = data;
                                            pctrl.fetchUser(data.username!);
                                            pctrl.update();
                                          },
                                          child: Container(
                                              width: 180,
                                              margin: EdgeInsets.only(left: 20),
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.all(2),
                                              child: tx600("${data.name}")),
                                        )),
                                        DataCell(Container(
                                            width: 150,
                                            height: 40,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(2),
                                            child:
                                                tx600("${data.phoneNumber}"))),
                                        DataCell(Container(
                                            width: 200,
                                            height: 40,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(2),
                                            child: tx600(data
                                                .countOfCoursesPurchased!
                                                .toString()))),
                                        DataCell(Container(
                                            width: 300,
                                            height: 40,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(2),
                                            child: tx600("${data.username}"))),
                                      ])
                                  ]),
                        SizedBox(
                          height: 20,
                        ),
                        if (pctrl.selectedProfileModel == null &&
                            pctrl.profileDatas != null &&
                            pctrl.profileDatas["next"] != null)
                          Container(
                              padding: EdgeInsets.only(right: 200),
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  pctrl.loadProfilesMore();
                                },
                                child: tx600("Load More"),
                              )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                if (pctrl.selectedProfileModel == null) Advancefilterview()
              ],
            )),
          ],
        ),
      );
    });
  }
}
