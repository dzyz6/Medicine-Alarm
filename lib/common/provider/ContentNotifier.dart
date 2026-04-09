import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentNotifier extends Notifier<List<Content>>{
  @override
  List<Content> build() {
    return [];
  }

  void add(Content todo) => state = [...state, todo];



}


//NotifierProvider 注册
final contentProvider = NotifierProvider<ContentNotifier, List<Content>>(() {
  return ContentNotifier();
});


class Content {
  late String content;
  late int state;
  Content(this.content,this.state);
}