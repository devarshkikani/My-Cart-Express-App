
import 'dart:convert';

GetStaffAllBranches getStaffAllBranchesFromJson(String str) => GetStaffAllBranches.fromJson(json.decode(str));

String getStaffAllBranchesToJson(GetStaffAllBranches data) => json.encode(data.toJson());

class GetStaffAllBranches {
    int? status;
    String? message;
    List<StaffBranch>? staffBranches;

    GetStaffAllBranches({
        this.status,
        this.message,
        this.staffBranches,
    });

    factory GetStaffAllBranches.fromJson(Map<String, dynamic> json) => GetStaffAllBranches(
        status: json["status"],
        message: json["message"],
        staffBranches: json["staff_branches"] == null ? [] : List<StaffBranch>.from(json["staff_branches"]!.map((x) => StaffBranch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "staff_branches": staffBranches == null ? [] : List<dynamic>.from(staffBranches!.map((x) => x.toJson())),
    };
}

class StaffBranch {
    String? branchId;
    String? parishname;
    String? branchCode;
    String? location;
    String? colorCode;

    StaffBranch({
        this.branchId,
        this.parishname,
        this.branchCode,
        this.location,
        this.colorCode,
    });

    factory StaffBranch.fromJson(Map<String, dynamic> json) => StaffBranch(
        branchId: json["branch_id"],
        parishname: json["parishname"],
        branchCode: json["branch_code"],
        location: json["location"],
        colorCode: json["color_code"],
    );

    Map<String, dynamic> toJson() => {
        "branch_id": branchId,
        "parishname": parishname,
        "branch_code": branchCode,
        "location": location,
        "color_code": colorCode,
    };
}


class GetDrawerStatusModel {
  int? status;
  DrawerDetails? drawerDetails;
  String? message;

  GetDrawerStatusModel({this.status, this.drawerDetails, this.message});

  GetDrawerStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    drawerDetails = json['drawer_details'] != null
        ? new DrawerDetails.fromJson(json['drawer_details'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (drawerDetails != null) {
      data['drawer_details'] = drawerDetails!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class DrawerDetails {
  String? id;
  String? posBranchName;
  String? drawerStartDate;

  DrawerDetails({this.id, this.posBranchName, this.drawerStartDate});

  DrawerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posBranchName = json['pos_branch_name'];
    drawerStartDate = json['drawer_start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['pos_branch_name'] = posBranchName;
    data['drawer_start_date'] = drawerStartDate;
    return data;
  }
}

