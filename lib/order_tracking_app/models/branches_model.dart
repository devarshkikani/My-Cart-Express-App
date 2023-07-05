// To parse this JSON data, do
//
//     final brabches = brabchesFromJson(jsonString);

import 'dart:convert';

Branches brabchesFromJson(String str) => Branches.fromJson(json.decode(str));

String brabchesToJson(Branches data) => json.encode(data.toJson());

class Branches {
  Branches({
    required this.branchId,
    required this.isStaffOnly,
    required this.status,
    required this.isFront,
    required this.location,
    required this.phone,
    required this.address,
    required this.city,
    required this.parishname,
    required this.openHour,
    required this.code,
    required this.colorCode,
    required this.branchCodeImage,
    required this.music,
  });

  String? branchId;
  String? isStaffOnly;
  String? status;
  String? isFront;
  String? location;
  String? phone;
  String? address;
  String? city;
  String? parishname;
  String? openHour;
  String? code;
  String? colorCode;
  String? branchCodeImage;
  String? music;

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        branchId: json["branch_id"],
        isStaffOnly: json["is_staff_only"],
        status: json["status"],
        isFront: json["is_front"],
        location: json["location"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        parishname: json["parishname"],
        openHour: json["open_hour"],
        code: json["code"],
        colorCode: json["color_code"],
        branchCodeImage: json["branch_code_image"],
        music: json["music"],
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "is_staff_only": isStaffOnly,
        "status": status,
        "is_front": isFront,
        "location": location,
        "phone": phone,
        "address": address,
        "city": city,
        "parishname": parishname,
        "open_hour": openHour,
        "code": code,
        "color_code": colorCode,
        "branch_code_image": branchCodeImage,
        "music": music,
      };
}
