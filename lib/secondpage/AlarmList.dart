import 'package:flutter/cupertino.dart';
import 'package:nhelp/common/localstorage/MySharedPreference.dart';
import 'package:nhelp/secondpage/widget/AlarmContainer.dart';

class AlarmList extends StatefulWidget {
  const AlarmList({super.key});

  @override
  State<AlarmList> createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  MySharedPreference mySharedPreference=MySharedPreference();
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(future: mySharedPreference.getAlarmList(), builder: (context,snapshot){
    //   return ListView.builder(itemBuilder: (context,index){
    //     return AlarmContainer();
    //   });
    // });
    return AlarmContainer(hour: 1,minute: 1,medicine: "盐酸氨溴索口服溶液、左甲状腺素钠片、氯雷他定分散片、缬沙坦氨氯地平片、多潘立酮片.",);
  }
}
