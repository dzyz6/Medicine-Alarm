import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/localstorage/MySharedPreference.dart';
import 'package:nhelp/common/utils/Alarm.dart';
import 'package:nhelp/secondpage/widget/OnTapContainer.dart';

import '../common/utils/Color.dart';
import '../common/utils/CommonPrefs.dart';


class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {

  late FixedExtentScrollController fixedExtentScrollController;
  late FixedExtentScrollController fixedExtentScrollController2;

  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool vibrate=false;
  bool finishDelete=false;

  ///计算选择时间与当前差
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
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });
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
    fixedExtentScrollController.dispose();
    fixedExtentScrollController2.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void openTextField() {
    // 先获取焦点
    FocusScope.of(context).requestFocus(_focusNode);
  }


  @override
  Widget build(BuildContext context) {
    final double keyboardHeight =
        MediaQuery
            .of(context)
            .viewInsets
            .bottom;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: SizedBox(
          height: 770.h,
          width: double.infinity,
          child: Column(
            children: [
              //灰色条
              stripe(),
              //功能行
              addAlarmAppbar(),
              SizedBox(
                height: 20.h,
              ),
              //可滚动内容区域
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //滚轮
                      chooseAlarm(),
                      //底部功能
                      alarmFunction(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }

  ///灰色条装饰
  Widget stripe() {
    return Opacity(
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
    );
  }

  ///最顶端一行
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
                          : "${timeCalculate().inHours}小时${timeCalculate()
                          .inMinutes % 60}分钟后响铃",
                      style:
                      TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
                    )
                  ],
                );
              }),
          IconButton(
              onPressed: ()async {
                var n=Navigator.of(context);
                await Alarm.createAlarm(fixedExtentScrollController.selectedItem%24,
                    fixedExtentScrollController2.selectedItem%60, vibrate,
                    finishDelete, _textEditingController.text);
                alarmRefreshNotifier.value = !alarmRefreshNotifier.value;
                n.pop();
              },
              icon: Icon(
                Icons.check,
                size: 30.sp,
              )),
        ],
      ),
    );
  }

  ///时间选择轮盘
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

  ///底部多个功能
  Widget alarmFunction() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: (55.h) * 2,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: CommonPrefs.decoration(Colors.white),
              margin: CommonPrefs.margin(),
              child: Column(
                children: [
                  SizedBox(
                    height: 55.h,
                    child: OnTapContainer(
                      size: 25,
                      text: "响铃时振动",
                      onTap: (){
                        vibrate=!vibrate;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 55.h,
                    child: OnTapContainer(
                      size: 25,
                      text: "响铃后删除此闹钟",
                      onTap: (){
                        finishDelete=!finishDelete;
                      },
                    ),
                  ),
                ],
              )),
          inputItem(),
        ],
      ),
    );
  }

  Widget inputItem() {
    return GestureDetector(
      onTap: openTextField,
      child: Container(
        height: 55.h,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            border: Border.all(
                color: _focusNode.hasFocus ? MyColor().blue2 : Colors
                    .transparent,
                width: 2.sp
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000), // 透明度26%（比之前的15%稍高），仍浅
                blurRadius: 1,
                offset: Offset(0, 0),
                spreadRadius: 0, // 不扩散，仅边缘有阴影
              )
            ]),
        margin: CommonPrefs.margin(),
        padding: CommonPrefs.padding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "用药",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 250.w,
              child: TextField(
                focusNode: _focusNode,
                cursorColor: MyColor().blue2,
                textAlign: TextAlign.right,
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: "输入内容",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                onChanged: (val) {
                  _textEditingController.value = TextEditingValue(
                    text: val,
                    selection: TextSelection.collapsed(offset: val.length),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


