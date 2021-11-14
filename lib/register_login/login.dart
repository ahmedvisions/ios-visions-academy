import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visions_academy/data_for_log_register/auth_for_stay_log.dart';
import 'package:visions_academy/data_for_log_register/database.dart';
import 'package:visions_academy/loading/loading0.dart';

class Login extends StatefulWidget {
  const Login({this.onSignedIn, this.auth});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ///final
  final formKey = GlobalKey<FormState>();

//////////////////////////////////
//   Future<void> initPlatformState() async {
//     String _platformImei;
//     String idunique;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       _platformImei =
//           await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
//       idunique = await ImeiPlugin.getId();
//     } on PlatformException {
//       _platformImei = 'Failed to get platform version.';
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       platformImei = _platformImei;
//       uniqueId = idunique;
//     });
//   }

  //////////////////////
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseService _databaseService = new DatabaseService();

  ///Controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ///strings
  String email, password, devID, _error, uid;
  bool loading = false;
  bool _showPassword = false;
//////////////////////////////////Check id////////////
//   Future<bool> checkuniqueId() async {
//     FirebaseFirestore _fire = FirebaseFirestore.instance;
//     bool a = false;
//     var b;
//
//     try {
//       await _fire.collection("users").doc(devID).get().then((value) {
//         b = value.get("email").toString();
//         if (b == _emailController.text) {
//           a = true;
//           print("UniqueId Matched");
//           print(devID + "      B/W      " + b);
//         } else {
//           print("No matched");
//           print(devID + "      B/W      " + b);
//           a = false;
//         }
//       });
//     } catch (e) {
//       print("No matched");
//       a = false;
//       print("Not Applied: " + e.toString());
//     }
//     return a;
//   }

  Future<String> getId() async {
    devID = await _databaseService.getId();
    print(devID.toString());
    return devID;
  }

  String getUID() {
    uid = FirebaseAuth.instance.currentUser.uid;
    print(uid);
    return uid;
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Stack(children: <Widget>[
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFCDD2),
                              Color(0xFFE57373),
                              Color(0xFFEF5350),
                              Color(0xFFC62828),
                            ],
                            stops: [0.1, 0.4, 0.7, 0.9],
                          ),
                        ),
                      ),
                      Container(
                          height: double.infinity,
                          child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: 35.0,
                                vertical: 10.0,
                              ),
                              child: Column(children: <Widget>[
                                SizedBox(height: 30.0),
                                Text(
                                  'Log in',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 5.0),
                                      Container(
                                        height: 380,
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.redAccent,
                                              blurRadius: 5.0,
                                              spreadRadius: 1.0,
                                              offset: Offset(
                                                4.0,
                                                4.0,
                                              ),
                                            )
                                          ],
                                        ),
                                        child: Form(
                                          key: formKey,
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 1.0),
                                            TextFormField(
                                              controller: _emailController,
                                              onChanged: (textValue) {
                                                setState(() {
                                                  email = textValue;
                                                });
                                              },
                                              validator: (emailValue) {
                                                if (emailValue.isEmpty) {
                                                  TextStyle(
                                                      color: Colors.white);
                                                  return 'This field is mandatory';
                                                }

                                                String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                                    "\\@" +
                                                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                                    "(" +
                                                    "\\." +
                                                    "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                                    ")+";
                                                RegExp regExp = new RegExp(p);

                                                if (regExp
                                                    .hasMatch(emailValue)) {
                                                  // So, the email is valid
                                                  return null;
                                                }
                                                TextStyle(color: Colors.white);
                                                return 'This is not a valid email';
                                              },
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.email,
                                                  color: Colors.black,
                                                ),
                                                errorStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                hintText: 'Enter Your Email',
                                                hintStyle: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                                focusColor: Colors.white,
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.0)),
                                              ),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 5.0),
                                                TextFormField(
                                                  controller:
                                                      _passwordController,
                                                  onChanged: (textValue) {
                                                    setState(() {
                                                      password = textValue;
                                                    });
                                                  },
                                                  validator: (pwValue) {
                                                    if (pwValue.isEmpty) {
                                                      TextStyle(
                                                          color: Colors.white);
                                                      return 'This field is mandatory';
                                                    }
                                                    if (pwValue.length < 6) {
                                                      TextStyle(
                                                          color: Colors.white);
                                                      return 'Password must be at least 6 characters';
                                                    }

                                                    return null;
                                                  },
                                                  obscureText: !_showPassword,
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _showPassword =
                                                              !_showPassword;
                                                        });
                                                      },
                                                      child: Icon(
                                                        _showPassword
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                      ),
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons.lock,
                                                      color: Colors.black,
                                                    ),
                                                    errorStyle: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    hintText:
                                                        'Enter Your Password',
                                                    hintStyle: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white),
                                                    focusColor: Colors.white,
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    60.0)),
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  RaisedButton(
                                                      elevation: 40.0,
                                                      color: Colors.white,
                                                      child: Text(
                                                        'Log In',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15.0,
                                                              horizontal: 60),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                      ),
                                                      onPressed: () async {
                                                        if (formKey.currentState
                                                            .validate()) {
                                                          setState(() =>
                                                              loading = true);
                                                          try {
                                                            await _firebaseAuth
                                                                .signInWithEmailAndPassword(
                                                                    email:
                                                                        email,
                                                                    password:
                                                                        password);

                                                            _databaseService
                                                                .loginUser(
                                                                    getUID(),
                                                                    await getId());
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    "/Botton");

                                                            widget.onSignedIn();
                                                          } catch (e) {
                                                            print(e);
                                                            setState(() =>
                                                                loading =
                                                                    false);
                                                            setState(() {
                                                              _error =
                                                                  e.toString();
                                                            });
                                                          }
                                                        }
                                                      }),
                                                ]),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              "/register");
                                                    },
                                                    child: Text(
                                                      'Not Registered ? sign up',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                          ]),
                                        ),
                                      )
                                    ]),
                                SizedBox(height: _height * 0.025),
                                showAlert(),
                              ]))),
                    ]))));
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
