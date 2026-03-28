import 'package:flutter/cupertino.dart';

import '../localstorage/MySharedPreference.dart';


// 全局单一变量
final ValueNotifier<bool> alarmRefreshNotifier = ValueNotifier(false);

class Alarm {
  Alarm(this.id, this.hour,  this.minute,  this.vibrate,
       this.medicine,  this.finishDelete,  this.open);

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
      "open":open,
    };
  }

  static Alarm fromJson(Map<String, dynamic> map) {
    return Alarm(map['id'], map['hour'], map['minute'], map['vibrate'],
        map['medicine'], map["finishDelete"],map["open"]);
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
    Alarm alarm = Alarm(id, hour, minute, vibrate, medicine, finishDelete,true);
    await mySharedPreference.saveAlarmList(alarm);
  }

  //打开或关闭闹钟
  static Future<void> setAlarmOpen(int id) async {
    MySharedPreference mySharedPreference = MySharedPreference();
    Alarm a=await mySharedPreference.getAlarmById(id);
    a.open=!a.open;
    await mySharedPreference.setAlarm(a);
  }

  static Future<List<Alarm>> getAlarmList() async {
    MySharedPreference mySharedPreference = MySharedPreference();
    return await mySharedPreference.getAlarmList();
  }
}
