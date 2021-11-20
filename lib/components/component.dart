import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function onTap,
  bool isPassword = false,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted:onSubmit ,
      onChanged:onChange,
      onTap: onTap,
      enabled: isClickable,
      validator:validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
            onPressed: suffixPressed,
              icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  @required Function function,
  @required String text,
  double radius = 0.0,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed:(){function();},
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: background),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
        onPressed:(){
          function();
    },
        child: Text(text.toUpperCase()));


