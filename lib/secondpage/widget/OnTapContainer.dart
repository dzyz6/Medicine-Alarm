import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:nhelp/common/utils/CommonPrefs.dart';

import 'MyButton.dart';




///背景点击连接button的container
class OnTapContainer extends StatefulWidget {
  OnTapContainer({super.key, this.onTap,required this.text,required this.size});

  Function()? onTap;
  String text;
  double size;

  @override
  State<OnTapContainer> createState() => _OnTapContainerState();
}

class _OnTapContainerState extends State<OnTapContainer> with SingleTickerProviderStateMixin{
  bool _isPress = false;
  Timer? _resetPressTimer;
  ValueNotifier<bool> valueNotifier=ValueNotifier(false);
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
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
    valueNotifier.dispose();
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
    return LayoutBuilder(
      builder: (context,constraints) {
        final parentHeight = constraints.maxHeight;
        final buttonTop = ((parentHeight-widget.size.h)/2).h;
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
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
                valueNotifier.value=!valueNotifier.value;
              },
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context,child) {
                  return Container(
                    color:  _colorAnimation.value,
                    padding: CommonPrefs.padding(),
                    width: double.infinity,
                    height: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.text,
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }
              ),
            ),

            Positioned(
              top: 15.h,
              right:10.w,
              child: MyButton(
                size: widget.size,
                valueNotifier: valueNotifier,
              ),
            ),
          ],
        );
      }
    );
  }
}
