import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/CommonPrefs.dart';

import '../../../common/provider/ContentNotifier.dart';
import '../../../common/utils/Res.dart';

class TextFieldContainer extends StatefulWidget {
  const TextFieldContainer({super.key});

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer>
    with WidgetsBindingObserver {
  late TextEditingController textEditingController;
  late FocusNode focusNode;

  bool hasContent=false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    textEditingController.addListener((){
      setState(() {
        hasContent = textEditingController.text.isNotEmpty;
      });
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {});
  }

  Future<void> postRag(String text,WidgetRef ref) async {
    try {
      Dio dio = Dio();
      Response res=await dio.post("http://localhost:8000/api/medication-plan",data: {
        "user_input":text,
      } );
      Content c= Content(res.data.medication_plan, 1);
      ref.read(contentProvider.notifier).add(c);
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {

        double textFieldHeight() {
          final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          if (keyboardHeight > 0) {
            return keyboardHeight.h;
          } else {
            return 70.h;
          }
        }

        return Positioned(
          left: 0,
          right: 0,
          bottom: textFieldHeight(),
          child: Container(
            constraints: BoxConstraints(minHeight: 60.h),
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18.r)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 2,
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.photo_camera_outlined),
                SizedBox(
                  width: 200.w,
                  child: TextField(
                    focusNode: focusNode,
                    controller: textEditingController,
                  ),
                ),
                hasContent?GestureDetector(
                  onTap: () {
                    if (textEditingController.text.isNotEmpty) {
                      Content c=Content(  textEditingController.text, 0);
                      ref.read(contentProvider.notifier).add(
                        c,
                      );
                      ///暂不使用
                      ///postRag(textEditingController.text,ref);
                      // 清空输入框
                      textEditingController.clear();
                      // 收起键盘
                      focusNode.unfocus();
                    }
                  },
                  child: Container(
                    width: 50.w,
                    height: 30.h,
                    decoration: CommonPrefs.decoration(MyColor().blue2),
                    child: Center(
                      child: Text(
                        "发送",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ):Icon(Icons.add_circle_outline),
              ],
            ),
          ),
        );
      },
    );
  }
}