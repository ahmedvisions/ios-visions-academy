import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:visions_academy/components/component.dart';
import 'package:visions_academy/components/shard/shard.dart';
import 'package:visions_academy/components/widget/loading.dart';
import 'package:visions_academy/ui/screens/home_screen/home_screen.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/auth_for_stay_log.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/database.dart';
import 'package:visions_academy/ui/screens/login_signup/sign_up/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.onSignedIn, this.auth});

  // // static const routeName = '/login';

  // final BaseAuth auth;
  final BaseAuth auth;
  VoidCallback onSignedIn;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();

  ///Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ///strings
  String email, password, devID, _error,uid;
  bool loading = false;
  bool _showPassword = false;

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
            body: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.all(15),
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height:130),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Lottie.asset(
                          'assets/lottieJson/login.json',
                          height: 150,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          controller: _emailController,
                          onChanged: (textValue) {
                            setState(() {
                              email = textValue;
                            });
                          },
                          validator: (emailValue) {
                            if (emailValue.isEmpty) {
                              const TextStyle(color: Colors.white);
                              return 'This field is mandatory';
                            }

                            String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                "\\@" +
                                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                "(" +
                                "\\." +
                                "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                ")+";
                            RegExp regExp = RegExp(p);

                            if (regExp.hasMatch(emailValue)) {
                              // So, the email is valid
                              return null;
                            }
                            const TextStyle(color: Colors.white);
                            return 'This is not a valid email';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          onChanged: (textValue) {
                            setState(() {
                              password = textValue;
                            });
                          },
                          validator: (pwValue) {
                            if (pwValue.isEmpty) {
                              const TextStyle(color: Colors.white);
                              return 'This field is mandatory';
                            }
                            if (pwValue.length < 6) {
                              const TextStyle(color: Colors.white);
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: !_showPassword,
                          autocorrect: false,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                            filled: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            hintText: 'Password',
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          shape: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(15),
                          textColor: Colors.white,
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              setState(() => loading = true);

                              try {
                                await _firebaseAuth.signInWithEmailAndPassword(
                                    email: email, password: password);
                                _databaseService
                                    .loginUser(
                                    getUID(),
                                    await getId());
                                navigateAndFinish(context, const Home());
                                widget.onSignedIn();
                              } catch (e) {
                                print(e);
                                setState(() => loading = false);
                                setState(() {
                                  _error = e.toString();
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                            },
                            child: const Text(
                              'Not Registered ? sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ]),
                    showAlert(),
                  ],
                ),
              ),
            )),
            // appBar: AppBar(
            //   elevation: 0,
            //   leading: IconButton(
            //     icon: const Icon(Icons.arrow_back_ios),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ),

            // body: LayoutBuilder(
            //   builder: (BuildContext context, BoxConstraints constraints) {
            //     return SingleChildScrollView(
            //         child: Container(
            //       padding: const EdgeInsets.all(15),
            //       color: Theme.of(context).primaryColor,
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height,
            //       child: Form(
            //         key: formKey,
            //         child: Column(
            //           children: [
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.stretch,
            //               children: <Widget>[
            //                 Lottie.asset(
            //                   'assets/lottieJson/login.json',
            //                   height: 150,
            //                 ),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 TextFormField(
            //                   style: const TextStyle(
            //                       fontSize: 18, color: Colors.black54),
            //                   decoration: InputDecoration(
            //                     prefixIcon: const Icon(
            //                       Icons.email,
            //                       color: Colors.black,
            //                     ),
            //                     filled: true,
            //                     fillColor: Colors.white,
            //                     hintText: 'Email',
            //                     contentPadding: const EdgeInsets.all(15),
            //                     focusedBorder: OutlineInputBorder(
            //                       borderSide:
            //                           const BorderSide(color: Colors.white),
            //                       borderRadius: BorderRadius.circular(5),
            //                     ),
            //                     enabledBorder: UnderlineInputBorder(
            //                       borderSide:
            //                           const BorderSide(color: Colors.white),
            //                       borderRadius: BorderRadius.circular(5),
            //                     ),
            //                   ),
            //                   controller: _emailController,
            //                   onChanged: (textValue) {
            //                     setState(() {
            //                       email = textValue;
            //                     });
            //                   },
            //                   validator: (emailValue) {
            //                     if (emailValue.isEmpty) {
            //                       const TextStyle(color: Colors.white);
            //                       return 'This field is mandatory';
            //                     }
            //
            //                     String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
            //                         "\\@" +
            //                         "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            //                         "(" +
            //                         "\\." +
            //                         "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
            //                         ")+";
            //                     RegExp regExp = RegExp(p);
            //
            //                     if (regExp.hasMatch(emailValue)) {
            //                       // So, the email is valid
            //                       return null;
            //                     }
            //                     const TextStyle(color: Colors.white);
            //                     return 'This is not a valid email';
            //                   },
            //                 ),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 TextFormField(
            //                   controller: _passwordController,
            //                   onChanged: (textValue) {
            //                     setState(() {
            //                       password = textValue;
            //                     });
            //                   },
            //                   validator: (pwValue) {
            //                     if (pwValue.isEmpty) {
            //                       const TextStyle(color: Colors.white);
            //                       return 'This field is mandatory';
            //                     }
            //                     if (pwValue.length < 6) {
            //                       const TextStyle(color: Colors.white);
            //                       return 'Password must be at least 6 characters';
            //                     }
            //                     return null;
            //                   },
            //                   obscureText: !_showPassword,
            //                   autocorrect: false,
            //                   style: const TextStyle(
            //                       fontSize: 18, color: Colors.black54),
            //                   decoration: InputDecoration(
            //                     filled: true,
            //                     suffixIcon: GestureDetector(
            //                       onTap: () {
            //                         setState(() {
            //                           _showPassword = !_showPassword;
            //                         });
            //                       },
            //                       child: Icon(
            //                         _showPassword
            //                             ? Icons.visibility
            //                             : Icons.visibility_off,
            //                       ),
            //                     ),
            //                     prefixIcon: const Icon(
            //                       Icons.lock,
            //                       color: Colors.black,
            //                     ),
            //                     fillColor: Colors.white,
            //                     hintText: 'Password',
            //                     contentPadding: const EdgeInsets.all(15),
            //                     focusedBorder: OutlineInputBorder(
            //                       borderSide:
            //                           const BorderSide(color: Colors.white),
            //                       borderRadius: BorderRadius.circular(5),
            //                     ),
            //                     enabledBorder: UnderlineInputBorder(
            //                       borderSide:
            //                           const BorderSide(color: Colors.white),
            //                       borderRadius: BorderRadius.circular(5),
            //                     ),
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 FlatButton(
            //                   child: const Text(
            //                     'Login',
            //                     style: TextStyle(
            //                       fontSize: 20,
            //                     ),
            //                   ),
            //                   shape: OutlineInputBorder(
            //                     borderSide: const BorderSide(
            //                         color: Colors.white, width: 2),
            //                     borderRadius: BorderRadius.circular(5),
            //                   ),
            //                   padding: const EdgeInsets.all(15),
            //                   textColor: Colors.white,
            //                   onPressed: () async {
            //                     if (formKey.currentState.validate()) {
            //                       setState(() => loading = true);
            //                       try {
            //                         await _firebaseAuth
            //                             .signInWithEmailAndPassword(
            //                                 email: email, password: password);
            //                         navigateTo(context, const Home());
            //                         widget.onSignedIn();
            //                       } catch (e) {
            //                         print(e);
            //                         setState(() => loading = false);
            //                         setState(() {
            //                           _error = e.toString();
            //                         });
            //                       }
            //                     }
            //                   },
            //                 ),
            //               ],
            //             ),
            //             SizedBox(height: _height * 0.025),
            //             Row(
            //                 mainAxisAlignment:
            //                 MainAxisAlignment.center,
            //                 children: <Widget>[
            //                   InkWell(
            //                     onTap: () {
            //                       Navigator.pushReplacement(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) =>
            //                                   const SignupScreen()));
            //                     },
            //                     child: const Text(
            //                       'Not Registered ? sign up',
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 16.0,
            //                         fontWeight:
            //                         FontWeight.bold,
            //                         decoration:
            //                         TextDecoration
            //                             .underline,
            //                       ),
            //                     ),
            //                   ),
            //                 ]),
            //             showAlert(),
            //           ],
            //         ),
            //       ),
            //     ));
            //   },
            // ),
          );
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
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
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
                icon: const Icon(Icons.close),
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
    return const SizedBox(
      height: 0,
    );
  }
}
