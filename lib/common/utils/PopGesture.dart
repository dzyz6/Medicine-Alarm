import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PopGesture{

  static const channel = EventChannel("pop_gesture");

  static void listen(Function() onCallBack){
    channel.receiveBroadcastStream().listen((event){
      if(event=="callBack"){
        onCallBack();
      }
    });
  }

}