import 'dart:convert';
import 'package:nhelp/common/utils/Alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  /// 闹钟本地存储 - 新增
  Future<void> saveAlarmList(Alarm alarm) async {
    final prefs = await SharedPreferences.getInstance();
    List<Alarm> oldList = await getAlarmList();
    oldList.add(alarm);

    // 修复：统一编码格式
    List<Map<String, dynamic>> jsonList = oldList.map((e) => e.toJson()).toList();
    await prefs.setString("alarmList", jsonEncode(jsonList));
  }

  // 修改某个闹钟信息
  Future<void> setAlarm(Alarm newAlarm) async {
    final prefs = await SharedPreferences.getInstance();
    List<Alarm> list = await getAlarmList();

    // 修复：增加安全判断，防止找不到id崩溃
    int index = list.indexWhere((a) => a.id == newAlarm.id);
    if (index != -1) {
      list[index] = newAlarm;
    }

    // 修复：编码格式统一（关键！）
    List<Map<String, dynamic>> jsonList = list.map((alarm) => alarm.toJson()).toList();
    await prefs.setString("alarmList", jsonEncode(jsonList));
  }

  Future<List<Alarm>> getAlarmList() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('alarmList');
    if (jsonString == null) return [];
    List<dynamic> jsonlist = jsonDecode(jsonString);
    List<Alarm> list = jsonlist.map((e) => Alarm.fromJson(e)).toList();
    return list;
  }

  Future<Alarm> getAlarmById(int id) async{
    List<Alarm> list=await getAlarmList();
    return list.firstWhere((e)=>e.id==id);
  }

  Future<void> deleteAlarm(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<Alarm> oldList = await getAlarmList();
    List<Alarm> newList = oldList.where((alarm) => alarm.id != id).toList();

    // 修复：编码格式统一
    List<Map<String, dynamic>> jsonList = newList.map((alarm) => alarm.toJson()).toList();
    await prefs.setString("alarmList", jsonEncode(jsonList));
  }

  /// id 自增
  Future<void> saveId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("id", await getId() + 1);
  }

  Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id") ?? 1;
  }
}