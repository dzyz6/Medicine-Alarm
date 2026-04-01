import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/localstorage/MySharedPreference.dart';
import 'package:nhelp/common/provider/AlarmDelete.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/PopGesture.dart';
import 'package:provider/provider.dart';
import 'AddAlarm.dart';
import 'AlarmList.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      PopGesture.listen((){
        var provider=Provider.of<AlarmDelete>(context,listen: false);
        if(provider.isDeleteMode){
          provider.setMode(false);
          provider.clearSet();
        }
        else{
          Navigator.pop(context);
        }
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    var isDeleteMode = Provider.of<AlarmDelete>(context).isDeleteMode;
    return Stack(
      children: [
        Column(
          children: [
            AppBar(
              leading: isDeleteMode
                  ? IconButton(
                      onPressed: () {
                        Provider.of<AlarmDelete>(context, listen: false)
                            .setMode(false);
                        Provider.of<AlarmDelete>(context, listen: false)
                            .clearSet();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 30.sp,
                      ))
                  : Container(),
              backgroundColor: MyColor().backgroundColor,
              actions: [
                isDeleteMode
                    ? IconButton(
                        onPressed: () {
                          Provider.of<AlarmDelete>(context, listen: false)
                              .addAll();
                        },
                        icon: Icon(Icons.menu))
                    : IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 20.w),
                  height: 40.h,
                  child: isDeleteMode
                      ? Text(
                          "已选择${Provider.of<AlarmDelete>(context).selectedId.length}项",
                          style: TextStyle(fontSize: 30.sp),
                        )
                      : Text(
                          "闹钟",
                          style: TextStyle(fontSize: 30.sp),
                        ),
                )),
            AlarmList(),
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
