import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/localstorage/MySharedPreference.dart';
import 'package:nhelp/common/provider/AlarmDelete.dart';
import 'package:nhelp/secondpage/widget/AlarmContainer.dart';
import 'package:provider/provider.dart';

import '../common/utils/Alarm.dart';

class AlarmList extends StatefulWidget {
  const AlarmList({super.key});

  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  MySharedPreference mySharedPreference = MySharedPreference();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AlarmDelete>(context);
    return ValueListenableBuilder(
        valueListenable: alarmRefreshNotifier,
        builder: (context, value, child) {
          return FutureBuilder(
              future: mySharedPreference.getAlarmList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Alarm> alarms = snapshot.data!
                    ..sort((a, b) {
                      if (a.hour != b.hour) {
                        return a.hour.compareTo(b.hour);
                      }
                      return a.minute.compareTo(b.minute);
                    });

                  // ======================================
                  // 找到最近开启的闹钟，并得到剩余小时、分钟
                  // ======================================
                  int remainingHours = 0;
                  int remainingMinutes = 0;

                  DateTime now = DateTime.now();
                  DateTime today = DateTime(now.year, now.month, now.day);

                  // 筛选开启的闹钟
                  List<Alarm> openAlarms = alarms.where((e) => e.open).toList();

                  if (openAlarms.isNotEmpty) {
                    Duration? minDuration;

                    for (var alarm in openAlarms) {
                      DateTime alarmTime = today.add(
                          Duration(hours: alarm.hour, minutes: alarm.minute));
                      Duration diff = alarmTime.difference(now);

                      if (diff.isNegative) {
                        // 时间已过，算明天
                        alarmTime = alarmTime.add(Duration(days: 1));
                        diff = alarmTime.difference(now);
                      }

                      if (minDuration == null ||
                          diff.inMinutes < minDuration.inMinutes) {
                        minDuration = diff;
                      }
                    }

                    // 赋值给你要的两个变量
                    remainingHours = minDuration!.inHours;
                    remainingMinutes = minDuration.inMinutes.remainder(60);
                  }

                  List<AlarmContainer> alarmList = alarms.map((alarm) {
                    return AlarmContainer(
                        alarm: alarm,
                        onLongPress: () {
                          provider.setMode(true);
                          provider.addSet(alarm.id);
                        },
                        onTap: () {
                          if (provider.isDeleteMode) {
                            if (provider.selectedId.contains(alarm.id)) {
                              provider.removeSet(alarm.id);
                            } else {
                              provider.addSet(alarm.id);
                            }
                          }
                        },
                    );
                  }).toList();

                  ///列表
                  return Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        timeRing(remainingHours, remainingMinutes),
                        ...alarmList,
                        SizedBox(
                          height: 200.h,
                        )
                      ],
                    ),
                  );
                } else if (snapshot.data == null) {
                  return Container(
                      margin: EdgeInsets.only(top: 40.h, bottom: 70.h),
                      child: Center(
                          child: Text(
                        "所有闹钟已关闭",
                        style: TextStyle(fontSize: 25.sp),
                      )));
                } else {
                  return Container();
                }
              });
        });
  }

  Widget timeRing(int hour, int minute) {
    if (hour == 0 && minute == 0) {
      return Container(
          margin: EdgeInsets.only(top: 40.h, bottom: 70.h),
          child: Center(
              child: Text(
            "所有闹钟已关闭",
            style: TextStyle(fontSize: 25.sp),
          )));
    }
    return Container(
        margin: EdgeInsets.only(top: 40.h, bottom: 70.h),
        child: Center(
            child: Text(
          "$hour小时$minute分钟后响铃",
          style: TextStyle(fontSize: 25.sp),
        )));
  }
}
