import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calculator/components/button_row.dart';
import 'package:calculator/components/button.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  final void Function(String) cb;
  Keyboard(this.cb);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        children: <Widget>[
          ButtonRow([
            Button(text: 'AC', color: Button.DARK, cb: widget.cb),
            Button(text: '+/-', color: Button.DARK, cb: widget.cb),
            Button(text: '%', color: Button.DARK, cb: widget.cb),
            Button.operation(text: '/', cb: widget.cb)
          ]),
          SizedBox(height: 5.0.h),
          ButtonRow([
            Button(text: '7', cb: widget.cb),
            Button(text: '8', cb: widget.cb),
            Button(text: '9', cb: widget.cb),
            Button.operation(text: 'x', cb: widget.cb)
          ]),
          SizedBox(height: 5.0.h),
          ButtonRow([
            Button(text: '4', cb: widget.cb),
            Button(text: '5', cb: widget.cb),
            Button(text: '6', cb: widget.cb),
            Button.operation(text: '-', cb: widget.cb),
          ]),
          SizedBox(height: 5.0.h),
          ButtonRow([
            Button(text: '1', cb: widget.cb),
            Button(text: '2', cb: widget.cb),
            Button(text: '3', cb: widget.cb),
            Button.operation(text: '+', cb: widget.cb)
          ]),
          SizedBox(height: 5.0.h),
          ButtonRow(
            [
              Button.big(text: '0', cb: widget.cb),
              Button(text: '.', cb: widget.cb),
              Button.operation(text: '=', cb: widget.cb)
            ],
          ),
        ],
      ),
    );
  }
}
