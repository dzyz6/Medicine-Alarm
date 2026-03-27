import '../localstorage/MySharedPreference.dart';

class Alarm{
  Alarm(int this.id,int this.hour,int this.minute,bool this.vibrate,String this.medicine,bool this.finishDelete);

  int? id;
  int? hour;
  int? minute;
  bool? vibrate;
  bool? finishDelete;
  String? medicine;

  //对象转map
  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "hour":hour,
      "minute":minute,
      "vibrate":vibrate,
      "medicine":medicine,
      "finishDelete":finishDelete
    };
  }

  static Alarm fromJson(Map<String,dynamic> map){
    return Alarm(
      map['id'],
      map['hour'],
      map['minute'],
      map['vibrate'],
      map['medicine'],
      map["finishDelete"]
    );
  }

  static Future<void> createAlarm(int hour, int minute, bool vibrate,bool finishDelete,
      String medicine, ) async {
    MySharedPreference mySharedPreference = MySharedPreference();
    await mySharedPreference.saveId();
    int id=await mySharedPreference.getId();
    Alarm alarm=Alarm(id, hour, minute, vibrate, medicine, finishDelete);
    mySharedPreference.saveAlarmList(alarm);
  }

  static Future<List<Alarm>> getAlarm() async {
    MySharedPreference mySharedPreference = MySharedPreference();
    return await mySharedPreference.getAlarmList();
  }
}