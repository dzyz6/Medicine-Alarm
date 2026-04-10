import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm/model/notification_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:alarm/alarm.dart' as pluginAlarm;
import '../common/localstorage/MySharedPreference.dart';

// 全局单一变量
final ValueNotifier<bool> alarmRefreshNotifier = ValueNotifier(false);

class Alarm {
  Alarm(this.id, this.hour, this.minute, this.vibrate, this.medicine,
      this.finishDelete, this.open);

  int id;
  int hour;
  int minute;
  bool vibrate;
  bool finishDelete;
  String medicine;
  bool open;

  //对象转map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "hour": hour,
      "minute": minute,
      "vibrate": vibrate,
      "medicine": medicine,
      "finishDelete": finishDelete,
      "open": open,
    };
  }

  static Alarm fromJson(Map<String, dynamic> map) {
    return Alarm(map['id'], map['hour'], map['minute'], map['vibrate'],
        map['medicine'], map["finishDelete"], map["open"]);
  }

  static Future<void> createAlarm(
    int hour,
    int minute,
    bool vibrate,
    bool finishDelete,
    String medicine,
  ) async {
    MySharedPreference mySharedPreference = MySharedPreference();
    await mySharedPreference.saveId();
    int id = await mySharedPreference.getId();
    Alarm alarm =
        Alarm(id, hour, minute, vibrate, medicine, finishDelete, true);
    // 日期逻辑
    var now = DateTime.now();
    int addDay = 0;
    DateTime todayAlarm = DateTime(now.year, now.month, now.day, hour, minute);
    if (todayAlarm.isBefore(now)) {
      addDay = 1;
    }
    await mySharedPreference.saveAlarmList(alarm);
    alarmRefreshNotifier.value = !alarmRefreshNotifier.value;
    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: DateTime(now.year, now.month, now.day + addDay, hour, minute),
      assetAudioPath: 'lib/common/assets/alarm.mp3',
      loopAudio: true,
      vibrate: vibrate,
      androidFullScreenIntent: true,
      notificationSettings: const NotificationSettings(
        title: '用药提醒',
        body: '该吃药了！',
      ),
    );
    await pluginAlarm.Alarm.set( alarmSettings: alarmSettings);

  }

  //打开或关闭闹钟
  static Future<void> setAlarmOpen(int id) async {
    MySharedPreference mySharedPreference = MySharedPreference();
    Alarm a = await mySharedPreference.getAlarmById(id);
    a.open = !a.open;
    await mySharedPreference.setAlarm(a);

    if (a.open) {
      // 开启：重新创建闹钟
      DateTime now = DateTime.now();
      int addDay = 0;
      DateTime todayAlarm = DateTime(now.year, now.month, now.day, a.hour, a.minute);
      if (todayAlarm.isBefore(now)) {
        addDay = 1;
      }

      final alarmSettings = AlarmSettings(
        id: a.id,
        dateTime: DateTime(now.year, now.month, now.day + addDay, a.hour, a.minute),
        assetAudioPath: 'lib/common/assets/alarm.mp3',
        loopAudio: true,
        vibrate: a.vibrate,
        androidFullScreenIntent: true,
        notificationSettings: const NotificationSettings(
          title: '用药提醒',
          body: '该吃药了！',
        ),
      );
      await pluginAlarm.Alarm.set(alarmSettings: alarmSettings);
    } else {
      // 关闭：停止
      await pluginAlarm.Alarm.stop(id);
    }

    alarmRefreshNotifier.value = !alarmRefreshNotifier.value;
  }

  static Future<List<Alarm>> getAlarmList() async {
    MySharedPreference mySharedPreference = MySharedPreference();
    return await mySharedPreference.getAlarmList();
  }

  static Future<void> removeAllAlarm(List list) async {
    MySharedPreference mySharedPreference = MySharedPreference();
    for (int id in list) {
      await mySharedPreference.deleteAlarm(id);
    }
    await pluginAlarm.Alarm.stopAll();
  }
}
