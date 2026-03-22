import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/Color.dart';

import 'MyButton.dart';
import 'MyContainer.dart';

class OnTapContainer extends StatefulWidget {
  OnTapContainer({super.key, this.onTap});

  Function()? onTap;

  @override
  State<OnTapContainer> createState() => _OnTapContainerState();
}

class _OnTapContainerState extends State<OnTapContainer> with SingleTickerProviderStateMixin{
  bool _isPress = false;
  Timer? _resetPressTimer;

  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: MyColor().pressColor, ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resetPressTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }



  void _setPressedState(bool isPressed) {
    if (isPressed) {
      // 按下时：立即设为按压状态，同时取消之前的定时器（避免叠加）
      setState(() => _isPress = true);
      _resetPressTimer?.cancel();
    } else {
      // 松开/取消时：延迟100ms恢复常态（核心！确保快速点击也能看到变色）
      _resetPressTimer = Timer(const Duration(milliseconds: 50), () {
        if (mounted) { // 防止页面销毁后更新状态
          setState(() => _isPress = false);
          _animationController.reset();
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () {
        _setPressedState(false);
      },
      onTapDown: (details) {
        _setPressedState(true);
        _animationController.forward();
      },
      onTapUp: (details) {
        _setPressedState(false);
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context,child) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
            height: 55.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                boxShadow:[
                  BoxShadow(
                    color: Color(0x1A000000), // 透明度26%（比之前的15%稍高），仍浅
                    blurRadius: 1,
                    offset: Offset(0, 0),
                    spreadRadius: 0, // 不扩散，仅边缘有阴影
                  )
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "响铃时振动",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
                MyButton(
                  size: 25,
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
