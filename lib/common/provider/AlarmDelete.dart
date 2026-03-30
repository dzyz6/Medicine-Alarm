import 'package:flutter/cupertino.dart';
import 'package:nhelp/common/utils/Alarm.dart';

import '../localstorage/MySharedPreference.dart';

class AlarmDelete extends ChangeNotifier{

  //是否是删除模式
  bool isDeleteMode=false;

  //被选中的选项
  Set<int> selectedId={};


  //设置是否是删除模式
  void setMode(bool a){
    isDeleteMode=a;
    notifyListeners();
  }

  //添加到列表中
  void addSet(int id){
    selectedId.add(id);
    notifyListeners();
  }

  //从列表中删除某一项
  void removeSet(int id){
    selectedId.remove(id);
    notifyListeners();
  }

  //是否在删除列表中
  bool inSet(int id){
    return selectedId.contains(id);
  }


  //清空
  void clearSet(){
    selectedId={};
    notifyListeners();
  }

  MySharedPreference mySharedPreference=MySharedPreference();

  void addAll()async{
    List list =await mySharedPreference.getAlarmList();
    for(Alarm a in list){
      if( !selectedId.contains(a.id)){
        selectedId.add(a.id);
      }
    }
    notifyListeners();
  }

}