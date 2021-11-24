import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String text;
  Display(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        // color: Color.fromRGBO(48, 48, 48, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: AutoSizeText(
                text,
                minFontSize: 20,
                maxFontSize: 80,
                textAlign: TextAlign.end,
                maxLines: 1,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 80.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
