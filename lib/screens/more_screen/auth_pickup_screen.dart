import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/widget/validator.dart';

class AuthPickupScreen extends StatefulWidget {
  const AuthPickupScreen({super.key});

  @override
  State<AuthPickupScreen> createState() => _AuthPickupScreenState();
}

class _AuthPickupScreenState extends State<AuthPickupScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  String? idType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.height,
        color: primary,
        child: Column(
          children: [
            appBarWithAction(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: bodyView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Authorise Pick Up',
            style: regularText18,
          ),
          formView(),
        ],
      ),
    );
  }

  Widget formView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height30,
          Text(
            'First Name',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'First name',
            controller: firstName,
            validator: (value) => Validators.validateText(value, 'First Name'),
          ),
          height15,
          Text(
            'Last Name',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Last name',
            controller: lastName,
            validator: (value) => Validators.validateText(value, 'Last Name'),
          ),
          height15,
          Text(
            'Mobile Number',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Mobile Number',
            controller: mobileNumber,
            validator: (value) =>
                Validators.validateText(value, 'Mobile Number'),
          ),
          height15,
          Text(
            'ID Type',
            style: regularText14,
          ),
          height10,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: blackColor,
              ),
            ),
            child: DropdownButton<String>(
              underline: const SizedBox(),
              isExpanded: true,
              value: idType,
              hint: Text(
                'Select ID Type',
                style: lightText16.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: primary,
              ),
              items: <String>[
                "Driver's License",
                'National Id',
                'Other',
                'Passport'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
              onChanged: (_) {
                idType = _;
                setState(() {});
              },
            ),
          ),
          height15,
          Text(
            'ID Number',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'ID Number',
            controller: idNumber,
            validator: (value) => Validators.validateText(value, 'ID Number'),
          ),
          height20,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: const Text(
              'SUBMIT',
              style: TextStyle(
                letterSpacing: 0.5,
              ),
            ),
          ),
          height20,
        ],
      ),
    );
  }
}
