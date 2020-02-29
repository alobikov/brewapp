class Message {

  String from;
  String title;
  String body;
  String message;
  DateTime timestamp;

  Message({this.from, this.title, this.body, this.message, this.timestamp});
  
}

  class Messages {
  List<Message> messages;

  Messages._privateConstructor();

  static final Messages _instance = Messages._privateConstructor();

  static Messages get instance => _instance;

}