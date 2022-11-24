import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cart_express/constant/default_images.dart';
import 'package:my_cart_express/constant/sizedbox.dart';
import 'package:my_cart_express/theme/colors.dart';
import 'package:my_cart_express/theme/text_style.dart';
import 'package:my_cart_express/widget/app_bar_widget.dart';
import 'package:my_cart_express/widget/input_text_field.dart';
import 'package:my_cart_express/widget/validator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      date.text = picked.day.toString();
      month.text = picked.month.toString();
      year.text = picked.year.toString();
      // setState(() {
      // selectedDate = picked;
      // });
    }
  }

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
                width: Get.width,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit Profile',
          style: regularText18,
        ),
        height20,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileView(),
                height20,
                editDetails(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget profileView() {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              dummyProfileImage,
              height: 100,
              width: 100,
            ),
          ),
          height20,
          Text(
            'KAMAR PALMER',
            style: regularText18.copyWith(
              color: blackColor,
              letterSpacing: 0.3,
            ),
          ),
          height5,
          Text(
            'User Code : STF000002',
            style: lightText16,
          ),
          height5,
          Text(
            'Email : mkamar@mycartexpress.com',
            style: lightText16,
          ),
          height5,
          Text(
            'Phone : ',
            style: lightText16,
          ),
        ],
      ),
    );
  }

  Widget editDetails() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PICK UP LOCATION',
            style: regularText14,
          ),
          height10,
          TextFormFieldWidget(
            hintText: 'Select Location',
            controller: pickUpLocation,
            readOnly: true,
            onTap: () {
              showBottomSheet(context, 1);
            },
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primary,
            ),
            validator: (value) =>
                Validators.validateText(value, 'Pick Up Location'),
          ),
          height15,
          Text(
            'DATE',
            style: regularText14,
          ),
          height10,
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Day',
                  controller: date,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) => Validators.validateText(value, 'Date'),
                ),
              ),
              width10,
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Month',
                  controller: month,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) => Validators.validateText(value, 'Month'),
                ),
              ),
              width10,
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Year',
                  controller: year,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: primary,
                  ),
                  validator: (value) => Validators.validateText(value, 'Year'),
                ),
              ),
            ],
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
          Row(
            children: [
              Text(
                'UPLOAD ID',
                style: lightText14,
              ),
              Text(
                ' (PDF/JPEG/PNG/TIFF)',
                style: lightText14.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          height15,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: greyColor.withOpacity(.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Invoice file',
                      ),
                      Text(
                        '(filename.txt)',
                        style: lightText14.copyWith(
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greyColor,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        onPressed: () {
                          selectFileType(context);
                        },
                        child: const Text(
                          'Click to select file...',
                          style: TextStyle(
                            letterSpacing: 0.5,
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          height15,
          const Text(
            'Upload File to Your Account \nDO NOT UPLOAD Shipping Invoice Here',
          ),
          height20,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondary,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: const Text(
              'SAVE',
              style: TextStyle(
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectFileType(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: offWhite,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                height20,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    textStyle: const TextStyle(color: blackColor),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: blackColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "CHOOSE IMAGE FROM GALLERY",
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ),
                height10,
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    textStyle: const TextStyle(color: blackColor),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: blackColor,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "CHOOSE DOCUMENT",
                    style: TextStyle(
                      color: blackColor,
                    ),
                  ),
                ),
                height10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blackColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                height20,
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  magnification: 1.33,
                  squeeze: 1.2,
                  useMagnifier: true,
                  looping: true,
                  onSelectedItemChanged: (int i) {
                    pickUpLocation.text = 'Hello';
                  },
                  children: List.generate(
                    10,
                    (index) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Hello',
                        style: mediumText18.copyWith(
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(Get.width, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'SELECT',
                    style: TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              height10,
            ],
          ),
        );
      },
    );
  }
}
