import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/utils/Color.dart';



class AskPage extends StatelessWidget {
  const AskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AppBar(
              backgroundColor: MyColor().blue2,
            ),
            Expanded(child: Talking()),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
        Positioned(
          right: 20.w,
          bottom: 100.h,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(40.r)),
              ),
              child: Icon(Icons.check,color: Colors.white,size: 30.sp,),
            ),
          ),
        )
      ],
    );
  }
}

class Talking extends StatefulWidget {
  const Talking({super.key});

  @override
  State<Talking> createState() => _TalkingState();
}

class _TalkingState extends State<Talking> {
  List<MyMedicine> list = [];

  void addMedicine() {
    setState(() {
      MyMedicine myMedicine = MyMedicine();
      list.add(myMedicine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        if (index == list.length) {
          //最后的添加
          return addButton();
        } else {
          return item(index);
        }
      },
    );
  }

  //列表每项
  Widget item(int index) {
    return GestureDetector(
      child: list[index],
    );
  }

  //添加按钮
  Widget addButton() {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        InkWell(
          onTap: addMedicine,
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                color: MyColor().blue3),
            child: Icon(
              Icons.add_rounded,
              size: 40.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}

class MyMedicine extends StatefulWidget {
  const MyMedicine({super.key});

  @override
  State<MyMedicine> createState() => _MyMedicineState();
}

class _MyMedicineState extends State<MyMedicine> {
  TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();

  String? daySelectedValue;

  List<String> dayList = ["每日", "隔日", "每周"];

  String? timeSelectedValue;

  List<String> timeList = ["一次", "两次", "三次", "四次"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.5.h),
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
            width: 80.w,
            height: 60.h,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: DropdownButton(
              underline: const SizedBox(),
              hint: Center(
                child: Text(
                  "选择周期",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ),
              value: daySelectedValue,
              items: dayList.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Center(child: Text(item)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  daySelectedValue = value;
                });
              },
              isExpanded: true,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blueAccent, width: 0.5.h),
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
            height: 60.h,
            width: 150.w,
            child: TextField(
              focusNode: focusNode,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "请输入用药名称",
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 0.5.h),
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
            ),
            width: 80.w,
            constraints: BoxConstraints(minHeight: 60.h),
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: DropdownButton(
              underline: const SizedBox(),
              hint: Center(
                child: Text(
                  "服用次数",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ),
              value: timeSelectedValue,
              items: timeList.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Center(child: Text(item)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  timeSelectedValue = value;
                });
              },
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
