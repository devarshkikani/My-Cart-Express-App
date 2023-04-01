import 'package:flutter/material.dart';

class ERaisedButtonCustomWidget extends StatelessWidget {
  const ERaisedButtonCustomWidget(
      {super.key,
      required this.icon,
      this.text,
      this.onPressed,
      this.borderColor = Colors.white});
  final IconData icon;
  final String? text;
  final Function()? onPressed;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: borderColor,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
