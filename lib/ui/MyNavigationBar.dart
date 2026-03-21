import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/Color.dart';
import 'package:nhelp/provider/PageChange.dart';
import 'package:provider/provider.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> expandAnimation; // 变长动画（0→1）
  late Animation<double> shrinkAnimation; // 缩短动画（1→0）

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
      value: 0.0,
    );

    expandAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    shrinkAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInCubic),));

    animationController.addListener((){
      if(animationController.value>=0.5&&onleft){
        setState(() {
          bgleft = null;
          bgright = 80.w;
        });

      }
      if(animationController.value<=0.5&&!onleft){
          setState(() {
            bgleft = 80.w;
            bgright = null;

          });
      }

      if(animationController.value>=0.6&&onleft){
        setState(() {
          color2 = Colors.black;
          color1 = Colors.white;
        });
      }

      if(animationController.value>=0.6&&!onleft){
        setState(() {
          color1 = Colors.black;
          color2 = Colors.white;
        });
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  var color1 = Colors.black;
  var color2 = Colors.white;
  double? bgleft = 80.w;
  double? bgright = null;
  bool onleft=false;

  void onRightButton() async{
    if (animationController.isAnimating) return;
    onleft=!onleft;
    await animationController.forward();
  }

  void onLeftButton() async{
    if (animationController.isAnimating) return;
    onleft=!onleft;
    await animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
              decoration: BoxDecoration(
                color:MyColor().blue2,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r))
              ),
              height: 80.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      left: bgleft,
                      right: bgright,
                      child: Container(
                        width: animationController.value<0.5?expandAnimation.value*155.w+60.w:shrinkAnimation.value*155.w+60.w,
                        height: 60.h,
                        padding: EdgeInsets.all(5.sp),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.r)),
                            color: Colors.white),
                      )),
                  Positioned(
                    left: 80.w,
                    child: InkWell(
                        splashColor: Colors.white.withAlpha(30),
                        onTap: () {
                          context.read<PageChange>().pageChangeToAskPage();
                          onLeftButton();
                        },
                        child: Container(
                            width: 60.w,
                            height: 60.h,
                            padding: EdgeInsets.all(5.sp),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                                color: Colors.transparent),
                            child: Icon(
                              Icons.add_task,
                              color: color1,
                            ))),
                  ),
                  Positioned(
                    right: 80.w,
                    child: InkWell(
                        splashColor: Colors.white.withAlpha(30),
                        onTap: () async {
                          context.read<PageChange>().pageChangeToAlarmPage();
                          onRightButton();
                        },
                        child: Container(
                            width: 60.w,
                            height: 60.h,
                            padding: EdgeInsets.all(5.sp),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.r)),
                                color: Colors.transparent),
                            child: Icon(
                              Icons.calendar_today_outlined,
                              color: color2,
                            ))),
                  ),
                ],
              ));
        });
  }
}
