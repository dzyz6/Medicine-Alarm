import 'dart:convert';

import 'package:nhelp/common/utils/Alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {


  ///闹钟本地存储
  Future<void> saveAlarmList(Alarm alarm) async {
    final prefs = await SharedPreferences.getInstance();
    // 1. 先拿到现有列表
    List<Alarm> oldList = await getAlarmList();

    // 2. 把新 alarm 加进去
    oldList.add(alarm);

    // 3. 转 JSON 存起来
    List<Map<String, dynamic>> jsonList =
    oldList.map((e) => e.toJson()).toList();

    await prefs.setString("alarmList", jsonEncode(jsonList));
  }



  Future<List<Alarm>> getAlarmList() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('alarmList');
    if (jsonString == null) return [];
    List<dynamic> jsonlist = jsonDecode(jsonString);
    List<Alarm> list = jsonlist.map(
        (e){
          return Alarm.fromJson(e);
        }
    ).toList();
    return list;
  }


  Future<void> deleteAlarm(int id)async {
    final prefs = await SharedPreferences.getInstance();

    List<Alarm> oldList = await getAlarmList();

    List<Alarm> newList = oldList.where((alarm) => alarm.id != id).toList();
    List<String> jsonList = newList.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setString("alarmList", jsonEncode(jsonList));

  }


  ///id
  Future<void> saveId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("id",(await getId()+1));
  }



  Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getInt("id")??1;
  }


}
