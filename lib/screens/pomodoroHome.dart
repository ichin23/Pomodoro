import 'package:flutter/material.dart';

import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PomodoroHome extends StatefulWidget {
  final notify;
  PomodoroHome(Function this.notify);

  @override
  _PomodoroHomeState createState() => _PomodoroHomeState(this.notify);
}

class _PomodoroHomeState extends State<PomodoroHome> {
  final notify;
  _PomodoroHomeState(Function this.notify);

  Timer _timer;
  int _time1 = 1800;
  int _minutes = 30;
  var _seconds = 0;
  double _percent = 1;
  var _vintecinco = true;
  var _running = false;
  var _status = true;
  void _startTime() {
    _running = true;
    _minutes = 29;
    _seconds = 0;
    _time1 = 1800;
    Timer _internal;

    _internal = Timer.periodic(Duration(minutes: 5), (timer) {
      if (_time1 < 300) {
        this.notify(title: "Relaxa", detail: "Chega de tanto foco, relaxe.", id: 2);
      }
    });
    var sub = 1 / (60 * 30);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds == 0) {
          _seconds = 60;
        }
        if (_time1 > 0 && _percent - sub >= 0) {
          _time1--;
          _seconds--;
          _percent -= sub;

          if (_time1 <= 300) {
            _vintecinco = false;
            _status = false;
          } else {
            _vintecinco = true;
          }
          if (_time1 % 60 == 0) {
            _minutes -= 1;
          }
        } else {
          _vintecinco = true;
          _running = false;
          _status = true;
          _time1 = 1800;
          _percent = 1;
          _seconds = 0;
          _minutes = 30;
          _timer.cancel();
          this.notify(title: "Acabou", detail: "Acabou o tempo, retornar?", id: 3);
        }
      });
    });
  }

  void stopTime() {
    setState(() {
      _vintecinco = true;
      _running = false;
      _status = true;
      _time1 = 1800;
      _percent = 1;
      _seconds = 0;
      _minutes = 30;
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Pomodoro",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ),
        Spacer(),
        (_status)
            ? Text(
                "Concentre",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),
              )
            : Text(
                "Relaxe",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                ),
              ),
        Expanded(
            child: CircularPercentIndicator(
                radius: 200,
                percent: _percent,
                animation: true,
                animateFromLastPercent: true,
                lineWidth: 5,
                progressColor: _vintecinco ? Colors.blue : Colors.red,
                center: Text(
                  (_minutes).toString() + ":" + (_seconds).toString(),
                  style: TextStyle(fontSize: 30),
                ))),
        Spacer(),
        Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 5),
            child: Row(children: [
              (_running)
                  ? TextButton(
                      onPressed: stopTime,
                      child: Text("Stop"),
                      style: TextButton.styleFrom(
                          minimumSize: Size(300, 50),
                          primary: Colors.white,
                          shadowColor: Colors.red,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))))
                  : TextButton(
                      onPressed: _startTime,
                      child: Text("Start"),
                      style: TextButton.styleFrom(
                          minimumSize: Size(300, 50),
                          primary: Colors.white,
                          shadowColor: Colors.blue,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
            ])),
      ],
    ));
  }
}
