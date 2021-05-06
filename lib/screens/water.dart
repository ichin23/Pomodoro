import 'package:flutter/material.dart';

class Water extends StatefulWidget {
  @override
  _WaterState createState() => _WaterState();
}

class _WaterState extends State<Water> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 15, bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pomodoro&WaterApp",
            style: TextStyle(fontSize: 30, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          Column(
            children: [
              Text(
                "Informações: ",
                style: TextStyle(fontSize: 25, color: Colors.orange),
                textAlign: TextAlign.center,
              ),
              Text("Concentração: 25 minutos"),
              Text("Relaxe: 5 minutos"),
            ],
          ),
          Text(
            "Github: @ichin23",
            style: TextStyle(color: Colors.blue[200]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    )));
  }
}
