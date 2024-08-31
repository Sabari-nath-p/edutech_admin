import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab_admin/Constants/Strings.dart';
import 'package:mathlab_admin/Constants/functionsupporter.dart';
import 'package:mathlab_admin/Screen/HomeScreen/Homescreen.dart';
import 'package:mathlab_admin/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController emailText = TextEditingController();

  bool isLoading = false;
  bool isLogin = true;
  double fem = 0;
  double ffem = 0;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1200;

    fem = MediaQuery.of(context).size.width / baseWidth;
    ffem = fem * 0.8;
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500, maxHeight: 700),
          width: double.infinity,
          margin: EdgeInsets.all(100),
          alignment: Alignment.center,
          child: Container(
            // loginTBL (9:229)
            //  padding: EdgeInsets.fromLTRB(25 * fem, 26 * fem, 25 * fem, 256 * fem),
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.circular(60 * fem),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // letsgetstartedJjg (9:232)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 19 * fem),
                    child: Text('MathLab  Admin',
                        textAlign: TextAlign.center, style: mystyle()),
                  ),
                  Container(
                    // frame162519a2z (9:230)
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // inputfieldcVU (9:234)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          padding: EdgeInsets.fromLTRB(
                              20 * fem, 22 * fem, 10.5 * fem, 22 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xfff9fafb),
                            borderRadius: BorderRadius.circular(20 * fem),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  // frame511037SE (9:235)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.black54,
                                  )),
                              Expanded(
                                  child: TextField(
                                controller: emailText,
                                style: mystyle(color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText: "Sign in User ID",
                                    hintStyle: mystyle()),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          // inputfieldcVU (9:234)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          padding: EdgeInsets.fromLTRB(
                              20 * fem, 22 * fem, 10 * fem, 22 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xfff9fafb),
                            borderRadius: BorderRadius.circular(20 * fem),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  // frame511037SE (9:235)

                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.password)),
                              Expanded(
                                  child: TextField(
                                controller: passwordText,
                                obscureText: true,
                                style: mystyle(color: Colors.black),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText: "Enter Password",
                                    hintStyle: mystyle()),
                              ))
                            ],
                          ),
                        ),
                        if (!isLogin)
                          Container(
                            // inputfieldcVU (9:234)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 19 * fem),
                            padding: EdgeInsets.fromLTRB(
                                20 * fem, 22 * fem, 83.5 * fem, 22 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xfff9fafb),
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    // frame511037SE (9:235)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    width: 18 * fem,
                                    height: 14.32 * fem,
                                    child: Icon(Icons.near_me)),
                                Expanded(
                                    child: TextField(
                                  controller: nameText,
                                  style: mystyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      isCollapsed: true,
                                      hintText: "Enter Name",
                                      hintStyle: mystyle()),
                                ))
                              ],
                            ),
                          ),
                        if (isLogin)
                          InkWell(
                            onTap: () {
                              if (passwordText.text.isNotEmpty &&
                                  emailText.text.isNotEmpty) {
                                tryLog(emailText.text.trim(),
                                    passwordText.text.trim());
                              } else {}
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: (isLoading)
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white, size: 25)
                                  : Text(
                                      "sign In",
                                      style: mystyle(
                                          color: Colors.white, size: 23),
                                    ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black),
                            ),
                          ),
                        if (!isLogin)
                          InkWell(
                            onTap: () {
                              if (nameText.text.isNotEmpty &&
                                  passwordText.text.isNotEmpty &&
                                  emailText.text.isNotEmpty) {
                                tryReg(
                                    nameText.text.trim(),
                                    emailText.text.trim(),
                                    passwordText.text.trim());
                              } else {}
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: (isLoading)
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white, size: 25)
                                  : Text(
                                      "Sign Up",
                                      style: mystyle(
                                          color: Colors.white, size: 23),
                                    ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black),
                            ),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        if (!isLogin)
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already Have an Account?',
                                  style: mystyle(size: 14),
                                ),
                                Text(' ', style: mystyle()),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text('Sign in', style: mystyle()),
                                ),
                              ],
                            ),
                          ),
                        if (isLogin)
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'you, didn\'t have an account?',
                                  style: mystyle(size: 14),
                                ),
                                Text(' ', style: mystyle()),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text('Sign up', style: mystyle()),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  mystyle({Color color = const Color(0xff979797), double size = 16}) {
    return GoogleFonts.lato(
      fontSize: size * ffem,
      fontWeight: FontWeight.w500,
      height: 1.6000000238 * ffem / fem,
      color: color,
    );
  }

  /* sendlogin(String email, String password) {
    setState(() {
      isLoading = true;
    });
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    users.doc(email).get().then((value) async {
      if (value.exists) {
        if (password == value.get("password").toString()) {
          print(value.data());
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("LOGIN", "IN");
          pref.setString("EMAIL", email);
          pref.setString("PASSWORD", password);
          pref.setString("NAME", value.get("name").toString());
          // if (value.get("admin").exists)
          // pref.setString("ISADMIN", value.get("admin").toString());
          //Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "Sucessfully Logined");
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "Login failed , invalid Credential");
        }
      } else {
        Fluttertoast.showToast(msg: "Login failed , invalid Credential");
        setState(() {
          isLoading = false;
        });
      }
    });
  }*/

  tryLog(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(Uri.parse(endpoint + "/users/login/"),
        body: {"username": "$email", "password": "$password"});

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      if (response.body.toString() ==
          "\"The username or password is incorrect\"") {
        ShowToast(
            title: "Invalid Credentials",
            body: "username or password is incorrect");
      } else if (response.body.toString() == "Multiple Login Detected") {
        // ShowToast(title: "Already Logined", body: "Please retry to login");
        tryLog(email, password);
      } else {
        var js = json.decode(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("TOKEN", js["token"]);
        preferences.setString("LOGIN", "IN");
        preferences.setString("EMAIL", email);
        token = js["token"];
        Get.to(HomeScreen(),
            duration: Duration(
              milliseconds: 500,
            ),
            transition: Transition.zoom);
      }
    }
  }

  tryReg(String name, String email, String password) async {}
}
