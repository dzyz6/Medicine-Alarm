// import 'dart:ffi';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class MyContainer extends StatelessWidget {
//   MyContainer({super.key, this.child, this.width, this.height});
//
//   Widget? child;
//   double? width;
//   double? height;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
//       padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(16.r)),
//         boxShadow:[
//           BoxShadow(
//             color: Color(0x1A000000), // 透明度26%（比之前的15%稍高），仍浅
//             blurRadius: 1,
//             offset: Offset(0, 0),
//             spreadRadius: 0, // 不扩散，仅边缘有阴影
//           )
//         ]
//       ),
//
//       child: child,
//     );
//   }
// }
