import 'dart:convert';

Branches branchesFromJson(String str) => Branches.fromJson(json.decode(str));

String branchesToJson(Branches data) => json.encode(data.toJson());

class Branches {
  Branches({
    required this.branchId,
    required this.isStaffOnly,
    required this.isFront,
    required this.location,
    required this.status,
    required this.phone,
    required this.address,
    required this.city,
    required this.parishname,
    required this.openHour,
    required this.code,
    required this.colorCode,
    required this.isInhouseDelivery,
    required this.isThirdpartyDelivery,
    required this.music,
    required this.musicOrg,
    required this.branchCode,
    required this.branchCodeImage,
    required this.insertTimestamp,
    required this.updateTimestamp,
  });

  String branchId;
  String isStaffOnly;
  String isFront;
  String location;
  String status;
  String phone;
  String address;
  String city;
  String parishname;
  String openHour;
  String code;
  String colorCode;
  String isInhouseDelivery;
  String isThirdpartyDelivery;
  String music;
  String musicOrg;
  String branchCode;
  String branchCodeImage;
  DateTime insertTimestamp;
  DateTime updateTimestamp;

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        branchId: json["branch_id"],
        isStaffOnly: json["is_staff_only"],
        isFront: json["is_front"],
        location: json["location"],
        status: json["status"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        parishname: json["parishname"],
        openHour: json["open_hour"],
        code: json["code"],
        colorCode: json["color_code"],
        isInhouseDelivery: json["is_inhouse_delivery"],
        isThirdpartyDelivery: json["is_thirdparty_delivery"],
        music: json["music"],
        musicOrg: json["music_org"],
        branchCode: json["branch_code"],
        branchCodeImage: json["branch_code_image"],
        insertTimestamp: DateTime.parse(json["insert_timestamp"]),
        updateTimestamp: DateTime.parse(json["update_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "is_staff_only": isStaffOnly,
        "is_front": isFront,
        "location": location,
        "status": status,
        "phone": phone,
        "address": address,
        "city": city,
        "parishname": parishname,
        "open_hour": openHour,
        "code": code,
        "color_code": colorCode,
        "is_inhouse_delivery": isInhouseDelivery,
        "is_thirdparty_delivery": isThirdpartyDelivery,
        "music": music,
        "music_org": musicOrg,
        "branch_code": branchCode,
        "branch_code_image": branchCodeImage,
        "insert_timestamp": insertTimestamp.toIso8601String(),
        "update_timestamp": updateTimestamp.toIso8601String(),
      };
}
