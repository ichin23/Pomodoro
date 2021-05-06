import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'screens/pomodoroHome.dart';
import 'screens/water.dart';

final FlutterLocalNotificationsPlugin flutterNotification =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('water');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterNotification.initialize(initializationSettings);
  runApp(Pomodoro());
}

Future _showNotification({String title, String detail, int id}) async {
  var androidDetails = AndroidNotificationDetails(
    "Water",
    "Local Notification",
    "Beba água",
    importance: Importance.high,
  );
  var iosDetails = IOSNotificationDetails();
  var generalNotificationDetail =
      NotificationDetails(android: androidDetails, iOS: iosDetails);

  await flutterNotification.show(id, title, detail, generalNotificationDetail);
}

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final _telas = [PomodoroHome(_showNotification), Water()];
  int _indiceAtual = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        Duration(
          minutes: 30,
        ),
        (timer) => _showNotification(
            title: "Beba água",
            detail: "Vai, se hidrate, não espere 3 pedras no rim....",
            id: 1));
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _telas[_indiceAtual],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Pomodoro"),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "About")
          ],
        ),
      ),
    );
  }
}
