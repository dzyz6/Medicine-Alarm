import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/CommonPrefs.dart';
import 'package:nhelp/pages/home/widget/TextFieldContainer.dart';

class AskPage extends StatelessWidget {
  const AskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            thisAppbar(),
            Expanded(child: Talking()),
            SizedBox(height:140.h,)
          ],
        ),
        TextFieldContainer(),
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
}

class Talking extends StatefulWidget {
  const Talking({super.key});

  @override
  State<Talking> createState() => _TalkingState();
}

class _TalkingState extends State<Talking> {
  @override
  Widget build(BuildContext context) {
    return Text("sf");
  }
}
