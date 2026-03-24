import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/Color.dart';
import 'AddAlarm.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {




  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AppBar(
              backgroundColor: MyColor().backgroundColor,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  child: Text(
                    "闹钟",
                    style: TextStyle(fontSize: 30.sp),
                  ),
                )),
          ],
        ),

        ///悬浮按钮
        floatingButton(),
      ],
    );
  }

  Widget alarmRemind() {
    return Container();
  }

  Widget floatingButton() {
    return Positioned(
      right: 25.w,
      bottom: 100.h,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: MyColor().backgroundColor,
              context: context,
              constraints: BoxConstraints(maxHeight: 770.h),
              builder: (BuildContext modalContext) {

                return AddAlarm();
              },
              isScrollControlled: true);
        },
        child: Container(
          width: 55.w,
          height: 55.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40.r)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 6,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Icon(
            Icons.add,
            color: MyColor().blue2,
            size: 40.sp,
          ),
        ),
      ),
    );
  }


}

