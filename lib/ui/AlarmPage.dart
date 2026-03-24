import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/Color.dart';
import 'package:nhelp/common/CommonPrefs.dart';
import 'package:nhelp/common/MyButton.dart';

import 'package:nhelp/common/container/OnTapContainer.dart';

import '../common/container/MyContainer.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late FixedExtentScrollController fixedExtentScrollController;
  late FixedExtentScrollController fixedExtentScrollController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var now = DateTime.now();

    fixedExtentScrollController = FixedExtentScrollController(
      initialItem: now.hour,
    );
    fixedExtentScrollController2 = FixedExtentScrollController(
      initialItem: now.minute,
    );

    fixedExtentScrollController.addListener(timeCalculate);
    fixedExtentScrollController2.addListener(timeCalculate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      timeCalculate();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fixedExtentScrollController.dispose();
    fixedExtentScrollController2.dispose();
  }

  Duration timeCalculate() {
    DateTime dateTime = DateTime.now();
    if (!fixedExtentScrollController.hasClients ||
        !fixedExtentScrollController2.hasClients) {
      return Duration(hours: 23, minutes: 59); // 或其他默认值
    }
    DateTime dateTime2 = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        fixedExtentScrollController.selectedItem,
        fixedExtentScrollController2.selectedItem,
        0,
        0);
    if (dateTime.isBefore(dateTime2)) {
      return dateTime2.difference(dateTime);
    } else {
      DateTime dateTime3 = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day + 1,
          fixedExtentScrollController.selectedItem,
          fixedExtentScrollController2.selectedItem);
      return dateTime3.difference(dateTime);
    }
  }

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
              builder: (context) {
                return SizedBox(
                  height: 770.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      //灰色条
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: 60.w,
                          height: 5.h,
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                      ),

                      //功能行
                      addAlarmAppbar(),
                      SizedBox(
                        height: 20.h,
                      ),
                      //滚轮挑选
                      chooseAlarm(),

                      SingleChildScrollView(
                        physics:  AlwaysScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                height: (55.h)*4,
                                width: double.infinity,
                                clipBehavior: Clip.hardEdge,
                                decoration: CommonPrefs.decoration(Colors.white),
                                margin: CommonPrefs.margin(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:55.h,
                                      child: OnTapContainer(
                                        size: 25,
                                        text: "A",
                                      ),
                                    ),
                                    SizedBox(
                                      height:55.h,
                                      child: OnTapContainer(
                                        size: 25,
                                        text: "B",
                                      ),
                                    ),
                                    SizedBox(
                                      height:55.h,
                                      child: OnTapContainer(
                                        size: 25,
                                        text: "响铃时振动",
                                      ),
                                    ),
                                    SizedBox(
                                      height:55.h,
                                      child: OnTapContainer(
                                        size: 25,
                                        text: "响铃后删除此闹钟",
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              height: 55.h,
                              width: double.infinity,
                              clipBehavior: Clip.hardEdge,
                              decoration: CommonPrefs.decoration(Colors.white),
                              margin: CommonPrefs.margin(),
                              padding: CommonPrefs.padding(),
                              child: Row(
                                children: [
                                  Text(
                                    "备注",
                                    style: TextStyle(
                                        fontSize: 16.sp, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
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

  Widget addAlarmAppbar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                size: 30.sp,
              )),
          ListenableBuilder(
              listenable: Listenable.merge(
                  [fixedExtentScrollController, fixedExtentScrollController2]),
              builder: (context, child) {
                return Column(
                  children: [
                    Text(
                      "添加闹钟",
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    Text(
                      (timeCalculate().inHours == 0) &&
                              (timeCalculate().inMinutes % 60) == 0
                          ? "不到1分钟后响铃"
                          : "${timeCalculate().inHours}小时${timeCalculate().inMinutes % 60}分钟后响铃",
                      style:
                          TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
                    )
                  ],
                );
              }),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.check,
                size: 30.sp,
              )),
        ],
      ),
    );
  }

  Widget chooseAlarm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 280.h,
            child: Column(
              children: [
                Text(
                  "时",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 200.h,
                  width: 137.w,
                  child: ListWheelScrollView.useDelegate(
                      magnification: 1.2,
                      overAndUnderCenterOpacity: 0.3,
                      diameterRatio: 2,
                      perspective: 0.002,
                      controller: fixedExtentScrollController,
                      physics: FixedExtentScrollPhysics(),
                      itemExtent: 45.h,
                      childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                        return Text(
                          "${index % 24}".padLeft(2, '0'),
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.w500),
                        );
                      })),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 280.h,
            child: Column(
              children: [
                Text(
                  "分",
                  style: TextStyle(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 200.h,
                  width: 137.w,
                  child: ListWheelScrollView.useDelegate(
                      magnification: 1.2,
                      overAndUnderCenterOpacity: 0.3,
                      diameterRatio: 2,
                      perspective: 0.002,
                      controller: fixedExtentScrollController2,
                      physics: FixedExtentScrollPhysics(),
                      itemExtent: 45.h,
                      childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                        return Text(
                          "${index % 60}".padLeft(2, '0'),
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.w500),
                        );
                      })),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlarmItem extends StatefulWidget {
  const AlarmItem({super.key});

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
