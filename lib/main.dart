import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nhelp/common/localstorage/MySharedPreference.dart';
import 'package:nhelp/common/provider/AlarmDelete.dart';
import 'package:nhelp/common/utils/Color.dart';
import 'package:provider/provider.dart' as oldProvider;
import 'common/provider/PageChange.dart';
import 'package:alarm/alarm.dart' as pluginAlarm;
import 'common/widget/MyNavigationBar.dart';
import 'models/Alarm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await pluginAlarm.Alarm.init();
  runApp(
    ProviderScope(
      child: oldProvider.MultiProvider(
        providers: [
          oldProvider.ChangeNotifierProvider(create: (context) => PageChange()),
          oldProvider.ChangeNotifierProvider(
              create: (context) => AlarmDelete()),
        ],
        child: const MyApp(),
      ),
    ),
  );
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
          theme: ThemeData(
            appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent),
          ),
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
          // 1. 页面内容（最下层）
          oldProvider.Consumer<PageChange>(builder: (context, value, child) {
            return value.mainPage;
          }),

          // 2. 导航栏（中层）
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MyNavigationBar(),
          ),

          // 3. 删除按钮（最上层！盖住导航栏）
          if (context.watch<AlarmDelete>().isDeleteMode)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60.h,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () async {
                    final alarmDelete = oldProvider.Provider.of<AlarmDelete>(
                        context,
                        listen: false);
                    await Alarm.removeAllAlarm(alarmDelete.selectedId.toList());
                    alarmDelete.setMode(false);
                    alarmDelete.clearSet();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_outline, size: 30.sp),
                      Text("删除"),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
