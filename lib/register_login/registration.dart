//registration

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visions_academy/data_for_log_register/auth.dart';
import 'package:visions_academy/data_for_log_register/database.dart';
import 'package:visions_academy/loading/loading0.dart';

class SignUp extends StatefulWidget {
  static const String id = "SignIn";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Controller
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  //final action
  final AuthService _auth = new AuthService();
  DatabaseService _databaseService = new DatabaseService();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _showPassword = false;
  String email, password, photoUrl, devID;

  //signUpUser
  void _signUpUser(String email, String password, BuildContext context,
      String displayName, String phoneNumber) async {
    try {
      String _returnString = await _auth.signUpUser(
          email, password, displayName, phoneNumber, photoUrl, devID);
      if (_returnString == "success") {
        setState(() => loading = true);
        Navigator.pushReplacementNamed(context, "/log");
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(e.message),
      ));
    }
  }

  void getId() async {
    devID = await _databaseService.getId();
    print(devID.toString());
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : //loading
        Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Stack(children: <Widget>[
                      Container(
                        ///all screen
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
                                vertical: 20.0,
                              ),
                              child: Column(

                                  ///word in the top
                                  children: <Widget>[
                                    SizedBox(height: 40.0),
                                    Text(
                                      'Registration',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Column(

                                        ///the box which in side the register
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 5.0),
                                          Container(
                                            height: 620,
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
                                              ///box field
                                              key: formKey,
                                              child: Column(children: <Widget>[
                                                SizedBox(height: 1.0),
                                                TextFormField(
                                                  autocorrect: false,
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
                                                    RegExp regExp =
                                                        new RegExp(p);

                                                    if (regExp
                                                        .hasMatch(emailValue)) {
                                                      // So, the email is valid
                                                      return null;
                                                    }
                                                    TextStyle(
                                                        color: Colors.white);
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
                                                    hintText:
                                                        'Enter Your Email',
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
                                                            BorderRadius
                                                                .circular(
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
                                                              color:
                                                                  Colors.white);
                                                          return 'This field is mandatory';
                                                        }
                                                        if (pwValue.length <
                                                            6) {
                                                          TextStyle(
                                                              color:
                                                                  Colors.white);
                                                          return 'Password must be at least 6 characters';
                                                        }

                                                        return null;
                                                      },
                                                      autocorrect: false,
                                                      obscureText:
                                                          !_showPassword,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.lock,
                                                          color: Colors.black,
                                                        ),
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _showPassword =
                                                                  !_showPassword;
                                                            });
                                                          },
                                                          child: Icon(
                                                            _showPassword
                                                                ? Icons
                                                                    .visibility
                                                                : Icons
                                                                    .visibility_off,
                                                          ),
                                                        ),
                                                        errorStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        hintText:
                                                            'Enter Your Password',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.white),
                                                        focusColor:
                                                            Colors.white,
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
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
                                                    SizedBox(height: 1.0),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          _confirmPasswordController,
                                                      onChanged: (textValue) {
                                                        setState(() {});
                                                      },
                                                      validator: (pwConfValue) {
                                                        if (pwConfValue !=
                                                            password) {
                                                          TextStyle(
                                                              color:
                                                                  Colors.white);
                                                          return 'Passwords must match';
                                                        }

                                                        return null;
                                                      },
                                                      autocorrect: false,
                                                      obscureText:
                                                          !_showPassword,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons.lock,
                                                          color: Colors.black,
                                                        ),
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              _showPassword =
                                                                  !_showPassword;
                                                            });
                                                          },
                                                          child: Icon(
                                                            _showPassword
                                                                ? Icons
                                                                    .visibility
                                                                : Icons
                                                                    .visibility_off,
                                                          ),
                                                        ),
                                                        errorStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        hintText:
                                                            'Re-Enter Password',
                                                        hintStyle: TextStyle(
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.white),
                                                        focusColor:
                                                            Colors.white,
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
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
                                                SizedBox(height: 10.0),
                                                TextFormField(
                                                  style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 20),
                                                  onChanged: (textValue) {
                                                    setState(() {
                                                      _displayNameController =
                                                          textValue
                                                              as TextEditingController;
                                                    });
                                                  },
                                                  // ignore: missing_return
                                                  validator:
                                                      // ignore: missing_return
                                                      (_displayNameController) {
                                                    if (_displayNameController
                                                        .isEmpty) {
                                                      return 'This field is fullName';
                                                    }
                                                    if (_displayNameController
                                                            .length <
                                                        4) {
                                                      return "Name must be at least 2 Word long";
                                                    }
                                                  },
                                                  controller:
                                                      _displayNameController,
                                                  cursorColor:
                                                      Color(0xFFFFFFFF),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    errorStyle: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    prefixIcon: Icon(
                                                      Icons.account_circle,
                                                      color: Colors.black,
                                                    ),
                                                    hintText: "FullName",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal),
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
                                                ),
                                                SizedBox(height: 10.0),
                                                TextField(
                                                  style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 20),
                                                  controller: _phoneController,
                                                  cursorColor:
                                                      Color(0xFFFFFFFF),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.mobile_screen_share,
                                                      color: Colors.black,
                                                    ),
                                                    hintText: "Phone",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal),
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
                                                ),
                                                SizedBox(height: 30),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      RaisedButton(
                                                        elevation: 40.0,
                                                        color: Colors.white,
                                                        child: Text(
                                                          'Register',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15.0,
                                                                horizontal: 60),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ),
                                                        onPressed: () async {
                                                          if (formKey
                                                              .currentState
                                                              .validate()) {
                                                            setState(() =>
                                                                loading = true);

                                                            _signUpUser(
                                                                _emailController
                                                                    .text,
                                                                _passwordController
                                                                    .text,
                                                                context,
                                                                _displayNameController
                                                                    .text,
                                                                _phoneController
                                                                    .text);
                                                          }
                                                        },
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator
                                                              .pushReplacementNamed(
                                                                  context,
                                                                  "/log");
                                                        },
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              'ALREADY REGISTERED?',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            ),
                                                            Text(
                                                              'SIGN IN',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ])
                                              ]),
                                            ),
                                          )
                                        ]),
                                  ]))),
                    ]))));
  }
}
