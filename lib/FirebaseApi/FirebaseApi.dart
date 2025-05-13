import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:dentocoreauth/pages/notification/notification.dart';
import 'package:dentocoreauth/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utills/Utills.dart';
import '../controllers/notification_controller.dart';

class FirebaseApi {
  final util = Utills();
  final _firebaseMessaging = FirebaseMessaging.instance;

  final NotificationController _notificationController = Get.find();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //channel
  final _androidChannel = const AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notification",
      description: "This Channel is used for High Importance Notification",
      importance: Importance.defaultImportance);

  final _loccalNotification = FlutterLocalNotificationsPlugin();

  _handleMessage(RemoteMessage? message) {
    if (message == null) return;
    //util.showSnackBar("${message.notification!.title.toString()}",
    //  "${message.notification!.body.toString()}", true);
    print('Title ${message.notification!.title.toString()}');
    print('Body ${message.notification!.body.toString()}');
    print('Payload ${message.data.toString()}');
    Get.to(MyNotification());
  }

//function to send notification locally
  sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(_androidChannel.id, _androidChannel.name,
            channelDescription: 'dental channel',
            importance: Importance.max,
            priority: Priority.max);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _loccalNotification
        .show(0, title, body, notificationDetails)
        .then((value) => {
              _notificationController.setDot(true),
              // Get.defaultDialog(
              //     title: title,
              //     content: Text(body),
              //     onConfirm: () {
              //       Get.back();
               //     Get.to(MyNotification());
              //     },
              //     onCancel: () {
              //       Get.back();
              //     }),

              //it fire when notification pop up without click
            });
  }

  Future initLocalNotifications() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = null;
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _loccalNotification.initialize(
      initializationSettings,
    );

    //creating channel
    final platform = _loccalNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

   saveUserData(key, value) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then((value) => {
          //   util.showSnackBar("Alert", "getInitialMessage", true),
          _handleMessage(value),
        });

    //onclick notification
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //  util.showSnackBar("Alert", "onMessageOpenedApp", true);
      _notificationController.setDot(false);
      _handleMessage(event);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if (notification == null) return;
      //for show notification locally
      sendNotification(message.notification!.title!.toString(),
          message!.notification!.body.toString());

      var res = _loccalNotification
          .show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  _androidChannel.id,
                  _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/ic_launcher',
                ),
              ),
              payload: jsonEncode(message.toMap()))
          .then((value) => {
                //    _notificationController.setDot(true),
              });
    });
  }

  //bg handling//not used
  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    util.showSnackBar("Alert", "handleBackgroundMessage", true);
    print('Title ${message.notification!.title.toString()}');
    print('Body ${message.notification!.body.toString()}');
    print('Payload ${message.data.toString()}');
  }

  // Future<void> initFirebase() async {
  //   await _firebaseMessaging.requestPermission();
  //   final fcmToken = await _firebaseMessaging.getToken();
  //   print("Abhi:- Get Firebase token $fcmToken");
  //   if (fcmToken != null) {
  //     saveUserData("fcm", fcmToken);
  //     AppConstant.setData("fcm", "${fcmToken}");
  //   }
  //   print('MyToken:$fcmToken');
  //
  //   //for background
  //   initPushNotification();
  //
  //   //for on ground
  //   initLocalNotifications();
  // }

   Future<void> initFirebase() async {
    try {
      print("Abhi:- Firebase init shuru ho raha hai");

      // Permission maang rahe hain
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      print("Abhi:- Permission status: ${settings.authorizationStatus}");

      // Agar permission mil gaya
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("Abhi:- Token lene ki koshish kar rahe hain");
        final fcmToken = await _firebaseMessaging.getToken();
        if (fcmToken != null) {
          print("Abhi:- FCM Token mil gaya: $fcmToken");
          await saveUserData("fcm", fcmToken);
          AppConstant.setData("fcm", fcmToken);
        } else {
          print("Abhi:- FCM Token null hai, internet ya setup check karo");
        }
      } else {
        print("Abhi:- Permission nahi mili, settings mein allow karo");
      }

      // Baaki setup
      await initPushNotification();
      await initLocalNotifications();
      print("Abhi:- Firebase init pura ho gaya");
    } catch (e) {
      print("Abhi:- Error aaya: $e");
    }
  }
}
