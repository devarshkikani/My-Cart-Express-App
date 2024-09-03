
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
