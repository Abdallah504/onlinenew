

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onlinenew/main.dart';
import 'package:onlinenew/screens/notify-screen.dart';

class FirebaseApi{

final _firebasemessaging = FirebaseMessaging.instance;

Future<void>initNotify()async{
  await _firebasemessaging.requestPermission();
  final fcmToken = await _firebasemessaging.getToken();
  print("Token : $fcmToken");


  

  // FirebaseMessaging.onBackgroundMessage(handleBackground);
  initPushNotify();

}
}

Future<void>handleBackground(RemoteMessage? message)async{
print('Title :${message!.notification?.title}');
print('Body :${message!.notification?.body}');
print('Data :${message!.data}');
}
void handleMessage(RemoteMessage? message)async{
  if(message==null)return;
  navigatorKey.currentState?.pushNamed(
    NotifyScreen.route,
    arguments: message
  );
}

Future initPushNotify()async{
  final localNotifi = FlutterLocalNotificationsPlugin();
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  final androidChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'High_Importance_Notifications',
      description: 'This Channel is important',
      importance: Importance.defaultImportance
  );
  // execute the handle message function to move to next screen
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  // same upper line but for background case
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleBackground);
  FirebaseMessaging.onMessage.listen((message){

    final notification = message.notification;
    if(notification==null)return;
    localNotifi.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(androidChannel.id, androidChannel.name,
          channelDescription: androidChannel.description,
            icon: '@drawable/ic_launcher'
          )
        ),
      payload: jsonEncode(message.toMap()),

    );
    initLocalNotify(jsonEncode(message.toMap()),androidChannel);
  });
}

Future initLocalNotify(messagnig,androidChannel)async{
  final localNotifi = FlutterLocalNotificationsPlugin();
  final android = AndroidInitializationSettings('@drawable/ic_launcher');
  final settings = InitializationSettings(android: android);
await localNotifi.initialize(settings);
final message = RemoteMessage.fromMap(jsonDecode(messagnig));
handleMessage(message);
final platform = localNotifi.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
await platform?.createNotificationChannel(androidChannel);
}