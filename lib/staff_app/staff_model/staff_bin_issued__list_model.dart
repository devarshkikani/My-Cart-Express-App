class BinIssuedDetailsModel {
  int? status;
  String? message;
  List<PackageList>? packageList;

  BinIssuedDetailsModel({this.status, this.message, this.packageList});

  BinIssuedDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['package_list'] != null) {
      packageList = <PackageList>[];
      json['package_list'].forEach((v) {
        packageList!.add(PackageList.fromJson(v));
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
  String? branchId;
  String? userId;
  String? firstname;
  String? lastname;
  String? mceNumber;
  String? colorCode;
  String? code;

  PackageList(
      {this.packageId,
      this.shippingMcecode,
      this.branchId,
      this.userId,
      this.firstname,
      this.lastname,
      this.mceNumber,
      this.colorCode,
      this.code});

  PackageList.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    shippingMcecode = json['shipping_mcecode'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    mceNumber = json['mce_number'];
    colorCode = json['color_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_id'] = packageId;
    data['shipping_mcecode'] = shippingMcecode;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['mce_number'] = mceNumber;
    data['color_code'] = colorCode;
    data['code'] = code;
    return data;
  }
}
