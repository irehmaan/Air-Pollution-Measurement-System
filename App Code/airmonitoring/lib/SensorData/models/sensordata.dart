import 'package:json_annotation/json_annotation.dart';

part 'sensordata.g.dart';

@JsonSerializable()
class SensorData {
  @JsonKey(name: 'temprature')
  int? temp;
  @JsonKey(name: 'humidity')
  double? humidity;
  @JsonKey(name: 'pressure')
  double? pressure;
  @JsonKey(name: 'realAltitude')
  int? realAltitude;
  @JsonKey(name: 'altitude')
  int? altitude;
  @JsonKey(name: 'seaLevelPressure')
  int? seaLevelPressure;
  @JsonKey(name: 'ppm')
  double? ppm;

  SensorData(this.altitude, this.humidity, this.ppm, this.pressure,
      this.realAltitude, this.seaLevelPressure, this.temp);

  static SensorData SensorDataFromJson(Map<String, dynamic> map) =>
      _$SensorDataFromJson(map);
}
