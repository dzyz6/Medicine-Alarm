import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/CommonPrefs.dart';
import 'package:nhelp/pages/home/widget/TextFieldContainer.dart';

import '../../common/provider/ContentNotifier.dart';

class AskPage extends StatelessWidget {
  const AskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            thisAppbar(),
            Expanded(child: Talking()),
            SizedBox(height: 140.h,)
          ],
        ),
        TextFieldContainer(),
      ],

    );
  }

  Widget thisAppbar() {
    return Container(
      height: 80.h,
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 5.h),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "AI",
          style: TextStyle(fontSize: 25.sp),
        ),
      ),
    );
  }
}

class Talking extends ConsumerWidget {
  const Talking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(contentProvider);

    return ListView.builder(itemBuilder: (context, index) {
      var i = list[index];
      var content=i.content;
      var state = i.state;
      return chatBox(state, content);

    },itemCount: list.length,);
  }

  Widget chatBox(int state,String text){
    if(state==0){
      return Align(
        alignment:Alignment.topRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 200.w
          ),
          margin: CommonPrefs.margin(),
          padding: CommonPrefs.padding(),
          decoration: CommonPrefs.decoration(MyColor().blue2),
          child: Text(text,style: TextStyle(color: Colors.white),),
        ),
      );
    }
    else{
      return Align(
        alignment:Alignment.topLeft,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: 200.w
          ),
          margin: CommonPrefs.margin(),
          padding: CommonPrefs.padding(),
          decoration: CommonPrefs.decoration(Colors.white),
          child: Text(text,style: TextStyle(color: Colors.black),),
        ),
      );
    }
    
  }

}
