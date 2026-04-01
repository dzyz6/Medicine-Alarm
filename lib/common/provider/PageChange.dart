
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../pages/alarm/AlarmPage.dart';

import '../../pages/home/AskPage.dart';
import 'AlarmDelete.dart';



class PageChange extends ChangeNotifier {
  Widget mainPage = AskPage();
  bool isAskPage=false;
  void pageChangeToAskPage() {
    mainPage = AskPage();
    isAskPage=true;
    notifyListeners();
  }

  void pageChangeToAlarmPage() {
    mainPage = AlarmPage();
    isAskPage=false;
    notifyListeners();
  }
}
