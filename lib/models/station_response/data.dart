import 'package:seaoil_technical_exam/models/station_response/area_enum.dart';
import 'package:seaoil_technical_exam/models/station_response/type_enum.dart';

class StationData {
  StationData({
    this.id,
    this.code,
    this.mobileNum,
    this.area,
    this.province,
    this.city,
    this.name,
    this.businessName,
    this.address,
    this.lat,
    this.lng,
    this.type,
    this.depotId,
    this.dealerId,
    this.createdAt,
    this.updatedAt,
    this.kmDistanceFromUserDevice,
    this.radioValue
  });

  int id;
  String code;
  String mobileNum;
  Area area;
  String province;
  String city;
  String name;
  String businessName;
  String address;
  String lat;
  String lng;
  Type type;
  int depotId;
  int dealerId;
  DateTime createdAt;
  DateTime updatedAt;
  double kmDistanceFromUserDevice;
  int radioValue;

  factory StationData.fromJson(Map<String, dynamic> json) => StationData(
    id: json["id"],
    code: json["code"],
    mobileNum: json["mobileNum"],
    area: areaValues.map[json["area"]],
    province: json["province"],
    city: json["city"],
    name: json["name"],
    businessName: json["businessName"],
    address: json["address"],
    lat: json["lat"],
    lng: json["lng"],
    type: typeValues.map[json["type"]],
    depotId: json["depotId"],
    dealerId: json["dealerId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "mobileNum": mobileNum,
    "area": areaValues.reverse[area],
    "province": province,
    "city": city,
    "name": name,
    "businessName": businessName,
    "address": address,
    "lat": lat,
    "lng": lng,
    "type": typeValues.reverse[type],
    "depotId": depotId,
    "dealerId": dealerId,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}