// To parse this JSON data, do
//
//     final drawerEndDetailsModel = drawerEndDetailsModelFromJson(jsonString);

import 'dart:convert';

DrawerEndDetailsModel drawerEndDetailsModelFromJson(String str) => DrawerEndDetailsModel.fromJson(json.decode(str));

String drawerEndDetailsModelToJson(DrawerEndDetailsModel data) => json.encode(data.toJson());

class DrawerEndDetailsModel {
    int? success;
    DrawerEndDetailsData? data;

    DrawerEndDetailsModel({
        this.success,
        this.data,
    });

    factory DrawerEndDetailsModel.fromJson(Map<String, dynamic> json) => DrawerEndDetailsModel(
        success: json["success"],
        data: json["data"] == null ? null : DrawerEndDetailsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class DrawerEndDetailsData {
    DrawerDetails? drawerDetails;
    int? drawerUsdTransactionFlag;
    List<StaffList>? staffList;
    String? staffName;
    String? branchName;

    DrawerEndDetailsData({
        this.drawerDetails,
        this.drawerUsdTransactionFlag,
        this.staffList,
        this.staffName,
        this.branchName,
    });

    factory DrawerEndDetailsData.fromJson(Map<String, dynamic> json) => DrawerEndDetailsData(
        drawerDetails: json["drawer_details"] == null ? null : DrawerDetails.fromJson(json["drawer_details"]),
        drawerUsdTransactionFlag: json["drawer_usd_transaction_flag"],
        staffList: json["staff_list"] == null ? [] : List<StaffList>.from(json["staff_list"]!.map((x) => StaffList.fromJson(x))),
        staffName: json["staff_name"],
        branchName: json["branch_name"],
    );

    Map<String, dynamic> toJson() => {
        "drawer_details": drawerDetails?.toJson(),
        "drawer_usd_transaction_flag": drawerUsdTransactionFlag,
        "staff_list": staffList == null ? [] : List<dynamic>.from(staffList!.map((x) => x.toJson())),
        "staff_name": staffName,
        "branch_name": branchName,
    };
}

class DrawerDetails {
    String? id;
    String? cashBranchId;
    String? initialAmount;
    String? cashUsdSummed;
    String? cashUsdJmdSummed;
    String? cashSummed;
    String? cardReceiptSummed;
    String? ewalletSummed;
    String? cashChangeValueSummed;
    String? bagHashUsd;
    String? bagHash;
    String? usdVerifiedBy;
    String? verifiedBy;
    String? isNoteAdded;
    String? usdDifference;
    String? cashDifference;
    String? cardDifference;
    String? cashChangeValueDifference;
    String? isInitAmountReturned;
    String? isClosed;
    String? loggedUserId;
    DateTime? endTimestamp;
    DateTime? insertTimestamp;

    DrawerDetails({
        this.id,
        this.cashBranchId,
        this.initialAmount,
        this.cashUsdSummed,
        this.cashUsdJmdSummed,
        this.cashSummed,
        this.cardReceiptSummed,
        this.ewalletSummed,
        this.cashChangeValueSummed,
        this.bagHashUsd,
        this.bagHash,
        this.usdVerifiedBy,
        this.verifiedBy,
        this.isNoteAdded,
        this.usdDifference,
        this.cashDifference,
        this.cardDifference,
        this.cashChangeValueDifference,
        this.isInitAmountReturned,
        this.isClosed,
        this.loggedUserId,
        this.endTimestamp,
        this.insertTimestamp,
    });

    factory DrawerDetails.fromJson(Map<String, dynamic> json) => DrawerDetails(
        id: json["id"],
        cashBranchId: json["cash_branch_id"],
        initialAmount: json["initial_amount"],
        cashUsdSummed: json["cash_usd_summed"],
        cashUsdJmdSummed: json["cash_usd_jmd_summed"],
        cashSummed: json["cash_summed"],
        cardReceiptSummed: json["card_receipt_summed"],
        ewalletSummed: json["ewallet_summed"],
        cashChangeValueSummed: json["cash_change_value_summed"],
        bagHashUsd: json["bag_hash_usd"],
        bagHash: json["bag_hash"],
        usdVerifiedBy: json["usd_verified_by"],
        verifiedBy: json["verified_by"],
        isNoteAdded: json["is_note_added"],
        usdDifference: json["usd_difference"],
        cashDifference: json["cash_difference"],
        cardDifference: json["card_difference"],
        cashChangeValueDifference: json["cash_change_value_difference"],
        isInitAmountReturned: json["is_init_amount_returned"],
        isClosed: json["is_closed"],
        loggedUserId: json["logged_user_id"],
        endTimestamp: json["end_timestamp"] == null ? null : DateTime.parse(json["end_timestamp"]),
        insertTimestamp: json["insert_timestamp"] == null ? null : DateTime.parse(json["insert_timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cash_branch_id": cashBranchId,
        "initial_amount": initialAmount,
        "cash_usd_summed": cashUsdSummed,
        "cash_usd_jmd_summed": cashUsdJmdSummed,
        "cash_summed": cashSummed,
        "card_receipt_summed": cardReceiptSummed,
        "ewallet_summed": ewalletSummed,
        "cash_change_value_summed": cashChangeValueSummed,
        "bag_hash_usd": bagHashUsd,
        "bag_hash": bagHash,
        "usd_verified_by": usdVerifiedBy,
        "verified_by": verifiedBy,
        "is_note_added": isNoteAdded,
        "usd_difference": usdDifference,
        "cash_difference": cashDifference,
        "card_difference": cardDifference,
        "cash_change_value_difference": cashChangeValueDifference,
        "is_init_amount_returned": isInitAmountReturned,
        "is_closed": isClosed,
        "logged_user_id": loggedUserId,
        "end_timestamp": endTimestamp?.toIso8601String(),
        "insert_timestamp": insertTimestamp?.toIso8601String(),
    };
}

class StaffList {
    String? userId;
    String? firstname;
    String? lastname;

    StaffList({
        this.userId,
        this.firstname,
        this.lastname,
    });

    factory StaffList.fromJson(Map<String, dynamic> json) => StaffList(
        userId: json["user_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "firstname": firstname,
        "lastname": lastname,
    };
}
