import 'package:flutter/cupertino.dart';

class MyButton extends StatefulWidget {
  MyButton({super.key,required this.child,required this.onTap});

  Widget child;

  Function() onTap;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.child,
    );
  }
}
