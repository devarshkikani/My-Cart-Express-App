// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.roleId,
    required this.firstname,
    required this.lastname,
    required this.branchId,
    required this.profileImage,
    required this.isCustomer,
    required this.priceGroupId,
    required this.isAdmin,
  });

  String userId;
  String username;
  String email;
  String roleId;
  String firstname;
  String lastname;
  String branchId;
  String profileImage;
  String isCustomer;
  String priceGroupId;
  int isAdmin;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        roleId: json["role_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        branchId: json["branch_id"],
        profileImage: json["profile_image"],
        isCustomer: json["is_customer"],
        priceGroupId: json["price_group_id"],
        isAdmin: json["is_admin"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "role_id": roleId,
        "firstname": firstname,
        "lastname": lastname,
        "branch_id": branchId,
        "profile_image": profileImage,
        "is_customer": isCustomer,
        "price_group_id": priceGroupId,
        "is_admin": isAdmin,
      };
}
