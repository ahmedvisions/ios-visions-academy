import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visions_academy/components/component.dart';
import 'package:visions_academy/components/shard/shard.dart';
import 'package:visions_academy/components/widget/loading.dart';
import 'package:visions_academy/ui/screens/home_screen/home_and_Screen/home_page.dart';
import 'package:visions_academy/ui/screens/home_screen/home_screen.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/auth.dart';
import 'package:visions_academy/ui/screens/login_signup/data_for_log_register/database.dart';
import 'package:visions_academy/ui/screens/login_signup/login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  static const String id = "SignIn";

  const SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final prefs =  SharedPreferences.getInstance();

  //Controller
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //final action
  final AuthService _auth = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  final  _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool _showPassword = false;
  String email, password, photoUrl, devID, _error;

  //signUpUser
  void _signUpUser(String email, String password, BuildContext context,
      String displayName, String phoneNumber) async {
    try {
      String _returnString = await _auth.signUpUser(
          email, password, displayName, phoneNumber, photoUrl, devID);
      if (_returnString == "success") {
        setState(() => loading = true);
        navigateAndFinish(context, const Home());

      }
    } catch (e) {

      setState(() => loading = false);
      Get.snackbar('Error login account', e.message,
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);

      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text(e.message),
      // ));

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
        : Scaffold(
            // appBar: AppBar(
            //   elevation: 0,
            //   leading: IconButton(
            //     icon: const Icon(Icons.arrow_back_ios),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ),
            body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          color: Theme.of(context).primaryColor,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Lottie.asset('assets/lottieJson/login.json',
                                      height: 150),
                                  const SizedBox(
                                    height: 10,
                                  ),

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
                                        const TextStyle(color: Colors.white);
                                        return 'This field is mandatory';
                                      }

                                      String p =
                                          "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
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
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter Your Email',
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
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
                                    autocorrect: false,
                                    obscureText: !_showPassword,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
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
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter Your Password',
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    onChanged: (textValue) {
                                      setState(() {});
                                    },
                                    validator: (pwConfValue) {
                                      if (pwConfValue != password) {
                                        const TextStyle(color: Colors.white);
                                        return 'Passwords must match';
                                      }
                                      return null;
                                    },
                                    autocorrect: false,
                                    obscureText: !_showPassword,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
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
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Confirm Password',
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _displayNameController,
                                    // onChanged: (textValue) {
                                    //   setState(() {
                                    //      _displayNameController
                                    //          .text = textValue;
                                    //
                                    //   });
                                    // },
                                    // ignore: missing_return
                                    validator: (nameValue) {
                                      if (nameValue.isEmpty) {
                                        return 'This field is fullName';
                                      }
                                      if (nameValue.length < 4) {
                                        return "Name must be at least 2 Word long";
                                      }
                                    },
                                    // // ignore: missing_return
                                    //     (_displayNameController) {
                                    //   if (_displayNameController
                                    //       .isEmpty) {
                                    //     return 'This field is fullName';
                                    //   }
                                    //   if (_displayNameController
                                    //       .length <
                                    //       4) {
                                    //     return "Name must be at least 2 Word long";
                                    //   }
                                    // },
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.account_circle,
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Full Name',
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    keyboardType:
                                    TextInputType.phone,
                                    controller: _phoneController,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.mobile_screen_share,
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Phone Number',
                                      contentPadding: const EdgeInsets.all(15),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FlatButton(
                                    child: const Text(
                                      'Signup',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    shape: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(15),
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      _formKey.currentState.save();
                                      if (_formKey.currentState.validate()) {
                                        setState(() =>
                                        loading = true);
                                        try{
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
                                        }catch(e){
                                          setState(() =>
                                          loading =
                                          false);
                                          Get.snackbar('Error Signup account', e.message,
                                              colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
                                        }
                                      }

                                      // _formKey.currentState.save();
                                      // if (_formKey.currentState.validate()) {
                                      //   setState(() => loading = true);
                                      //   try {
                                      //     _signUpUser(
                                      //         _emailController.text,
                                      //         _passwordController.text,
                                      //         context,
                                      //         _displayNameController.text,
                                      //         _phoneController.text);
                                      //   } catch (e) {
                                      //     print(e);
                                      //     setState(() {
                                      //       loading = false ;
                                      //       _error = e.toString();
                                      //     });
                                      //   }
                                      // }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    LoginScreen()));
                                          },
                                          child: Column(
                                            children: const <Widget>[
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )));
  }
}
