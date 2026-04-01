import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/CommonPrefs.dart';

class AskPage extends StatelessWidget {
  const AskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        thisAppbar(),
        Expanded(child: Talking()),
        bottomTextField(),
        SizedBox(height:80.h,)
      ],
    );
  }

  Widget thisAppbar() {
    return Container(
      height: 80.h,
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 5.h),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "AI",
          style: TextStyle(fontSize: 25.sp),
        ),
      ),
    );
  }

  Widget bottomTextField() {
    return Container(
      constraints: BoxConstraints(
          minHeight: 60.h
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 2, // 不扩散，仅边缘有阴影
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.photo_camera_outlined),
          SizedBox(width: 200.w,child: TextField(),),
          Icon(Icons.mic_none_rounded),
          Icon(Icons.add_circle_outline),
        ],
      ),
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
    return const Placeholder();
  }
}
