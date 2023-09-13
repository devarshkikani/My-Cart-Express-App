// To parse this JSON data, do
//
//     final packageDetailModel = packageDetailModelFromJson(jsonString);

import 'dart:convert';

PackageDetailModel packageDetailModelFromJson(String str) =>
    PackageDetailModel.fromJson(json.decode(str));

String packageDetailModelToJson(PackageDetailModel data) =>
    json.encode(data.toJson());

class PackageDetailModel {
  int status;
  List<PackageTracking> packageTracking;
  String packageStatus;
  Data data;

  PackageDetailModel({
    required this.status,
    required this.packageTracking,
    required this.packageStatus,
    required this.data,
  });

  factory PackageDetailModel.fromJson(Map<String, dynamic> json) =>
      PackageDetailModel(
        status: json["status"],
        packageTracking: List<PackageTracking>.from(
            json["package_tracking"].map((x) => PackageTracking.fromJson(x))),
        packageStatus: json["package_status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "package_tracking":
            List<dynamic>.from(packageTracking.map((x) => x.toJson())),
        "package_status": packageStatus,
        "data": data.toJson(),
      };
}

class Data {
  String packageId;
  String shippingMcecode;
  String tracking;
  String userId;
  String weight;
  String vendorName;
  String branchId;
  String branch;
  String location;
  String colorCode;
  String firstname;
  String lastname;
  String mceNumber;
  String status;
  dynamic seaShipment;
  dynamic dimLength;
  dynamic dimWidth;
  dynamic dimHeight;
  String packageStatus;
  String isOverdueDispose;
  DateTime insertTimestamp;
  String packageRank;
  String manifestId;
  dynamic amount;
  String valueCost;
  String freightCost;
  String freightCharges;
  String inlandCharges;
  String storageFee;
  String processingFee;
  String tax;
  String dutyTax;
  String deliveryCost;
  String gct;
  String thirdPartyDeliveryCost;
  String badAddressFee;
  String amountDue;
  String statusId;
  String customerName;
  String flightEtaDate;
  String flightEtaStatus;
  String weightLabel;
  int attachmentCount;
  int invoiceType;
  String invoiceTypeLabel;
  int uploadAttachmentFlag;
  int pkgDeliveryId;
  dynamic dutyTaxPercentage;
  dynamic gctTaxPercentage;
  dynamic storageDays;
  String packageImage;

  Data({
    required this.packageId,
    required this.shippingMcecode,
    required this.tracking,
    required this.userId,
    required this.weight,
    required this.vendorName,
    required this.branchId,
    required this.branch,
    required this.location,
    required this.colorCode,
    required this.firstname,
    required this.lastname,
    required this.mceNumber,
    required this.status,
    required this.seaShipment,
    required this.dimLength,
    required this.dimWidth,
    required this.dimHeight,
    required this.packageStatus,
    required this.isOverdueDispose,
    required this.insertTimestamp,
    required this.packageRank,
    required this.manifestId,
    required this.amount,
    required this.valueCost,
    required this.freightCost,
    required this.freightCharges,
    required this.inlandCharges,
    required this.storageFee,
    required this.processingFee,
    required this.tax,
    required this.dutyTax,
    required this.deliveryCost,
    required this.gct,
    required this.thirdPartyDeliveryCost,
    required this.badAddressFee,
    required this.amountDue,
    required this.statusId,
    required this.customerName,
    required this.flightEtaDate,
    required this.flightEtaStatus,
    required this.weightLabel,
    required this.attachmentCount,
    required this.invoiceType,
    required this.invoiceTypeLabel,
    required this.uploadAttachmentFlag,
    required this.pkgDeliveryId,
    required this.storageDays,
    required this.dutyTaxPercentage,
    required this.gctTaxPercentage,
    required this.packageImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        packageId: json["package_id"],
        shippingMcecode: json["shipping_mcecode"],
        tracking: json["tracking"],
        userId: json["user_id"],
        weight: json["weight"],
        vendorName: json["vendor_name"],
        branchId: json["branch_id"],
        branch: json["branch"],
        location: json["location"],
        colorCode: json["color_code"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mceNumber: json["mce_number"],
        status: json["status"],
        seaShipment: json["sea_shipment"],
        dimLength: json["dim_length"],
        dimWidth: json["dim_width"],
        dimHeight: json["dim_height"],
        packageStatus: json["package_status"],
        isOverdueDispose: json["is_overdue_dispose"],
        insertTimestamp: DateTime.parse(json["insert_timestamp"]),
        packageRank: json["package_rank"],
        manifestId: json["manifest_id"],
        amount: json["amount"],
        valueCost: json["value_cost"].toString(),
        freightCost: json["freight_cost"],
        freightCharges: json["freight_charges"],
        inlandCharges: json["inland_charges"],
        storageFee: json["storage_fee"],
        processingFee: json["processing_fee"],
        tax: json["tax"],
        dutyTax: json["duty_tax"],
        deliveryCost: json["delivery_cost"],
        gct: json["gct"],
        thirdPartyDeliveryCost: json["third_party_delivery_cost"],
        badAddressFee: json["bad_address_fee"],
        amountDue: json["amount_due"],
        statusId: json["status_id"],
        customerName: json["customer_name"],
        flightEtaDate: json["flight_eta_date"],
        flightEtaStatus: json["flight_eta_status"],
        weightLabel: json["weight_label"],
        attachmentCount: json["attachment_count"],
        invoiceType: json["invoice_type"],
        invoiceTypeLabel: json["invoice_type_label"],
        uploadAttachmentFlag: json["upload_attachment_flag"],
        pkgDeliveryId: json["pkg_delivery_id"],
        storageDays: json["storage_days"],
        packageImage: json["package_image"],
        dutyTaxPercentage: json["duty_tax_percentage"],
        gctTaxPercentage: json["gct_tax_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "shipping_mcecode": shippingMcecode,
        "tracking": tracking,
        "user_id": userId,
        "weight": weight,
        "vendor_name": vendorName,
        "branch_id": branchId,
        "branch": branch,
        "location": location,
        "color_code": colorCode,
        "firstname": firstname,
        "lastname": lastname,
        "mce_number": mceNumber,
        "status": status,
        "sea_shipment": seaShipment,
        "dim_length": dimLength,
        "dim_width": dimWidth,
        "dim_height": dimHeight,
        "package_status": packageStatus,
        "is_overdue_dispose": isOverdueDispose,
        "insert_timestamp": insertTimestamp.toIso8601String(),
        "package_rank": packageRank,
        "manifest_id": manifestId,
        "amount": amount,
        "value_cost": valueCost,
        "freight_cost": freightCost,
        "freight_charges": freightCharges,
        "inland_charges": inlandCharges,
        "storage_fee": storageFee,
        "processing_fee": processingFee,
        "tax": tax,
        "duty_tax": dutyTax,
        "delivery_cost": deliveryCost,
        "gct": gct,
        "third_party_delivery_cost": thirdPartyDeliveryCost,
        "bad_address_fee": badAddressFee,
        "amount_due": amountDue,
        "status_id": statusId,
        "customer_name": customerName,
        "flight_eta_date": flightEtaDate,
        "flight_eta_status": flightEtaStatus,
        "weight_label": weightLabel,
        "attachment_count": attachmentCount,
        "invoice_type": invoiceType,
        "invoice_type_label": invoiceTypeLabel,
        "upload_attachment_flag": uploadAttachmentFlag,
        "pkg_delivery_id": pkgDeliveryId,
        "storage_days": storageDays,
        "package_image": packageImage,
        "duty_tax_percentage": dutyTaxPercentage,
        "gct_tax_percentage": gctTaxPercentage,
      };
}

class PackageTracking {
  String id;
  String packageId;
  String packageStatus;
  String dateTime;

  PackageTracking({
    required this.id,
    required this.packageId,
    required this.packageStatus,
    required this.dateTime,
  });

  factory PackageTracking.fromJson(Map<String, dynamic> json) =>
      PackageTracking(
        id: json["id"],
        packageId: json["package_id"],
        packageStatus: json["package_status"],
        dateTime: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_id": packageId,
        "package_status": packageStatus,
        "date_time": dateTime,
      };
}
