import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldContainer extends StatefulWidget {
  const TextFieldContainer({super.key});

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> with WidgetsBindingObserver {
  late TextEditingController textEditingController;
  late FocusNode focusNode ;


  @override
  void initState() {
    super.initState();
    textEditingController= TextEditingController();
    focusNode=FocusNode();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {


    double textFieldHeight(){
      if(focusNode.hasFocus){
        return MediaQuery.of(context).viewInsets.bottom.h;
      }
      else{
        return 70.h;
      }
    }

    return Positioned(
      left: 0,
      right: 0,
      bottom: textFieldHeight(),
      child: Container(
        constraints: BoxConstraints(
            minHeight: 60.h
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18.r)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 1),
                spreadRadius: 2, // 不扩散，仅边缘有阴影
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.photo_camera_outlined),
            SizedBox(width: 200.w,child: TextField(focusNode: focusNode,controller: textEditingController,),),
            Icon(Icons.mic_none_rounded),
            Icon(Icons.add_circle_outline),
          ],
        ),
      ),
    );
  }
}
