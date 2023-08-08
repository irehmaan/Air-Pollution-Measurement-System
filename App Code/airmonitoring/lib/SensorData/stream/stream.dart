import 'package:airmonitoring/SensorData/models/sensordata.dart';
import 'package:airmonitoring/SensorData/service/getsensordata.dart';

class SensorDataStream {
  final FetchSensorData _fetchSensorData = FetchSensorData();

  Stream<List<SensorData>> get sensorDataStream async* {
    while (true) {
      final sensorDataStream =
          await _fetchSensorData.getLatestSensorDataAsList();
      yield sensorDataStream;
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
