class GetAllScannedPackagesModel {
  int? status;
  String? message;
  List<PackageList>? packageList;

  GetAllScannedPackagesModel({this.status, this.message, this.packageList});

  GetAllScannedPackagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['package_list'] != null) {
      packageList = <PackageList>[];
      json['package_list'].forEach((v) {
        packageList!.add(new PackageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (packageList != null) {
      data['package_list'] = packageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageList {
  String? packageId;
  String? shippingMcecode;
  String? status;
  int? foundFlag;
  String? isFlagged;
  String? isDetained;
  String? isDamaged;
  // List<dynamic>? packageTags;
  int? internalNote;
  int? checkOffScan;
  String? checkOffScanImage;
  String? icon;
  String? iconImage;
  String? binnedLocation;

  PackageList(
      {this.packageId,
      this.shippingMcecode,
      this.status,
      this.foundFlag,
      this.isFlagged,
      this.isDetained,
      this.isDamaged,
      // this.packageTags,
      this.internalNote,
      this.checkOffScan,
      this.checkOffScanImage,
      this.icon,
      this.iconImage,
      this.binnedLocation});

  PackageList.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    shippingMcecode = json['shipping_mcecode'];
    status = json['status'];
    foundFlag = json['found_flag'];
    isFlagged = json['is_flagged'];
    isDetained = json['is_detained'];
    isDamaged = json['is_damaged'];
    // if (json['package_tags'] != null) {
    //   packageTags = <Null>[];
    //   json['package_tags'].forEach((v) {
    //     packageTags!.add(new dynamic.fromJson(v));
    //   });
    // }
    internalNote = json['internal_note'];
    checkOffScan = json['check_off_scan'];
    checkOffScanImage = json['check_off_scan_image'];
    icon = json['icon'];
    iconImage = json['icon_image'];
    binnedLocation = json['binned_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_id'] = packageId;
    data['shipping_mcecode'] = shippingMcecode;
    data['status'] = status;
    data['found_flag'] = foundFlag;
    data['is_flagged'] = isFlagged;
    data['is_detained'] = isDetained;
    data['is_damaged'] = isDamaged;
    // if (this.packageTags != null) {
    //   data['package_tags'] = this.packageTags!.map((v) => v.toJson()).toList();
    // }
    data['internal_note'] = internalNote;
    data['check_off_scan'] = checkOffScan;
    data['check_off_scan_image'] = checkOffScanImage;
    data['icon'] = icon;
    data['icon_image'] = iconImage;
    data['binned_location'] = binnedLocation;
    return data;
  }
}
