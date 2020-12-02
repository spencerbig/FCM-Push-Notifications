// import 'dart:io';
// import 'dart:async';
// import 'package:flutter/material.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// _saveDeviceToken() async {
//   final FirebaseMessaging _fcm = FirebaseMessaging();
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   //uuid
//   String uid = 'device1';

//   //get token
//   String token = await _fcm.getToken();

//   if (token != null) {
//     var documentID =
//         _db.collection('users').doc(uid).collection('tokens').doc(token);
//   }
// }
