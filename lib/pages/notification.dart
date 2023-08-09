import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


import '../datamodel.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);

Future<void> scheduleNotification(TimeOfDay t,String medName,DateTime start,DateTime end) async {
  if(DateTime.now().isBefore(start)||DateTime.now().isAfter(end)){
    return;
  }
  const int notificationId = 0;
  const String channelId = 'channel_id';
  const String channelName = 'Channel Name';
  const String channelDescription = 'Channel Description';
  
  // Define the notification details
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription,
    importance: Importance.high,
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  DateTime date=DateTime.now();
  // Calculate the date and time to schedule the notification
  final tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(DateTime(date.year,date.month,date.day,t.hour,t.minute).add(const Duration(seconds: 5)), tz.local);
  String body="Its time to take you medicine:$medName";
  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationId,
    'Reminder',
    body,
    scheduledDateTime,
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}
Future<void> scheduleappnotification(TimeOfDay t) async {
const int notificationId = 0;
  const String channelId = 'channel_id';
  const String channelName = 'Channel Name';
  const String channelDescription = 'Channel Description';
  
  // Define the notification details
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription,
    importance: Importance.high,
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  DateTime date=DateTime.now();
  // Calculate the date and time to schedule the notification
  final tz.TZDateTime scheduledDateTime = tz.TZDateTime.from(DateTime(date.year,date.month,date.day,t.hour,t.minute).add(const Duration(seconds: 5)), tz.local);
  String body="Its time for your appoinment";
  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationId,
    'Reminder',
    body,
    scheduledDateTime,
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}