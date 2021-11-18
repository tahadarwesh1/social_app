import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/colors.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultTextField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String label,
  required IconData prefixIcon,
  required String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  bool isPassword = false,
  IconData? suffixIcon,
  void Function()? suffixPressed,
}) =>
    TextFormField(
      style: TextStyle(
        color: defaultColor,
      ),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
          label: Text(
            label,
          ),
          prefixIcon: Icon(
            prefixIcon,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(
          //     20.0,
          //   ),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(
          //     20.0,
          //   ),
          // ),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffixIcon,
            ),
          )),
    );

Widget defaultButton({
  required String title,
  required void Function()? onPressed,
}) =>
    MaterialButton(
      minWidth: double.infinity,
      height: 50.0,
      color: defaultColor,
      onPressed: onPressed,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );

void toast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
