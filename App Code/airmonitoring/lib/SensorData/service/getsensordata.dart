import 'dart:convert';

import 'package:airmonitoring/SensorData/models/sensordata.dart';
import 'package:airmonitoring/shared/config.dart';
import 'package:airmonitoring/shared/services/apilcient.dart';
import 'package:dio/dio.dart';

class FetchSensorData {
  final ApiClient _apiClient = ApiClient();

  Future<List<SensorData>> getLatestSensorDataAsList() async {
    const url = Constants.sensorDataUrl;

    final Response response = await _apiClient.get(url);
    final List<dynamic> list = response.data;
    // List<SensorData> sensorData =
    //     list.map((e) => SensorData.SensorDataFromJson(e)).toList();
    // //print(sensorData);
    // return sensorData;

    if (list.isNotEmpty) {
      final sensorData = SensorData.SensorDataFromJson(list.last);
      return [sensorData];
    } else {
      throw Exception("No Sensor Data Available");
    }
  }
}
