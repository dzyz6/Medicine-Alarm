import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/provider/AlarmDelete.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/CommonPrefs.dart';
import 'package:nhelp/secondpage/widget/MyButton.dart';
import 'package:provider/provider.dart';

import '../../common/utils/Alarm.dart';

class AlarmContainer extends StatefulWidget {
  AlarmContainer(
      {super.key,
      required this.alarm,
      required this.onLongPress,
      required this.onTap});

  final Alarm alarm;

  Function() onLongPress;

  Function() onTap;

  @override
  State<AlarmContainer> createState() => _AlarmContainerState();
}

class _AlarmContainerState extends State<AlarmContainer> {
  @override
  void initState() {
    super.initState();
    textColor = widget.alarm.open ? Colors.black : MyColor().unpressedTextColor;
  }

  late Color textColor;

  void isOpen() {
    Alarm.setAlarmOpen(widget.alarm.id);
    setState(() {
      widget.alarm.open = !widget.alarm.open;
      if (widget.alarm.open) {
        textColor = Colors.black;
      } else {
        textColor = MyColor().unpressedTextColor;
      }
    });
    alarmRefreshNotifier.value = !alarmRefreshNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AlarmDelete>(context);

    return GestureDetector(
      onLongPress: () {
        widget.onLongPress.call();
      },
      onTap: () {
        widget.onTap.call();
      },
      child: Container(
        decoration: CommonPrefs.decoration(provider.inSet(widget.alarm.id)
            ? MyColor().pressColor
            : Colors.white),
        margin: CommonPrefs.margin(),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 90.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Row(
                children: [
                  Text(
                    '${widget.alarm.hour.toString().padLeft(2, '0')}:${widget.alarm.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                        color: textColor),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "|",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: textColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.h),
                    width: 180.w,
                    child: Text(
                      widget.alarm.medicine,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: textColor,
                        fontWeight: FontWeight.w400,
                      ),
                      softWrap: true,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: button(),
            ),
          ],
        ),
      ),
    );
  }

  Widget button() {
    if (!Provider.of<AlarmDelete>(context).isDeleteMode) {
      return MyButton(
        size: 25,
        onTap: isOpen,
        open: widget.alarm.open,
      );
    } else {
      if (Provider.of<AlarmDelete>(context).inSet(widget.alarm.id)) {
        return Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: MyColor().blue2,
          ),
          child: Icon(Icons.check,color: Colors.white,size: 12  .sp,   grade:200,),
        );
      } else {
        return  Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.white,
              border: Border.all(color: MyColor().unpressedTextColor,width: 2.sp)
          ),
        );
      }
    }
  }
}
