import 'package:cometchat/models/base_message.dart';
import 'package:cometchat/models/text_message.dart';
import 'package:cometchat/utils/constants.dart';

class TextSingelton{

  TextSingelton._privateConstructor();

  static final TextSingelton _instance = TextSingelton._privateConstructor();

  factory TextSingelton() {
    print("Singelton Class initiated");
    eventStreamChannel.receiveBroadcastStream(1)
        .map((e) {

      print("Receaving in this method");
      BaseMessage receavedMessage = BaseMessage.fromMap(e);
      if(receavedMessage is TextMessage){
       // _messageListeners.values.forEach((element) { element.onTextMessageReceived(receavedMessage);});
      }

    } );
    return _instance;
  }


}