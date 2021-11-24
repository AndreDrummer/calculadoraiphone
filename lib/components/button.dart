import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const OPERATION = Color.fromRGBO(250, 158, 13, 1);
  static const DEFAULT = Color.fromRGBO(112, 112, 112, 1);
  static const DARK = Color.fromRGBO(82, 82, 82, 1);

  final void Function(String)? cb;
  final String text;
  final Color color;
  final bool big;

  Button({
    this.color = DEFAULT,
    required this.text,
    this.big = false,
    this.cb,
  });
  Button.big({
    this.color = DEFAULT,
    required this.text,
    this.big = true,
    this.cb,
  });
  Button.operation({
    this.color = OPERATION,
    required this.text,
    this.big = false,
    this.cb,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.big ? 2 : 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.0.h),
          ),
          primary: this.color,
        ),
        onPressed: () => cb!(text),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 40.sp,
          ),
        ),
      ),
    );
  }
}
