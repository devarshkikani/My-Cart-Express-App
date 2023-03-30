import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_cart_express/e_commerce_app/constant/enum.dart';
import 'package:my_cart_express/e_commerce_app/constant/divider.dart';
import 'package:my_cart_express/e_commerce_app/constant/sizedbox.dart';
import 'package:my_cart_express/e_commerce_app/theme/app_text_theme.dart';
import 'package:my_cart_express/e_commerce_app/widget/elevated_button.dart';
import 'package:my_cart_express/e_commerce_app/widget/input_text_field.dart';
import 'package:my_cart_express/e_commerce_app/controller/theme_controller.dart';
import 'package:my_cart_express/e_commerce_app/controller/profile/account_info_screen_controller.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GetX<AccountInfoScreenController>(
          builder: (_) {
            return Text(
              _.editProfileType.value == EditProfileType.showDetails
                  ? 'Account Information'
                  : _.editProfileType.value == EditProfileType.editProfile
                      ? 'Edit Information'
                      : 'Edit Password',
            );
          },
        ),
      ),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            dividers(0),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: GetX<AccountInfoScreenController>(
                    builder: (_) {
                      return _.editProfileType.value ==
                              EditProfileType.showDetails
                          ? displayDetailsView(context)
                          : _.editProfileType.value ==
                                  EditProfileType.editProfile
                              ? editProfileView(context, _)
                              : editPasswordView(context, _);
                    },
                  ),
                ),
              ),
            ),
            height10,
            GetX<AccountInfoScreenController>(
              builder: (_) {
                return _.editProfileType.value == EditProfileType.showDetails
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: Get.width * 0.4,
                            child: elevatedButton(
                              context: context,
                              title: 'Edit Profile',
                              onTap: () {
                                _.editProfileOnTap();
                              },
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: elevatedButton(
                              context: context,
                              title: 'Changed Password',
                              onTap: () {
                                _.editPasswordOnTap();
                              },
                            ),
                          ),
                        ],
                      )
                    : _.editProfileType.value == EditProfileType.editProfile
                        ? SizedBox(
                            width: Get.width * 0.4,
                            child: elevatedButton(
                              context: context,
                              title: 'Save Profile',
                              onTap: () {
                                _.saveProfileOnTap();
                              },
                            ),
                          )
                        : SizedBox(
                            width: Get.width * 0.4,
                            child: elevatedButton(
                              context: context,
                              title: 'Save Password',
                              onTap: () {
                                _.savePasswordOnTap();
                              },
                            ),
                          );
              },
            ),
            height15,
          ],
        ),
      ),
    );
  }

  Widget displayDetailsView(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Get.find<ThemeController>().isDarkTheme.value
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.5)
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: Get.find<ThemeController>().isDarkTheme.value
            ? <BoxShadow>[]
            : <BoxShadow>[
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          rowDecorationView(
            title: 'Email',
            details: 'mathew6896@gmail.com',
            context: context,
            onTap: () {},
          ),
          dividers(0),
          rowDecorationView(
            title: 'password',
            details: '********',
            context: context,
            onTap: () {},
          ),
          dividers(0),
          rowDecorationView(
            title: 'Phone',
            details: '+91 123450 67890',
            context: context,
            onTap: () {},
          ),
          dividers(0),
          rowDecorationView(
            title: 'Birth Date',
            details: '10/06/1980',
            context: context,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget editProfileView(BuildContext context, AccountInfoScreenController _) {
    return Column(
      children: <Widget>[
        EmailWidget(
          hintText: 'Email',
          controller: _.email,
        ),
        height15,
        NumberWidget(
          hintText: 'Phone number',
          controller: _.number,
        ),
        height15,
        TextFormFieldWidget(
          controller: _.birthDate,
          hintText: 'Select Date',
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              _.birthDate.text =
                  '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
            }
          },
        ),
      ],
    );
  }

  Widget editPasswordView(BuildContext context, AccountInfoScreenController _) {
    return Column(
      children: <Widget>[
        PasswordWidget(
          passType: 'Password',
          hintText: 'Password',
          controller: _.password,
        ),
        height15,
        PasswordWidget(
          hintText: 'Confirm Password',
          passType: 'Confirm Password',
          controller: _.confirm,
        ),
      ],
    );
  }

  Widget rowDecorationView({
    required String title,
    required String details,
    required Function() onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: regularText14.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            const Spacer(),
            Text(
              details,
              style: regularText14,
            ),
          ],
        ),
      ),
    );
  }
}
