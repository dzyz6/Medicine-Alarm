import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/PageChange.dart';
import 'package:provider/provider.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        height: 80.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  splashColor: Colors.white.withAlpha(30),
                  onTap: context.read<PageChange>().pageChangeToAskPage,
                  child: SizedBox(
                    width: 40.w,
                      height: 40.h,
                      child: Center(child: Icon(Icons.add_task)))),
              InkWell(
                  splashColor: Colors.white.withAlpha(30),
                  onTap: context.read<PageChange>().pageChangeToAlarmPage,
                  child: Icon(Icons.calendar_today_outlined)),
            ],
          ),
        ));
  }
}
