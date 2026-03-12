import 'package:flutter/cupertino.dart';
import 'package:nhelp/ui/AskPage.dart';

import '../ui/AlarmPage.dart';

class PageChange extends ChangeNotifier{
  Widget mainPage=AskPage();

  void pageChangeToAskPage(){
    mainPage=AskPage();
    notifyListeners();
  }

  void pageChangeToAlarmPage(){
    mainPage=AlarmPage();
    notifyListeners();
  }
}