import 'package:airmonitoring/SensorData/models/sensordata.dart';
import 'package:airmonitoring/homescreen/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class uiLayout extends StatelessWidget {
  SensorData sensorData;

  uiLayout({super.key, required this.sensorData});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        DataContainer(
            datapath: sensorData.temp.toString(),
            label: "Temp: ",
            imgPath: "assets/icons/hot.gif"),
        DataContainer(
            datapath: sensorData.humidity.toString(),
            label: "Humidity",
            imgPath: "assets/icons/humidity.gif"),
        DataContainer(
            datapath: sensorData.ppm.toString(),
            label: "PPM Conc. : ",
            imgPath: "assets/icons/pollution.gif"),
        DataContainer(
            datapath: sensorData.pressure.toString(),
            label: "Pressure: ",
            imgPath: "assets/icons/pressure-gauge.png"),
        DataContainer(
            datapath: sensorData.altitude.toString(),
            label: "Altitude: ",
            imgPath: "assets/icons/altitude.png"),
        DataContainer(
            datapath: sensorData.realAltitude.toString(),
            label: "Real Altitude: ",
            imgPath: "assets/icons/real-altitude.png"),
        DataContainer(
            datapath: sensorData.seaLevelPressure.toString(),
            label: "Sea Level Pressure: ",
            imgPath: "assets/icons/sea-level.png"),
      ],
    );
  }
}
