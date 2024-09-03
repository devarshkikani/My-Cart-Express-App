// To parse this JSON data, do
//
//     final getSelectedBinDetailsModel = getSelectedBinDetailsModelFromJson(jsonString);

import 'dart:convert';

GetSelectedBinDetailsModel getSelectedBinDetailsModelFromJson(String str) => GetSelectedBinDetailsModel.fromJson(json.decode(str));

String getSelectedBinDetailsModelToJson(GetSelectedBinDetailsModel data) => json.encode(data.toJson());

class GetSelectedBinDetailsModel {
    int? status;
    String? message;
    PackageData? packageData;

    GetSelectedBinDetailsModel({
        this.status,
        this.message,
        this.packageData,
    });

    factory GetSelectedBinDetailsModel.fromJson(Map<String, dynamic> json) => GetSelectedBinDetailsModel(
        status: json["status"],
        message: json["message"],
        packageData: json["package_data"] == null ? null : PackageData.fromJson(json["package_data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "package_data": packageData?.toJson(),
    };
}

class PackageData {
    String? exchangeRate;
    Map<String, String>? packageList;
    String? customerName;
    PackagePriceDetails? packagePriceDetails;
    int? packageAttachments;
    List<dynamic>? internalNotes;
    int? invoiceAttachment;
    String? packageAge;
    String? daysAgo;
    String? manifestId;
    String? manifestCode;
    dynamic declarationDetails;
    String? priceGroupName;
    int? clearanceScan;
    StatusTimestamp? statusTimestamp;
    dynamic isMissing;
    List<dynamic>? capturePhotos;

    PackageData({
        this.exchangeRate,
        this.packageList,
        this.customerName,
        this.packagePriceDetails,
        this.packageAttachments,
        this.internalNotes,
        this.invoiceAttachment,
        this.packageAge,
        this.daysAgo,
        this.manifestId,
        this.manifestCode,
        this.declarationDetails,
        this.priceGroupName,
        this.clearanceScan,
        this.statusTimestamp,
        this.isMissing,
        this.capturePhotos,
    });

    factory PackageData.fromJson(Map<String, dynamic> json) => PackageData(
        exchangeRate: json["exchange_rate"],
        packageList:
         Map.from(json["package_list"]!).map((k, v) => MapEntry<String, String>(k??"", v??"")),
        customerName: json["customer_name"],
        packagePriceDetails: json["package_price_details"] == null ? null : PackagePriceDetails.fromJson(json["package_price_details"]),
        packageAttachments: json["package_attachments"],
        internalNotes: json["internal_notes"] == null ? [] : List<dynamic>.from(json["internal_notes"]!.map((x) => x)),
        invoiceAttachment: json["invoice_attachment"],
        packageAge: json["package_age"],
        daysAgo: json["days_ago"],
        manifestId: json["manifest_id"],
        manifestCode: json["manifest_code"],
        declarationDetails: json["declaration_details"],
        priceGroupName: json["price_group_name"],
        clearanceScan: json["clearance_scan"],
        statusTimestamp: json["status_timestamp"] == null ? null : StatusTimestamp.fromJson(json["status_timestamp"]),
        isMissing: json["is_missing"],
        capturePhotos: json["capture_photos"] == null ? [] : List<dynamic>.from(json["capture_photos"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "exchange_rate": exchangeRate,
        "package_list": Map.from(packageList!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "customer_name": customerName,
        "package_price_details": packagePriceDetails?.toJson(),
        "package_attachments": packageAttachments,
        "internal_notes": internalNotes == null ? [] : List<dynamic>.from(internalNotes!.map((x) => x)),
        "invoice_attachment": invoiceAttachment,
        "package_age": packageAge,
        "days_ago": daysAgo,
        "manifest_id": manifestId,
        "manifest_code": manifestCode,
        "declaration_details": declarationDetails,
        "price_group_name": priceGroupName,
        "clearance_scan": clearanceScan,
        "status_timestamp": statusTimestamp?.toJson(),
        "is_missing": isMissing,
        "capture_photos": capturePhotos == null ? [] : List<dynamic>.from(capturePhotos!.map((x) => x)),
    };
}

class PackagePriceDetails {
    String? packageCost;
    String? freightCharges;
    String? inboundCharge;
    String? storageFees;
    String? gct;
    String? gctPer;
    String? dutyTax;
    String? dutyTaxPer;
    String? deliveryCost;
    String? thirdPartyDeliveryCost;
    String? badAddressFees;
    String? estimateTotalDue;

    PackagePriceDetails({
        this.packageCost,
        this.freightCharges,
        this.inboundCharge,
        this.storageFees,
        this.gct,
        this.gctPer,
        this.dutyTax,
        this.dutyTaxPer,
        this.deliveryCost,
        this.thirdPartyDeliveryCost,
        this.badAddressFees,
        this.estimateTotalDue,
    });

    factory PackagePriceDetails.fromJson(Map<String, dynamic> json) => PackagePriceDetails(
        packageCost: json["package_cost"],
        freightCharges: json["freight_charges"],
        inboundCharge: json["inbound_charge"],
        storageFees: json["storage_fees"],
        gct: json["gct"],
        gctPer: json["gct_per"],
        dutyTax: json["duty_tax"],
        dutyTaxPer: json["duty_tax_per"],
        deliveryCost: json["delivery_cost"],
        thirdPartyDeliveryCost: json["third_party_delivery_cost"],
        badAddressFees: json["bad_address_fees"],
        estimateTotalDue: json["estimate_total_due"],
    );

    Map<String, dynamic> toJson() => {
        "package_cost": packageCost,
        "freight_charges": freightCharges,
        "inbound_charge": inboundCharge,
        "storage_fees": storageFees,
        "gct": gct,
        "gct_per": gctPer,
        "duty_tax": dutyTax,
        "duty_tax_per": dutyTaxPer,
        "delivery_cost": deliveryCost,
        "third_party_delivery_cost": thirdPartyDeliveryCost,
        "bad_address_fees": badAddressFees,
        "estimate_total_due": estimateTotalDue,
    };
}

class StatusTimestamp {
    DateTime? insertTimestamp;

    StatusTimestamp({
        this.insertTimestamp,
    });

    factory StatusTimestamp.fromJson(Map<String, dynamic> json) => StatusTimestamp(
        insertTimestamp: json["insert_timestamp"] == null ? null : DateTime.parse(json["insert_timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "insert_timestamp": insertTimestamp?.toIso8601String(),
    };
}
