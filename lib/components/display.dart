import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  final String text;
  Display(this.text);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: AutoSizeText(
                widget.text,
                minFontSize: 20,
                maxFontSize: 80,
                textAlign: TextAlign.end,
                maxLines: 1,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 72.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
