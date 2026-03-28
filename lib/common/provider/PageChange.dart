import 'package:flutter/cupertino.dart';
import 'package:nhelp/firstpage/AskPage.dart';
import 'package:provider/provider.dart';

import '../../secondpage/AlarmPage.dart';
import 'AlarmDelete.dart';



class PageChange extends ChangeNotifier {
  Widget mainPage = AskPage();

  void pageChangeToAskPage() {
    mainPage = AskPage();
    notifyListeners();
  }

  void pageChangeToAlarmPage() {
    mainPage = AlarmPage();
    notifyListeners();
  }
}
