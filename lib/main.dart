import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/utils/Color.dart';

import 'package:provider/provider.dart';
import 'common/provider/PageChange.dart';
import 'firstpage/AskPage.dart';
import 'navigationbar/MyNavigationBar.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => PageChange(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          color: MyColor().backgroundColor,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor().backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Provider.of<PageChange>(context, listen: true).mainPage,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MyNavigationBar(),
          ),
        ],
      ),
    );
  }
}
