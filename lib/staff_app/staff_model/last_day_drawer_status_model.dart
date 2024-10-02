// To parse this JSON data, do
//
//     final checkLastDayDrawerStatusModel = checkLastDayDrawerStatusModelFromJson(jsonString);

import 'dart:convert';

CheckLastDayDrawerStatusModel checkLastDayDrawerStatusModelFromJson(String str) => CheckLastDayDrawerStatusModel.fromJson(json.decode(str));

String checkLastDayDrawerStatusModelToJson(CheckLastDayDrawerStatusModel data) => json.encode(data.toJson());

class CheckLastDayDrawerStatusModel {
    int? status;
    String? message;
    LastDayDrawerDetails? lastDayDrawerDetails;

    CheckLastDayDrawerStatusModel({
        this.status,
        this.message,
        this.lastDayDrawerDetails,
    });

    factory CheckLastDayDrawerStatusModel.fromJson(Map<String, dynamic> json) => CheckLastDayDrawerStatusModel(
        status: json["status"],
        message: json["message"],
        lastDayDrawerDetails: json["last_day_drawer_details"] == null ? null : LastDayDrawerDetails.fromJson(json["last_day_drawer_details"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "last_day_drawer_details": lastDayDrawerDetails?.toJson(),
    };
}

class LastDayDrawerDetails {
    String? id;
    String? cashBranchId;
    String? initialAmount;
    String? cashUsdSummed;
    String? cashUsdJmdSummed;
    String? cashSummed;
    String? cardReceiptSummed;
    String? ewalletSummed;
    String? cashChangeValueSummed;
    dynamic bagHashUsd;
    dynamic bagHash;
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
    String? endTimestamp;
    DateTime? insertTimestamp;

    LastDayDrawerDetails({
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

    factory LastDayDrawerDetails.fromJson(Map<String, dynamic> json) => LastDayDrawerDetails(
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
        endTimestamp: json["end_timestamp"],
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
        "end_timestamp": endTimestamp,
        "insert_timestamp": insertTimestamp?.toIso8601String(),
    };
}
