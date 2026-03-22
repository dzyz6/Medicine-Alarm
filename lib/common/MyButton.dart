import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/Color.dart';

class MyButton extends StatefulWidget {
  MyButton({super.key,this.onTap,required this.size});
  Function? onTap;
  double size;
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 150));
    curvedAnimation=CurvedAnimation(parent: animationController, curve:Curves.easeInOut);
  }

  //当前按钮状态
  int curState=0;

  var curColor=MyColor().buttonColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (context,child) {
        return GestureDetector(
          onTap: (){
            if(curvedAnimation.isAnimating){
              return;
            }
            if(curState==0){
              animationController.forward();
              setState(() {
                curColor=MyColor().blue2;
              });
              curState=1;
            }
            else{
              animationController.reverse();
              setState(() {
                curColor=MyColor().buttonColor;
              });
              curState=0;
            }
            widget.onTap;
          },
          onLongPress: (){

          },
          child: Container(
            width:widget.size*1.875.w,
            height: widget.size.h,
            decoration: BoxDecoration(
              color: curColor,
              borderRadius: BorderRadius.all(Radius.circular(50.r)),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(width: animationController.value*widget.size*0.85.w,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: widget.size*0.125.w),
                    width:widget.size*0.75.w,
                    height: widget.size*0.75.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50.r)),
                    ),
                  ),
                ],
              ),
            ),

          ),
        );
      }
    );
  }
}
