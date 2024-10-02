// To parse this JSON data, do
//
//     final scanPosPackageModel = scanPosPackageModelFromJson(jsonString);

import 'dart:convert';

ScanPosPackageModel scanPosPackageModelFromJson(String str) => ScanPosPackageModel.fromJson(json.decode(str));

String scanPosPackageModelToJson(ScanPosPackageModel data) => json.encode(data.toJson());

class ScanPosPackageModel {
    num? status;
    String? message;
    ScanPosPackageData? data;

    ScanPosPackageModel({
        this.status,
        this.message,
        this.data,
    });

    factory ScanPosPackageModel.fromJson(Map<String, dynamic> json) => ScanPosPackageModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ScanPosPackageData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class ScanPosPackageData {
    num? posModuleOpenId;
    CustomerDetails? customerDetails;
    List<TransactionList>? transactionList;
    TransactionDetails? transactionDetails;
    num? walletBalance;
    num? bucksBalance;
    String? priceValue;
    List<BankList>? bankList;
    UsdDetails? usdDetails;

    ScanPosPackageData({
        this.posModuleOpenId,
        this.customerDetails,
        this.transactionList,
        this.transactionDetails,
        this.walletBalance,
        this.bucksBalance,
        this.priceValue,
        this.bankList,
        this.usdDetails,
    });

    factory ScanPosPackageData.fromJson(Map<String, dynamic> json) => ScanPosPackageData(
        posModuleOpenId: json["pos_module_open_id"],
        customerDetails: json["customer_details"] == null ? null : CustomerDetails.fromJson(json["customer_details"]),
        transactionList: json["transaction_list"] == null ? [] : List<TransactionList>.from(json["transaction_list"]!.map((x) => TransactionList.fromJson(x))),
        transactionDetails: json["transaction_details"] == null ? null : TransactionDetails.fromJson(json["transaction_details"]),
        walletBalance: json["wallet_balance"],
        bucksBalance: json["bucks_balance"],
        priceValue: json["price_value"],
        bankList: json["bank_list"] == null ? [] : List<BankList>.from(json["bank_list"]!.map((x) => BankList.fromJson(x))),
        usdDetails: json["usd_details"] == null ? null : UsdDetails.fromJson(json["usd_details"]),
    );

    Map<String, dynamic> toJson() => {
        "pos_module_open_id": posModuleOpenId,
        "customer_details": customerDetails?.toJson(),
        "transaction_list": transactionList == null ? [] : List<dynamic>.from(transactionList!.map((x) => x.toJson())),
        "transaction_details": transactionDetails?.toJson(),
        "wallet_balance": walletBalance,
        "bucks_balance": bucksBalance,
        "price_value": priceValue,
        "bank_list": bankList == null ? [] : List<dynamic>.from(bankList!.map((x) => x.toJson())),
        "usd_details": usdDetails?.toJson(),
    };
}

class BankList {
    String? id;
    String? name;
    String? recipientName;
    String? accountNumber;
    String? branch;
    String? isenable;
    String? isdelete;

    BankList({
        this.id,
        this.name,
        this.recipientName,
        this.accountNumber,
        this.branch,
        this.isenable,
        this.isdelete,
    });

    factory BankList.fromJson(Map<String, dynamic> json) => BankList(
        id: json["id"],
        name: json["name"],
        recipientName: json["recipient_name"],
        accountNumber: json["account_number"],
        branch: json["branch"],
        isenable: json["isenable"],
        isdelete: json["isdelete"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "recipient_name": recipientName,
        "account_number": accountNumber,
        "branch": branch,
        "isenable": isenable,
        "isdelete": isdelete,
    };
}

class CustomerDetails {
    String? customerId;
    String? customerName;
    String? email;
    String? phone;
    String? profileImage;
    dynamic authorizedPickup;
    dynamic birthDate;
    num? rateCalculate;
    num? shipments;
    num? isToggled;
    num? shipmentsReady;
    String? priceGroupName;
    num? totalPackages;
    String? branchName;
    num? hideAccountSwitchBranchFlag;
    num? hideResetDisableAccountFlag;

    CustomerDetails({
        this.customerId,
        this.customerName,
        this.email,
        this.phone,
        this.profileImage,
        this.authorizedPickup,
        this.birthDate,
        this.rateCalculate,
        this.shipments,
        this.isToggled,
        this.shipmentsReady,
        this.priceGroupName,
        this.totalPackages,
        this.branchName,
        this.hideAccountSwitchBranchFlag,
        this.hideResetDisableAccountFlag,
    });

    factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        email: json["email"],
        phone: json["phone"],
        profileImage: json["profile_image"],
        authorizedPickup: json["authorized_pickup"],
        birthDate: json["birth_date"],
        rateCalculate: json["rate_calculate"],
        shipments: json["shipments"],
        isToggled: json["is_toggled"],
        shipmentsReady: json["shipments_ready"],
        priceGroupName: json["price_group_name"],
        totalPackages: json["total_packages"],
        branchName: json["branch_name"],
        hideAccountSwitchBranchFlag: json["hide_account_switch_branch_flag"],
        hideResetDisableAccountFlag: json["hide_reset_disable_account_flag"],
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_name": customerName,
        "email": email,
        "phone": phone,
        "profile_image": profileImage,
        "authorized_pickup": authorizedPickup,
        "birth_date": birthDate,
        "rate_calculate": rateCalculate,
        "shipments": shipments,
        "is_toggled": isToggled,
        "shipments_ready": shipmentsReady,
        "price_group_name": priceGroupName,
        "total_packages": totalPackages,
        "branch_name": branchName,
        "hide_account_switch_branch_flag": hideAccountSwitchBranchFlag,
        "hide_reset_disable_account_flag": hideResetDisableAccountFlag,
    };
}

class TransactionDetails {
    String? id;
    String? parentId;
    String? userId;
    String? drawerId;
    String? amount;
    String? cash;
    String? cashUsd;
    String? cashUsdJmd;
    String? card;
    String? cardUsd;
    String? ewallet;
    String? bucks;
    String? changeDue;
    String? remainingDue;
    String? ewalletDue;
    dynamic cardBank;
    dynamic cardInvoice;
    String? paymentType;
    String? paymentStatus;
    String? paymentThrough;
    String? paymentThroughId;
    String? loggedUserId;
    DateTime? insertTimestamp;
    DateTime? updateTimestamp;

    TransactionDetails({
        this.id,
        this.parentId,
        this.userId,
        this.drawerId,
        this.amount,
        this.cash,
        this.cashUsd,
        this.cashUsdJmd,
        this.card,
        this.cardUsd,
        this.ewallet,
        this.bucks,
        this.changeDue,
        this.remainingDue,
        this.ewalletDue,
        this.cardBank,
        this.cardInvoice,
        this.paymentType,
        this.paymentStatus,
        this.paymentThrough,
        this.paymentThroughId,
        this.loggedUserId,
        this.insertTimestamp,
        this.updateTimestamp,
    });

    factory TransactionDetails.fromJson(Map<String, dynamic> json) => TransactionDetails(
        id: json["id"],
        parentId: json["parent_id"],
        userId: json["user_id"],
        drawerId: json["drawer_id"],
        amount: json["amount"],
        cash: json["cash"],
        cashUsd: json["cash_usd"],
        cashUsdJmd: json["cash_usd_jmd"],
        card: json["card"],
        cardUsd: json["card_usd"],
        ewallet: json["ewallet"],
        bucks: json["bucks"],
        changeDue: json["change_due"],
        remainingDue: json["remaining_due"],
        ewalletDue: json["ewallet_due"],
        cardBank: json["card_bank"],
        cardInvoice: json["card_invoice"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        paymentThrough: json["payment_through"],
        paymentThroughId: json["payment_through_id"],
        loggedUserId: json["logged_user_id"],
        insertTimestamp: json["insert_timestamp"] == null ? null : DateTime.parse(json["insert_timestamp"]),
        updateTimestamp: json["update_timestamp"] == null ? null : DateTime.parse(json["update_timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "user_id": userId,
        "drawer_id": drawerId,
        "amount": amount,
        "cash": cash,
        "cash_usd": cashUsd,
        "cash_usd_jmd": cashUsdJmd,
        "card": card,
        "card_usd": cardUsd,
        "ewallet": ewallet,
        "bucks": bucks,
        "change_due": changeDue,
        "remaining_due": remainingDue,
        "ewallet_due": ewalletDue,
        "card_bank": cardBank,
        "card_invoice": cardInvoice,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "payment_through": paymentThrough,
        "payment_through_id": paymentThroughId,
        "logged_user_id": loggedUserId,
        "insert_timestamp": insertTimestamp?.toIso8601String(),
        "update_timestamp": updateTimestamp?.toIso8601String(),
    };
}

class TransactionList {
    String? id;
    String? posTransactionId;
    String? packageId;
    String? isShippingPackage;
    DateTime? insertTimestamp;
    DateTime? updateTimestamp;
    String? shippingMcecode;
    dynamic description;
    String? weight;
    String? status;
    String? subTotal;
    String? amount;
    String? valueCost;
    String? freightCost;
    String? clearanceFee;
    String? storageFee;
    String? processingFee;
    String? tax;
    String? badAddressFee;
    String? inboundsCharge;
    String? gctPer;
    String? gct;

    TransactionList({
        this.id,
        this.posTransactionId,
        this.packageId,
        this.isShippingPackage,
        this.insertTimestamp,
        this.updateTimestamp,
        this.shippingMcecode,
        this.description,
        this.weight,
        this.status,
        this.subTotal,
        this.amount,
        this.valueCost,
        this.freightCost,
        this.clearanceFee,
        this.storageFee,
        this.processingFee,
        this.tax,
        this.badAddressFee,
        this.inboundsCharge,
        this.gctPer,
        this.gct,
    });

    factory TransactionList.fromJson(Map<String, dynamic> json) => TransactionList(
        id: json["id"],
        posTransactionId: json["pos_transaction_id"],
        packageId: json["package_id"],
        isShippingPackage: json["is_shipping_package"],
        insertTimestamp: json["insert_timestamp"] == null ? null : DateTime.parse(json["insert_timestamp"]),
        updateTimestamp: json["update_timestamp"] == null ? null : DateTime.parse(json["update_timestamp"]),
        shippingMcecode: json["shipping_mcecode"],
        description: json["description"],
        weight: json["weight"],
        status: json["status"],
        subTotal: json["sub_total"],
        amount: json["amount"],
        valueCost: json["value_cost"],
        freightCost: json["freight_cost"],
        clearanceFee: json["clearance_fee"],
        storageFee: json["storage_fee"],
        processingFee: json["processing_fee"],
        tax: json["tax"],
        badAddressFee: json["bad_address_fee"],
        inboundsCharge: json["inbounds_charge"],
        gctPer: json["gct_per"],
        gct: json["gct"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pos_transaction_id": posTransactionId,
        "package_id": packageId,
        "is_shipping_package": isShippingPackage,
        "insert_timestamp": insertTimestamp?.toIso8601String(),
        "update_timestamp": updateTimestamp?.toIso8601String(),
        "shipping_mcecode": shippingMcecode,
        "description": description,
        "weight": weight,
        "status": status,
        "sub_total": subTotal,
        "amount": amount,
        "value_cost": valueCost,
        "freight_cost": freightCost,
        "clearance_fee": clearanceFee,
        "storage_fee": storageFee,
        "processing_fee": processingFee,
        "tax": tax,
        "bad_address_fee": badAddressFee,
        "inbounds_charge": inboundsCharge,
        "gct_per": gctPer,
        "gct": gct,
    };
}

class UsdDetails {
    String? id;
    String? usdTenderEnable;

    UsdDetails({
        this.id,
        this.usdTenderEnable,
    });

    factory UsdDetails.fromJson(Map<String, dynamic> json) => UsdDetails(
        id: json["id"],
        usdTenderEnable: json["usd_tender_enable"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usd_tender_enable": usdTenderEnable,
    };
}
