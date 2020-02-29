import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushapp/models/message.dart';
import 'package:pushapp/models/user.dart';
import 'package:pushapp/screens/home/home.dart';
import 'package:pushapp/services/database.dart';

class MessageHandling extends StatefulWidget {
  MessageHandling({Key key}) : super(key: key);

  @override
  _MessageHandlingState createState() => _MessageHandlingState();
}

class _MessageHandlingState extends State<MessageHandling> {
  Messages _msg = Messages.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    _msg.messages = List<Message>();
    _saveDeviceToken();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _setMessage(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    final user = Provider.of<User>(context, listen: false);
    String fcmToken = await _fcm.getToken();
    try {
      print('atempting to firestore token $fcmToken');
      await DatabaseService(uid: user.uid).updateUserToken(token: fcmToken);
    } catch (e) {
      print('MessageHandling: ${e.toString()}');
    }
    print('MessageHandling ${user.uid}');
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];
    setState(() {
      Message m = Message(title: title, body: body, message: mMessage);
      _msg.messages.add(m);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
