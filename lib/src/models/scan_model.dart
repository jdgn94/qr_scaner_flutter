import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String type;
  String value;

  ScanModel({
    this.id,
    this.type,
    this.value,
  }) {
    this.type = this.value.contains('http') ? 'http' : 'geo';
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  LatLng getLatLong() {
    final arrTemp = value.substring(4).split(',');
    final lat = double.parse(arrTemp[0]);
    final lng = double.parse(arrTemp[1]);

    return LatLng(lat, lng);
  }
}
