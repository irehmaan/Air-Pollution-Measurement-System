// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensordata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorData _$SensorDataFromJson(Map<String, dynamic> json) => SensorData(
      json['altitude'] as int?,
      (json['humidity'] as num?)?.toDouble(),
      (json['ppm'] as num?)?.toDouble(),
      (json['pressure'] as num?)?.toDouble(),
      json['realAltitude'] as int?,
      json['seaLevelPressure'] as int?,
      json['temprature'] as int?,
    );

Map<String, dynamic> _$SensorDataToJson(SensorData instance) =>
    <String, dynamic>{
      'temprature': instance.temp,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'realAltitude': instance.realAltitude,
      'altitude': instance.altitude,
      'seaLevelPressure': instance.seaLevelPressure,
      'ppm': instance.ppm,
    };
