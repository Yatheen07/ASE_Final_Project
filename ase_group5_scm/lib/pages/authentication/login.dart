import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:get/get.dart';
import 'package:ase_group5_scm/routing/routes.dart';
import 'package:ase_group5_scm/constants/style.dart';
import 'package:ase_group5_scm/widgets/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';

/*
* Login screen class is used to implement authentication of users
*
* */

var guestVar = true;
StreamSubscription? connection;
bool isoffline = false;

class loginScreen extends StatelessWidget {
  static const String _title = 'Dublin SCM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text(_title)),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  //user name field
  TextEditingController userNameController = TextEditingController();

  //password field
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                padding: EdgeInsets.all(24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Image.asset("assets/icons/logo.png"),
                          )),
                          Expanded(
                              child: Text("Dublin SCM",
                                  style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                          Expanded(child: Container()),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                      ),
                      CustomText(
                        text: "Enter the admin credentials ",
                        color: lightGrey,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          key: Key("username-field"),
                          controller: userNameController,
                          decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "abc@domain.com",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: TextField(
                          key: Key("password-field"),
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "123",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          signIn(userNameController.text,
                                  passwordController.text)
                              .then((result) {
                            if (result == "success") {
                              Get.offAllNamed(overviewPageRoute);
                            } else if (result == "network-request-failed") {
                              setState(() {
                                guestVar = true;
                              });
                            } else {
                              guestVar = false;
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Invalid credentials!"),
                                    content: result == "unknown"
                                        ? new Text("Empty username or password")
                                        : new Text(result),
                                    actions: <Widget>[
                                      new TextButton(
                                        child: new Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: active,
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: CustomText(
                            text: "Login",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      isoffline == true
                          ? Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: new GestureDetector(
                                    onTap: () {
                                      Get.offAllNamed(overviewPageRoute);
                                    },
                                    child: new Text(
                                      "No internet Login offline",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: active,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )))
                          : Container()
                    ]))));
  }

  /*
  * signIn method is used to authenticate credentials with firebase
  *
  * @param String email
  * @param String password
  * @return Future<String> (success or auth message)
  * */
  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
