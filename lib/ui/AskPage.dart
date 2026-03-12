import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AskPage extends StatelessWidget {
  const AskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(backgroundColor: Colors.blue,),
        Talking(),
      ],
    );
  }
}


class Talking extends StatefulWidget {
  const Talking({super.key});

  @override
  State<Talking> createState() => _TalkingState();
}

class _TalkingState extends State<Talking> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        MyTextField(),
      ],
    );
  }
}

class MyTextField extends StatefulWidget {
  const  MyTextField({super.key});

  @override
  State< MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State< MyTextField> {

  TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.all(10.h),
      height: 60.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: Colors.grey,width: 0.5.h),
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black45, // 阴影颜色
            blurRadius: 10.0.h, // 模糊半径
            spreadRadius: 1.0.h, // 扩散半径
            offset: Offset(1.0, 1.0), // X,Y轴偏移量
          ),
        ]
      ),

      child: TextField(
        controller: textEditingController,
      ),
    );
  }
}

