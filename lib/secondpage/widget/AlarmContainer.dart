import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/CommonPrefs.dart';
import 'package:nhelp/secondpage/widget/MyButton.dart';

class AlarmContainer extends StatefulWidget {
  AlarmContainer(
      {super.key,
      required this.hour,
      required this.minute,
      required this.medicine});

  int hour;
  int minute;
  String medicine;

  @override
  State<AlarmContainer> createState() => _AlarmContainerState();
}

class _AlarmContainerState extends State<AlarmContainer> {
  var textColor = MyColor().unpressedTextColor;

  void changeColor() {
    setState(() {
      textColor = textColor == MyColor().unpressedTextColor
          ? Colors.black
          : MyColor().unpressedTextColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CommonPrefs.decoration(Colors.white),
      margin: CommonPrefs.margin(),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 90.h
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
              children: [
                Text(
                  '${widget.hour.toString().padLeft(2, '0')}:${widget.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
                SizedBox(width: 5.w,),
                Text(
                  "|",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: textColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(width: 10.w,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  width: 180.w,
                  child: Text(
                    widget.medicine,
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
            child: MyButton(
              size: 25,
              onTap: changeColor,
            ),
          ),
        ],
      ),
    );
  }
}
