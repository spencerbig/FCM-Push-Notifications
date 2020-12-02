import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Topic Notifications',
      home: Scaffold(
        body: MessageHandler(),
      ),
    );
  }
}

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _saveDeviceToken();

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // final snackbar = SnackBar(
        //   content: Text(message['notification']['title']),
        //   action: SnackBarAction(
        //     label: 'Go',
        //     onPressed: () => null,
        //   ),
        // );

        // Scaffold.of(context).showSnackBar(snackbar);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      // onLaunch: (Map<String, dynamic> message) async {
      //   print("onLaunch: $message");
      //TO DO
      // },
      // onResume: (Map<String, dynamic> message) async {
      //   print("onResume: $message");
      //TO DO
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Firebase Topic Notifications'),
      ),
    );
  }

  //save token to database
  _saveDeviceToken() async {
    String uid = 'device1';

    //get the token
    String dbData = await _fcm
        .getToken()
        .whenComplete(() => print('Tokenization complete'));

    //save to firestore
    if (dbData != null) {
      var tokens =
          _db.collection('users').doc(uid).collection('tokens').doc(dbData);

      await tokens.set({
        'token': dbData,
        // 'createdAt': FieldValue.serverTimestamp(),
        // 'platform': Platform.operatingSystem
      }).whenComplete(() => print('Data has been set'));
    }
  }

  // /// Subscribe the user to a topic
  // _subscribeToTopic() async {
  //   _fcm.subscribeToTopic('engineer');
}
