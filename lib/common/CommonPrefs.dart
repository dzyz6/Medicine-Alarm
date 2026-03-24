import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonPrefs {
  static margin() {
    return EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h);
  }

  static padding() {
    return EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h);
  }

  static decoration(Color color) {
    return BoxDecoration(
        color:color,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000), // 透明度26%（比之前的15%稍高），仍浅
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0, // 不扩散，仅边缘有阴影
          )
        ]);
  }
}
