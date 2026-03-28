import 'package:flutter/cupertino.dart';
import 'package:nhelp/common/utils/Alarm.dart';

class AlarmDelete extends ChangeNotifier{

  //是否是删除模式
  bool isDeleteMode=false;

  //被选中的选项
  Set<int> selectedId={};

  void setMode(bool a){
    isDeleteMode=a;
    notifyListeners();
  }

  void addSet(int id){
    selectedId.add(id);
    notifyListeners();
  }

  void removeSet(int id){
    selectedId.remove(id);
    notifyListeners();
  }

  bool inSet(int id){
    return selectedId.contains(id);
  }

  void clearSet(){
    selectedId={};
    notifyListeners();
  }

}