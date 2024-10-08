// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  UserInfoModel({
    required this.userId,
    // required this.username,
    required this.email,
    // required this.roleId,
    // required this.firstname,
    this.showTrnPopup,
    // required this.lastname,
    required this.branchId,
    required this.profileImage,
    // required this.isCustomer,
    // required this.priceGroupId,
    // required this.isAdmin,
    // required this.isStaff,
    required this.verifyEmail,
    this.trnPopupMessage,
    this.showRestrictedItemsPopup,
    this.restrictedItemsPopupMessage,
    this.restrictedItemsAcceptButtonText,
    this.showRestrictedItemsAcceptedStatus,
    this.isRestrictedItemsAccepted,
  });

  String userId;
  // String username;
  String email;
  // String roleId;
  // String firstname;
  // String lastname;
  String branchId;
  String profileImage;
  // String isCustomer;
  // String priceGroupId;
  String verifyEmail;
  String? trnPopupMessage;
  // num isStaff;
  // int isAdmin;
  num? showTrnPopup;
  num? showRestrictedItemsPopup;
  String? restrictedItemsPopupMessage;
  String? restrictedItemsAcceptButtonText;
  num? showRestrictedItemsAcceptedStatus;
  num? isRestrictedItemsAccepted;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        userId: json["user_id"],
        // username: json["username"],
        email: json["email"],
        // roleId: json["role_id"],
        // firstname: json["firstname"],
        // lastname: json["lastname"],
        branchId: json["branch_id"],
        profileImage: json["profile_image"] ?? '',
        // isCustomer: json["is_customer"],
        // isStaff: json["is_staff"],
        // priceGroupId: json["price_group_id"],
        // isAdmin: json["is_admin"],
        verifyEmail: json["verify_email"],
        showTrnPopup: json["show_trn_popup"],
        trnPopupMessage: json["trn_popup_message"],
        showRestrictedItemsPopup: json["show_restricted_items_popup "],
        restrictedItemsPopupMessage: json["restricted_items_popup_message"],
        restrictedItemsAcceptButtonText:
            json["restricted_items_accept_button_text"],
        showRestrictedItemsAcceptedStatus:
            json["show_restricted_items_accepted_status"],
        isRestrictedItemsAccepted: json["is_restricted_items_accepted"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        // "username": username,
        "email": email,
        // "role_id": roleId,
        // "firstname": firstname,
        // // "is_staff": isStaff,
        // "lastname": lastname,
        "branch_id": branchId,
        "profile_image": profileImage,
        // "is_customer": isCustomer,
        // "price_group_id": priceGroupId,
        // "is_admin": isAdmin,
        "verify_email": verifyEmail,
        "show_trn_popup": showTrnPopup,
        "trn_popup_message": trnPopupMessage,
        "show_restricted_items_popup ": showRestrictedItemsPopup,
        "restricted_items_popup_message": restrictedItemsPopupMessage,
        "restricted_items_accept_button_text": restrictedItemsAcceptButtonText,
        "show_restricted_items_accepted_status":
            showRestrictedItemsAcceptedStatus,
        "is_restricted_items_accepted": isRestrictedItemsAccepted,
      };
}

// StaffBottomModule staffBottomModuleFromJson(String str) =>
//     StaffBottomModule.fromJson(json.decode(str));

// String staffBottomModuleToJson(StaffBottomModule data) =>
//     json.encode(data.toJson());

// class StaffBottomModule {
//   int? warehouseAddToBin;
//   int? customerPos;
//   int? pickupRequest;
//   int? kiosk;
//   int? customerLookup;
//   int? transitScan;

//   StaffBottomModule({
//     this.warehouseAddToBin,
//     this.customerPos,
//     this.pickupRequest,
//     this.kiosk,
//     this.customerLookup,
//     this.transitScan,
//   });

//   factory StaffBottomModule.fromJson(Map<String, dynamic> json) =>
//       StaffBottomModule(
//         warehouseAddToBin: json["warehouse_add_to_bin"],
//         customerPos: json["customer_pos"],
//         pickupRequest: json["pickup_request"],
//         kiosk: json["kiosk"],
//         customerLookup: json["customer_lookup"],
//         transitScan: json["transit_scan"],
//       );

//   Map<String, dynamic> toJson() => {
//         "warehouse_add_to_bin": warehouseAddToBin,
//         "customer_pos": customerPos,
//         "pickup_request": pickupRequest,
//         "kiosk": kiosk,
//         "customer_lookup": customerLookup,
//         "transit_scan": transitScan,
//       };
// }
